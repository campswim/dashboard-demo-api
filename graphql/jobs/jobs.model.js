'use strict';

const dbQuery = require('../../helpers/db.query');

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
      pe.AdditionalData
    FROM ProcessingErrors pe
    JOIN ProcessJobs pj ON pe.ProcessJobId = pj.Id
  `;
  const { recordSet } = await dbQuery(query);  
  return recordSet;
};

module.exports = {
  getAllProcessingErrors
}