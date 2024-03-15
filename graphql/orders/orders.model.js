'use strict';

const dbQuery = require('../../helpers/db_query');

const getAllOrders = async () => {
  const query = 'SELECT TOP (5) * FROM Orders';
  const recordSet = await dbQuery(query);
  return Array.isArray(recordSet) ? recordSet : [recordSet];
};

const getAllFailedCrmPulls = async () => {
  const query = 'SELECT * FROM OrderStagingErrors WHERE IgnoredAt IS NULL';
  let recordSet = await dbQuery(query);

  if (!recordSet) recordSet = [];

  return Array.isArray(recordSet) ? recordSet : [recordSet];
}

const getAllUnpushedOrders = async () => {
  const query = 'SELECT DISTINCT OrderNumber, Market, OrderTotalAmount, PushStatusId FROM Orders WHERE PushStatusId IS NULL OR PushStatusId in (2, 3)';
  let recordSet = await dbQuery(query);
  
  if (!recordSet) recordSet = [];

  return Array.isArray(recordSet) ? recordSet : [recordSet];
}

const getAllFailedStagedPushes = async (daysBack = 365) => {
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
    let recordSet = await dbQuery(query);

    if (!recordSet) recordSet = [];

    return Array.isArray(recordSet) ? recordSet : [recordSet];
  } catch (error) {
    console.error({error});
  }
}

const getUnpushedNoFail = async () => { // Used to populate the "Unpushed" tab of the failed-orders page.
  const query = 'SELECT OrderNumber, CustomerNumber, Market, CurrencyCode, CreatedDate, OrderDate, Warehouse, OrderTotalAmount, OrderTypeDescription, StagingImportDate FROM Orders WHERE PushStatusId IS NULL';
  let recordSet = await dbQuery(query);

  if (!recordSet) recordSet = [];

  return Array.isArray(recordSet) ? recordSet : [ recordSet ];
}

const getFailedPullOrderById = async (ids) => {
  const idsString = ids.join(',');
  const query = `SELECT * FROM OrderStagingErrors where OrderNumber in (${idsString})`;
  const recordSet = await dbQuery(query);
  return Array.isArray(recordSet) ? recordSet : [recordSet];
}

