const pg = require('pg');
/// Normally we do
// to connect multiple time with database this approach is not good so we use other one
/*
const pool = new pg.Pool({
    host: process.env.HOST,
    port: process.env.PORT,
    database: process.env.DATABASE,
    user: process.env.USER,
    password: process.env.PASSWORD
});
module.exports = pool;
*/ 

/// This is a best way
class Pool {
    _pool = null;

    connect(options) {
        this._pool = new pg.Pool(options);
        return this._pool.query(`SELECT 1+1;`);
    }

    close() {
      this._pool.end();
    }
    
    /// REALLY BIG SECURITY ISSUE HERE

    // query(sql) {
    //  return this._pool.query(sql);
    // }

    /// SOLVING SECURITY ISSUE
    query(sql, params) {
        return this._pool.query(sql,params);
       }
}

module.exports = new Pool();