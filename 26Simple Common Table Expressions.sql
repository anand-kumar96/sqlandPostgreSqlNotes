--> 01: Question
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/e79dc722-8751-4008-ab7d-4ab6888feb51

--> 02: Solution
        (
        SELECT username, photo_tags.created_at
        FROM users
        JOIN photo_tags 
        ON users.id = photo_tags.user_id
        WHERE photo_tags.created_at  < '2010-01-7'
        )
        UNION
        (
        SELECT username, caption_tags.created_at
        FROM users
        JOIN caption_tags 
        ON users.id = caption_tags.user_id
        WHERE caption_tags.created_at  < '2010-01-7'
        ); 
    
    --> Or
        SELECT username, tags.created_at
        FROM users
        JOIN (
               SELECT user_id, created_at FROM photo_tags
               UNION
               SELECT user_id, created_at FROM caption_tags  
             ) AS tags
        ON tags.user_id = users.id
        WHERE tags.created_at  < '2010-01-7';

--> 03: Commaon Table Expression : The CTE , also known as the WITH clause.
     /* A Common Table Expression (CTE) is the result set of a query which exists temporarily and for use 
        only within the context of a larger query. Much like a derived table, 
        the result of a CTE is not stored and exists only for the duration of the query.
        There are two type of CTE
        1) Non Recursive CTE
        2) Recursive CTE
     */
    --> Syntax
        WITH cte_name AS (cte_query_definition)
        SELECT *
        FROM   cte_name;

    --> Example
        With tags As (
	         SELECT user_id, created_at FROM photo_tags
             UNION
             SELECT user_id, created_at FROM caption_tags 
        ) 
    
    --> Now above solution can be written as
        With tags As (
            SELECT user_id, created_at FROM photo_tags
            UNION
            SELECT user_id, created_at FROM caption_tags 
        ) 
        SELECT username, tags.created_at
        FROM users
        JOIN tags
        ON tags.user_id = users.id
        WHERE tags.created_at  < '2010-01-7';
    
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/a802dc26-f261-4d1d-b1c2-7e7b5b6ac4da
