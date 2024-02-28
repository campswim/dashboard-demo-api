'use strict';

const { dbConnectMySql } = require('./db_connect_mysql');
const stagingDb = async () => await dbConnectMySql();

async function dbQuery(queryText, database = 'STAGING') {
  const connection = await stagingDb();

  try {
    // Set the session's timezone to Pacific Time.
    await connection.query(`SET time_zone = "-8:00"`);
    
    // Send the query and set it equal to an arrayed variable.
    const [ recordSet ] = await connection.query(`${queryText}`);
    
    // console.log({queryText, recordSet});

    connection.release();

    if (Array.isArray(recordSet)) { // For SELECT queries.
      if (recordSet.length > 1 || recordSet.length === 0) return { recordSet };
      else return recordSet[0];
    } else { // For INSERT and UPDATE queries, returns the object commented out at the end of this file.
      return recordSet;
    }
  } catch {
    return { message: 'This system cannot connect to its database. Please check that your VPN is on and connected.' };
  }
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
