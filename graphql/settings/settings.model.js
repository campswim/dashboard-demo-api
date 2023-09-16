'use strict';

const dbQuery = require('../../helpers/db.query');

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
  const result = await dbQuery(query);
  
  return result.recordSet ? result.recordSet : result;
};

const getParamSettings = async () => {
  const query = `SELECT ap.Name, Value, Category, SubCategory, ValueTypeId, apvt.Type as ValueType, Notes, EnabledDate, ModifiedAt, ModifiedBy as UserId, u.Name as ModifiedBy FROM AppParams ap LEFT JOIN AppParamValueTypes apvt ON ap.ValueTypeId = apvt.ID LEFT JOIN Users u ON ModifiedBy = cast(u.Id as varchar(50))`;
  const result = await dbQuery(query);
  return result.recordSet ? result.recordSet : result;
};

const getParamByName = async (name) => {
  const query = `SELECT * FROM AppParams WHERE Name = '${name}'`;
  const { recordSet, message } = await dbQuery(query);
  if (message) recordSet.Error.message = message;
  return recordSet;
};

const updateParamSettings = async ({ id, column, newValue }, user) => {
  if ('disable' === newValue) newValue = null;
  const now = new Date().toISOString();
  let query = `UPDATE AppParams SET ${column} = `;
  query += !newValue ? 'NULL' : `'${newValue}'`;
  query += `, ModifiedAt = '${now}', ModifiedBy = '${user}'`;
  query += ` OUTPUT INSERTED.* WHERE Name like '%${id}%'`;
  const { recordSet } = await dbQuery(query);
    
  return recordSet;
};

const updateMapSettings = async ({ id, column, newValue }, user) => {
  const now = new Date().toISOString();
  const query = `UPDATE Maps SET ${column} = ${!newValue ? newValue : `'${newValue}'`}, ModifiedAt = '${now}', ModifiedBy = '${user}' OUTPUT INSERTED.* WHERE Id = ${id}`;
  const results = await dbQuery(query);

  return results.recordSet ? results.recordSet : { Error: results.message };
};

const getType = async ({ table, column }) => {
  const query = `SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH AS MAX_LENGTH FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '${table}' and COLUMN_NAME = '${column}'`;

  const { recordSet } = await dbQuery(query);
  const resultObj = {
    ColumnName: recordSet?.COLUMN_NAME,
    DataType: recordSet?.DATA_TYPE,
    MaxLength: recordSet?.MAX_LENGTH
  };

  return resultObj;
};

const getValueTypeId = async (dataType) => {
  const query = `SELECT Id FROM AppParamValueTypes WHERE Type = '${dataType}'`;
  const { recordSet } = await dbQuery(query);
  return recordSet;
};

const logChange = async({ table, column, prevValue, newValue, dataType }, user) => {
  if (!isNaN(parseInt(dataType))) dataType = parseInt(dataType);
  
  let valueType = typeof dataType !== 'number' ? await getValueTypeId(dataType) : dataType;

  if (typeof valueType === 'object') valueType = valueType?.Id;

  const query = `INSERT INTO ChangeLog (TableName, ColumnName, UserId, PrevValue, NewValue, ValueType) OUTPUT INSERTED.* VALUES ('${table}', '${column}', ${user.id}, '${prevValue}', '${newValue}', ${valueType})`;

  let result = await dbQuery(query);
  let recordSet = result?.recordSet;
  const message = result?.message;
  if (message) recordSet.Error = message;

  return recordSet;
}

module.exports = { getMapSettings, getParamSettings, getParamByName, updateParamSettings, updateMapSettings, getType, getValueTypeId, logChange };
