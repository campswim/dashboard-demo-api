'use strict';

const ordersModel = require('./orders.model');

module.exports = {
  Query: {
    orders: async () => { return await ordersModel.getAllOrders(); },
    failedPulls: async () => { return await ordersModel.getAllFailedCrmPulls(); },
    unpushed: async () => { return await ordersModel.getAllUnpushedOrders(); },
    unpushedNoFail: async () => { return await ordersModel.getUnpushedNoFail(); },
    failedPushes: async () => { return await ordersModel.getAllFailedStagedPushes(); },
    ignoredOrders: async (_, __, { user }) => { return await ordersModel.getAllIgnoredOrders(user.id); },
    failedPullOrderById: async (_, args) => { return await ordersModel.getFailedPullOrderById(args.ids); },
    orderDetails: async (_, args) => { return await ordersModel.getOrderDetails(args.id ? args.id : null); },
    getCrmOrderDetails: async (_, args) => { return await ordersModel.getCrmOrderDetails(args.id); },
    getPushStatusById: async (_, args) => { return await ordersModel.getPushStatusById(args.id); }
  },
  Mutation: {
    repullCrmOrders: async (_, args) => { return await ordersModel.repullCrmOrders(args.ids, args.mode); },
    ignoreCrmOrders: async (_, args, { user }) => { return await ordersModel.ignoreCrmOrders(args.ids, args.mode, user.id); },
    repushFailedStagedOrders: async (_, args) => { return await ordersModel.repushFailedStagedOrders(args.ids, args.mode); },
    ignoreFailedStagedOrders: async (_, args, { user }) => { return await ordersModel.ignoreFailedStagedOrders(args.ids, user.id); },
    unignoreOrder: async (_, args) => { return await ordersModel.unignoreIgnoredOrders(args.ids); },
    deleteFailedStagedOrder: async (_, args) => { return await ordersModel.deleteFailedStagedOrder(args.ids, args.mode); }
  }
}