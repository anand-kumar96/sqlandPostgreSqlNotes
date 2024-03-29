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
    --> 