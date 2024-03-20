--> 1 : What's a Subquery? 
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
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/ec8fa3e9-8344-408d-b8c9-bce0ad62eab9
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/a34bd8a7-0b54-41fa-8504-12df1d1764e6
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/75586833-6d63-4991-ab74-6e5f488537b3


