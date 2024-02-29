'use strict';

const dbQuery = require('../../helpers/db_query');

const getAllOrders = async () => {
  const query = 'SELECT TOP (5) * FROM Orders';
  const recordSet = await dbQuery(query);
  return Array.isArray(recordSet) ? recordSet : [recordSet];
};

const getAllFailedCrmPulls = async () => {
  const query = 'SELECT * FROM OrderStagingErrors WHERE IgnoredAt IS NULL';
  const recordSet = await dbQuery(query);
  return Array.isArray(recordSet) ? recordSet : [recordSet];
}

const getAllUnpushedOrders = async () => {
  const query = 'SELECT DISTINCT OrderNumber, Market, OrderTotalAmount, PushStatusId FROM Orders WHERE PushStatusId IS NULL OR PushStatusId in (2, 3)';
  const recordSet = await dbQuery(query);     
  return Array.isArray(recordSet) ? recordSet : [recordSet];
}

const getAllFailedStagedPushes = async (daysBackk = 90) => {
  const query = `SELECT
      o.OrderNumber,
      o.CustomerNumber,
      o.Market,
      o.CurrencyCode,
      o.OrderDate,
      o.Warehouse,
      o.ShipToName,
      o.ShipDate,
      o.OrderTotalAmount,
      o.OrderTypeDescription,
      o.StagingImportDate,
      b.Id as ErpBatchId,
      bd.ErrorCode,
      bd.ErrorMessage
    FROM Orders o
    JOIN OrderBatchDetail bd ON o.OrderNumber = bd.OrderNumber
    LEFT OUTER JOIN OrderBatchDetail bd2 ON (o.OrderNumber = bd2.OrderNumber AND bd.id < bd2.id)
    JOIN OrderBatch b ON bd.OrderBatchId = b.Id
    JOIN PushStatuses st on o.PushStatusId = st.Id
    WHERE st.Name = 'Failed'
      AND bd.ErrorMessage IS NOT NULL
      AND b.BatchDate between DATE_ADD(NOW(), INTERVAL -${daysBack} DAY) and NOW()
      AND bd2.id IS NULL;
  `;
  try {
    const recordSet = await dbQuery(query);
    return Array.isArray(recordSet) ? recordSet : [recordSet];
  } catch (error) {
    console.error({error});
  }
}

const getFailedPullOrderById = async (ids) => {
  const idsString = ids.join(',');
  const query = `SELECT * FROM OrderStagingErrors where OrderNumber in (${idsString})`;
  const recordSet = await dbQuery(query);
  return Array.isArray(recordSet) ? recordSet : [recordSet];
}

const getAllIgnoredOrders = async (userId) => {  
  const userEmail = await dbQuery(`SELECT Email from Users WHERE Id = ${userId}`);  
  const queryIgnoredCrmOrders = 'SELECT OrderNumber, OrderDate, OrderTotal, CurrencyCode, IgnoredAt, Message FROM OrderStagingErrors WHERE IgnoredAt IS NOT NULL';
  const queryIgnoredErpOrders = 'SELECT DISTINCT o.OrderNumber, o.CurrencyCode, o.OrderDate, o.OrderTotalAmount, bd.ErrorMessage FROM Orders o JOIN OrderBatchDetail bd ON o.OrderNumber = bd.OrderNumber LEFT OUTER JOIN OrderBatchDetail bd2 ON (o.OrderNumber = bd2.OrderNumber AND bd.id < bd2.id) WHERE PushStatusId = 3';
  const crmResult = await dbQuery(queryIgnoredCrmOrders);
  const erpResult = await dbQuery(queryIgnoredErpOrders);  
  const uniqueErpOrderNumbers = [], erpRecordSetFiltered = [], ignored = [];

  console.log({crmResult, erpResult});

  // Remove duplicates from the ERP record set.
  if (Array.isArray(erpResult)) {
    if (erpResult.length > 1) {
      erpResult.forEach(record => {
       if (!uniqueErpOrderNumbers.includes(record.OrderNumber)) {
        uniqueErpOrderNumbers.push(record.OrderNumber);
        erpRecordSetFiltered.push(record);
       }
      })
    }
  }

  if (!Array.isArray(crmResult)) {
    ignored.push({
      Type: 'CRM',
      OrderNumber: crmResult.OrderNumber,
      OrderDate: crmResult.OrderDate,
      OrderTotal: crmResult.OrderTotal,
      CurrencyCode: crmResult.CurrencyCode,
      IgnoredDate: crmResult.IgnoredAt,
      Message: crmResult.Message,
      User: userEmail?.Email
    });
  } else if (crmResult.length > 1) {
    crmResult.forEach(res => {
      ignored.push({
        Type: 'CRM',
        OrderNumber: res.OrderNumber,
        OrderDate: res.OrderDate,
        OrderTotal: res.OrderTotal,
        CurrencyCode: res.CurrencyCode,
        IgnoredDate: res.IgnoredAt,
        Message: res.Message,
        User: userEmail?.Email
      });
    });
  }

  if (erpResult) {
    if (Array.isArray(erpResult)) {
      if (erpResult.length === 1) {
        ignored.push({
          Type: 'ERP',
          OrderNumber: erpResult.OrderNumber,
          OrderDate: erpResult.OrderDate,
          OrderTotal: erpResult.OrderTotalAmount,
          CurrencyCode: erpResult.CurrencyCode,
          IgnoredDate: new Date(),
          Message: erpResult.ErrorMessage,
          User: userEmail?.Email
        });
      } else if (erpRecordSetFiltered.length > 1) {
        erpRecordSetFiltered.forEach(res => {
          ignored.push({
            Type: 'ERP',
            OrderNumber: res.OrderNumber,
            OrderDate: res.OrderDate,
            OrderTotal: res.OrderTotalAmount,
            CurrencyCode: res.CurrencyCode,
            IgnoredDate: new Date(),
            Message: res.ErrorMessage,
            User: userEmail?.Email
          });
        });
      }
    }
  }

  return ignored;
}

