--> 1 : Sorting by price
        SELECT * 
        FROM products
        ORDER BY price;
  --> : Decreasing order
        SELECT * 
        FROM products
        ORDER BY price DESC;

--> 2 : Sorting based on string
        SELECT * 
        FROM products
        ORDER BY name;
  --> : Decreasing order
        SELECT * 
        FROM products
        ORDER BY name DESC;
-->  :  Sorting when price is same then sort by weight
        SELECT *
        FROM products
        ORDER BY price ASC, weight ASC;
  --> : Decreasing order
        SELECT *
        FROM products
        ORDER BY price ASC, weight DESC;

--> 3 : The 'OFFSET' syntax in SQL is a clause used to skip a certain number of rows when returning the result set of a query. 
    --> It's typically used with the 'LIMIT' clause to handle data pagination in SQL queries efficiently.
    --> The 'LIMIT' option allows you to limit the number of rows returned from a query.
    --> Execlude first 5 products
        SELECT * 
        FROM products
        OFFSET 5;
    --> Print first five most expensive product
        SELECT * 
        FROM products
        ORDER BY price DESC
        LIMIT 5;
    --> Print first 5 least expensive product except most least expensive product
        SELECT * 
        FROM products
        ORDER BY price 
        LIMIT 5
        OFFSET 1;
    --> Suppose you want to show 20 records on page at a time and when we click next then show next 20 record . then we can use limit and offset and handle offset on click : initially offset:0 --> 20--> 40 --> 60---
        SELECT * 
        FROM products
        ORDER BY price 
        LIMIT 20
        OFFSET x; --> where x--> 0--20--30--40--60--80--100----
--> 4 : Sorting, Offsetting and Limiting Question
  --> : Question: Write a query that shows the names of only second and third most expensive phones.
--> 5 : Solutions
  --> : Creating phones table and inserting record
        CREATE TABLE phones(
          id serial PRIMARY KEY,
          name VARCHAR(20),
          manufacturer VARCHAR(200),
          price INTEGER,
          units_sold INTEGER
          );

        INSERT INTO phones (name, manufacturer, price,units_sold)
        VALUES
           ('N1280','Nokia',199,1925),
           ('Iphone 4','Apple',399,9436),
           ('Galaxy S','Samsung',299,2359),
           ('S5620 Monte','Samsung',250,2385),
           ('N8','Nokia',150,7543);

--> 6 : Query:-> Solution
        SELECT name
        FROM phones
        ORDER BY price DESC
        LIMIT 2
        OFFSET 1;
