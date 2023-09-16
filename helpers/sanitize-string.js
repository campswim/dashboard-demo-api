'use strict';

function sanitize({ id, column, newValue }) {
  if (id && id.includes("'")) id = id.replace("'", "''");
  if (column && column.includes("'")) column = column.replace("'", "''");
  if (newValue && newValue.includes("'")) newValue = newValue.replace("'", "''");
  return { id, column, newValue };
}

module.exports = sanitize;
