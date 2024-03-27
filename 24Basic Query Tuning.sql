--> 01: https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/324aaf5c-395d-480c-a749-ab7ad3a2d040
--> 02: Two query for analyze planner : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/9aed3da7-a433-4540-909d-c73bba94a375
        EXPLAIN --> Build a query plan and display info about it
        EXPLAIN ANALYZE --> Build a query plan, run it, and info about it.
    --> Example
        EXPLAIN SELECT username, contents
        FROM users
        JOIN comments ON comments.user_id = users.id
        WHERE username = 'Alyson14';
    --> or
        EXPLAIN ANALYZE SELECT username, contents
        FROM users
        JOIN comments ON comments.user_id = users.id
        WHERE username = 'Alyson14';

--> 03: https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/3a60f830-b985-430e-96d5-9a13d95f2141
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/ee2245a6-c1ff-42b9-b3f6-8700c5d964bf
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/647d0797-5cff-4da5-a285-b5e243d8b303
    --> How query planner make a guess of cost and other things without accessing the users table : lets see stats
        SELECT * 
        FROM pg_stats
        WHERE tablename = 'users'; 
       