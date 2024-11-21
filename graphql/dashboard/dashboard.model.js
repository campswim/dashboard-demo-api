'use strict';

const axios = require('axios');
const dbQuery = require('../../helpers/db_query');
const { getBcCompanyId, retrieveAccessToken } = require('../../helpers/oauth');

const checkDbConnection = async () => {  
  const query = `SELECT * FROM Users`;  
  const result = await dbQuery(query);

  return result && Array.isArray(result) && result.length >= 1 ? { Connected: true } : { Connected: false };
}

// This is only used with the missing-ERP items in BC, which is currently hidden.
const getAllActiveItems = async (daysBack, markets) => {
  let query = `SELECT DISTINCT ItemCode, Country FROM OrderDetails od JOIN Orders o on od.OrderID = o.OrderID WHERE o.CreatedDate >= DATEADD(DAY, -${daysBack}, GETDATE()) AND o.IsRma = 0 AND od.ItemCode != 'Promo' AND o.Country in (`, result, recordSet, error;
  markets.forEach((market, idx) => {
    if (markets.length === 1 || idx === markets.length - 1) query += `'${market}')`; // Only one item in the array or the last item.
    else query += `'${market}',` // All items but the last when there's more than one item in the array.
  });

  result = await dbQuery(query, 'CRM');
  recordSet = result?.recordSet;
  error = result?.message;
  
  if (error) recordSet.Error = error;
  
  return !Array.isArray(recordSet) ? [recordSet] : recordSet;
};

const getAllErpItems = async (itemCodes, markets, user, env) => {  
  if (!itemCodes || (Array.isArray(itemCodes) && itemCodes.length <= 0) || markets.length <= 0) return { Error: 'Either no item codes or no country code was sent to the getAll ErpItems function.' };

  // Use the OAuth access token from the DB, if not expired; otherwise, get a new token.
  const { token, companyId, bcEnv } = await retrieveAccessToken(user);
  
  if (!token) return // Can't do anything without the token.
  if (!companyId || !bcEnv) return; // Can't do anything without the company ID or the business environment.

  // Get the bcCompany code.
  const bcCompanies = await getBcCompanyId(markets);
  if (!bcCompanies) return; // Can't do anything without the companies' API keys.

  // Loop through the BC company values and make an API call for each.
  let items = [], error;
  for await (let bcCompany of bcCompanies) {
    const market = bcCompany.IsoCountryCode;
    let url = `https://api.businesscentral.dynamics.com/v2.0/${companyId}/${env ? env : bcEnv}/api/v2.0/companies(${bcCompany.ErpCompanyId})/items?$filter=`;

    if (Array.isArray(itemCodes)) {
      itemCodes.forEach(code => {
        if (code.Country.toLowerCase() === market.toLowerCase()) url += `number eq '${code.ItemCode}' or `;
      });
    }

    if (!url.includes('&$select=number')) {
      const regex = / or([^or]*)$/gm;
      url = url.replace(regex, '&$select=number');
    }

    // The get-call's configuration.
    const config = {
      method: 'get',
      maxBodyLength: Infinity,
      url,
      headers: { 'Authorization': `Bearer ${token}` },
      // params: {}
    };

    // Make the API call.
    await axios.request(config).then(
      res => {
        const data = res?.data;
        const status = res?.status;
        
        if (status && 200 === status) {
          const results = data?.value;
          
          if (results) {
            if (Array.isArray(results)) {
              results.forEach(result => {
                items.push({ Country: market, ItemCode: result.number });
              });
            } else {
              items.push({ [market]: results.number });
            }
          }
        } else {
          console.error('res.data isn\'t defined: ', {res});
        }
      },
      err => { error = err.code; }
    );
  };

  return error ? [{ Error: error }] : items;
}

const getOrderSummaryByMonth = async (monthsBack = 4) => {
  // Hardcode the current date, so that it will pull data from the mocked DB, the dates of which end in June. Also, there's only one month of data, so the chart isn't going to be very impressive until more order data is added. Date format for CURRDATE() = 'YYYY-MM-DD'.
  const currDate = '2024-11-20';

  const query = `SELECT
      COUNT(*) AS Count,
      DATE_FORMAT(o.OrderDate, '%Y-%m') AS Month,
      o.OrderTypeDescription AS OrderType
    FROM Orders o
    WHERE o.OrderDate >= DATE_FORMAT(DATE_SUB('${currDate}', INTERVAL ${monthsBack - 1} MONTH), '%Y-%m-01')
      AND o.OrderDate < DATE_FORMAT(DATE_ADD('${currDate}', INTERVAL 1 MONTH), '%Y-%m-01')
    GROUP BY
      DATE_FORMAT(o.OrderDate, '%Y-%m'),
      OrderTypeDescription;
  `;

  const result = await dbQuery(query);

  return Array.isArray(result) ? result : [result];
};

const getOrdersByMonthDay = async (month) => {
  if (!month) return;
  const yearMonthArray = month.split('-');
  const year = yearMonthArray[0];
  month = yearMonthArray[1];

  const query = `
    SELECT 
      DAY(o.OrderDate) as Day, 
      COUNT(*) as OrderCount
    FROM Orders o
    WHERE 
      YEAR(o.OrderDate) = ${year} AND 
      MONTH(o.OrderDate) = ${month}
    GROUP BY DAY(o.OrderDate)
    ORDER BY DAY(o.OrderDate);
  `;

  const result = await dbQuery(query);

  return !Array.isArray(result) ? [result] : result;
;}

module.exports = { checkDbConnection, getAllActiveItems, getAllErpItems, getOrderSummaryByMonth, getOrdersByMonthDay };
