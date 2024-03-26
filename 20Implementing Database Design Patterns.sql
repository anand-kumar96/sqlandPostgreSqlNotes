--> 01: https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/4dbdff7e-fa49-48b7-a5d0-0fa3d056b777

--> 02: Creating instagram database and tables and performing query in query tools
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/74be8865-986f-428f-a60d-b61473ce5c2e
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/6f33aacd-d782-4959-baf3-e5dac210e35a
    --> Creating Users Table
        CREATE Table users (
        id SERIAL PRIMARY KEY,
        created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
        username VARCHAR(30) NOT NULL,
        bio VARCHAR(400),
        avatar VARCHAR(200),
        phone VARCHAR(25),
        email VARCHAR(50),
        password VARCHAR(50),
        status VARCHAR(15),
        CHECK(COALESCE(phone,email) IS NOT NULL)
        )
    
--> 03: valid lattitue and longitude => lat : -90 < lat < 90, lang : -180 < lat < 180
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/a261fdfb-5750-46ff-8bd4-f4b1734a6291
    --> validation for lat : CHECK(lat IS NULL OR (lat >=- 90 AND lat <= 90)),
    --> Posts creation
        CREATE Table posts (
        id SERIAL PRIMARY KEY,
        created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
        url VARCHAR(200) NOT NULL,
        caption VARCHAR(240),
        lat REAL CHECK(lat IS NULL OR (lat >=- 90 AND lat <= 90)),
        lng REAL CHECK(lng IS NULL OR (lng >=- 180 AND lng <= 180)),
        user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE
        ) 
    
--> 04: Comments creation
        CREATE Table comments (
        id SERIAL PRIMARY KEY,
        created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
        contents VARCHAR(240) NOT NULL,
        user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        post_id INTEGER NOT NULL REFERENCES posts(id) ON DELETE CASCADE
        );

--> 05: Likes creation
        CREATE Table likes (
        id SERIAL PRIMARY KEY,
        created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
        user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        post_id INTEGER REFERENCES posts(id) ON DELETE CASCADE,
        comment_id INTEGER REFERENCES comments(id) ON DELETE CASCADE
        CHECK(
            COALESCE((post_id):: BOOLEAN :: INTEGER , 0)
            +
            COALESCE((comment_id):: BOOLEAN :: INTEGER , 0)
            = 1
        ),
    --> At least one should be null as we discuss
        UNIQUE(user_id,post_id,comment_id)
    --> it is concatnated value that should be unique
        );

--> 06: Photo_tags creation
        CREATE Table photo_tags(
        id SERIAL PRIMARY KEY,
        created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
        user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        post_id INTEGER NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
        x INTEGER NOT NULL,
        y INTEGER NOT NULL,
        UNIQUE(user_id, post_id)
        );

--> 07: Caption Tags creation
        CREATE Table caption_tags(
        id SERIAL PRIMARY KEY,
        created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
        user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        post_id INTEGER NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
        UNIQUE(user_id, post_id)
        );

    --> hashTags creation
        CREATE Table hashtags(
        id SERIAL PRIMARY KEY,
        created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
        title VARCHAR(20) NOT NULL UNIQUE
        );
    
    --> hashtags_posts creation
        CREATE Table hashtags_posts(
        id SERIAL PRIMARY KEY,
        hashtag_id INTEGER NOT NULL REFERENCES hashtags(id) ON DELETE CASCADE,
        post_id INTEGER NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
        UNIQUE(hashtag_id, post_id)
        );

    --> Followers creation
        CREATE Table followers(
        id SERIAL PRIMARY KEY,
        created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
        leader_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        follower_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        UNIQUE(leader_id, follower_id)
        );

    --> leader_id: Which is followed , follower_id: who is following