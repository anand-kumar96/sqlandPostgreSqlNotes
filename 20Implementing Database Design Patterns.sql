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
    --> Posts Creation
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