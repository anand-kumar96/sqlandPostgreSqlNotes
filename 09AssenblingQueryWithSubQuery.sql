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
    --> https://github.com/anand-kumar96/Scaler_Academy/assets/106487247/2e490d70-fcee-4ba7-8c31-8d46e8d48ba1
    --> https://github.com/anand-kumar96/Scaler_Academy/assets/106487247/70e84bbb-e5e9-4080-a7d0-d36dc09814e7
    --> https://github.com/anand-kumar96/Scaler_Academy/assets/106487247/d03366d6-f9a7-4771-b971-8bf3ae4fa4ce
    --> https://github.com/anand-kumar96/Scaler_Academy/assets/106487247/b0349f19-451b-499c-8968-0c3d4279b4da

--> 13: https://github.com/anand-kumar96/Scaler_Academy/assets/106487247/25c577d1-c617-4929-9700-40cd6ba784e7 
    --> https://github.com/anand-kumar96/Scaler_Academy/assets/106487247/f3f5674a-240e-445b-8213-36c4d00cbc08
        SELECT name 
        FROM products
        WHERE price > (
         Select AVG(price)
         FROM products
        );
--> 14: Exercise : https://github.com/anand-kumar96/Scaler_Academy/assets/106487247/90c1f27a-2ae6-4f83-aaa0-b33e838e19e0
--> 15: Solution
        SELECT name,price
        FROM phones 
        WHERE price > (
         SELECT price
         FROM phones 
         WHERE name = 'S5620 Monte' AND manufacturer = 'Samsung'
        );
--> 16: Not In Opetrator with a list : https://github.com/anand-kumar96/Scaler_Academy/assets/106487247/5a61429d-e25b-4fcc-a3dc-6f5d638ac2ed
    --> Solution
        SELECT name,department
        FROM products
        WHERE department NOT IN (
         SELECT department
         FROM products
         WHERE price < 100
        );
--> 17: A New Where Keyword : https://github.com/anand-kumar96/Scaler_Academy/assets/106487247/91ca9d42-2ebe-4171-9499-6ebbc4300f19
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
    --> Question: https://github.com/anand-kumar96/Scaler_Academy/assets/106487247/7ed17738-664e-4801-bedb-b7a6f174d0e2
        SELECT name,department,price
        FROM products
        WHERE price > SOME (
         SELECT price
         FROM products
         WHERE department = 'Industrial'
        );

--> 14: Exercise : https://github.com/anand-kumar96/Scaler_Academy/assets/106487247/b5bb1913-c20b-4f1b-8b94-d4ff51d0e3cd
--> 15: Solution
        SELECT name, manufacturer, price
        FROM phones
        WHERE price > ANY(
         SELECT price
         FROM phones
         WHERE manufacturer = 'Samsung'
        );