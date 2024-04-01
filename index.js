const express = require('express');
const pg = require('pg');
const dotenv = require("dotenv");
dotenv.config({ path: './config.env' });
// to make connection on postgre 
const pool = new pg.Pool({
    host:process.env.HOST,
    port:process.env.PORT,
    database:process.env.DATABASE,
    user:process.env.USER,
    password:process.env.PASSWORD
});

pool.query(`SELECT 1+1;`).then((res)=> console.log(res));