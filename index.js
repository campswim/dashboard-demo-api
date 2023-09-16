'use strict';

require('dotenv').config({ path: __dirname + '/.env' });

// Start the web server.
require('./server.js').start(process.env.PORT || 4000);
