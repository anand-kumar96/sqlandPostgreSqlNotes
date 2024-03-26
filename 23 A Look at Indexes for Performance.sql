--> 01: https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/3a36e24e-739b-444d-ab35-3193550b291b
--> 02: What is Index ?
     /* Indexes are a common way to enhance database performance. 
        An index allows the database server to find and retrieve specific rows much faster than it could do without an index. 
        But indexes also add overhead to the database system as a whole, so they should be used sensibly.
        or
        Index is data structure that efficiently tell us what block/index is stored at. 
         */

--> 03: How index work ?
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/2e03dfdb-2e5a-4987-8141-064bccae5391
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/f0544827-4869-49fb-bf38-416f58193fda

--> 04: Creating Index in user table specially for username
    --> Syntex:
        CREATE INDEX index_name
        ON table_name (column1_name, column2_name);

        CREATE INDEX user_Index ON users(username);
    --> to delete 
        DROP INDEX users_username_idx;

--> 05: Benchmarking Queries