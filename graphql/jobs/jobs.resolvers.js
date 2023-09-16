'use strict';

const jobsModel = require('./jobs.model');

module.exports = {
  Query: {
    getAllProcessingErrors: async () => { return await jobsModel.getAllProcessingErrors(); }
  }
}