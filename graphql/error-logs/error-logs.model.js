'use strict';

const axios = require('axios');
const dbQuery = require('../../helpers/db_query');

const getErrorLogs = async (numOfErrors, errorLevel = null) => {
  const query = `SELECT 
    Level, 
    TimeStamp, 
    Message, 
    Exception, 
    MachineName, 
    JobName
  FROM Logging
  WHERE 1 = 1
    AND (${errorLevel === null ? 'NULL' : `'${errorLevel}'`} IS NULL OR Level = '${errorLevel}')
  ORDER BY ID DESC
  LIMIT ${numOfErrors};
  `;

  const result = await dbQuery(query);

  return !Array.isArray(result) ? [result] : result;
}

module.exports = { getErrorLogs };
