------------------------------- Filtering Record -------------------------------------- () --> denote list
SELECT name , area FROM cities WHERE area > 4000 ; 
/*
SELECT name , area --> 1
FROM cities ---> 2
WHERE area > 4000 --->3
 it execute in POSTGRE => 2-->3--->1  Means first look in cities then filter area greater than 4000 in each individual row then it print name and area.
*/
SELECT name , area FROM cities WHERE area != 4000 ; 
SELECT name , area FROM cities WHERE area BETWEEN 2000 AND 5000; 
SELECT name , area FROM cities WHERE name IN('Delhi', 'Tokyo'); 
SELECT name , area FROM cities WHERE name NOT IN('Delhi', 'Tokyo'); 
--- compound condition --> We Can add many as many check
SELECT name , area FROM cities WHERE area NOT IN(2000, 5000) AND name ='Tokyo'; 
SELECT name , area FROM cities WHERE area NOT IN(2000, 5000) OR name ='Tokyo'; 
-- We Can add many as many check
SELECT name , area FROM cities WHERE area NOT IN(2000, 5000) OR name ='Tokyo'  OR name = 'Delhi';

----> Where clause as also
SELECT ---->3
 name,
 population / area As population_density 
FROM ---->2
 cities
WHERE ---> 1
 population / area > 5000;

--------------Creating Phones Table ----------------
CREATE TABLE phones (
  name VARCHAR(50),
  manufacturer VARCHAR(50),
  price INTEGER,
  units_sold INTEGER
  );

---> Insert Data
INSERT INTO phones (name, manufacturer, price,units_sold)
VALUES
   ('N1280','Nokia',199,1925),
   ('Iphone 4','Apple',399,9436),
   ('Galaxy S','Samsung',299,2359),
   ('S5620 Monte','Samsung',250,2385),
   ('N8','Nokia',150,7543);
  
------------------------------------UPDATING ROW ----------------
-- Write a query here to update units_sold of phone with name N8 to 8543
UPDATE phones SET units_sold = 8543 WHERE name = 'N8';
------------------------------------DELETING ROW -----------------
-- Write a query here to Delete Row with name 'N8'
DELETE FROM phones WHERE name = 'N8';
