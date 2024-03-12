'use strict';

const { dbConnectMySql } = require('./db_connect_mysql');
let pool = dbConnectMySql();

async function dbQuery(queryText) {
  if (!pool) pool = dbConnectMySql();

  // const connection = await pool.getConnection();
  let recordSet;

  try {
    // Send the query and set it equal to an arrayed variable. (With pool.query, the connection is automatically released.)
    const [ results ] = await pool.query(`${queryText}`);

    if (Array.isArray(results)) { // For SELECT queries.
      if (results.length === 1) recordSet = results[0];
      else recordSet = results;
    } else { // For INSERT and UPDATE queries, returns the object commented out at the end of this file.
      recordSet = results;
    }
  } catch (e) {
    console.error({e});
    return { Error: 'This system cannot connect to its database. Please check that your VPN is on and connected. If it is, contact technical support.' };
  }

  return recordSet;
}

module.exports = dbQuery;

// ResultSetHeader {
//   fieldCount: 0,
//   affectedRows: 1,
//   insertId: 0,
//   info: 'Rows matched: 1  Changed: 1  Warnings: 0',
//   serverStatus: 2,
//   warningStatus: 0,
//   changedRows: 1
// },
