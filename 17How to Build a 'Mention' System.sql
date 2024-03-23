--> 01: Build Mention Sytsem : concept of tagging and adding loaction
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/fbff33df-92c0-4919-8d36-eff95a5cd03f
--> 02: for caption and loaction
    --> Posts Table
        Table posts {
        id SERIAL [pk, increment]
        url VARCHAR(200)
        created_at TIMESTAMP
        updated_at TIMESTAMP
        user_id INTEGER [REF: > users.id]
        caption VARCHAR(240)
        lat REAL
        lng REAL
        }

--> 03: Since We are Tagging in a specific spot in a photo so so this will not work
    --> 