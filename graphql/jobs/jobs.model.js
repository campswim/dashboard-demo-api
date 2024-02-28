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
  const { recordSet } = await dbQuery(query);  
  return recordSet;
};

const dismissJobError = async (ids, userId) => {
  const now = 'GETDATE()';
  let idString, query, recordSet;

  ids.forEach((id, idx) => {
    if (ids?.length <= 1) idString = `'${id}'`;
    else {
      if (idx <= 0) idString = `'${id}'`;
      else if (idx === ids?.length - 1) idString += `,'${id}'`;
      else idString += `,'${id}'`;
    } 
  });

  query = `UPDATE ProcessingErrors SET DismissedAt = ${now}, DismissedBy = '${userId}' OUTPUT INSERTED.Id WHERE Id IN (${idString})`;

  ({ recordSet } = await dbQuery(query));

  return Array.isArray(recordSet) ? recordSet : [recordSet];
};

const reinstateJobError = async (ids) => {
  let idString, query, recordSet;

  ids.forEach((id, idx) => {
    if (ids?.length <= 1) idString = `'${id}'`;
    else {
      if (idx <= 0) idString = `'${id}'`;
      else if (idx === ids?.length - 1) idString += `,'${id}'`;
      else idString += `,'${id}'`;
    } 
  });

  query = `UPDATE ProcessingErrors SET DismissedAt = NULL, DismissedBy = NULL OUTPUT INSERTED.Id WHERE Id IN (${idString})`;

  ({ recordSet } = await dbQuery(query));

  return Array.isArray(recordSet) ? recordSet : [recordSet];
};

module.exports = {
  getAllProcessingErrors,
  dismissJobError,
  reinstateJobError
}