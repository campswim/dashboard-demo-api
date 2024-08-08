'use strict'

const settingsModel = require('./dashboard.model');

module.exports = {
  Query: {
    checkDbConnection: async () => { return await settingsModel.checkDbConnection(); },
    getAllActiveItems: async (_, args, ) => { return await settingsModel.getAllActiveItems(args.daysBack, args.markets); },
    getAllErpItems: async (_, args, { user }) => { return await settingsModel.getAllErpItems(args.itemCodes, args.markets, user, args.environment); },
  }
};
