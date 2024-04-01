--> 01: https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/33475b6e-0967-4ee1-9212-397a147b9470
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/d3bc0b06-25c5-4715-9410-5f606f752ad2 
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/3beb55c2-7c95-4d58-9b74-c4ebca147129
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/d8ed03bd-0150-4243-b716-67b3e60d2b25
    --> here Schema migration means :changing database structure =>  adding or removing tables or column
    --> Data Migration : we are not changing structure of database anyway : we are moving data aroud very different column

--> 02: Why should we did not do Schema Migration and Data Migration at same time
    --> There are more reason but we are focusing on one reason.
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/d718a28d-ec12-4aa7-a8b5-72413b615f00
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/c59ca9d4-0407-4346-ac1c-819fd5fcac97
    --> one big reason is if any thing wrong then we have to undo whole transaction, it will cost huge time, so that's why 
    --> we should do at same time.

--> 03: Properly Running data and Schema Migration
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/7ce70fd2-a145-4c58-8ca6-dd1f26f9e50a
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/c6b41a6f-343d-4c78-b1d8-2dc3b58c89aa
    --> then we drp lat and lng.

--> 04: https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/a2e57582-ce68-4f68-b319-8fe887473d15
    --> Creating post table
        npm run migrate create add posts table
    --> writing migration file
        exports.up = pgm => {
            pgm.sql(`
            CREATE TABLE posts(
                id SERIAL PRIMARY KEY,
                url VARCHAR(300),
                lat NUMERIC,
                lng NUMERIC
            )
            `);
        };

        exports.down = pgm => {
            pgm.sql(`
            DROP TABLE posts
            `);
        };
    --> executing migration file
        set DATABASE_URL=postgres://username:password@localhost:5432/socailnetwork&&npm run migrate up

     /* ### MIGRATION 1711965017292_add-posts-table (UP) ###
        CREATE TABLE posts(
            id SERIAL PRIMARY KEY,
            url VARCHAR(300),
            lat NUMERIC,
            lng NUMERIC
        );
        INSERT INTO "public"."pgmigrations" (name, run_on) VALUES ('1711965017292_add-posts-table', NOW());
        Migrations complete!
     */

--> 05: Creating Web app
    --> install express pg dotenv and write index.js
        