--> 01: What's a Subquery?
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

--> 03: Thinking about structure of data ? --> Very very Important
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

--> 04: Exercise 
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/841f604c-055b-4745-8c3b-b8c92cbdf118
--> 05: Solution
        SELECT name, price, 
         price/(
         Select Max(price)
         FROM phones) AS price_ratio
        FROM phones;
   
--> 06: 2=> SUBQUERY in FROM 
        https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/ebd14b5b-0408-4422-9192-6a1c84e1d625
        https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/2432de42-f707-4190-b89c-de69cb2097dc
    --> Examples:
        SELECT name, price_weight_ratio
        FROM (
          SELECT name, price / weight AS price_weight_ratio
          FROM products
          ) As p 
        WHERE price_weight_ratio > 5;
--> 07: OR
        SELECT *
        FROM (
         SELECT MAX(price)
         FROM products
         ) as p;
--> 08: Find Average number of orders for all users
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/3d7a27a6-5293-4da4-912e-3c61ef5432bf
        SELECT AVG(order_count)
        FROM (
         SELECT user_id, COUNT(*) as order_count
         FROM orders
         GROUP BY
         user_id
        )as o;
--> 09: Exercise => https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/99add27a-54db-48b1-87bf-fca3fcd5f866
--> 10: Solution
        SELECT Max(average_price) As max_average_price
        FROM (
            SELECT AVG(price) as average_price
            FROM phones 
            GROUP BY manufacturer
            ) 
        AS a;

--> 11: 3=>SUBQUERY in JOIN 
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

--> 12: 3=> SUBQUERY in WHERE =>USEFUL***
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/f25fb0e7-fc83-41b8-bfca-d3096d0fae30 
        SELECT o.id, p.price/p.weight as price_weight_ratio
        FROM orders As o
        JOIN products As p
        ON p.id= o.product_id
        WHERE p.price/p.weight > 5;
    --> using SubQueries
        SELECT id
        FROM orders
        WHERE product_id IN (
        SELECT id 
        FROM products
        WHERE price/weight > 5
        );
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/a9ba763f-d3ce-4718-badb-06e8d81215dc
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/485438d3-a2bf-4dd2-b263-e81622df3efd
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/85020cbf-9107-468f-901e-90ffdc951ffa
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/b5b6b811-1e63-4ed3-a22a-8594ef271691

--> 13: https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/b6c6be6b-0040-41b9-8bc0-2dc8d60a8850
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/a72478b2-2749-4d02-9525-e9b99520044c
        SELECT name 
        FROM products
        WHERE price > (
         Select AVG(price)
         FROM products
        );
--> 14: Exercise : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/182d1d16-e3fd-4845-b55d-19f0abc0335f
--> 15: Solution
        SELECT name,price
        FROM phones 
        WHERE price > (
         SELECT price
         FROM phones 
         WHERE name = 'S5620 Monte' AND manufacturer = 'Samsung'
        );
--> 16: Not In Opetrator with a list : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/d6524ab9-6f95-43a5-8fd0-eb7c91f399f8
    --> Solution
        SELECT name,department
        FROM products
        WHERE department NOT IN (
         SELECT department
         FROM products
         WHERE price < 100
        );
--> 17: A New Where Keyword : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/1e0c04ba-1159-47d0-a8c2-f654b2db3d39
    --> Solution
        SELECT name,department,price
        FROM products
        WHERE price > (
         SELECT Max(price)
         FROM products
         WHERE department = 'Industrial'
        );
    --> or
        SELECT name,department,price
        FROM products
        WHERE price > All (
         SELECT price
         FROM products
         WHERE department = 'Industrial'
        );
    --> when less expensive
        SELECT name,department,price
        FROM products
        WHERE price < All (
         SELECT price
         FROM products
         WHERE department = 'Industrial'
        );
    --> when more and equal to expensive
        SELECT name,department,price
        FROM products
        WHERE price >= All (
         SELECT price
         FROM products
         WHERE department = 'Industrial'
        );
    --> when equal to expensive
        SELECT name,department,price
        FROM products
        WHERE price = All (
         SELECT price
         FROM products
         WHERE department = 'Industrial'
        );
    --> when not eqaul to expensive
        SELECT name,department,price
        FROM products
        WHERE price <> All (
         SELECT price
         FROM products
         WHERE department = 'Industrial'
        );
--> 18: Some Keyword : Some is actually an Alias to Any => so Some and Any both are same => means atleast
    --> price >Some (20,100) --> price is greater than atleast one value from 20 and 100
    --> Question: https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/d2938b1f-cfae-4a8d-a083-259cf477d401
        SELECT name,department,price
        FROM products
        WHERE price > SOME (
         SELECT price
         FROM products
         WHERE department = 'Indust;rial'
        );

--> 19: Exercise : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/e8d783ac-ebe0-4981-b253-124ba2b6d252
--> 20: Solution
        SELECT name, manufacturer, price
        FROM phones
        WHERE price > ALL(
         SELECT price
         FROM phones
         WHERE manufacturer = 'Samsung'
        );
--> 21: Correlated SubQuery: A correlated subquery is a subquery that uses values from the outer query.
        /* A correlated scalar subquery is used in the same way that a column is used, 
           while an uncorrelated scalar subquery is used in the way that a constant value is used. 
           Scalar subqueries are not valid in the following cases: When used in ORDER BY and GROUP BY clauses.
        */
    --> We can use Correlated SubQuery any where not only in Where Keywords.
    --> Watch again for clearity
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/f59e66c7-b42f-4cf8-ac85-ebea4e5e5a7d
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/d4ee8a1a-6d74-4b6f-beff-a61fe262e038
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/1e2a0eb5-a1f3-4911-a4d0-154448cff125
        SELECT name, department, price
        FROM products as p1
        WHERE p1.price = (
          SELECT Max(price)
          FROM products as p2
          WHERE p2.department = p1.department
        );

--> 22: More on Correlated SubQuery : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/8823319b-baa7-48b5-91ad-998eff11d480
        SELECT p.name, p.department, (
         SELECT Count(*) as product_count
         FROM orders As o
         WHERE o.product_id= p.id
        )
        FROM products as p; 
--> 23: Select without a Form : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/8de6ac39-9b8e-46a5-8a61-d2af6bd04e15
    --> its work for only single value
        SELECT (
          SELECT name
          FROM products 
          WHERE id =1
        );
    --> other
        SELECT (
          SELECT MAX(price)
          FROM products 
        ),(
          SELECT MIN(price)
          FROM products 
        );

--> 24: Exercise : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/b8ef5d96-642a-467f-83db-1151bd3d2f8e
--> 25: Solution
        SELECT 
         (SELECT MAX(price) FROM phones) AS max_price, 
         (SELECT MIN(price) FROM phones) AS min_price, 
         (SELECT AVG(price) FROM phones) AS avg_price;
