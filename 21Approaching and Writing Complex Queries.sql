--> 01: downloading fake data : database backup
--> 02: now select database in pgadmin and click and select restore and select downloaded file 
    --> Restore option :  verbose messages-> yes, only data: Yes, donot save-> owner:yes, query--> single transcation : yes , disbale -> trigger:yes
    --> now restore
    --> ERROR HANDLING : If You are getting error while restorein the data then make sure that you have set binary path
    --> for setting binary path: open pg admin --> file --> preferences --> Paths --> binary paths : now in both  set binary path: C:\Program Files\PostgreSQL\16\bin
    --> may be  your bin file of postgresql will be diffrent location so get it and paste in both postgresql16 and save

--> 03: to restore without creating table==> add restore option of these field
    --> verbose messages-> yes, donot save-> owner:yes, query--> single transcation : yes , disbale -> trigger:yes
    --> Code to create Table :
        CREATE TABLE users (
            id SERIAL PRIMARY KEY,
            created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
            username VARCHAR(30) NOT NULL,
            bio VARCHAR(400),
            avatar VARCHAR(200),
            phone VARCHAR(25),
            email VARCHAR(40),
            password VARCHAR(50),
            status VARCHAR(15),
            CHECK(COALESCE(phone, email) IS NOT NULL)
        );

        CREATE TABLE posts (
            id SERIAL PRIMARY KEY,
            created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
            url VARCHAR(200) NOT NULL,
            caption VARCHAR(240),
            lat REAL CHECK(lat IS NULL OR (lat >= -90 AND lat <= 90)), 
            lng REAL CHECK(lng IS NULL OR (lng >= -180 AND lng <= 180)),
            user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE
        );

        CREATE TABLE comments (
            id SERIAL PRIMARY KEY,
            created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
            contents VARCHAR(240) NOT NULL,
            user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
            post_id INTEGER NOT NULL REFERENCES posts(id) ON DELETE CASCADE
        );

        CREATE TABLE likes (
            id SERIAL PRIMARY KEY,
            created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
            user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
            post_id INTEGER REFERENCES posts(id) ON DELETE CASCADE,
            comment_id INTEGER REFERENCES comments(id) ON DELETE CASCADE,
            CHECK(
                COALESCE((post_id)::BOOLEAN::INTEGER, 0)
                +
                COALESCE((comment_id)::BOOLEAN::INTEGER, 0)
                = 1
            ),
            UNIQUE(user_id, post_id, comment_id)
        );

        CREATE TABLE photo_tags (
            id SERIAL PRIMARY KEY,
            created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
            user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
            post_id INTEGER NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
            x INTEGER NOT NULL,
            y INTEGER NOT NULL,
            UNIQUE(user_id, post_id)
        );

        CREATE TABLE caption_tags (
            id SERIAL PRIMARY KEY,
            created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
            user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
            post_id INTEGER NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
            UNIQUE(user_id, post_id)
        );

        CREATE TABLE hashtags (
            id SERIAL PRIMARY KEY,
            created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
            title VARCHAR(20) NOT NULL UNIQUE
        );

        CREATE TABLE hashtags_posts (
            id SERIAL PRIMARY KEY,
            hashtag_id INTEGER NOT NULL REFERENCES hashtags(id) ON DELETE CASCADE,
            post_id INTEGER NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
            UNIQUE(hashtag_id, post_id)
        );

        CREATE TABLE followers (
            id SERIAL PRIMARY KEY,
            created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
            leader_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
            follower_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
            UNIQUE(leader_id, follower_id)
        );
--> 04: https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/db556f14-78ef-4a04-9c72-b143f4b176d8
--> 05: Solution
        SELECT * 
        FROM users
        ORDER BY id DESC 
        LIMIT 3;
--> 06: https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/05527478-da95-4895-a6d4-7ddbae265cad
--> 07: Solution
        SELECT u.username, p.caption
        FROM posts AS p
        JOIN users As u
        On u.id = p.user_id
        WHERE p.user_id = 200;
--> 08: hhttps://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/4e2ec1ed-aee5-4148-9627-31b1241ebea8
--> 09: Solution
        SELECT username, Count(*) AS total_likes
        FROM likes As l
        JOIN users AS u
        ON u.id = l.user_id
        Group By u.username;
