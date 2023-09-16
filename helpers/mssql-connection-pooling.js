'use strict';

const { ConnectionPool } = require('mssql');
const pools = {};
 
// create a new connection pool
function createPool(config) {
  const key = JSON.stringify(config);
  if (getPool(key)) throw new Error('Pool already exists');
  else pools[key] = new ConnectionPool(config).connect().catch(err => { return err; });
  return pools[key];
}

// get a connection pool from all pools
function getPool(name) {
  if (pools[name]) return pools[name];
  else return null;
}

// if pool already exists, return it, otherwise create it
function getCreateIfNotExistPool(config)  {
  const key = JSON.stringify(config);
  const pool = getPool(key);
  if (pool) return pool;
  else return createPool(config);
}

// close a single pool
function closePool(config) {
  const key = JSON.stringify(config);

  if (pools[key]) {
      const pool = pools[key];
      delete pools[key];
      pool.close();
      return true;
  }

  return false;
}

// close all the pools
function closeAllPools() {
  pools.forEach(pool => pool.close());
  pools = {};
  return true;
}
 
module.exports = {
  closePool,
  closeAllPools,
  createPool,
  getPool,
  getCreateIfNotExistPool
}