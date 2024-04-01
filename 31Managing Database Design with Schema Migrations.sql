--> 01: A Story on Migration : A Complete theory But Important.
--> What is Migration File ? 
    /*
    migration files provide a structured and version-controlled approach to managing database schema changes,
    making it easier for developers to collaborate on database-related tasks and ensuring consistency across different environments.
    */
--> 02: how to change column name
        ALTER TABLE accounts
        RENAME COLUMN name TO title;
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/349fdea2-4943-4cb2-b207-7ea498da68ed
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/9fc36a97-f853-4c11-8ffa-280d5be3012c
    --> A Migration file can be written in any programming language. In General Schema migration file have two different
    --> section one is Up and Other is Down.
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/75766466-aa3e-4a6e-895e-cdb002cf8633
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/ddb18f08-7cd9-4877-ae9d-0cbae2edaf86
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/9d15a373-f8c6-4205-a2be-783ca3e86a23

--> 03: Issue Solved by Migration File
    --> 1 https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/ca8f8a86-0e25-43f2-b9b6-818b68893a64
    --> 2 https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/ac5d89a9-3109-45f6-8c1b-916d9ac0757a

-->4&5: Different Library for Creating Migration File
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/b6c82f6e-cf83-44de-8fbf-7d72f8f304c0

    --> using node-pg-migrate => https://www.npmjs.com/package/node-pg-migrate
    --> Recommendation: Many migration tools can automatically generate migrations for us ==> We higly recommend you to write
    --> all migrations manually using plain SQL - since you have enough knowledge for this.

--> 06: Project Creation
    --> Open terminal : mkdir ig => cd ig => npm init => npm install node-pg-migrate pg
    --> instead modifying instagram database we will create new database => socialnetwork
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/664e6665-170a-4ab7-acea-672aa980531e

--> 07: Generating And Writing Migration
    --> creating socialnetwork database using pgadmin
    --> in script add => "migrate": "node-pg-migrate"
    --> to generate new migration file => npm run migrate create migration_filename
        npm run migrate create table comments
    --> it will create migrations folder now write plain sql in xxxxtabe_comments.js
        /* eslint-disable camelcase */
        exports.shorthands = undefined;
        exports.up = pgm => {
            pgm.sql(`
            CREATE TABLE comments (
                id SERIAL PRIMARY KEY,
                created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
                updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
                contents VARCHAR(250) NOT NULL
            )
            `);
        };
        exports.down = pgm => {
            pgm.sql(`
                DROP TABLE comments;
            `);
        };

--> 08: Applying and Reverting Migration
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/c51e4951-e90c-46d5-8ab6-d76409c116cc
    --> Database_url : postgres://username:password@localhots:5432/databasename 
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/39d6f636-5e65-4433-94e9-8cf6bf884ecc
        set DATABASE_URL=postgres://username:password@localhost:5432/socailnetwork&&npm run migrate up
    --> we will got message
     /* Migrating files:
        > - 1711953855147_table-comments
        ### MIGRATION 1711953855147_table-comments (UP) ###

        CREATE TABLE comments (
            id SERIAL PRIMARY KEY,
            created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
            contents VARCHAR(250) NOT NULL
        );
        INSERT INTO "public"."pgmigrations" (name, run_on) VALUES ('1711953855147_table-comments', NOW());
        Migrations complete!
     */

    --> now if we check pg admin we can get two table is created, one is comment table and other is pgmigrations table
    --> we found taht we are written something wrong then run below command : it will drop table : comments
        set DATABASE_URL=postgres://username:password@localhost:5432/socailnetwork&&npm run migrate down

--> 09: Generating and Applying Second migration
        npm run migrate create rename contents to body --> it will create new migration
    --> now open project 
        exports.up = pgm => {
            pgm.sql (`
            ALTER TABLE comments
            RENAME COLUMN contents to body
            `);
        };

        exports.down = pgm => {
            pgm.sql (`
            ALTER TABLE comments
            RENAME COLUMN body to contents
            `);
        };
    --> now run this command to execute migration file
        set DATABASE_URL=postgres://username:password@localhost:5432/socailnetwork&&npm run migrate down
    --> it will execute both migration file 
     /* ### MIGRATION 1711953855147_table-comments (UP) ###

        CREATE TABLE comments (
            id SERIAL PRIMARY KEY,
            created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
            contents VARCHAR(250) NOT NULL
        );
        INSERT INTO "public"."pgmigrations" (name, run_on) VALUES ('1711953855147_table-comments', NOW());

        ### MIGRATION 1711958841145_rename-contents-to-body (UP) ###

        ALTER TABLE comments
        RENAME COLUMN contents to body;
        INSERT INTO "public"."pgmigrations" (name, run_on) VALUES ('1711958841145_rename-contents-to-body', NOW());
        Migrations complete!
     */