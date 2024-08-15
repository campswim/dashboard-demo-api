'use strict';

const usersModel = require('./users.model');
const sanitize = require('../../helpers/sanitize-string');

module.exports = {
  Query: {
    users: async () => { return await usersModel.getAllUsers(); },
    userById: async (_, args) => { return await usersModel.getUserById(args.id); },
    userByEmail: async (_, args) => { return await usersModel.getUserByEmail(args.email); },
    me: (_, __, { user }) => {
      if (user) { // User is logged in.
        return {
          Id: user.id,
          Name: user.name,
          Role: user.role
        };
      } else { } // User is not logged in.
    },
    getUserRoles: async () => { return await usersModel.getUserRoles(); },
    getUserRestrictions: async (_, args) => { return await usersModel.getUserRestrictionsByRole(args.roleId); }
  },
  Mutation: {
    signup: async (_, args) => { return await usersModel.signup(args); },
    signin: async (_, args, { secret, context }) => {
      const res = context.context.res;
      const origin = context.headers['user-agent'];
      const { user, error } = await usersModel.signin(args, secret, res, origin);
      if (error) user.Error = error;
      return user;
    },
    signout: (_, __, { user, res }) => {return usersModel.signout(user, res); },
    changePassword: async (_, args, { secret, res }) => { 
      const { user } = await usersModel.changePassword(args.id, args.password, args.firstSignin, secret, res);
      return user;
    },
    deleteUser: async (_, args) => { return await usersModel.deleteUser(args.ids); },
    userUpdate: async (_, args) => { return await usersModel.updateUser(sanitize(args)); }
  }
}
