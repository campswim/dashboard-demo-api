'use strict';

const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const cookie = require('cookie');
const dbQuery = require('../../helpers/db_query');
const validateEmail = require('../../helpers/validate-email');
require('dotenv').config({ path: __dirname + '/../../../.env' });

const getUserRoles = async () => {
  const query = 'SELECT * FROM Roles';
  const recordSet = await dbQuery(query);
  return !Array.isArray(recordSet) ? [recordSet] : recordSet;
};

const getUserRestrictionsByRole = async (role) => {
  const query = `SELECT * FROM Roles WHERE Id = ${role}`;
  return await dbQuery(query);
}

const getAllUsers = async () => {
  const query = 'SELECT u.Id, Email, Name, r.Role as Role, u.Role as RoleId, DateRegistered, LastLogin, LoggedIn, FailedAttempts, Active FROM Users u JOIN Roles r ON u.Role = r.Id WHERE Active = 1';
  const recordSet = await dbQuery(query);

  return !Array.isArray(recordSet) ? [recordSet] : recordSet;
};

const getUserById = async (id) => {  
  if (!id) return { Error: 'No user ID was provided.' };
  const query = `SELECT u.Id, Email, Name, r.Role as Role, DateRegistered, LastLogin, LoggedIn, FailedAttempts FROM Users u JOIN Roles r ON u.Role = r.Id WHERE u.Id = ${id}`;
  const recordSet = await dbQuery(query);
  
  return recordSet;
};

const getUsersByIds = async (idArray) => {
  if (!idArray) return { Error: 'No user ID was provided.' };
  
  // Changed the strings into integers.
  const idIntArray = idArray.map(val => parseInt(val));
  const idString = idArray.join(',');
  const query = `SELECT u.Id, Email, Name, r.Role as Role, DateRegistered, LastLogin, LoggedIn, FailedAttempts FROM Users u JOIN Roles r ON u.Role = r.Id WHERE u.Id in (${idString})`;  
  return await dbQuery(query);
};

const getUserByEmail = async (email) => {  
  const query = `SELECT u.Id, Name, Email, r.Role as Role, u.Role as RoleId, DateRegistered, LastLogin, LoggedIn, FailedAttempts, Active FROM Users u JOIN Roles r ON u.Role = r.Id WHERE Email = '${email}'`;
  const recordSet = await dbQuery(query);
  return recordSet;
};

const getMe = async (id) => {
  const query = `SELECT * FROM Users WHERE Id = ${id}`;
  return await dbQuery(query);
};

const deleteUser = async (ids) => {
  if (!ids) return { Error: 'No IDs were provided to the delete function.' }
  if (!Array.isArray(ids)) return { Error: 'The ID(s) provided to the delete function were not in the form of an array.' }

  const idString = ids.join(',');
  const query = `UPDATE Users SET Active = 0 WHERE Id in (${idString})`;
  const recordSet = await dbQuery(query);
  return Array.isArray(recordSet) ? recordSet : [recordSet];
};

const signup = async ({ email, usersName, password, role }) => {
  if (!validateEmail(email)) return { Error: 'There\'s something wrong with the email you\'ve entered. Please correct it and try again.' };

  const salt = bcrypt.genSaltSync(12);
  const hash = bcrypt.hashSync(password, salt);
  // const dateRegistered = new Date().toISOString(); // Sends UTC, and we want local time.
  const dateRegistered = 'NOW()';
  const user = await getUserByEmail(email);
  const haveEmail = user?.Email === email ? true : false;
  const activeUser = user?.Active;
  let query, error;
  let recordSet = {};

  if (haveEmail) {
    if (!activeUser) {
      query = `UPDATE Users SET Name = '${usersName}', Hash = '${hash}', Role = '${role}', LastLogin = NULL, Active = 1 WHERE Id = ${user.Id}`;
    } else {
      error = `This email address (${email}) has already been registered to another user. If this is your email address, please sign in.`;
    }
  } else {
    query = `INSERT INTO Users (Email, Name, Hash, Role, DateRegistered, Active) VALUES ('${email}', '${usersName}', '${hash}', ${role}, ${dateRegistered}, 1)`;
  }
  
  if (query) {
    const result = await dbQuery(query);

    if (result?.affectedRows === 1) {
      const userId = await dbQuery(`SELECT Id FROM Users WHERE Email = '${email}'`);

      recordSet.Id = userId.Id;
      recordSet.Message = `An account for ${usersName} has been created.`;
    }

    if (recordSet && haveEmail && !activeUser) recordSet.Message = `The user's account, associated with email address ${email}, has been reactivated with a new password.`;

    return recordSet;
  } else if (error) {
    return { Error: error };
  }
}; 

