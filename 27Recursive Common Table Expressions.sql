--> 01: https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/38fae19e-ac92-47ce-bef5-4ba066ec3ba5
    --> Recursive CTE: A recursive CTE references itself. It returns the result subset, then it repeatedly (recursively) 
    --> references itself, and stops when it returns all the results.
    --> Recursive CTEs are used primarily when you want to query hierarchical data or graphs.
    --> Syntax
        WITH RECURSIVE cte_name AS (
        cte_query_definition (the anchor member)
 
        UNION ALL
        cte_query_definition (the recursive member)
        )

        SELECT *
        FROM   cte_name;

    --> Example
        WITH RECURSIVE countdown(val) AS (
        SELECT 40 AS val
        UNION ALL
        SELECT val - 1
        FROM countdown
        WHERE val > 1
        )

        SELECT val as count_number
        FROM countdown
        ORDER BY val;

    --> Below code is recursive CTE
        WITH RECURSIVE countdown(val) AS (
        SELECT 40 AS val
        UNION ALL
        SELECT val - 1
        FROM countdown
        WHERE val > 1
        )

--> 02: 