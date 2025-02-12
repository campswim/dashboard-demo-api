'use strict';

const dbQuery = require('../../helpers/db_query');

const getMapSettings = async () => {
  const query = `SELECT
      m.Id,
      IsoCountryCode,
      ErpCompanyId,
      IsoCurrencyCode,
      ErpCurrencyCode,
      SourceWarehouse,
      SourceShipMethod,
      DestinationWarehouse,
      ProcessingSequence,
      ActivatedAt,
      DeactivatedAt,
      ModifiedAt,
      ModifiedBy as UserId,
      u.Name as ModifiedBy
    FROM
      Maps m
      LEFT JOIN Users u ON ModifiedBy = u.Id`
  ;
  return await dbQuery(query);
};

const getParamSettings = async () => {
  const query = `SELECT
      ap.Name,
      Value,
      ProcessJobIds,
      Category,
      SubCategory,
      ValueTypeId,
      apvt.Type as ValueType,
      Notes,
      EnabledDate,
      ModifiedAt,
      ModifiedBy as UserId,
      u.Name as ModifiedBy
    FROM
      AppParams ap
      LEFT JOIN AppParamValueTypes apvt ON ap.ValueTypeId = apvt.ID
      LEFT JOIN Users u ON ModifiedBy = u.Id
  `;
  return await dbQuery(query);
};

const getParamByName = async (name) => {
  const query = `SELECT * FROM AppParams WHERE Name = '${name}'`;
  const recordSet = await dbQuery(query);
  return recordSet;
};

const updateParamSettings = async ({ id, column, newValue }, user) => {
  if ('disable' === newValue) newValue = null;
  // const now = new Date().toISOString(); // Uses UTC, and we need local time.
  const now = 'NOW()';
  let query = `UPDATE AppParams SET ${column} = `;
  query += !newValue || newValue === 'None' ? 'NULL' : column === 'EnabledDate' && newValue ? now : `'${newValue}'`;
  query += `, ModifiedAt = ${now}, ModifiedBy = '${user}'`;
  query += ` WHERE Name like '%${id}%'`;
  let recordSet = await dbQuery(query);
  
  if (recordSet) {
    if (recordSet.changedRows && recordSet.changedRows === 1) {
      query = `SELECT * FROM AppParams WHERE Name like '%${id}%'`;
      recordSet = await dbQuery(query);
    }
  }

  return recordSet;
};

const updateMapSettings = async ({ id, column, newValue }, user) => {
  // const now = new Date().toISOString();
  const now = new Date();
  const query = `UPDATE Maps SET ${column} = ${!newValue ? newValue : `'${newValue}'`}, ModifiedAt = NOW(), ModifiedBy = '${user}' WHERE Id = ${id}`;
  const results = await dbQuery(query);

  if (results) {
    if (results.changedRows && results.changedRows === 1) return { [column]: newValue, EnabledDate: now, Error: { message: null }};
  } else return { Error: { message: 'An error occurred in the process of updating the Warehouse Map value.' }};
};

const getType = async ({ table, column }) => {
  const query = `SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH AS MAX_LENGTH FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '${table}' and COLUMN_NAME = '${column}'`;
  const recordSet = await dbQuery(query);
  const resultObj = {
    ColumnName: recordSet?.COLUMN_NAME,
    DataType: recordSet?.DATA_TYPE,
    MaxLength: recordSet?.MAX_LENGTH
  };

  return resultObj;
};

const getValueTypeId = async (dataType) => {
  const query = `SELECT Id FROM AppParamValueTypes WHERE Type = '${dataType}'`;
  return await dbQuery(query);
};

const logChange = async({ table, rowName, column, prevValue, newValue, dataType }, user) => {
  if (!isNaN(parseInt(dataType))) dataType = parseInt(dataType);

  let valueType, query, result;
  
  valueType = typeof dataType !== 'number' ? await getValueTypeId(dataType) : dataType;

  if (typeof valueType === 'object') valueType = valueType?.Id;

  query = `INSERT INTO ChangeLog (TableName, RowName, ColumnName, UserId, PrevValue, NewValue, ValueType) VALUES ('${table}', '${rowName}', '${column}', ${user.id}, '${prevValue}', '${newValue}', ${valueType})`;

  result = await dbQuery(query);

  if (result) {
    if (result.insertId) return { Id: result.insertId };
    else if (result.warningStatus) return { Error: 'The change was not logged.' }
  } else return { Error: 'The change was not logged.' };
}

module.exports = { getMapSettings, getParamSettings, getParamByName, updateParamSettings, updateMapSettings, getType, getValueTypeId, logChange };
