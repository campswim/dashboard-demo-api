const axios = require('axios');
const qs = require('qs');
const dbQuery = require('./db.query');
const { encrypt, decrypt } = require('./encrypt-decrypt');

async function getAuthConfig() {
  const query = `SELECT Name, Value FROM AppParams WHERE Name in ('BcAadTenantId', 'BcClientId', 'BcClientSecret', 'BcScope', 'BcEnvironment')`;
  const results = await dbQuery(query);  
  const authConfig = {};

  if (results.recordSet) {
    if (Array.isArray(results.recordSet)) {
      results.recordSet.forEach(result => {
        authConfig[result.Name] = result.Value;
      });
    } else {
      authConfig[recordSet.Name] = recordSet.Value;
    }
  }

  return authConfig;
}

async function getBcCompanyId(markets) {
  let query = 'SELECT DISTINCT IsoCountryCode, ErpCompanyId FROM Maps WHERE IsoCountryCode in (';
  markets.forEach((market, idx) => {
    if (markets.length === 1 || idx === markets.length - 1) query += `'${market}')`;
    else query += `'${market}',`;
  });

  const { recordSet } = await dbQuery(query);

  return recordSet;
}

async function getNewAccessToken(user, oldToken = null) {
  const authConfig = await getAuthConfig();
  const clientId = authConfig?.BcClientId;
  const clientSecret = authConfig?.BcClientSecret;
  const scope = authConfig?.BcScope;
  const companyId = authConfig?.BcAadTenantId;
  const bcEnv = authConfig?.BcEnvironment;
  const tokenUrl = `https://login.microsoftonline.com/${companyId}/oauth2/v2.0/token`;
  const params = {
    client_id: clientId,
    scope,
    client_secret: clientSecret,
    grant_type: 'client_credentials'
  };

  axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';
  return await axios.post(tokenUrl, qs.stringify(params)).then(
    res => {
      const token = res?.data?.access_token;
      const expiresIn = res?.data?.expires_in;
      
      if (token && expiresIn) { // Save the token to the AppParams table, with expiration going to the notes field.
        const now = Date.now();
        const today = new Date().toISOString();
        const encryptedToken = encrypt(token);
        const expiration = now + (expiresIn * 1000);
        const query = !oldToken ? `INSERT INTO AppParams (Name, Value, ProcessJobIds, Category, SubCategory, ValueTypeId, Notes, EnabledDate, CreatedBy) OUTPUT INSERTED.Name VALUES ('BcAccessToken', '${JSON.stringify(encryptedToken)}', '200,201,210,211,212', 'Order', 'API', 10, '${expiration}', '${today}', '${user}')` : `UPDATE AppParams SET Value = '${JSON.stringify(encryptedToken)}', Notes = '${expiration}' OUTPUT INSERTED.Name WHERE Name = 'BcAccessToken'`;

        return dbQuery(query).then(
          res => { 
            const success = res?.recordSet?.Name === 'BcAccessToken';
            
            if (success) return { token, companyId, bcEnv };
            else return { error: res };
          },
          err => console.error(err)
        );
      } else {
        return { Error: 'The access token was not returned.' };
      }

    },
    err => {
      console.error(err);
      return err;
    }
  );
}

async function retrieveAccessToken(user) {
  const query = "SELECT Value, Notes FROM AppParams WHERE Name = 'BcAccessToken'";
  const { recordSet } = await dbQuery(query);
  
  if (recordSet) {
    if (Array.isArray(recordSet)) { // There's no token in the db, so one needs to be requested. 
      if (recordSet.length <= 0) {
        const results = await getNewAccessToken(user);
        return results;
      }
    } else { // There's alreayd a token in the db, which needs to be used, if still valid.
      const encryptedToken = JSON.parse(recordSet.Value);
      const expiration = parseInt(recordSet.Notes);
      const now = Date.now();

      if (now < expiration) { // The token is still good: decipher it and send it along.
        const token = decrypt(encryptedToken);
        const authConfig = await getAuthConfig();
        const companyId = authConfig?.BcAadTenantId;
        const bcEnv = authConfig?.BcEnvironment;

        return { token, companyId, bcEnv };
      }
      else { // The token has expired, so get a new one. (There's no refresh token with the client-credential workflow.)
        return await getNewAccessToken(user, true);
      }
    }
  }
}

module.exports = { getNewAccessToken, getBcCompanyId, retrieveAccessToken };
