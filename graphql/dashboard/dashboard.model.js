'use strict';

const axios = require('axios');
const dbQuery = require('../../helpers/db.query');
const { getBcCompanyId, retrieveAccessToken } = require('../../helpers/oauth');

const checkDbConnection = async (userId) => {
  const query = `SELECT Id FROM Users WHERE Id = ${userId}`;
  const result = await dbQuery(query);
  const recordSet = result?.recordSet;
  const error = result?.message;

  return error && !recordSet ? { Connected: false, Message: error } : { Connected: true };
}

// This is only used with the missing-ERP items in BC, which is currently hidden.
const getAllActiveItems = async (daysBack, markets) => {
  let query = `SELECT DISTINCT ItemCode, Country FROM OrderDetails od JOIN Orders o on od.OrderID = o.OrderID WHERE o.CreatedDate >= DATEADD(DAY, -${daysBack}, GETDATE()) AND o.IsRma = 0 AND od.ItemCode != 'Promo' AND o.Country in (`, result, recordSet, error;
  markets.forEach((market, idx) => {
    if (markets.length === 1 || idx === markets.length - 1) query += `'${market}')`; // Only one item in the array or the last item.
    else query += `'${market}',` // All items but the last when there's more than one item in the array.
  });

  result = await dbQuery(query, 'CRM');
  recordSet = result?.recordSet;
  error = result?.message;
  
  if (error) recordSet.Error = error;
  
  return !Array.isArray(recordSet) ? [recordSet] : recordSet;
};

const getAllErpItems = async (itemCodes, markets, user, env) => {  
  if (!itemCodes || (Array.isArray(itemCodes) && itemCodes.length <= 0) || markets.length <= 0) return { Error: 'Either no item codes or no country code was sent to the getAll ErpItems function.' };

  // Use the OAuth access token from the DB, if not expired; otherwise, get a new token.
  const { token, companyId, bcEnv } = await retrieveAccessToken(user);
  
  if (!token) return // Can't do anything without the token.
  if (!companyId || !bcEnv) return; // Can't do anything without the company ID or the business environment.

  // Get the bcCompany code.
  const bcCompanies = await getBcCompanyId(markets);
  if (!bcCompanies) return; // Can't do anything without the companies' API keys.

  // Loop through the BC company values and make an API call for each.
  let items = [], error;
  for await (let bcCompany of bcCompanies) {
    const market = bcCompany.IsoCountryCode;
    let url = `https://api.businesscentral.dynamics.com/v2.0/${companyId}/${env ? env : bcEnv}/api/v2.0/companies(${bcCompany.ErpCompanyId})/items?$filter=`;

    if (Array.isArray(itemCodes)) {
      itemCodes.forEach(code => {
        if (code.Country.toLowerCase() === market.toLowerCase()) url += `number eq '${code.ItemCode}' or `;
      });
    }

    if (!url.includes('&$select=number')) {
      const regex = / or([^or]*)$/gm;
      url = url.replace(regex, '&$select=number');
    }

    // The get-call's configuration.
    const config = {
      method: 'get',
      maxBodyLength: Infinity,
      url,
      headers: { 'Authorization': `Bearer ${token}` },
      // params: {}
    };

    // Make the API call.
    await axios.request(config).then(
      res => {
        const data = res?.data;
        const status = res?.status;
        
        if (status && 200 === status) {
          const results = data?.value;
          
          if (results) {
            if (Array.isArray(results)) {
              results.forEach(result => {
                items.push({ Country: market, ItemCode: result.number });
              });
            } else {
              items.push({ [market]: results.number });
            }
          }
        } else {
          console.error('res.data isn\'t defined: ', {res});
        }
      },
      err => { error = err.code; }
    );
  };

  return error ? [{ Error: error }] : items;
}

module.exports = { checkDbConnection, getAllActiveItems, getAllErpItems };
