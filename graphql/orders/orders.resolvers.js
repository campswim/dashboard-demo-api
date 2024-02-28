'use strict';

const ordersModel = require('./orders.model');

module.exports = {
  Query: {
    orders: async () => { return await ordersModel.getAllOrders(); },
    failedPulls: async () => { return await ordersModel.getAllFailedCrmPulls(); },
    unpushed: async () => { return await ordersModel.getAllUnpushedOrders(); },
    failedPushes: async () => { return await ordersModel.getAllFailedStagedPushes(); },
    ignoredOrders: async (_, __, { user }) => { return await ordersModel.getAllIgnoredOrders(user.id); },
    failedPullOrderById: async (_, args) => { return await ordersModel.getFailedPullOrderById(args.ids); },
    orderDetails: async (_, args) => { return await ordersModel.getOrderDetails(args.id); }
  },
  Mutation: {
    repullCrmOrders: async (_, args) => { return await ordersModel.repullCrmOrders(args.ids); },
    ignoreCrmOrders: async (_, args) => { return await ordersModel.ignoreCrmOrders(args.ids); },
    repushFailedStagedOrders: async (_, args) => { return await ordersModel.repushFailedStagedOrders(args.ids); },
    ignoreFailedStagedOrders: async (_, args) => { return await ordersModel.ignoreFailedStagedOrders(args.ids); },
    unignoreOrder: async (_, args) => { return await ordersModel.unignoreIgnoredOrders(args.ids); },
    deleteFailedStagedOrder: async (_, args) => { return await ordersModel.deleteFailedStagedOrder(args.ids); }
  }
}