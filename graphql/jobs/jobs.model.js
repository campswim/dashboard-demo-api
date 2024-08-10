'use strict';

const dbQuery = require('../../helpers/db_query');

const getAllProcessingErrors = async () => {
  const query = `Select
      pe.Id,
      pe.ProcessJobId,
      pj.Name,
      pe.OrderNumber,
      pe.LineNumber,
      pe.Category,
      pj.ExternalSystem,
      pj.DataDirection,
      pe.At,
      pe.Message,
      pe.Exception,
      pe.AdditionalData,
      pe.DismissedAt,
      u.Name as DismissedBy
    FROM ProcessingErrors pe
    JOIN ProcessJobs pj ON pe.ProcessJobId = pj.Id
    LEFT JOIN Users u ON pe.DismissedBy = u.Id
  `;
  let recordSet = await dbQuery(query);

  if (!recordSet) recordSet = [];

  return Array.isArray(recordSet) ? recordSet : [recordSet];
};

const dismissJobError = async (ids, userId) => {
  const now = new Date();
  const results = [];
  let idString, query, recordSet;

  ids.forEach((id, idx) => {
    if (ids?.length <= 1) idString = `'${id}'`;
    else {
      if (idx <= 0) idString = `'${id}'`;
      else if (idx === ids?.length - 1) idString += `,'${id}'`;
      else idString += `,'${id}'`;
    } 
  });

  query = `UPDATE ProcessingErrors SET DismissedAt = NOW(), DismissedBy = '${userId}' WHERE Id IN (${idString})`;

  recordSet = await dbQuery(query);

  if (recordSet && recordSet.changedRows === ids.length) {
    ids.forEach(id => {
      results.push({
        Id: id,
        DismissedAt: now,
        DismissedBy: userId
      });
    });
  }

  return results.length > 0 ? results : [{ Error: 'The attempt to dismiss job(s) failed.' }];
};

const reinstateJobError = async (ids) => {
  const results = [];
  let idString, query, recordSet;

  ids.forEach((id, idx) => {
    if (ids?.length <= 1) idString = `'${id}'`;
    else {
      if (idx <= 0) idString = `'${id}'`;
      else if (idx === ids?.length - 1) idString += `,'${id}'`;
      else idString += `,'${id}'`;
    } 
  });

  query = `UPDATE ProcessingErrors SET DismissedAt = NULL, DismissedBy = NULL WHERE Id IN (${idString})`;

  recordSet = await dbQuery(query);

  if (recordSet && recordSet.affectedRows === ids.length) {
    ids.forEach(id => {
      results.push({
        Id: id,
      });
    });
  }

  return results.length > 0 ? results : [{ Error: 'The attempt to dismiss job(s) failed.' }];
};

module.exports = {
  getAllProcessingErrors,
  dismissJobError,
  reinstateJobError
}