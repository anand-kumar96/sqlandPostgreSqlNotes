----->  Database For Photo Sharing App ---> it hase users, photos, comments, likes TABLE 
--> 01: Approach to database design
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/a016e6df-957a-4870-9550-43e738d398df
  
--> 02: One to Many and Many to one Relationships
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/1ffe2ce5-b1f7-402f-a0d0-fe439019046b
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/0214f6fe-a515-49cf-a62a-ccf2d141dcb0
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/3eea7523-6c89-434b-a2ed-7021a307dbc5
  
--> 03: one to one and many to many
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/a8de95d2-3874-4db7-8185-2c9a92905128
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/45067a9b-44b6-4393-9743-ce0fcd6fc67f
--> 04: Primary and Foregin key  ==> all four realtionship always done by using foregin key
    --> Primary keys serve as unique identifiers for each row in a database table. ---> always unique
    --> Foreign keys link data in one table to the data in another table.
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/8a129b43-7407-4786-9e7e-da9ffd7f06b8

--> 05: Understanding Foregin Key
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/1ce3a5ed-a9c1-4639-8493-b26486a490e5
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/ead3e147-0838-4e0c-98a6-7378661fc75b
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/73fbe5a2-1b53-44cc-a95a-ca732b649f62

--> 06: Create user table and fill data => Serial : Auto generate Id
    --> creating table
        CREATE TABLE users(
          id INTEGER,
          username VARCHAR(50)
        );
    --> Inserting data
        INSERT INTO users (id, username)
        VALUES
            (1,'manmohan93'),
            (2,'pfeffer'),
            (3,'99stroman'),
            (4,'sim3onis');

-----> #In POSTGRESQL => Serial:  keywords automatic generate integer id we dont need to pass value , in other AUTOINCREMENT -> will create auto 
        CREATE TABLE users(
          id Serial PRIMARY KEY, ---> PRIMARY KEY : helps performance
          username VARCHAR(50)
        );
    --> Inserting data
        INSERT INTO users (username)
        VALUES
            ('manmohan93'),
            ('pfeffer'),
            ('99stroman'),
            ('sim3onis');