const getAllIgnoredOrders = async (userId) => {
  if (!userId) return { Error: 'No user ID was passed to the getAllIgnoredOrders function.' };

  // Get ignored CRM orders.
  const getIgnoredCrmOrders = async () => {
    const queryIgnoredCrmOrders = `SELECT 
        OrderNumber, 
        OrderDate, 
        OrderTotal, 
        CurrencyCode, 
        IgnoredAt, 
        u.Name as IgnoredBy,
        Message 
      FROM OrderStagingErrors ose
      JOIN Users u on ose.IgnoredBy = u.Id
      WHERE IgnoredAt IS NOT NULL
    `;
    const crmResult = await dbQuery(queryIgnoredCrmOrders);

    if (!Array.isArray(crmResult)) {
      return [{
        Type: 'CRM',
        OrderNumber: crmResult.OrderNumber,
        OrderDate: crmResult.OrderDate,
        OrderTotal: crmResult.OrderTotal,
        CurrencyCode: crmResult.CurrencyCode,
        IgnoredDate: crmResult.IgnoredAt,
        Message: crmResult.Message,
        User: crmResult.IgnoredBy
      }];
    } else if (crmResult.length >= 1) {
      return crmResult.map(res => {
        return {
          Type: 'CRM',
          OrderNumber: res.OrderNumber,
          OrderDate: res.OrderDate,
          OrderTotal: res.OrderTotal,
          CurrencyCode: res.CurrencyCode,
          IgnoredDate: res.IgnoredAt,
          Message: res.Message,
          User: res.IgnoredBy
        }
      });
    } else {
      return [];
    }
  };

  // Get ignored ERP orders.
  const getIgnoredErpOrders = async () => {
    const queryIgnoredErpOrders = `SELECT DISTINCT 
        o.OrderNumber, 
        o.CurrencyCode, 
        o.OrderDate, 
        o.OrderTotalAmount, 
        bd.ErrorMessage, 
        u.Name as IgnoredBy,
        ip.IgnoredAt
      FROM Orders o 
      JOIN IgnorePush ip ON o.OrderNumber = ip.OrderNumber
      JOIN Users u ON ip.IgnoredBy = u.Id
      JOIN OrderBatchDetail bd ON o.OrderNumber = bd.OrderNumber 
      LEFT OUTER JOIN OrderBatchDetail bd2 ON (o.OrderNumber = bd2.OrderNumber AND bd.id < bd2.id) 
      WHERE PushStatusId = 3
    `;
    const erpResult = await dbQuery(queryIgnoredErpOrders);  
    const uniqueErpOrderNumbers = [], erpRecordSetFiltered = [];

    // Remove duplicates from the ERP record set.
    if (Array.isArray(erpResult) && erpResult.length > 1) {
      erpResult.forEach(record => {
        if (!uniqueErpOrderNumbers.includes(record.OrderNumber)) {
          uniqueErpOrderNumbers.push(record.OrderNumber);
          erpRecordSetFiltered.push(record);
        }
      });
    }
    
    // Populate the "ignored" array with ignored ERP items.
    if (Array.isArray(erpResult) && erpResult.length > 0) {
      if (erpResult.length === 1) {
        return [{
          Type: 'ERP',
          OrderNumber: erpResult.OrderNumber,
          OrderDate: erpResult.OrderDate,
          OrderTotal: erpResult.OrderTotalAmount,
          CurrencyCode: erpResult.CurrencyCode,
          IgnoredDate: new Date(),
          Message: erpResult.ErrorMessage,
          User: erpResult.IgnoredBy
        }];
      } else if (erpRecordSetFiltered.length > 1) {
        return erpRecordSetFiltered.map(res => (
          {
            Type: 'ERP',
            OrderNumber: res.OrderNumber,
            OrderDate: res.OrderDate,
            OrderTotal: res.OrderTotalAmount,
            CurrencyCode: res.CurrencyCode,
            IgnoredDate: new Date(),
            Message: res.ErrorMessage,
            User: res.IgnoredBy
          }
        ));
      }
    } else {
      return [];
    }
  };
  
  const crmResults = await getIgnoredCrmOrders();
  const erpResults = await getIgnoredErpOrders();
  const concattedArray = crmResults.concat(erpResults);

  return concattedArray;
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
      o.StagingImportDate as PulledDate, 
      o.SentToErp, 
      o.ErpOrderNumber, 
      o.ErpInvoicedAt
    FROM dbo.Orders o
    WHERE o.OrderNumber = '${id}'
  `;

  const result = await dbQuery(query);
  
  return result?.rowCount[0] <= 0 ? { Error: 'This order has not been pulled from the CRM yet.' } : result?.recordSet ? result.recordSet : { Error: 'An error occurred in the getOrderDetails function of the API', result }
}

const repullCrmOrders = async (ids) => {
  const idsString = ids.join(',');
  const query = `DELETE FROM OrderStagingErrors OUTPUT DELETED.* WHERE OrderNumber in (${idsString})`;
  const { recordSet } = await dbQuery(query);
  return Array.isArray(recordSet) ? recordSet : [recordSet];
}

const ignoreCrmOrders = async (ids, userId) => {
  const idsString = ids.join(',');
  const query = `UPDATE OrderStagingErrors SET IgnoredAt = NOW(), IgnoredBy = ${userId} WHERE OrderNumber in (${idsString})`;
  const recordSet = await dbQuery(query);
  const resultsArray = [];

  if (recordSet?.affectedRows >= 1) ids.forEach(record => resultsArray.push({ OrderNumber: record }));

  return resultsArray.length > 0 ? resultsArray : [{ Error: 'An error occurred in the process of ignoring orders; please contact technical support.'}];
}

const repushFailedStagedOrders = async (ids) => {
  const idsString = ids.join(',');
  const query = `UPDATE Orders SET PushStatusId = NULL OUTPUT INSERTED.* WHERE OrderNumber in (${idsString})`;
  const { recordSet } = await dbQuery(query);
  return Array.isArray(recordSet) ? recordSet : [recordSet];
}

const ignoreFailedStagedOrders = async (ids, userId) => {  
  const idsString = ids.join(',');
  // const todayUtc = new Date();
  // const todayLocal = new Date(todayUtc.toISOString().split('.')[0] + '+07:00');
  // const todayLocalFormatted = todayLocal.toISOString().split('.')[0].split('T').join(' ');
  const queryOne = `UPDATE Orders SET PushStatusId = 3 WHERE OrderNumber in (${idsString})`;
  let queryTwo = 'INSERT INTO IgnorePush (OrderNumber, IgnoredBy, IgnoredAt) VALUES';

  ids.forEach((id, idx) => {
    if (ids.length === 1 || idx === ids.length - 1) queryTwo += `('${id}', ${userId}, '${todayLocalFormatted}') `;
    else queryTwo += `('${id}', ${userId}, '${todayLocalFormatted}'),`;
  });

  queryTwo += `ON DUPLICATE KEY UPDATE IgnoredBy = ${userId}, IgnoredAt = NOW();`;

  const queryOneResult = await dbQuery(queryOne);
  const queryTwoResult = await dbQuery(queryTwo);

  if (queryOneResult?.affectedRows === ids.length && queryTwoResult?.affectedRows >= 1) return ids.map(id => ({ OrderNumber: id }));
  else return [];
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

  const crmQuery = `UPDATE OrderStagingErrors 
    SET IgnoredAt = NULL, IgnoredBy = NULL 
    WHERE OrderNumber in (${crmIds})
  `;
  const erpQueryOne = `UPDATE Orders 
    SET PushStatusId = 2 
    WHERE OrderNumber in (${erpIds});
  `;
  const erpQueryTwo = `UPDATE IgnorePush 
    SET IgnoredAt = NULL, IgnoredBy = NULL 
    WHERE OrderNumber in (${erpIds})
  `;
  const crmResult = crmIds.length > 0 ? await dbQuery(crmQuery) : '';
  const erpResultOne = erpIds.length > 0 ? await dbQuery(erpQueryOne) : '';
  const erpResultTwo = erpIds.length > 0 ? await dbQuery(erpQueryTwo) : '';
    
  if (crmResult) { // With crmResult.
    let combinedReturn;
    
    if (crmResult?.affectedRows === crmIds.length) {
      combinedReturn = crmIds.map(id => ({ OrderNumber: id }));
    }

    if (erpResultOne && erpResultTwo) {
      if (erpResultOne.affectedRows === erpIds.length && erpResultTwo.affectedRows === erpIds.length) {
        const tempArray = erpIds.map(id => ({ OrderNumber: id }));
        const tempConcatted = combinedReturn.concat(tempArray);
        combinedReturn = tempConcatted;
      }
    }

    return combinedReturn;
  } else { // Without crmResult.
    if (erpResultOne && erpResultTwo) {
      if (erpResultOne.affectedRows === erpIds.length && erpResultTwo.affectedRows === erpIds.length) return erpIds.map(id => ({ OrderNumber: id }));
      else return null;
    }
  }
}

module.exports = { 
  getAllOrders, 
  getAllFailedCrmPulls,
  getAllUnpushedOrders,
  getAllFailedStagedPushes,
  getUnpushedNoFail,
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
