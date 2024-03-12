'use strict';

const dbQuery = require('../../helpers/db_query');
const usersModel = require('../users/users.model');

const getAllFailedPayments = async () => {
  // For production.
  const query = `SELECT
      p.OrderNumber,
      p.PaymentType,
      p.PaymentAmount,
      p.PaymentDate,
      p.CardNumber,
      pt.AttemptedAt,
      pt.DismissedAt,
      pt.DismissedBy,
      pt.ErrorReason,
      pt.PaymentId,
      o.CurrencyCode
    from
      PaymentsTracking pt
      join Payments p on pt.PaymentId = p.Id
      join Orders o on p.OrderNumber = o.OrderNumber
    where
      ErrorReason is not NULL
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

  query = `UPDATE PaymentsTracking SET ErrorReason = NULL, DismissedAt = ${now}, DismissedBy = '${user.id}' OUTPUT INSERTED.PaymentId, INSERTED.DismissedAt, INSERTED.DismissedBy WHERE PaymentId IN (${idString})`;

  ({ recordSet } = await dbQuery(query));

  // Add the DismisssedBy property to the returned object(s).
  if (recordSet) {
    if (Array.isArray(recordSet)) {
      recordSet.forEach((record, idx) => recordSet[idx].DismissedBy = user.name);
    } else {
      recordSet.DismissedBy = user.name;
    }
  }

  return Array.isArray(recordSet) ? recordSet : [recordSet];
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

  // Fetch the error reason from the payments-tracking-history table: this part of the process has not yet been worked out or tested. This function to be disabled in the dashboard for now. If it gets enabled, to reinstate a payment error, the reason will have to be fetched from the PTHistory table and inserted into the payments-tracking table where the payment ID matches.
  // query = `SELECT PaymentID, ErrorReason FROM PaymentsTrackingHistory WHERE PaymentId IN (${idString})`;
  // ({ recordSet } = await dbQuery(query));

  query = `UPDATE PaymentsTracking SET DismissedAt = NULL, DismissedBy = NULL OUTPUT INSERTED.PaymentId WHERE PaymentId IN (${idString})`;

  ({ recordSet } = await dbQuery(query));

  return Array.isArray(recordSet) ? recordSet : [recordSet];
}

module.exports = {
  getAllFailedPayments,
  getAllUnpushedPayments,
  dismissPaymentError,
  reinstatePaymentError
}