--> 07: Creating Photos table and fill data id ,url, user_id 
    --> point for foregin key : user_id INTEGER   REFERENCES tableNametoReference(tableNameToReference primary key column i.e. id)  => users(username ka primary key column ---> id)
        CREATE Table photos (
          id Serial PRIMARY KEY,
          url VARCHAR(200),
          user_id INTEGER  REFERENCES users(id)
        );

        INSERT INTO photos (url, user_id)
        VALUES
          ('http://img1.jpg',4),
          ('http://img2.jpg',4),
          ('http://img3.jpg',1),
          ('http://img5.jpg',3),
          ('http://img8.jpg',2),
          ('http://img8.jpg',4),
          ('http://img9.jpg',1),
          ('http://img10.jpg',1),
          ('http://img4.jpg',2);

    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/47d3808c-b4ef-4840-a1b1-9a3d0b5d7af1
 
    --> RUNNING QUIERS ON ASSOCIATED DATA
    --> Find all photos created by user with id 4
        SELECT * FROM photos WHERE user_id = 4; 

    --> list all photos with details about the associated user for each  ---> after joint concept
        SELECT p.id, p.url, p.user_id, u.username 
          FROM photos p 
          INNER JOIN users u 
          ON p.user_id = u.id;
    --> or
        SELECT url, user_id, username 
          FROM photos 
          INNER JOIN users 
          ON photos.user_id = users.id;

    --> Question : Create boat table and fill data
        CREATE table boats (
          id serial PRIMARY KEY,
          name VARCHAR(100)
          );
        INSERT INTO boats(name)
        VALUES ('Rogue Wave'),('Harbor Master');

    --> Create crew_members and fill data
        CREATE table crew_members(
          id serial PRIMARY KEY,
          first_name VARCHAR(100),
          boat_id INTEGER REFERENCES boats(id)
        );

        INSERT INTO crew_members(first_name, boat_id)
        VALUES ('Alex',1),('Lucia',1),('Ari',2);

    --> Now write a query to fetch all crew_members associated with boat that has id 1.
        SELECT * 
        FROM crew_members 
        WHERE boat_id = 1;


    --> Consistency in database : https://www.scaler.com/topics/data-consistency-in-dbms/
    --> there are 3 scenario inserting data when handling constency
        1. We insert a photo that is tied to a user that exists : EveryThing okay : Insert into photos (url,user_id) Values("http://img5.jpg",3); ==> user_id: 3 exist in users table
        2. We insert a photo that refer  a user that doesnot exists : An Error! : Insert into photos (url,user_id) Values("http://img5.jpg",35555); ==> user_id: 35555 does not exist in users table
        3. We insert a photo that is not tied  to any user: Put in a value of 'NULL' for the user_id : Insert into photos (url,user_id) Values("http://img5.jpg",NULL); ==> put user_id : Null

    --> deleting data cases
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/5fa1ac5e-2fac-446a-be64-2417f089d2c9
    --> what will happen if we delete user 1 => then some dangling reference will be in photos foregin key 
    --> means photos trying to reference to user that doesnot exist  -> since we are using serial in useres id so never ever that id will be exist after delete
    --> So solution is that we have make some option befoe deleting user there are couple of option :
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/38bcc704-945d-4f11-a877-4578368db537
    --> Testing deleting Constraints
    --> create photos table and add data after deleting previous table users and photos
    --> create users table
        CREATE TABLE users (
          id SERIAL PRIMARY KEY,
          username VARCHAR(50)
        );
        INSERT INTO users (username)
        VALUES
       	('monahan93'),
        ('pferrer'),
        ('si93onis'),
        ('99stroman');

    --> creating photos table
        CREATE TABLE photos (
          id SERIAL PRIMARY KEY,
          url VARCHAR(200),
          user_id INTEGER REFERENCES users(id)
        );

        INSERT INTO photos (url, user_id)
        VALUES
          ('http://one.jpg', 4),
        	('http://two.jpg', 1),
          ('http://25.jpg', 1),
          ('http://36.jpg', 1),
          ('http://754.jpg', 2),
          ('http://35.jpg', 3),
          ('http://256.jpg', 4);
    --> all 5 cases
        case 1(ON DELETE RESTRICT):  DELETE FROM users WHERE id = 1;  --- => Throw error--> update or delete on table "users" violates foreign key constraint "photos_user_id_fkey" on table "photos" 
        case 2(ON DELETE NO ACTION):   -- see later

    --> for case 3-> means when we delete user related photos also delete we should have write this command while creating photos table
        CREATE TABLE photos (
        id SERIAL PRIMARY KEY,
        url VARCHAR(200),
        user_id INTEGER REFERENCES users(id) ON DELETE CASCADE
        );
            
        INSERT INTO photos (url, user_id)
        VALUES
          ('http://one.jpg', 4),
          ('http://two.jpg', 1),
          ('http://25.jpg', 1),
          ('http://36.jpg', 1),
          ('http://754.jpg', 2),
          ('http://35.jpg', 3),
          ('http://256.jpg', 4);
      
    --> case 3 (ON DELETE CASCADE) : DELETE FROM users WHERE id = 1; --> this will delete user and related photos since we use on delete cascade => ### IMPORTANT USES MANY 

    --> case 4 : delete users and photos table and recreate : use ON DELETE SET NULL : command while referencing: it will set null when user is delete in photos user_id 
        CREATE TABLE users (
        id SERIAL PRIMARY KEY,
        username VARCHAR(50)
        );
        INSERT INTO users (username)
        VALUES
         ('monahan93'),
         ('pferrer'),
         ('si93onis'),
         ('99stroman');
      
        CREATE TABLE photos (
        id SERIAL PRIMARY KEY,
        url VARCHAR(200),
        user_id INTEGER REFERENCES users(id) ON DELETE SET NULL
        );
      
        INSERT INTO photos (url, user_id)
        VALUES
         ('http://one.jpg', 4),
         ('http://two.jpg', 1),
         ('http://25.jpg', 1),
         ('http://36.jpg', 1),
         ('http://754.jpg', 2),
         ('http://35.jpg', 3),
         ('http://256.jpg', 4);
      
        case 4 (ON DELETE SET NULL) : DELETE FROM users WHERE id = 1; --> this will delete user and set null to related user photos user_id => ### IMPORTANT USES MANY 
        case 5 : -- see later.

    --> DataBase schema diagram : VVI #############
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/c736beb3-7f5d-4eb6-8769-7ce25cb6fe91
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/0f23ab73-7328-4d25-9a8b-342ac6912131
            
            
            




















