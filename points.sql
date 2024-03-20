--> Points:
  --> Point:The SELECT DISTINCT statement is used to return only distinct (different) values.
      SELECT DISTINCT department FROM products;
  --> By using the DISTINCT keyword in a function called COUNT, we can return the number of different products.
      SELECT COUNT(DISTINCT department) FROM products;
  --> The SELECT TOP clause is used to specify the number of records to return.
      SELECT TOP 3 * FROM products;
  --> The ANY and ALL operators allow you to perform a comparison between a single column value and a range of other values.
  --> The ANY operator: returns a boolean value as a result returns TRUE if ANY of the subquery values meet the condition ANY means that the condition will be true if the operation is true for any of the values in the range.
      SELECT column_name(s)
      FROM table_name
      WHERE column_name operator ANY (
      SELECT column_name
      FROM table_name
      WHERE condition
      );
  --> The operator must be a standard comparison operator (=, <>, !=, >, >=, <, or <=).
  --> The SQL ALL Operator returns a boolean value as a result --> returns TRUE if ALL of the subquery values meet the condition is used with SELECT, WHERE and HAVING statements
  --> ALL means that the condition will be true only if the operation is true for all values in the range. 
  --> ALL Syntax With SELECT
      SELECT ALL column_name(s)
      FROM table_name
      WHERE condition;

  --> ALL Syntax With WHERE or HAVING
      SELECT column_name(s)
      FROM table_name
      WHERE column_name operator ALL (
      SELECT column_name
      FROM table_name
      WHERE condition
      );
  --> Example
      SELECT *
      FROM products
      WHERE id = ANY (
       SELECT id 
       FROM products 
       WHERE id !=45
      );
  --> All Exapmle
      SELECT *
      FROM products
      WHERE department = ALL (
       SELECT department 
       FROM products 
       WHERE department = 'Toys'
     );
