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

const getAllUnpushedOrders = async () => { // Used for the homepage's "Staged Orders" section.
  // const query = 'SELECT DISTINCT OrderNumber, Market, OrderTotalAmount, PushStatusId FROM Orders WHERE PushStatusId IS NULL OR PushStatusId in (2, 3)'; // This query mostly works, except when the status ID isn't updated in Chad's API, a rare occurence.
  const queryUnpushed = `SELECT o.Market, Count(*) as Count, Sum(o.OrderTotalAmount) as OrderTotalAmount FROM Orders o WHERE o.SentToErp IS NULL GROUP BY o.Market`;
  const queryFailedPushed = 'SELECT Market, Count(*) as Count, Sum(OrderTotalAmount) as OrderTotalAmount FROM Orders WHERE SentToErp IS NULL and PushStatusId = 2 GROUP BY Market';
  const queryIgnored = 'SELECT Market, Count(*) as Count, Sum(OrderTotalAmount) as OrderTotalAmount FROM Orders WHERE SentToErp IS NULL and PushStatusId = 3 GROUP BY Market';
  const unpushed = await dbQuery(queryUnpushed);
  const failedPushed = await dbQuery(queryFailedPushed);
  const ignored = await dbQuery(queryIgnored);
  let result = [], error;

  // Collate the unpushed returns.
  if (unpushed) {
    if (Array.isArray(unpushed)) {
      unpushed.forEach(record => {
        const obj = {
          Type: 'Unpushed',
          Market: record.Market,
          OrderTotalAmount: record.OrderTotalAmount,
          Count: record.Count
        };

        result.push(obj);
      });
    } else {
      const obj = {
        Type: 'Unpushed',
        Market: unpushed.Market,
        OrderTotalAmount: unpushed.OrderTotalAmount,
        Count: unpushed.Count
      };

      result.push(obj);
    }
    
    if (unpushed.message) {
      error = unpushed.message;
      result.push({ Type: 'Unpushed', Error: error });
    }
  }

  // Collate the failed-push returns.
  if (failedPushed) {
    if (Array.isArray(failedPushed)) {
      failedPushed.forEach(record => {
        const obj = {
          Type: 'Push Failed',
          Market: record.Market,
          OrderTotalAmount: record.OrderTotalAmount,
          Count: record.Count
        };
  
        result.push(obj);
      });
    } else {
      const obj = {
        Type: 'Push Failed',
        Market: failedPushed.Market,
        OrderTotalAmount: failedPushed.OrderTotalAmount,
        Count: failedPushed.Count
      };

      result.push(obj);
    }
    
    if (failedPushed.message) {
      error = failedPushed.message;
      result.push({ Type: 'Push Failed', Error: error });
    }
  }

  // Collate the ignored-orders returns.
  if (ignored) {
    if (Array.isArray(ignored)) {
      ignored.forEach(record => {
        const obj = {
          Type: 'Ignored',
          Market: record.Market,
          OrderTotalAmount: record.OrderTotalAmount,
          Count: record.Count
        };
  
        result.push(obj);
      });
    } else {
      const obj = {
        Type: 'Ignored',
        Market: ignored.Market,
        OrderTotalAmount: ignored.OrderTotalAmount,
        Count: ignored.Count
      };

      result.push(obj);
    }
    
    if (ignored && ignored.message) {
      error = ignored.message;
      result.push({ Type: 'Ignored', Error: error });
    }
  }
  
  return result;
};

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
        IgnoredAt: crmResult.IgnoredAt,
        Message: crmResult.Message,
        IgnoredBy: crmResult.IgnoredBy
      }];
    } else if (crmResult.length >= 1) {
      return crmResult.map(res => {
        return {
          Type: 'CRM',
          OrderNumber: res.OrderNumber,
          OrderDate: res.OrderDate,
          OrderTotal: res.OrderTotal,
          CurrencyCode: res.CurrencyCode,
          IgnoredAt: res.IgnoredAt,
          Message: res.Message,
          IgnoredBy: res.IgnoredBy
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
          IgnoredAt: new Date(),
          Message: erpResult.ErrorMessage,
          IgnoredBy: erpResult.IgnoredBy
        }];
      } else if (erpRecordSetFiltered.length > 1) {
        return erpRecordSetFiltered.map(res => (
          {
            Type: 'ERP',
            OrderNumber: res.OrderNumber,
            OrderDate: res.OrderDate,
            OrderTotal: res.OrderTotalAmount,
            CurrencyCode: res.CurrencyCode,
            IgnoredAt: new Date(),
            Message: res.ErrorMessage,
            IgnoredBy: res.IgnoredBy
          }
        ));
      }
    } else if (!Array.isArray(erpResult)) {
      return [
        {
          Type: 'ERP',
          OrderNumber: erpResult.OrderNumber,
          OrderDate: erpResult.OrderDate,
          OrderTotal: erpResult.OrderTotalAmount,
          CurrencyCode: erpResult.CurrencyCode,
          IgnoredAt: new Date(),
          Message: erpResult.ErrorMessage,
          IgnoredBy: erpResult.IgnoredBy
        }
      ];
    } else return erpResult;
  };
  
  const crmResults = await getIgnoredCrmOrders();
  const erpResults = await getIgnoredErpOrders();
  const concattedArray = crmResults.concat(erpResults);

  return concattedArray;
}

