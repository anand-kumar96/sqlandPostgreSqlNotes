--> 01: Requirement of A Like System : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/eb4f678e-4e50-4a30-8634-39b5baabb74c

--> 02: How Not to Design A Like System : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/52e4ab5f-05e9-426a-b847-dbcdbe7952df
    --> Never add column of likes in post table.
    --> Because There are a lot of Reason : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/bbb618d4-6196-43ca-8aaf-7605d704fb32

--> 03: Better way to Design A Like System : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/172d4365-40df-4a9f-ad32-a8247185b31d
    --> UNIQUE(user_id, post_id) => means combine both value or resulting value should be unique.
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/b4c66b5c-6797-44a8-ab7e-8ace5e4acaec
    --> SOME IMPORTANT QUERY

    --> # of likes on post with id =3
        SELECT COUNT(*)
        FROM likes
        WHERE post_id = 3;

    --> Id's of top five most liked posts
        SELECT posts.id
        FROM posts
        JOIN likes ON posts.id = likes.post_id
        GROUP BY posts.id
        ORDER BY COUNT(*) DESC
        LIMIT 5;

    --> Username of people who likes post with id = 3
        SELECT username
        fROM likes
        JOIN users ON users.id = likes.user_id
        WHERE post_id = 3;

    --> Url of posts that user with id = 4 liked
        SELECT url
        fROM likes
        JOIN posts ON posts.id = likes.post_id
        WHERE likes.user_id = 4;

    --> This type of design is same for Favourites, bookmarks ***
    --> This Design can not handle comment likes and reaction like Facebook. 

--> 04: Making a Recation System Design
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/b79a1a2c-baff-4df4-86bf-7a218be2de61

--> 05: Plymorphic association : To allow uses to either like a post or like a comments
    --> 1st  Possible Solution :
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/584c56e6-a96c-4b97-ab44-181806ed7c68
    --> Plymorphic association is not good as per data consistency : But still see in some ruby and rails project
--> 06: 2nd
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/e2f49130-ab68-4908-bf40-ed99f2f55f33
    --> We have to write a validation that likes have either post_id and comment_id, we have to ensure that both should not be null.
    --> so this is also little bit complicated
    --> COALESCE:it is a function which Return the first non-null value in a list:
        SELECT COALESCE(NULL, NULL, NULL, 'W3Schools.com', NULL, 'Example.com'); --> it return: W3Schools.com
        SELECT COALESCE((4):: BOOLEAN :: INTEGER ,0)--> 1
        SELECT COALESCE((NULL):: BOOLEAN :: INTEGER ,0)--> 0
    --> to check
        CHECK (
        (
        (SELECT COALESCE((4)::BOOLEAN::INTEGER, 0)) +
        (SELECT COALESCE((4)::BOOLEAN::INTEGER, 0))
        ) = 1
        );
--> 07: 3rd Best and Simplest Solution
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/d14a3acf-4bf1-4f9c-9f56-adcd023d92ab
        
--> 08: Which Solution We use : Since we don't have to store any information for like for post and like for comment so we are going through 2nd method
    --> How to models

    --> Users Table
        Table users {
        id SERIAL [pk, increment]
        username VARCHAR(30)
        created_at TIMESTAMP
        updated_at TIMESTAMP
        }
    --> Posts Table
        Table posts {
        id SERIAL [pk, increment]
        url VARCHAR(200)
        created_at TIMESTAMP
        updated_at TIMESTAMP
        user_id INTEGER [REF: > users.id]
        }
    --> Comments Table
        Table comments {
        id SERIAL [pk, increment]
        contents VARCHAR(240)
        created_at TIMESTAMP
        updated_at TIMESTAMP
        user_id INTEGER [REF: > users.id]
        post_id INTEGER [REF: > posts.id]
        }
    --> Likes Table
        Table likes {
        id SERIAL [pk, increment]
        created_at timestamp
        user_id INTEGER [REF: > users.id]
        comment_id INTEGER [REF: > comments.id]
        post_id INTEGER [REF: > posts.id]
        }
    --> Diagram: https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/35a77a90-8bc2-4c18-bdc0-5f8e8df7b6f7
    