const getOrderDetails = async (id) => {
  if (!id) return { Error: 'No Order ID was provided to the API.'};
  
  const query = `SELECT
      o.OrderNumber, 
      o.CustomerNumber, 
      o.Market, 
      o.CurrencyCode, 
      o.OrderTypeDescription, 
      o.ReferenceOrderNumber,
      o.OrderTotalAmount, 
      o.TaxAmount, 
      o.FreightAmount, 
      o.FreightTaxAmount,
      o.OrderDate, 
      o.ShipDate, 
      o.Warehouse, 
      o.ShipMethod, 
      o.PickupName,
      ps.Name as PushStatus,
      o.StagingImportDate as PulledDate, 
      o.SentToErp, 
      o.ErpOrderNumber, 
      o.ErpInvoicedAt
    FROM dbo.Orders o
    JOIN dbo.PushStatuses ps ON o.PushStatusId = ps.Id
    WHERE o.OrderNumber = '${id}'
  `;

  const result = await dbQuery(query);
  
  return result?.rowCount <= 0 ? { Error: 'The order number entered does not exist.' } : result?.recordSet ? result.recordSet : { Error: 'An error occurred in the getOrderDetails function of the API', result }
}

const repullCrmOrders = async (ids) => {
  const idsString = ids.join(',');
  const query = `DELETE FROM OrderStagingErrors OUTPUT DELETED.* WHERE OrderNumber in (${idsString})`;
  const { recordSet } = await dbQuery(query);
  return Array.isArray(recordSet) ? recordSet : [recordSet];
}

const ignoreCrmOrders = async (ids) => {
  const idsString = ids.join(',');
  const query = `UPDATE OrderStagingErrors SET IgnoredAt = LOCALTIME() WHERE OrderNumber in (${idsString})`;
  const recordSet = await dbQuery(query);

  return recordSet?.affectedRows >= 1 ? ids : [{ Error: 'An error occurred in the process of ignoring orders; please contact technical support.'}];
}

const repushFailedStagedOrders = async (ids) => {
  const idsString = ids.join(',');
  const query = `UPDATE Orders SET PushStatusId = NULL OUTPUT INSERTED.* WHERE OrderNumber in (${idsString})`;
  const { recordSet } = await dbQuery(query);
  return Array.isArray(recordSet) ? recordSet : [recordSet];
}

const ignoreFailedStagedOrders = async (ids) => {
  const idsString = ids.join(',');
  const query = `UPDATE Orders SET PushStatusId = 3 OUTPUT INSERTED.* WHERE OrderNumber in (${idsString})`;
  const { recordSet } = await dbQuery(query);
  return Array.isArray(recordSet) ? recordSet : [recordSet];
}

const deleteFailedStagedOrder = async (ids) => {
  const idsString = ids.join(',');
  const query = `DELETE FROM Orders OUTPUT DELETED.OrderNumber WHERE OrderNumber in (${idsString})`;
  const { recordSet } = await dbQuery(query);
  return Array.isArray(recordSet) ? recordSet : [recordSet];
}

const unignoreIgnoredOrders = async (ids) => {
  if (!ids) return;

  const crmIds = [];
  const erpIds = [];
  ids.forEach(id => {
    const key = Object.keys(id)[0];
    if ('CRM' === key) crmIds.push(id[key]);
    else if ('ERP' === key) erpIds.push(id[key]);
  });
  const crmQuery = `UPDATE OrderStagingErrors SET IgnoredAt = NULL OUTPUT INSERTED.OrderNumber WHERE OrderNumber in (${crmIds})`;
  const erpQuery = `UPDATE Orders SET PushStatusId = 2 OUTPUT INSERTED.OrderNumber WHERE OrderNumber in (${erpIds})`;
  const crmResult = crmIds.length > 0 ? await dbQuery(crmQuery) : '';
  const erpResult = erpIds.length > 0 ? await dbQuery(erpQuery) : '';
  const combinedReturn = [];

  if (Array.isArray(crmResult.recordSet)) {
    crmResult.recordSet.forEach(record => combinedReturn.push(record));
  } else {
    combinedReturn.push(crmResult.recordSet);
  }

  if (Array.isArray(erpResult.recordSet)) {
    erpResult.recordSet.forEach(record => combinedReturn.push(record));
  } else {
    combinedReturn.push(erpResult.recordSet);
  }

  return combinedReturn;
}

module.exports = { 
  getAllOrders, 
  getAllFailedCrmPulls,
  getAllUnpushedOrders,
  getAllFailedStagedPushes, 
  getFailedPullOrderById, 
  getAllIgnoredOrders,
  getOrderDetails,
  repullCrmOrders, 
  ignoreCrmOrders, 
  repushFailedStagedOrders,
  ignoreFailedStagedOrders,
  deleteFailedStagedOrder,
  unignoreIgnoredOrders
};