const getOrderDetails = async (id) => {
  if (!id) return { Error: 'No Order ID was provided to the API.'};
  
  const query = `SELECT OrderNumber, CustomerNumber, Market, CurrencyCode, PushStatusId, OrderTypeDescription, ReferenceOrderNumber, OrderTotalAmount, TaxAmount, FreightAmount, FreightTaxAmount, OrderDate, ShipDate, Warehouse, ShipMethod, PickupName, StagingImportDate as PulledDate, SentToErp, ErpOrderNumber FROM Orders WHERE OrderNumber = '${id}'`;
  const result = await dbQuery(query);
  
  return !result ? { Error: 'An error occurred in the getOrderDetails function of the API', result } : Array.isArray(result) && result.length <= 0 ? null : result;
}

const getCrmOrderDetails = async (id) => {
  if (!id) return { Error: 'No Order Number was submitted.' };

  const query = `SELECT * FROM OrderStagingErrors WHERE OrderNumber = '${id}'`;  
  const result = await dbQuery(query);

  return Array.isArray(result) && result.length <= 0 ? { Error: 'This order has not been pulled from the CRM yet or the order number does not exist.' } : !result ? { Error: 'An error occurred in the getCrmOrderDetails function of the API' } : result;
};

const getPushStatusById = async (id) => {
  if (!id) return { Error: 'No Order ID was provided to the API.' };
  const query = `SELECT * FROM PushStatuses WHERE Id = ${id}`;
  const recordSet = await dbQuery(query);
  return recordSet;
};

const repullCrmOrders = async (ids, mode = 'prod') => {
  if (mode === 'demo') return [{ Message: 'This feature has been disabled in the demo.' }];
  else {
    const idsString = ids.join(',');
    const query = `DELETE FROM OrderStagingErrors WHERE OrderNumber in (${idsString})`;
    let recordSet = await dbQuery(query);

    if (recordSet && recordSet.affectedRows && recordSet.affectedRows === ids.length) recordSet = ids.map(id => ({ Id: id }));

    return recordSet;
  }
}

const ignoreCrmOrders = async (ids, mode = 'prod', userId) => {
  const idsString = ids.join(',');
  const query = `UPDATE OrderStagingErrors SET IgnoredAt = NOW(), IgnoredBy = ${userId} WHERE OrderNumber in (${idsString})`;
  const recordSet = await dbQuery(query);
  const resultsArray = [];

  if (recordSet?.affectedRows >= 1) ids.forEach(record => resultsArray.push({ OrderNumber: record }));

  return resultsArray.length > 0 ? resultsArray : [{ Error: 'An error occurred in the process of ignoring orders; please contact technical support.'}];
}

const repushFailedStagedOrders = async (ids, mode = 'prod') => {  
  if (mode === 'demo') return [{ Message: 'This feature has been disabled in the demo' }];
  else {
    const idsString = ids.join(',');
    const query = `UPDATE Orders SET PushStatusId = NULL WHERE OrderNumber in (${idsString})`;
    const recordSet = await dbQuery(query);
    const resultsArray = [];
  
    if (recordSet?.affectedRows >= 1) ids.forEach(record => resultsArray.push({ OrderNumber: record }));
  
    return resultsArray.length > 0 ? resultsArray : [{ Error: 'An error occurred in the process of respushing orders; please contact technical support.'}];
  }
}

const ignoreFailedStagedOrders = async (ids, mode = 'prod', userId) => {  
  const idsString = ids.join(',');
  const todayUtc = new Date();
  const todayLocal = new Date(todayUtc.toISOString().split('.')[0] + '+07:00');
  const todayLocalFormatted = todayLocal.toISOString().split('.')[0].split('T').join(' ');
  const queryOne = `UPDATE Orders SET PushStatusId = 3 WHERE OrderNumber in (${idsString})`;
  let queryTwo = 'INSERT INTO IgnorePush (OrderNumber, IgnoredBy, IgnoredAt) VALUES', queryOneResult, queryTwoResult;


  ids.forEach((id, idx) => {
    if (ids.length === 1 || idx === ids.length - 1) queryTwo += `('${id}', ${userId}, '${todayLocalFormatted}') `;
    else queryTwo += `('${id}', ${userId}, '${todayLocalFormatted}'),`;
  });

  queryTwo += `ON DUPLICATE KEY UPDATE IgnoredBy = ${userId}, IgnoredAt = NOW();`;

  queryOneResult = await dbQuery(queryOne);
  queryTwoResult = await dbQuery(queryTwo);

  if (queryOneResult?.affectedRows === ids.length && queryTwoResult?.affectedRows >= 1) return ids.map(id => ({ OrderNumber: id }));
  else return [];
}

const deleteFailedStagedOrder = async (ids, mode = 'prod') => {  
  if (mode === 'demo') return [{ Message: 'This feature has been disabled in the demo' }];
  else {
    const idsString = ids.join(',');
    const query = `DELETE FROM Orders WHERE OrderNumber in (${idsString})`;
    const recordSet = await dbQuery(query);

    if (recordSet && recordSet.affectedRows && recordSet.affectedRows === ids.length) recordSet = ids.map(id => ({ Id: id }));

    return recordSet;
  }
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
  getCrmOrderDetails,
  getPushStatusById,
  repullCrmOrders, 
  ignoreCrmOrders, 
  repushFailedStagedOrders,
  ignoreFailedStagedOrders,
  deleteFailedStagedOrder,
  unignoreIgnoredOrders
};
