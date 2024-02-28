'use strict';

const paymentsModel = require('./payments.model');

module.exports = {
  Query: {
    getAllFailedPayments: async () => { return await paymentsModel.getAllFailedPayments(); }
  },
  Mutation: {
    dismissPaymentError: async (_, args, { user }) => { return await paymentsModel.dismissPaymentError(args.ids, user) },
    reinstatePaymentError: async (_, args) => { return await paymentsModel.reinstatePaymentError(args.ids) }
  }
}