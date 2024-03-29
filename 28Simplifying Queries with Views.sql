--> 01: Question: https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/6694a971-8e41-4a43-b5cc-a8ad5fef31fc
    --> we use union and put together photo and caption tag 
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/aae3879c-518f-4404-97c9-807f72be10a4
    --> now join tag and user table
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/785798f6-f4bc-4b37-a6df-eb9b8f31ba10
    --> Solution
        SELECT  username, Count(*)
        FROM users
        JOIN (
            SELECT user_id 
            FROM photo_tags
            UNION ALL
            SELECT user_id 
            FROM caption_tags
        ) AS tags
        ON tags.user_id = users.id
        GROUP By username
        ORDER By  Count(*) DESC;

    --> using CTE
        WITH tags As (
            SELECT user_id 
            FROM photo_tags
            UNION ALL
            SELECT user_id 
            FROM caption_tags	
        )
        SELECT  username, Count(*)
        FROM users
        JOIN tags
        ON tags.user_id = users.id
        GROUP By username
        ORDER By  Count(*) DESC;

--> 02: Since We are doing Union between photo_tags and caption_tags multiple times which did not reslut good design so may 
    --> be we did some design mistake --> so we have to make a tag instead of seperate tag
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/10c95133-7868-4528-b51e-610e35d5f24f
    --> Solution 01: Merge two tables and delete Original table
    --> Create Single tags Table
        CREATE TABLE tags (
        id SERIAL PRIMARY KEY,
        created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
        user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        post_id INTEGER NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
        x INTEGER,
        y INTEGER
        );

    --> Copy all the row from photo_tags
        INSERT INTO tags(created_at, updated_at, user_id, post_id, x, y)
        SELECT created_at, updated_at, user_id, post_id, x, y
        FROM photo_tags;
    --> Copy all the row from caption_tags
        INSERT INTO tags(created_at, updated_at, user_id, post_id)
        SELECT created_at, updated_at, user_id, post_id
        FROM caption_tags;
    --> Now delete Original Tables
        DROP TABLE photo_tags;
        DROP TABLE caption_tags;
    --> 1) Can't copy over the ID's of photo_tags and caption_tags since they must be unique
    --> 2) If We delete original tables,we break any existing queries that refer to them.

--> 03: Solution 2 : Create a View
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/f81fc445-612f-4486-9634-d80f00fd168b
    --> What is View ?  
    --> A view is a virtual table that contains rows and columns of data, and is based on the result set of an SQL statement. 
    --> Views are useful for organizing tables in a database and can simplify complex queries, data access, and security.
    --> but a view doesn’t store data on the disk like a table.
    --> Creating View Syntax
        CREATE VIEW view_name AS
        SELECT column1, column2.....
        FROM table_name
        WHERE condition;
    --> now simplyfying above query using view
        CREATE VIEW tags AS (
        SELECT id, created_at, user_id, post_id, 'photo_tag' AS type FROM photo_tags
        UNION ALL
        SELECT id, created_at, user_id, post_id, 'caption_tag' AS type FROM caption_tags
        );
    --> now 
        SELECT * FROM tags; 

        SELECT * 
        FROM tags
        WHERE type = 'caption_tag'
        ;

    --> Now Best Solution of Question using view 
        SELECT username, Count(*)
        from users 
        JOIN tags 
        On tags.user_id = users.id
        GROUP BY username
        ORDER BY Count(*) DESC; 

--> 04: When to use View ?
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/6f3be441-a1b2-4e57-b560-d028c2c15beb
    --> To Solve simillar type of problems i mean to avoid writing same query for multiple problems we can use View.
    --> Shows the users who created the 10 most recent posts
    --> creating recent_post view
        CREATE VIEW recent_posts AS (
            SELECT *
            FROM posts
            ORDER BY created_at DESC
            LIMIT 10
        );

    --> Query 1
        SELECT user_id, username, rp.created_at AS post_created_at
        FROM recent_posts as rp
        JOIN users
        ON users.id = rp.user_id;

    --> Query 2
        SELECT likes.post_id, Count(*) as total_likes
        FROM recent_posts
        JOIN likes 
        ON likes.post_id = recent_posts.id
        GROUP BY likes.post_id;

    --> Query 3
        SELECT username  
        FROM recent_posts 
        JOIN users 
        On users.id = recent_posts.user_id;

    --> Query 4
        SELECT hashtag.post_id, hashtag.title as hashtag_title
        FROM recent_posts
        JOIN (
            SELECT post_id, h.title
            FROM hashtags_posts
            JOIN hashtags AS h
            ON hashtags_posts.hashtag_id = h.id
        ) As hashtag
        ON hashtag.post_id = recent_posts.id; 

    --> Query 5
        SELECT recent_posts.id as post_id, AVG(hashtags_posts.hashtag_id) as Average_hashtags
        FROM recent_posts
        JOIN hashtags_posts 
        ON hashtags_posts.post_id = recent_posts.id
        GROUP BY recent_posts.id;

    --> Query 6
        SELECT COUNT(*) as total_comments
        FROM recent_posts
        JOIN comments 
        ON recent_posts.id = comments.post_id;

--> 05: Deleting and Creating post
    --> create or replace
        CREATE OR REPLACE VIEW recent_posts As (
        SELECT * 
        FROM posts
        ORDER BY created_at DESC
        LIMIT 15
        );

        SELECT * FROM recent_posts;

    --> Delete View
        DROP VIEW recent_posts;