const signin = async ({ id, password }, secret, res) => {
  const user = await dbQuery(`SELECT u.Id, Name, r.Role, r.Id as RoleId, Hash FROM Users u JOIN Roles r ON u.Role = r.Id WHERE u.Id = '${id}'`);
  const date = new Date().toLocaleString(); // Set local time of client.
  // const date = new Date().toISOString(); // Sets UTC, but need local time.
  const dateSQL = 'NOW()';
  const query = user ? `UPDATE Users SET LastLogin = ${dateSQL}, LoggedIn = 1 WHERE Id = ${user.Id}` : '';
  let validPassword = false, token, error;

  // Compare the password passed in to the hashed version in the db.
  if (user) validPassword = bcrypt.compareSync(password, user.Hash);
  
  // Create the token.
  if (validPassword) {
    const payload = {
      id: user.Id,
      name: user.Name,
      role: user.Role
    };
    const expiration = { expiresIn: '1y' };

    token = jwt.sign(
      payload,
      secret,
      expiration
    );
  } else {
    error = 'Invalid password';
  }

  if (token) {
    // Set the last-login date to today.
    const lastLoginResult = await dbQuery(query);
    const serialized = cookie.serialize('token', token, {
      httpOnly: true,
      secure: process.env.NODE_ENV === 'production',
      sameSite: 'none',
      partitioned: 'Partitioned',
      maxAge: 60 * 60 * 24 * 365, // 1 year in seconds
      path: '/',
    });
    
    if (lastLoginResult && lastLoginResult.changedRows === 1) error = '';
    else error = lastLoginResult.info;

    res.setHeader('Set-Cookie', serialized);
  }
  
  return { user: { Id: user.Id, Name: user.Name, Role: user.Role, RoleId: user.RoleId, LastLogin: date }, error };
}

const signout = async (user, res) => {
  // Expire the token http-only cookie.
  const serialized = cookie.serialize('token', null, {
    httpOnly: true,
    secure: process.env.NODE_ENV === 'production',
    sameSite: 'none',
    maxAge: -1,
    path: '/',
  });
  
  res.setHeader('Set-Cookie', serialized);

  // Set LoggedIn to 0.
  const query = `UPDATE Users SET LoggedIn = 0 WHERE Id = ${user.id}`;
  const recordSet = await dbQuery(query);

  if (recordSet?.affectedRows === 1) {
    return { Id: user.id, Name: user.name };
  } else {
    const message = 'The Users table is empty.';
    return { Id: user.id, Name: user.name, Error: message };
  }
};

const changePassword = async (id, password, firstSignin = false, secret, res) => {
  if (!id || !password) return { Error: 'No ID or password was provided to the changePassword function.' };

  // The user is required to change her password upon first signing in.
  if (firstSignin) {
    // Check that the user-entered password matches that assigned by the administrator in the db.
    let hash = await dbQuery(`SELECT Hash FROM Users WHERE Id = ${id}`);
    hash = hash?.Hash;
    let error, validPassword;

    if (hash) validPassword = bcrypt.compareSync(password, hash);
    if (!validPassword) error = 'Invalid password.';
    return { user: { Id: id, Error: error }};
  } else { // Update the password and sign the user in.
    const salt = bcrypt.genSaltSync(12);
    const hash = bcrypt.hashSync(password, salt);
    const query = `UPDATE Users SET Hash = '${hash}' WHERE Id = ${id}`;
    const recordSet = await dbQuery(query);

    if (recordSet?.affectedRows === 1) {
      return await signin({id, password}, secret, res); // Sign the user in.
    } else {
      error = 'An error occurred in the process of updating your password; please try again or contact technical support.'
      return { Error: error };
    }
  }
};

const updateUser = async ({ id, column, newValue }) => {
  const rowId = 'Role' === column ? parseInt(newValue) : '';
  let query = `UPDATE Users SET ${column} = '${newValue}' WHERE Id = ${id}`, result, error;
  
  if (rowId && !isNaN(rowId)) query = `UPDATE Users SET ${column} = ${rowId} WHERE Id = ${id}`;
    
  result = await dbQuery(query);

  if (result) {
    if (result.changedRows && result.changedRows === 1) return { [column]: newValue, Error: '' };
    else return { Error: 'The attempt to update the user was unsuccessful.' };
  } else return { Error: 'The database is not responding. Please contact technical support.' };
};

module.exports = {
  getUserRoles,
  getUserRestrictionsByRole,
  getAllUsers,
  getUserById,
  getUsersByIds,
  getUserByEmail,
  getMe,
  deleteUser,
  signup,
  signin,
  signout,
  changePassword,
  updateUser
};
