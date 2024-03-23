--> 01: Handling Sets with Union
    --> Question : Find the 4 products with the highest price and 4 products with the highst price/weight ratio.
    --> Lets Solve in two part 
    --> First part Find the 4 products with the highest price
        SELECT price
        FROM products 
        ORDER BY price DESC
        LIMIT 4;
    --> Second part Find the 4 products with the highst price/weight ratio
        SELECT *
        FROM products 
        ORDER BY price/weight DESC
        LIMIT 4;
    --> The UNION operator is used to combine the result-set of two or more SELECT statements.
    --> Solution : 
        (
         SELECT *
         FROM products 
         ORDER BY price DESC
         LIMIT 4
        )
        UNION
        (
         SELECT *
         FROM products 
         ORDER BY price/weight DESC
         LIMIT 4
        );
    --> printed value : 
    --> id	        name           	        department         price  weight
        38    	   Awesome Fresh Keyboard	     Home	    982    30
        86         Refined Concrete Pants	     Sports         724	   2
        46 	   Incredible Granite Bacon          Music	    982    9
        80         Small Fresh Gloves	             Garden         991    8
        24	   Small Plastic Soap	             Beauty         345    1
        7	   Incredible Granite Mouse          Home           989	   2
        1	   Practical Fresh Shirt	     Toys           876	   3

    --> But there is only 7 products becoz 1 product is common in both list.
    --> But if donot want to remove duplicate then use : UnionAll : UNION ALL combines the results of two or more SELECT statements, showing all values, including duplicates if they exist.
    --> 
       (
        SELECT *
        FROM products 
        ORDER BY price DESC
        LIMIT 4
       )
       UNION ALL
       (
        SELECT *
        FROM products 
        ORDER BY price/weight DESC
        LIMIT 4
       );

    --> id	name	              department	 price  weight
        80	Small Fresh Gloves  	Garden            991	8
        7	Incredible Granite Mouse Home	          989	2
        38	Awesome Fresh Keyboard	 Home	          982	30
        46	Incredible Granite Bacon Music	          982	9
        7	Incredible Granite Mouse Home	          989	2
        86	Refined Concrete Pants	Sports	          724	2
        24	Small Plastic Soap	Beauty	          345	1
        1	Practical Fresh Shirt	Toys	          876	3

--> 02: We can use parenthesis or we can't no issue but better to use parenthesis in union
        SELECT * FROM products
        UNION
        SELECT * FROM products
    --> Or
        (
         SELECT * FROM products
        )
        UNION
        (
         SELECT * FROM products
        );

    --> Points for use union
    --> Column number and colum should be same in both list.
    --> data type also should be same in ireesprctive column.

--> 03: https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/2722575c-ae0a-4464-82b9-a2fc8549eeb1
    --> Intersects : Find the rows common in the results of two queries. Removes duplicates
    --> Intersects All : Find the rows common in the results of two queries. do not Remove duplicates : not if common in both it means if one contains multiple then show duplicate 
    --> Except : Find the rows that are present in first query but not second query. Remove duplicates --> Remember duplicate remove from first : so order matter in except i mean which one is first query.
    --> Except All : Find the rows that are present in first query but not second query. do not Remove duplicates
        (
         SELECT *
         FROM products 
         ORDER BY price DESC
         LIMIT 4
        )
        INTERSECT
        (
         SELECT *
         FROM products 
         ORDER BY price/weight DESC
         LIMIT 4
        );
    --> id	name	                       department	price	weight
        7	Incredible Granite Mouse	Home        	989	2
    --> Intersect All
        (
         SELECT *
         FROM products 
         ORDER BY price DESC
         LIMIT 4
        )
        INTERSECT ALL
        (
         SELECT *
         FROM products 
         ORDER BY price/weight DESC
         LIMIT 4
        );
    --> id	name	                       department	price	weight
        7	Incredible Granite Mouse	Home        	989	2

--> 04: Removing Commonalities With Except
        https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/7dd702f9-2b37-49e4-b38f-e87b4a7efc11
        https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/3810637c-55a8-49c2-ae43-824a0ad3b423
        (
          SELECT id, name 
          FROM products 
          ORDER BY price DESC
          LIMIT 4
        )
        EXCEPT 
        (
         SELECT id, name 
         FROM products 
         ORDER BY price/weight DESC
         LIMIT 6
         );
    --> id	name	               department	price	weight
        38	Awesome Fresh Keyboard	   Home	        982	30
        46	Incredible Granite Bacon   Music	 982	9
        80	Small Fresh Gloves	  Garden	 991	8
    --> Analysis : 
        SELECT id, name 
        FROM products 
        ORDER BY price DESC
        LIMIT 4
    --> id	 name	                      department price	weight 
        80    Small Fresh Gloves	        Garden	    991  	8 
        7 	Incredible Granite Mouse	Home	    989 	2 
        38	Awesome Fresh Keyboard	        Home	    982 	30 
        46	Incredible Granite Bacon	Music	    982 	9

        SELECT * 
        FROM products 
        ORDER BY price/weight DESC
        LIMIT 6
    --> id	 name	                      department price	weight 
        7	 Incredible Granite Mouse     Home	989	2
        86	Refined Concrete Pants	      Sports	724	2
        24	Small Plastic Soap	      Beauty	345	1
        1	 Practical Fresh Shirt	      Toys	876	3
        56	Gorgeous Plastic Sausages    Movies	556	2
        8 	Gorgeous Rubber Ball	      Books	801	4

--> 05: Practice : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/95116c30-140a-426f-8ace-999baa7edab6
--> 06: Solution : 
        SELECT manufacturer 
        FROM phones
        WHERE price < 170
        UNION
        SELECT manufacturer 
        FROM phones
        GROUP BY manufacturer
        HAVING COUNT (*) > 2; 
