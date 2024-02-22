'use strict';
require('dotenv').config({ path: __dirname + '/.env' });
const Connection = require('tedious').Connection;
// const sql = require('mssql');
const { getCreateIfNotExistPool } = require('./mssql-connection-pooling');

// Connection to Microsoft SQL Server DB via the npm package node-mssql, which has async-and-await functionality.
async function dbConnectMsSql(database) {
  const user = ${database}_DB_USERNAME;
  const pwd = ${database}_DB_PASSWORD;
  const db = ${database}_DB_NAME;
  const server = ${database}_HOST;
  const sqlConfig = {
    user: process.env[user],
    password: process.env[pwd],
    database: process.env[db],
    server: process.env[server],
    pool: {
      max: 10,
      min: 0,
      idleTimeoutMillis: 30000
    },
    options: {
      encrypt: true, // for azure
      trustServerCertificate: true // For self-signed certificates or locally hosted servers.
    }
  };

  return await getCreateIfNotExistPool(sqlConfig);
}

// Connection to Microsoft SQL Server DB via the npm package Tedious; no async, only works with callbacks.
function dbConnectTedious() {
  const config = {  
      server: process.env.STAGING_HOST,
      authentication: {
          type: 'default',
          options: {
              userName: process.env.STAGING_DB_USERNAME,
              password: process.env.STAGING_DB_PASSWORD
          }
      },
      options: {
          // If you are on Microsoft Azure, you need encryption:
          // encrypt: true,
          trustServerCertificate: true, // For self-signed certificates or locally hosted servers.
          database: process.env.STAGING_DB_NAME
      }
  };  
  return { Connection, config };
}

module.exports = {
  dbConnectTedious,
  dbConnectMsSql,
}
