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

--> 2 : Thinking about structure of data ? --> Very very Important
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

--> 3 : Exercise 
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/841f604c-055b-4745-8c3b-b8c92cbdf118
--> 4 : Solution
        SELECT name, price, 
         price/(
         Select Max(price)
         FROM phones) AS price_ratio
        FROM phones;
   
--> 5 : 2=> SUBQUERY in FROM 
        https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/ebd14b5b-0408-4422-9192-6a1c84e1d625
        https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/2432de42-f707-4190-b89c-de69cb2097dc
    --> Examples:
        SELECT name, price_weight_ratio
        FROM (
          SELECT name, price / weight AS price_weight_ratio
          FROM products
          ) As p 
        WHERE price_weight_ratio > 5;
    --> 
        SELECT *
        FROM (
         SELECT MAX(price)
         FROM products
         ) as p;
--> 6 : Find Average number of orders for all users
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/3d7a27a6-5293-4da4-912e-3c61ef5432bf
        SELECT AVG(order_count)
        FROM (
         SELECT user_id, COUNT(*) as order_count
         FROM orders
         GROUP BY
         user_id
        )as o;