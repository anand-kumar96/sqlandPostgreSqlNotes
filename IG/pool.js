const pg = require('pg');
const dotenv = require('dotenv');
dotenv.config({ path: './config.env' });

const pool = new pg.Pool({
    host: process.env.HOST,
    port: process.env.PORT,
    database: process.env.DATABASE,
    user: process.env.USER,
    password: process.env.PASSWORD
});

module.exports = pool;
