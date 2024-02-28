'use strict';

const jobsModel = require('./jobs.model');

module.exports = {
  Query: {
    getAllProcessingErrors: async () => { return await jobsModel.getAllProcessingErrors(); }
  },
  Mutation: {
    dismissJobError: async (_, args, { user }) => { return await jobsModel.dismissJobError(args.ids, user.id) },
    reinstateJobError: async (_, args) => { return await jobsModel.reinstateJobError(args.ids) }
  }
}