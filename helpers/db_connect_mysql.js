'use strict';
require('dotenv').config({ path: __dirname + '/.env' });
const mysql = require('mysql2');

function dbConnectMySql(database='STAGING') {
  const user = `${database}_DB_USERNAME`;
  const password = `${database}_DB_PASSWORD`;
  const db = `${database}_DB_NAME`;
  const host = `${database}_HOST`;
  const jawsDb = process.env.JAWSDB_URL;

  // Create a connection pool, if it doesn't already exist, using the jaswDb env var for production and the local db for development.
  const pool = jawsDb ? 
    mysql.createPool(jawsDb) : 
    mysql.createPool({
    host: process.env[host],
    user: process.env[user],
    password: process.env[password],
    database: process.env[db],
    waitForConnections: true,
    connectionLimit: 10,
    maxIdle: 10, // max idle connections, the default value is the same as `connectionLimit`
    idleTimeout: 60000, // idle connections timeout, in milliseconds, the default value 60000
    queueLimit: 0,
    enableKeepAlive: true,
    keepAliveInitialDelay: 0,
  });
    
  // Create a promise of the pool.
  const promisePool = pool.promise();  
  return promisePool;
}

module.exports = {
  dbConnectMySql,
}
