const pool = require("../pool");
const { toCamelCase } = require("../utils/to-camel-case");

class UserRepo {

    /// @@@FETCHING ALL DATA
    static async find() {
        // const result = await pool.query(`SELECT * FROM users;`);
        // we donot care about whole result since it has a lot of things
        // we only care about data => rows
        const {rows} = await pool.query(`SELECT * FROM users;`);

        // Converting snake_case or kebab-case to camelCase.
    return toCamelCase(rows);
    }
    
    /// @@@FETCHING DATA BY ID
    static async findById(id) {
        // WARNING: REALLY BIG SECURITY ISSUE
        // const {rows} = await pool.query(`SELECT * FROM users WHERE id = ${id}`)

        /// SOLVING SECURITY ISSUE
        const {rows} = await pool.query(`
        SELECT * FROM users WHERE id = $1;
        `,[id]);

    return toCamelCase(rows)[0];
    }

    /// @@@INSERTING
    static async insert(bio, username) {
        /// to get information about user created we add at last RETURING *
    const {rows} =  await pool.query(`
        INSERT INTO users(bio,username)
        VALUES($1,$2) RETURNING *;
        `, [bio,username]
        );

        return toCamelCase(rows)[0];
    }

    /// @@@UPDATING DATA BY ID
    static async update(id,bio,username) {
        const {rows} = await pool.query(`
        UPDATE users
        SET bio = $1, username = $2
        WHERE id = $3 
        RETURNING *;
        `, [bio,username,id]
        );

        return toCamelCase(rows)[0]
    }

    /// @@@DELETING DATA BY ID
    static async delete(id) {
        const {rows} = await pool.query(`
        DELETE FROM users
        WHERE id = $1
        RETURNING *;
        `, [id]);

        return toCamelCase(rows)[0]
    }

    /// @@@ Total users
    static async count () {
        const {rows} = await pool.query(`SELECT COUNT(*) FROM users`);

        return parseInt(rows[0].count);
    }
}

module.exports = UserRepo;

