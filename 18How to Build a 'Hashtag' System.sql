--> 01: https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/5249fcab-3684-4d3a-8990-9f913d7778c7
    --> HashTag can be used in Captons, comments, Bio etc.
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/4591f7d1-c766-49f9-bd87-f1eed2e11d91
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/8868fe79-3404-4b33-9ae9-18f625b4f095
    --> We we really nedd to query users, posts, coments related to hashtag then we should have to model all hashtag seperately
    --> else we can use Polymorphic association
    --> since we search hashtag and after clicking it we shown list of photos under posts
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/879fa739-6ef4-483c-b8a1-f8f5899c5d01
    
--> 02: One possible way :https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/dc68f925-861f-4656-b9ce-4d35bf64a240
    --> for performance concern and to avoid duplication of title of hashtags we can seperate 
    --> like this : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/e5a71c23-fc7a-4b02-93c4-559264fcd2f4

--> 03: Code : We have to add unique Constraints on title
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

    --> Design Image : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/245f203a-b8c1-4eeb-b2eb-1193593e6a03

--> 04: 