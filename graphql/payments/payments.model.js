'use strict';

const dbQuery = require('../../helpers/db_query');
const usersModel = require('../users/users.model');

const getAllFailedPayments = async () => {
  const query = `SELECT
      p.OrderNumber,
      p.PaymentType,
      p.PaymentAmount,
      p.PaymentDate,
      p.CardNumber,
      pt.AttemptedAt,
      pt.DismissedAt,
      pt.DismissedBy as UserId,
      u.Name as DismissedBy,
      pt.ErrorReason,
      pt.PaymentId,
      o.CurrencyCode
    from
      PaymentsTracking pt
      join Payments p on pt.PaymentId = p.Id
      join Orders o on p.OrderNumber = o.OrderNumber
      left join Users u on DismissedBy = u.Id
    where
      ErrorReason is not NULL || DismissedBy is not NULL
  `;

  let dismissedByIds, usernames, dismissedRecords;
  const recordSet = await dbQuery(query);
  
  if (recordSet) {
    if (!Array.isArray(recordSet)) {
      recordSet.DismissedBy;
    } else {
      if (recordSet.length > 0 ) {
        recordSet.filter(record => record.DismissedBy);
      }
    }
  }
  
  if (dismissedRecords || Array.isArray(dismissedRecords) && dismissedRecords.length > 0) dismissedByIds = dismissedRecords.map(record => record.DismissedBy);
  if (dismissedByIds && dismissedByIds.length > 0) usernames = await usersModel.getUsersByIds(dismissedByIds);

  if (usernames) {
    if (Array.isArray(usernames)) {
      usernames.forEach(username => {
        recordSet.forEach((record, idx) => {
          if (username.Id === record.DismissedBy) recordSet[idx].DismissedBy = username.Name;
        });
      });
    } else {
      if (Array.isArray(recordSet)) {
        recordSet.forEach((record, idx) => {
          if (usernames.Id === record.DismissedBy) recordSet[idx].DismissedBy = usernames.Name;
        })
      } else {
        recordSet.DismissedBy = usernames.Name;
      }
    }
  }
  
  return Array.isArray(recordSet) ? recordSet : [recordSet];
}

const getAllUnpushedPayments = async () => {
  const query = `SELECT DISTINCT
      p.OrderNumber,
      p.PaymentType,
      p.PaymentAmount,
      p.PaymentDate,
      p.CardNumber,
      p.SentToErp,
      p.Id,
      o.CurrencyCode
    FROM
      Payments p
      JOIN Orders o ON p.OrderNumber = o.OrderNumber
    WHERE
      p.SentToErp IS NULL
      AND NOT EXISTS (
        SELECT
          *
        FROM
          PaymentsTracking pt
        WHERE
          pt.PaymentId = p.ID
      );
  `;

  const recordSet = await dbQuery(query);

  return !recordSet ? [] : Array.isArray(recordSet) ? recordSet : [recordSet];
}

const dismissPaymentError = async (ids, user) => {
  if (!ids || !user) return;

  const now = new Date();
  let idString, query, recordSet;

  ids.forEach((id, idx) => {
    if (ids?.length <= 1) idString = `'${id}'`;
    else {
      if (idx <= 0) idString = `'${id}'`;
      else if (idx === ids?.length - 1) idString += `,'${id}'`;
      else idString += `,'${id}'`;
    }
  });

  query = `UPDATE PaymentsTracking SET DismissedAt = NOW(), DismissedBy = '${user.id}' WHERE PaymentId IN (${idString})`;

  recordSet = await dbQuery(query);

  // Add the DismisssedBy property to the returned object(s).
  if (recordSet) {
    if (recordSet.changedRows && recordSet.changedRows === ids.length) {
      recordSet = ids.map(record => ({ PaymentId: record, DismissedAt: now, DismissedBy: user.name }));
      return recordSet;
    }
  } else {
    return [{ Error: 'An error occurred in the process of dismissing payment errors' }];
  }

}

const reinstatePaymentError = async (ids) => {
  if (!ids) return;

  let idString, query, recordSet;

  ids.forEach((id, idx) => {
    if (ids?.length <= 1) idString = `'${id}'`;
    else {
      if (idx <= 0) idString = `'${id}'`;
      else if (idx === ids?.length - 1) idString += `,'${id}'`;
      else idString += `,'${id}'`;
    }
  });

  query = `UPDATE PaymentsTracking SET DismissedAt = NULL, DismissedBy = NULL WHERE PaymentId IN (${idString})`;

  recordSet = await dbQuery(query);

  if (recordSet) {
    if (recordSet.changedRows && recordSet.changedRows === ids.length) {
      recordSet = ids.map(record => ({ PaymentId: record }));
      return recordSet;
    }
  } else {
    return [{ Error: 'An error occurred in the process of reinstating payment errors'}];
  }
}

module.exports = {
  getAllFailedPayments,
  getAllUnpushedPayments,
  dismissPaymentError,
  reinstatePaymentError
}
