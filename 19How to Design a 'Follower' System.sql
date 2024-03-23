--> 01: Desiging Followers
    --> user_id or leader_id  is who is followed and follower_id is who is following 
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/f3222683-8cc4-4987-b702-3f3197091d1c
    --> we have to check a validation constraint that user can not follow it self
        CHECK(leader_id <> follower_id)
        UNIQUE(leader_id, follower_id)

    --> Code
        Table users {
        id SERIAL [pk, increment]
        created_at TIMESTAMP
        updated_at TIMESTAMP
        bio VARCHAR(400)
        username VARCHAR(30)
        avatar VARCHAR(200)
        phone VARCHAR(25)
        email VARCHAR(50)
        password VARCHAR(50)
        status VARCHAR(15)
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
        post_id INTEGER [REF: > posts.id]
        user_id INTEGER [REF: > users.id]
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
        post_id INTEGER [REF: > posts.id]
        user_id INTEGER [REF: > users.id]
        x INTEGER
        y INTEGER
        }

        Table caption_tags {
        id SERIAL [pk, increment]
        created_at timestamp
        user_id INTEGER [REF: > users.id]
        post_id INTEGER [REF: > posts.id]
        }

        Table hashtags {
        id SERIAL [pk, increment]
        created_at timestamp
        title VARCHAR(20)
        }

        Table hashtags_posts {
        id SERIAL [pk, increment]
        hashtag_id INTEGER [REF: > hashtags.id]
        post_id INTEGER [REF: > posts.id]
        }

        Table followers{
        id SERIAL [pk, increment] 
        created_at timestamp
        leader_id INTEGER [REF: > users.id]
        follower_id INTEGER [REF: > users.id]
        }

    --> Design Image: https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/85c969a0-59fa-4a75-a589-87177bf8c8ca