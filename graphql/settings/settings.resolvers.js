'use strict'

const settingsModel = require('./settings.model');
const sanitize = require('../../helpers/sanitize-string');

module.exports = {
  Query: {
    maps: async () => {
      let result = await settingsModel.getMapSettings();
      if (!Array.isArray(result)) result = [{Error: result }];
      return result;
    },
    params: async () => {
      let result = await settingsModel.getParamSettings();
      if (!Array.isArray(result)) result = [{ Error: result }];      
      return result;
    },
    getParamByName: async (_, args) => { return await settingsModel.getParamByName(args.name); },
    getType: async (_, args) => { return await settingsModel.getType(args); },
    getValueTypeId: async (_, args) => { return await settingsModel.getValueTypeId(args.dataType); },
    logChange: async (_, args, { user }) => { return await settingsModel.logChange(args, user); }
  },
  Mutation: {
    paramsUpdate: async (_, args, { user }) => {
      const result = await settingsModel.updateParamSettings(sanitize(args), user.id);
      return !result.message ? result : { Error: result };
    },
    mapsUpdate: async (_, args, { user }) => {
      const result = await settingsModel.updateMapSettings(sanitize(args), user.id);
      return !result.message ? result : { Error: result.message };
    }
  }
}