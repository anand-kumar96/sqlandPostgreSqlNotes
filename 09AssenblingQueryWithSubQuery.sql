--> 1 : What's a Subquery?
    --> A subquery in SQL is a nested query enclosed within parentheses, used to retrieve data necessary for the main query to execute.
    --> It can appear in various parts of a SQL statement and is commonly used for filtering, joining, or performing calculations.
    --> Question: List the name and price of all products that are more expensive than all products in the 'Toys' department.
    --> Solution: https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/581c0d50-acb1-4fb9-8ffe-501fdaaf60c8
    --> First find most expensive product of toys then find all products which is more expensive than this.
        Select name, price
        From products 
        Where price > (most Expensive Product);
    --> Final Solution : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/a64dac34-d5e0-442b-bfc2-ff56519bc342
        Select Max(price)
        from products
        where department = 'Toys';

        Select name, price 
        from products 
        where price > --- above query put
    --> So whenever we have to write two seperate query and sending them to server or database --> instead we combine this two query in single query using ==> SUBQUERY
    --> SUBQUERY: Subquery can be simply defined as a query within another query. In other words Subquery is a query that is embedded in WHERE clause of another SQL query. 
    --> Important rules for Subqueries: You can place the Subquery in a number of SQL clauses: WHERE clause, HAVING clause, FROM clause.
    --> how to write ?
        Select name, price 
        from products 
        where price > (
        Select Max(price)
        from products
        where department = 'Toys'
        );

--> 3 : Thinking about structure of data ? --> Very very Important
    --> 1 : 1=> SUBQUERY in SELECT 
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/ec8fa3e9-8344-408d-b8c9-bce0ad62eab9
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/a34bd8a7-0b54-41fa-8504-12df1d1764e6
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/75586833-6d63-4991-ab74-6e5f488537b3
    --> Example:
        SELECT price, name, (
          SELECT price 
          FROM products
          WHERE id = 3
        ) As id_3_price
        FROM products
        WHERE price > 867;

--> 4 : Exercise 
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/841f604c-055b-4745-8c3b-b8c92cbdf118
--> 5 : Solution
        SELECT name, price, 
         price/(
         Select Max(price)
         FROM phones) AS price_ratio
        FROM phones;
   
--> 6 : 2=> SUBQUERY in FROM 
        https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/ebd14b5b-0408-4422-9192-6a1c84e1d625
        https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/2432de42-f707-4190-b89c-de69cb2097dc
    --> Examples:
        SELECT name, price_weight_ratio
        FROM (
          SELECT name, price / weight AS price_weight_ratio
          FROM products
          ) As p 
        WHERE price_weight_ratio > 5;
--> 7 :
        SELECT *
        FROM (
         SELECT MAX(price)
         FROM products
         ) as p;
--> 8 : Find Average number of orders for all users
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/3d7a27a6-5293-4da4-912e-3c61ef5432bf
        SELECT AVG(order_count)
        FROM (
         SELECT user_id, COUNT(*) as order_count
         FROM orders
         GROUP BY
         user_id
        )as o;
--> 9 : Exercise => https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/99add27a-54db-48b1-87bf-fca3fcd5f866
--> 10: Solution
        SELECT Max(average_price) As max_average_price
        FROM (
            SELECT AVG(price) as average_price
            FROM phones 
            GROUP BY manufacturer
            ) 
        AS a;

--> 11 : 3=> SUBQUERY in JOIN 
     --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/7eb6e1a3-ff13-4490-9fd9-5c20f1c76c1c
     --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/43387efa-e7f0-4dd0-9f41-a74f5e889b9a
     --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/d45aed59-1fc1-404f-97b7-5ba7f11bed75
         SELECT first_name
         FROM users
         JOIN (
            Select user_id
            FROM orders
            WHERE product_id = 3
         ) AS o 
         ON o.user_id = users.id;
    --> or
        SELECT first_name
        FROM users
        JOIN orders As o
        ON o.user_id = users.id
        WHERE o.product_id =3;

--> 12 : 3=> SUBQUERY in WHERE 