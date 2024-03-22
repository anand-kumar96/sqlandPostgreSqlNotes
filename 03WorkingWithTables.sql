----->  Database For Photo Sharing App ---> it hase users, photos, comments, likes TABLE 
--> 01: Approach to database design
    --> https://github.com/anand-kumar96/SQL/assets/106487247/6c37ab08-579c-4cce-88cc-d03a9bb4024b
  
--> 02: One to Many and Many to one Relationships
    --> https://github.com/anand-kumar96/SQL/assets/106487247/d2c86408-ff11-47c0-96f4-4e8ab4fd9de3
    --> https://github.com/anand-kumar96/SQL/assets/106487247/37d655c0-e2b4-484f-93c0-c2b6e0563e2c
    --> https://github.com/anand-kumar96/SQL/assets/106487247/1f01fba7-b913-4ea1-bfe6-bc41c9d3d2a9
  
--> 03: one to one and many to many
    --> https://github.com/anand-kumar96/SQL/assets/106487247/79d8969e-1061-4051-95c0-76e719cd52e3
    --> https://github.com/anand-kumar96/SQL/assets/106487247/ce55f7d3-a1c4-43c6-9fb7-bf79d2ccf227
  
--> 04: Primary and Foregin key  ==> all four realtionship always done by using foregin key
    --> Primary keys serve as unique identifiers for each row in a database table. ---> always unique
    --> Foreign keys link data in one table to the data in another table.
    --> https://github.com/anand-kumar96/SQL/assets/106487247/ad85b7b3-a625-4851-88f5-4d261b2c241f

--> 05: Understanding Foregin Key
    --> https://github.com/anand-kumar96/SQL/assets/106487247/cb8b6830-176c-4bcc-9297-0a2adc972e81
    --> https://github.com/anand-kumar96/SQL/assets/106487247/4f0ad70c-ff01-4590-866a-35b68832df46
    --> https://github.com/anand-kumar96/SQL/assets/106487247/2444c690-3f77-493d-82fe-715894f6a3a8

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

    --> https://github.com/anand-kumar96/SQL/assets/106487247/7795668d-58fa-462b-975d-0f56dd2b7159
 
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
    --> https://github.com/anand-kumar96/SQL/assets/106487247/8f1294dc-8228-469b-ad37-4ea8deb95b26
    --> what will happen if we delete user 1 => then some dangling reference will be in photos foregin key 
    --> means photos trying to reference to user that doesnot exist  -> since we are using serial in useres id so never ever that id will be exist after delete
    --> So solution is that we have make some option befoe deleting user there are couple of option :
    --> https://github.com/anand-kumar96/SQL/assets/106487247/85ebcc74-e1a5-4bae-b13f-f0b397667a72
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
    --> https://github.com/anand-kumar96/SQL/assets/106487247/98fba156-5ea4-4b6d-81f0-761f1568ea33
    --> https://github.com/anand-kumar96/SQL/assets/106487247/1e677a31-6a88-464e-9acb-dbb8c6ddabcd
            
            
            




















