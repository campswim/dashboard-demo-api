'use strict';

const { dbConnectMsSql } = require('./db_connect');
const stagingDb = async () => await dbConnectMsSql('STAGING');
const crmDb = async () => await dbConnectMsSql('CRM');

async function dbQuery(queryText, database = 'STAGING') {
  const connection = 'STAGING' === database ? await stagingDb() : await crmDb();
  const connectionError = !connection?.ConnectionPool ? Object.values(connection) : null;
  
  if (connectionError && connectionError.includes('ConnectionError')) {
    return { message: 'This system cannot connect to its database. Please check that your VPN is on and connected.' };
  } else {
    const result = await connection.query([`${queryText}`]);  
    const recordSet = result.recordset && result.recordset.length === 1 ? result.recordset[0] : result.recordset;
    const rowCount = result?.rowsAffected;
  
    return recordSet ? { recordSet, rowCount } : result;
  }

}

module.exports = dbQuery;
