--> 01: https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/86eace88-6240-4752-8e79-99b1b245793b
    --> Some Important Schema Designers https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/910f0b06-84e1-4d22-8949-47a66dcf46a3
    --> dbdiagram.io, drawsql.app, saldbm.com, qucikdatabasediagrams.com, ondras.zarovi.cz/sql/demo

--> 02: Schema Design using--> 
    --> Diagram based--> ondras.zarovi.cz/sql/demo : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/41513233-8c08-4957-9e5c-cee92d5e8082
    --> Code based--> dbdiagram.io : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/41513233-8c08-4957-9e5c-cee92d5e8082
        Table users {
        id integer [primary key]
        username varchar
        }

        Table comments {
        id integer [primary key]
        contents varchar
        post_id integer
        user_id integer
        }

        Table posts {
        id integer [primary key]
        title varchar
        user_id integer
        }
        Ref: posts.user_id > users.id // many-to-one
        Ref: comments.user_id >  users.id
        Ref: comments.post_id > posts.id
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/357afa16-71be-40fe-b47b-5127c054bf20
    --> or   
        Table users {
        id integer [primary key]
        username varchar
        }

        Table comments {
        id integer [primary key]
        contents varchar
        post_id integer [ref:  > users.id ]
        user_id integer [ref:  > posts.id ]
        }
        
        Table posts {
        id integer [primary key]
        title varchar
        user_id integer [ref:  > users.id ]
        }