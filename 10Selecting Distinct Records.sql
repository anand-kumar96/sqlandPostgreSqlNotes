--> 01: Selecting Distinct Values : 
     /* The SELECT DISTINCT statement is used in SQL to return only distinct (different) values. 
        It is used when a column in a table contains many duplicate values, and you only want to list the different (distinct) values */
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/5f548be8-625f-4f45-a37c-a16e9d0a70a3
        SELECT DISTINCT department 
        FROM products;
-->02: Exercise: https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/b65f0bd6-0c78-41fa-86bc-6fe08ee19cf8
-->03: Solution
       SELECT COUNT(DISTINCT manufacturer)
       FROM phones;
       