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

-->5&6: Creating Web app
    --> install express pg dotenv and write index.js
    --> code in IG folder

--> 07: Addling loc(location) Column
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/2ab09b5f-1f3a-4f56-bc09-d52967b38952
    --> Step 1 : Generate migration file for adding loc column
        exports.up = pgm => {
        pgm.sql(`
        ALTER TABLE posts
        ADD COLUMN loc POINT;
        `);
        };

        exports.down = pgm => {
        pgm.sql(`
        ALTER TABLE posts
        DROP COLUMN loc;
        `);
        };
    --> execute migration file
        set DATABASE_URL=postgres://username:password@localhost:5432/socailnetwork&&npm run migrate up
     /* ### MIGRATION 1712033205449_add-loc-to-posts (UP) ###
        ALTER TABLE posts
        ADD COLUMN loc POINT;;
        INSERT INTO "public"."pgmigrations" (name, run_on) VALUES ('1712033205449_add-loc-to-posts', NOW());
        Migrations complete!
     */

--> 08: Step 2 : now change server code to show location column
    --> modifing createpost
        exports.createPost = async(req,res)=>{
        const{lng,lat} = req.body;
        await pool.query(`
        INSERT INTO posts(lat,lng,loc) 
        VALUES ($1,$2,$3);`,
        [lat,lng,`(${lng}, ${lat})`]
        );
        res.redirect('/posts');
        }
    --> now create post and see in pg admin
--> 09: copy lat/lng to loc
    --> method 1 : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/e9fa97ae-1152-44f6-a067-db543cedd9ef
    --> issue with first method : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/75ca7d52-5385-475e-bd0b-3f717649c0cc
    ---> method 02 : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/4e4d572b-8c50-48b4-bdfe-bb7f4105d008
    --> In both method there is a big issue that if our bulk update transaction is running for long time and if user want to update his data 
    --> which is lock since it is proccessed by transaction 1 then user transcation should have to wait unitil transcation 1
    --> did not completed all update
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/2d1f17b4-cb46-4254-9bbc-f637dd447a2d
    --> Open two query tool window in pgadmin and open transaction in 1 and transaction in 2
    --> in transcation 1
        SELECT * FROM posts;

        BEGIN;

        UPDATE posts
        SET lat = 56
        WHERE id = 1;
    
    --> in transcation 2
        SELECT * FROM posts;

        UPDATE posts
        SET lat = 60
        WHERE id = 1;
    --> it will show : waiting for the query to complete...
    --> here transcation 1 is bulk update transaction and transcation 2 is to update the user data
    --> now comit the transaction 1
        COMMIT;
    --> as we commited transaction 2 processed and update completed

    --. So better way to do batch update means we are going to update in chunk wise means 1million each time, i know biggest downside
    --> is that we can not update whole in one go but it will be better.