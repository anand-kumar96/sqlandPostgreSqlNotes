--> FIRST FORM OF VALIDATION : IS A GIVEN VALUE DEFINED? 

--> 1&2:https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/bdc59d78-06f4-4259-a847-e7cc3a2d33bc
    --> Create product table and insertdata in database 
    --> Create validation database and open query tols when we open query tools then we are using a specific databse
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/ff797693-3ee4-4752-9f39-1f8409825828
        CREATE TABLE (
        id SERIAL PRIMARY KEY,
        name VARCHAR(50),
        department VARCHAR(50),
        price INTEGER,
        weight INTEGER
        );
    --> to see table--> click on validation database --> expand it click on Schemas--> public -->Tables --> products(table name) --> right click => view/edit data
        INSERT INTO products(name,department,price,weight)
        VALUES ('Shirt','Clothes',200,1);

--> 03: Applying null constraints 
        INSERT INTO products(name,department,weight)
        VALUES ('Pants','Clothes',3);
    --> it will add price as null : that is big issue so we not some type of validation 
    --> so we can solve it two way : before creating table or after creating table
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/88bd33e8-8ae5-461e-8465-4e6db2b30616
        CREATE TABLE (
        id SERIAL PRIMARY KEY,
        name VARCHAR(50),
        department VARCHAR(50),
        price INTEGER NOT NULL,
        weight INTEGER
        );
    --> or
        ALTER TABLE products
        ALTER COLUMN price
        SET NOT NULL;
    --> ERROR:  column "price" of relation "products" contains null values 
    --> so we can either select all rows which contains price null and delete them or update them

--> 04: so we can solve it two way : before creating table or after creating table => setting default value
        CREATE TABLE (
        id SERIAL PRIMARY KEY,
        name VARCHAR(50) NOT NULL,
        department VARCHAR(50) NOT NULL,
        price INTEGER DEFAULT 9999,
        weight INTEGER 
        );
    --> or After Creating Table
        ALTER TABLE products
        ALTER COLUMN price
        SET DEFAULT 9999;
    --> Now we can add new value
        INSERT INTO products(name,department,weight)
        VALUES ('Gloves','Tools',1);

--> SECOND FORM OF VALIDATION : IS A VALUE IN ITS COLUMN IS UNIQUE?

--> 05: Applying a unique constrains to a column
        INSERT INTO products(name,department,price,weight)
        VALUES ('Shirt','Clothes',200,1);
    --> we have two products with same name --> but we want name should be unique how to do that?
    --> so we use UNIQUE constraints
    --> When creating table
        CREATE TABLE (
        id SERIAL PRIMARY KEY,
        name VARCHAR(50) UNIQUE,
        department VARCHAR(50) NOT NULL,
        price INTEGER DEFAULT 9999,
        weight INTEGER 
        );
    --> After Creating Table
        ALTER TABLE products
        ADD UNIQUE(name);
    --> we can't execute this command unless all the value in name column is unique.
    --> ERROR: could not create unique index "products_name_key" DETAIL: Key (name)=(Shirt) is duplicated.
    --> So can rename that value or can delete that row
        Delete from products 
        Where name = 'Shirt';
    --> or update
        UPDATE products
        SET name = 'Shoes', department = 'Sports'
        WHERE name = 'Shirt' AND department = 'Clothes';
    --> now run
        ALTER TABLE products
        ADD UNIQUE(name);

--> 07: To add Multi Column Uniquness
    --> When Creating a table
        CREATE TABLE (
        id SERIAL PRIMARY KEY,
        name VARCHAR(50),
        department VARCHAR(50) NOT NULL,
        price INTEGER DEFAULT 9999,
        weight INTEGER
        UNIQUE(name,department)
        );
    --> After Table was created
        ALTER TABLE products
        ADD UNIQUE(name, department);
    --> To remove Existing Unique Constraints --> go to click validation database -->Schemas--> public -->Tables -->products-->Constraints--> see all key
    --> run 
        ALTER TABLE products
        DROP CONSTRAINT products_name_key; --> it will delete name uniqueness
    --> now we can add multiple uniquness constraints
        ALTER TABLE products
        ADD UNIQUE(name,department);
    --> now add shirt with different department 
        INSERT INTO products(name,department,price,weight)
        VALUES ('Shirt','PartyWear',200,1); --> its successfully added
    --> now add shirt with existing department 
        INSERT INTO products(name,department,price,weight)
        VALUES ('Shirt','Clothes',200,1); --> its throw error
        /*
        ERROR:  Key (name, department)=(Shirt, Clothes) already exists.duplicate key value violates unique constraint "products_name_department_key" 
        ERROR:  duplicate key value violates unique constraint "products_name_department_key"
        SQL state: 23505
        Detail: Key (name, department)=(Shirt, Clothes) already exists.
        */
--> THIRD FORM OF VALIDATION : IS A VALUE >,<,>=,<=,= SOME OTHER VALUE?

--> 08: CHECK Constraints : When don't want to put price value negative 
        INSERT INTO products(name,department,price,weight)
        VALUES ('Belt','Clothes',-100,1);
    --> So we need validation : So we use CHECK validation.
    --> When Creating a table
        CREATE TABLE (
        id SERIAL PRIMARY KEY,
        name VARCHAR(50),
        department VARCHAR(50) NOT NULL,
        price INTEGER CHECK(price>0),
        weight INTEGER
        );
    --> After Table was created
        ALTER TABLE products
        ADD CHECK(price>0);

    --> after running this command
        INSERT INTO products(name,department,price,weight)
        VALUES ('Belt','Clothes',-100,1);
        /*
        ERROR:  Failing row contains (9, Belt, Clothes, -100, 1).new row for relation "products" violates check constraint "products_price_check" 
        ERROR:  new row for relation "products" violates check constraint "products_price_check"
        SQL state: 23514
        Detail: Failing row contains (9, Belt, Clothes, -100, 1).
        */
    --> We can see CHECK constraint and remove it simillar to UNIQUE contraints

--> 09: Check Over Multiple Columns
    --> Creating a new table orders
        CREATE TABLE orders(
        id SERIAL PRIMARY KEY,
        name VARCHAR(50) NOT NULL,
        created_at TIMESTAMP NOT NULL,
        est_delivery TIMESTAMP NOT NULL,
        CHECK (created_at < est_delivery)
        );
    --> now inserting data
        INSERT INTO orders(name, created_at,est_delivery)
        VALUES ('Shirt','2000-Nov-20 01:00 AM', '2000-Nov-19 01:00 AM'); --> its successfully added

        INSERT INTO orders(name, created_at,est_delivery)
        VALUES ('Shirt','2000-Nov-20 01:00 AM', '2000-Nov-19 01:00 AM'); --> its throw error
        /*
        ERROR:  Failing row contains (2, Shirt, 2000-11-20 01:00:00, 2000-11-19 01:00:00).new row for relation "orders" violates check constraint "orders_check" 
        ERROR:  new row for relation "orders" violates check constraint "orders_check"
        SQL state: 23514
        Detail: Failing row contains (2, Shirt, 2000-11-20 01:00:00, 2000-11-19 01:00:00).
        */

--> 10: Where are We Applying Validation ?
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/2a1adbef-0cb9-440e-892e-fa788b777453
    --> add easy validation on web server and difficult validation on database
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/74f55c4c-b57e-44c5-9eb5-fb5372a63e00