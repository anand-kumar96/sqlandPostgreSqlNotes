--> 01: https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/33ca7772-e106-4b24-94d2-e1f0b6e48168

--> 02: Where does data store in postgre => run command --> show data_directory
    --> to get different database in postgresql run command 
        SELECT oid, datname
        FROM pg_database;
    --> to see each individual object, tables etc in database
        SELECT *
        FROM pg_class;
    --> 17028 file is user data file.

--> 03: Heap data Structure and Heap File are different
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/c703de39-f673-44cd-bb5f-d5f3fcc72a0e
    --> each block or pages are 8kb in size.

--> 04: