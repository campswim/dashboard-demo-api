'use strict';

const express = require('express');
const cors = require('cors');
const jwt = require('jsonwebtoken');
const bodyParser = require('body-parser');
const app = express();
const { loadFilesSync } = require('@graphql-tools/load-files');
// const { graphqlHTTP } = require('express-graphql');
const { createHandler } = require('graphql-http/lib/use/express');
const { makeExecutableSchema } = require('@graphql-tools/schema');
const compression = require('compression');
const helmet = require('helmet');
const RateLimit = require('express-rate-limit');
require('dotenv').config({ path: __dirname + '/.env' });

const typesArray = loadFilesSync('**/*', { extensions: ['graphql'] });
const resolversArray = loadFilesSync('**/*', { extensions: ['resolvers.js'] });

const schema = makeExecutableSchema({
  typeDefs: typesArray,
  resolvers: resolversArray
});

const validateToken = (req, _res, next) => {  
  const operation = req?.body?.operation;
  const noValidate = operation === 'signup' || operation === 'signin' || operation === 'userByEmail' || operation === 'usersSansToken' || operation === 'changePassword' || operation === 'getUserRoles' || operation === 'getUserRestrictions' ? true : false;
  let token = req?.headers?.cookie;
    
  if (token && token.includes('Bearer ')) token = token.split(' ')[1];  
  if (token && token.includes('token=')) token = token.split('=')[1];
  if (!noValidate) {
    if (token) {
      try {
        const user = jwt.verify(token, process.env.SECRET);

        if (!user) next({name: 'Data Error', message: 'No such user'});
        else {
          req.user = user;
        }
      } catch (err) {
        console.error({err});
        next(err);
      }
    } else {
      next({name: 'Server Error', message: 'You must sign in to access this resource.'});
    }
  }

  if (req) req.next();
};

// Set up rate limiter: maximum of twenty requests per minute
const limiter = RateLimit({
  windowMs: 1 * 60 * 1000, // 1 minute
  max: 50,
});

// Apply rate limiter to all requests
app.use(limiter);

// Apply the CORS policy.
app.use(cors({
  origin: [
    'http://localhost:3000', 
  ],
  credentials: true,
}));

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(validateToken); // Validate the user's token.
app.use(compression()); // Compress all routes.
app.use(helmet()); // Protect against well-known vulnerabilities.

app.use(
  '/graphql',
  createHandler(
    {
      schema,
      context: context => (
        {
          secret: process.env.SECRET,
          user: context.raw.user,
          res: context.context.res,
          context
        }
      ),
      graphiql: true
    }
  ),
  (err, _req, res, next) => {
    if (err) res.send(err);
    else next();    
  }  
);

// Export the server for import in index.js.
module.exports = {
  server: app,
  start: port => {
    if (!port) throw new Error('The port is missing.');
    app.listen(port, () => console.log(`Running GraphQL Server on port ${port}.`));
  }
};
