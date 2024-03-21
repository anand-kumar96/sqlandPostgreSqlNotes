--> 01: The Greatest value in list
        SELECT Greatest(100,200,35);
    --> or https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/3568ccaa-ce8d-46c1-8803-17f8432fcdb8
        SELECT name,weight, department, Greatest(weight*2, 30) as cost_to_ship
        FROM products;
--> 02: The Least value in list
        SELECT Least(100,200,35);
    --> or https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/d3bb3029-0b55-4397-86bb-e60c5c77ebf9
        SELECT name,weight, department, LEAST(price*0.5, 400) as product_price
        FROM products;
--> 02: The Case Keyword: https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/e409d1d5-5650-4ea7-89ca-3011a017b713
        SELECT
        name,
        price,
        CASE
            WHEN price > 600 THEN 'high'
            WHEN price < 300 THEN 'medium'
            ELSE 'cheap'
        END
        FROM products;