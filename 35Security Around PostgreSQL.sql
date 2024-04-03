--> 01: SQL injection Exploits
    --> Security issue lets make a request (which is not valid)=> http://localhost:3005/users/1;DROP TABLE users;
    --> This will give error :  
    /* Cannot read properties of undefined (reading 'map')
    at exports.toCamelCase (C:\Users\Administrator\Desktop\api\social-repo\src\utils\to-camel-case.js:3:29)
    at UserRepo.findById (C:\Users\Administrator\Desktop\api\social-repo\src\reopository\userRepository.js:18:12)
    at process.processTicksAndRejections (node:internal/process/task_queues:95:5)
    at async exports.getUserById (C:\Users\Administrator\Desktop\api\social-repo\src\controllers\userController.js:15:18)
    */
    --> now lets make a valid request : http://localhost:3005/users/1
    --> getting error :
    /*  relation "users" does not exist
        at C:\Users\Administrator\Desktop\api\social-repo\node_modules\pg-pool\index.js:45:11
        at process.processTicksAndRejections (node:internal/process/task_queues:95:5)
        at async UserRepo.find (C:\Users\Administrator\Desktop\api\social-repo\src\reopository\userRepository.js:9:24)
        at async exports.getAllUser (C:\Users\Administrator\Desktop\api\social-repo\src\controllers\userController.js:6:19) {
        length: 104,
        severity: 'ERROR',
        code: '42P01',
        detail: undefined,
        hint: undefined,
        position: '15',
        internalPosition: undefined,
        internalQuery: undefined,
        where: undefined,
        schema: undefined,
        table: undefined,
        column: undefined,
        dataType: undefined,
        constraint: undefined,
        file: 'parse_relation.c',
        line: '1452',
        routine: 'parserOpenTable'
        }
    */
    --> What user does not exist, let's verify on pg admin --> yeah users not exist so this is main security issue.
    --> LETS UNDERSTAND WHY THIS HAPPENED?
        https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/53d8bd26-4f3a-4f7c-83bb-fa4fc9f04143
    --> What happened behind the scene 
    /*  When we make a request--> http://localhost:3005/users/1 then 1 is extracted as a plain string and aaded into our query
        SELECT * FROM users WHERE id = 1
        and our query execute.

        now but for this request --> http://localhost:3005/users/1;DROP TABLE users;
        every thing after users/ is treated as plain string => 1;DROP TABLE users;
        and now added in our query : id = 1;DROP TABLE users;
        so it look like

        SELECT * FROM users WHERE id = 1;DROP TABLE users;
    --> this query executed and drop the table so this is the security issue.
    --> this is the worst senario that when you deploy your application and any user can delete the information.
    */
    
    --> SQL INJECTION EXPLOIT:
        --> WE NEVER, EVER directly concatenate user-provided input into a sql query.
        --> There are a variety of safe ways to get user provided values into a string.
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/33f40096-f1d6-46b3-9189-8933e4f7af77
    --> So we can not going to write a code like this
        const {rows} = await pool.query(`SELECT * FROM users WHERE id = ${id}`)
    --> if we write code like this we will face sql injection exploits
   
    --> SQL INJECTION: 
    /*  SQL injection is a security flaw where attackers inject malicious SQL code into an application's input fields 
        to manipulate database queries. It can lead to unauthorized access, data theft, or database manipulation. 
        Preventing SQL injection involves validating user input, using parameterized queries, and conducting security testing.
       
        ALL Type of SQL INJECTION
        1) SQL Injection Based on 1=1 is Always True
        when we request with userid = 105 OR 1=1
        then sql statement look like this

        SELECT * FROM users WHERE id = 105 OR 1=1;

        and this will return ALL rows from the "users" table, since OR 1=1 is always TRUE.
        this is a major issue means attacker can easily get user pasword.

        2) SQL Injection Based on ""="" is Always True
        A hacker might get access to user names and passwords in a database by simply inserting 
        " OR ""=" into the user name or password text box:

        SELECT * FROM users WHERE name ="" or ""="" AND pass ="" or ""=""

        The SQL above is valid and will return all rows from the "Users" table, since OR ""="" is always TRUE.

        3) SQL Injection Based on Batched SQL Statements 
        if userId = 1; DROP TABLE users
        then sql statement will look like

        SELECT * FROM users WHERE id = 1; DROP TABLE users;

        this is a valid statement and attacker will delete the table
    */ 

