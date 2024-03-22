--> 01: Editor:https://pg-sql.com/

--> 02: INSERTING DATA
    --> Creating table and column
        CREATE TABLE cities (
          name VARCHAR(50),
          country VARCHAR(50),
          population INTEGER,
          area INTEGER
        );

--> 03: Now insert single  row
        INSERT INTO cities(name,country,population,area)
        VALUES('Tokyo','Japan',37274000,13452);

    --> Insert multiple row in single statement 
        INSERT INTO cities(name,country,population,area)
        VALUES
            ('Tokyo','Japan',37274000,13452),
            ('Delhi','India',29000000,3483),
            ('Shanghai','China',25582000,6341),
            ('Sao Paulo','Brazil',21650000,1321);

--> 04: RETRIVING DATA 
    --> Retrive all data
        SELECT * FROM cities;
    --> Retrive specific column
        SELECT name, country 
        FROM cities;
    --> we can also change order to print or print multiple time
        SELECT area,name, country 
        FROM cities;

        SELECT area,name,name,name,country 
        FROM cities;

--> 05: Calutating Density 
        SELECT name, population / area As population_density 
        FROM cities;

--> 06: STRING Operator And Function -------------------------------
        SELECT name || country 
        FROM cities;

        SELECT name || ', ' || country 
        FROM cities;

        SELECT name || ', ' || country AS location 
        FROM cities;
    --> OR
        SELECT CONCAT(name, country) AS location 
        FROM cities;

        SELECT CONCAT(name, ', ', country) AS location 
        FROM cities;

        SELECT CONCAT(UPPER(name), ', ', UPPER(country)) AS location 
        FROM cities;
    --> OR
        SELECT UPPER(CONCAT(name, ', ', country)) AS location 
        FROM cities;

