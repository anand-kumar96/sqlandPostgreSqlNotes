const dotenv = require('dotenv')
dotenv.config({path:"./config.env"})
const {randomBytes} = require('crypto') // to generatea series of number of letters
const {default: migrate} = require('node-pg-migrate')
const format = require('pg-format')
const pool = require('../pool')
// test help
class Context {
    static async build() {
        // Randomly generating a role name to connect to PG as
        const roleName = 'a' + randomBytes(4).toString('hex'); // to start string aleways with letter append a

        // Connect to PG as usual
        await pool.connect({
            host: process.env.HOST,
            port: process.env.PORT,
            database: 'socialnetwork-test',
            user: process.env.USER,
            password: process.env.PASSWORD
        })
        // Create a new role
        /// We can not use parameterized style to prevent sql injection because it will not work with identifier so we use pg-format package
        /*
        await pool.query(`
            CREATE ROLE ${roleName} WITH LOGIN PASSWORD '${roleName}';
        `)
        */
        // updated code
        await pool.query(format('CREATE ROLE %I WITH LOGIN PASSWORD %L;', roleName, roleName))

        // Create a schema with the same name
        /*
        await pool.query(`
            CREATE SCHEMA ${roleName} AUTHORIZATION ${roleName};
        `)
        */
        /// updated code
        await pool.query(format('CREATE SCHEMA %I AUTHORIZATION %I;', roleName, roleName))

        // Disconnect entirely from PG 
        await pool.close();

        // Run our migrations in the new schema
        await migrate({
            schema: roleName,
            direction:'up',
            log:()=>{},
            noLock:true,
            dir:'migrations',
            databaseUrl:{
                host: process.env.HOST,
                port: process.env.PORT,
                database: 'socialnetwork-test',
                user: roleName,
                password: roleName
            }
        })
        // Connect to PG as the newly created role
        await pool.connect({
            host: process.env.HOST,
            port: process.env.PORT,
            database: 'socialnetwork-test',
            user: roleName,
            password: roleName
        })

        return new Context(roleName);
    }

    constructor(roleName) {
        this.roleName = roleName;
    }

    async reset() {
        await pool.query('DELETE FROM users;');
    }

    async close() {
        // Disconnect from PG
        await pool.close();

        // Reconnect as our root user
        await pool.connect({
            host: process.env.HOST,
            port: process.env.PORT,
            database: 'socialnetwork-test',
            user: process.env.USER,
            password: process.env.PASSWORD
        });

        // Delete the role and schema we created
        await pool.query(format('DROP SCHEMA %I CASCADE;', this.roleName));
        await pool.query(format('DROP ROLE %I;', this.roleName));

        // Disconnected
        await pool.close();
    }
}
module.exports = Context;