--> 02: Handling SQL INJECTION with Prepared Statements
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/eb4487a3-bf6c-443e-9120-646c12517325
    --> 1 Add code to sanitize user-provided values to our app
    --> or
    --> 2 Rely on Postgress to sanitize user-provided values for us
    --> Actually we always go to option to but in some cases option 2 not work.
    --> Generally --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/61a23906-b4f0-4735-b83e-ba16f6fe0fc5
    --> but ww will do like that : using prepare statement
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/5b690e81-7653-4a56-9f9c-db76124c91a6
    --> one downside of this is we can not use identifier(id, username,bio) in prepared statement we only use value.

--> 03: Preventing Sql Injection
    --> deleting database socialnetwork and re creating and running migration file and inserting users data
         INSERT INTO users(bio,username)
         VALUES ('This is my bio','Anand'),
                ('This is about me','Aryan');

    --> now modifying userRepo Code
        const {rows} = await pool.query(`
        SELECT * FROM users WHERE id = ${id}
        `)
    --> modify by using prepared statement
        const {rows} = await pool.query(`
        SELECT * FROM users WHERE id = $1
        `, [id]
        )
    --> if we want to provide multiple different value : we can put as mush as possible
        const {rows} = await pool.query(`
        SELECT * FROM users WHERE id = $1 AND username = $2 AND bio = $3
        `, [id,username,bio]
        )
    --> array [id,username,bio] $1 showing index first element in array
    --> pool.query here is function which is defined by me in pool.js so we have to take this two argument and pass it
    --> to actual query function inside the pg module means
        query(sql) {
        return this._pool.query(sql);
        }
    --> update query function in pool.js by
        query(sql,params) {
        return this._pool.query(sql,params);
        }
    --> now lets make a  request : http://localhost:3005/users/1 : working
    --> now make a invalid request : http://localhost:3005/users/1;DROP TABLE users;
    /*
        error: invalid input syntax for type integer: "1;DROP TABLE users;"
        working fine good !!!
    */

--> 04: Post Request using REST Client
        POST http://localhost:3005/users HTTP/1.1
        Content-Type: application/json

        {
        "username":"cookiee123",
        "bio":"I am a cookiee"
        }

--> 05: Inserting User
        exports.createUser = async(req,res) => {
        const{bio,username} = req.body;
        const user = await UserRepo.insert(bio,username)
        
        res.send(user);
        }

        --> USERRepo class function
        static async insert(bio, username) {
                /// to get information about user created we add at last RETURING *
            const {rows} =  await pool.query(`
                INSERT INTO users(bio,username)
                VALUES($1,$2) RETURNING *;
                `, [bio,username]
                );

                return toCamelCase(rows[0]);
            }
    --> Send request : we can also do by postman
        POST http://localhost:3005/users HTTP/1.1
        Content-Type: application/json

        {
        "username":"cookiee123",
        "bio":"I am a cookiee"
        }

--> 06: Updating User
        exports.updateUser = async(req,res) => {
            const {id} = req.params;
            const{bio,username} = req.body;
            const user = await UserRepo.update(id,bio,username);
            
            if(user) {
                res.send(user);
            } else {
                res.sendStatus(404);
            }
        }

        --> USERRepo class function
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

--> 06: Deleting User
        exports.deleteUser = async(req,res) => {
            const {id} = req.params;
            const user = await UserRepo.delete(id);

        if(user) {
            res.send(user);
            } else {
            res.sendStatus(404);
            }
        }

        --> USERRepo class function
        static async delete(id) {
            const {rows} = await pool.query(`
            DELETE FROM users
            WHERE id = $1
            RETURNING *;
            `, [id]);

            return toCamelCase(rows)[0]
            }