'use strict'

const dashboardModel = require('./dashboard.model');

module.exports = {
  Query: {
    checkDbConnection: async () => { return await dashboardModel.checkDbConnection(); },
    getAllActiveItems: async (_, args, ) => { return await dashboardModel.getAllActiveItems(args.daysBack, args.markets); },
    getAllErpItems: async (_, args, { user }) => { return await dashboardModel.getAllErpItems(args.itemCodes, args.markets, user, args.environment); },
    getOrderSummaryByMonth: async (_, args) => { return await dashboardModel.getOrderSummaryByMonth(args.monthsBack); },
    getOrdersByMonthDay: async (_, args) => { return await dashboardModel.getOrdersByMonthDay(args.month); }
  }
};
