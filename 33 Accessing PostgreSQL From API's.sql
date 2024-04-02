--> 01: Section goal: Creating an api
--> 02: Initial Setup
        mkdir api
        cd api
        mkdir social-repo
        cd social-repo
        npm init -y
        npm install dedent express jest node-pg-migrate nodemon pg pg-format supertest

--> 03: https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/2893945e-2d52-42b6-800c-befa6c68868f
    --> point:
    /*  dedent: The dedent package is used to remove leading whitespace from multiline strings in JavaScript. 
        It's particularly helpful when you have long strings that span multiple lines, and you want to maintain clean, 
        readable code without manually removing indentation.
        
        Jest: Jest is a popular testing framework for JavaScript projects, primarily used for testing Node.js 
        applications and front-end JavaScript code.
        Jest is a powerful and versatile testing framework that simplifies the process of writing and running tests 
        for JavaScript projects. Whether you're working on a Node.js backend, a front-end JavaScript application, or a 
        full-stack project, Jest can help you ensure the quality and reliability of your codebase through automated testing.


    */

    --> creating new migration for to add users table
        npm run migrate create add users table
       
    --> drop socailnetwork database and create newone: socialnetwork database
    --> execute migrate file
        set DATABASE_URL=postgres://postgres:123456@Anand@localhost:5432/socialnetwork&&npm run migrate up
    /*  ### MIGRATION 1712051903171_add-users-table (UP) ###
        CREATE TABLE users(
            id SERIAL PRIMARY KEY,
            created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
            bio VARCHAR(400),
            username VARCHAR(30) NOT NULL
        );
        ;
        INSERT INTO "public"."pgmigrations" (name, run_on) VALUES ('1712051903171_add-users-table', NOW());
        Migrations complete!
    */

--> 04: setting up, index,app, routes, controller
--> 05: Undersatanding connecting pools
        const pg = require('pg');
        class Pool {
            _pool = null;
            connect(options) {
                this._pool = new pg.Pool(options);
            }
        }
        module.exports = new Pool();

--> 06: Validating Connection Credentials

--> 07: Query and Close