'use strict';

const errorLogModel = require('./error-logs.model.js');

module.exports = {
  Query: {
    getErrorLogs: async (_, args) => { return await errorLogModel.getErrorLogs(args.numOfErrors, args.errorLevel); }
  }
};
