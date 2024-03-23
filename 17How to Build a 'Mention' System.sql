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
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/c656c3d3-2c0e-4ab4-ad9d-2266ddc485f8
    --> location of tag in x and y coordinate : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/75a3a62e-d102-49e1-acba-fb9d5330364b
    --> there is two type of tags one which is one post and other with in caption : but caption tag can be handled in frontend
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/a0910a56-c9b8-4d01-8872-fa0b98ad6f71

--> 04: https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/238ef554-0bb2-4ab5-b394-8bb0ce6b28d7
    --> How to solve tag issue --> we have two solution
    --> Solution 1: https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/25a03e11-9d7d-42e0-9174-d5848694cbd7
    --> Solution 2: by creating two sepearte table photos tag and captions tag
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/b6adb4e8-d6fd-4520-8d8c-6b912feb3887
    --> to add many functionality we go through solution 2

--> 05: Code 

        Table users {
        id SERIAL [pk, increment]
        username VARCHAR(30)   
        created_at TIMESTAMP
        updated_at TIMESTAMP
        }

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

        Table comments {
        id SERIAL [pk, increment]
        contents VARCHAR(240)
        created_at TIMESTAMP
        updated_at TIMESTAMP
        user_id INTEGER [REF: > users.id]
        post_id INTEGER [REF: > posts.id]
        }

        Table likes {
        id SERIAL [pk, increment]
        created_at timestamp
        user_id INTEGER [REF: > users.id]
        comment_id INTEGER [REF: > comments.id]
        post_id INTEGER [REF: > posts.id]
        }

        Table photo_tags {
        id SERIAL [pk, increment]
        created_at timestamp
        updated_at TIMESTAMP
        user_id INTEGER [REF: > users.id]
        post_id INTEGER [REF: > posts.id]
        x INTEGER
        y INTEGER
        }

        Table caption_tags {
        id SERIAL [pk, increment]
        created_at timestamp
        user_id INTEGER [REF: > users.id]
        post_id INTEGER [REF: > posts.id]
        }

    --> Diagram Design: https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/0dfba5c5-2a15-4974-9619-0fe932a79e09