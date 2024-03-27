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
    --> With Index : Execution Time: 0.060ms
        EXPLAIN ANALYZE SELECT *
        FROM users
        WHERE username = 'Emil30';

    --> Without Index: Execution Time: 1.629 ms
        DROP INDEX users_username_idx;

        EXPLAIN ANALYZE SELECT *
        FROM users
        WHERE username = 'Emil30';

--> 06: Downside of index 
        /* 
        What is index? 
        A database index is a strategically designed data structure that enhances the speed of data retrieval activities in a database table. 
        Advantages of Indexes in PostgreSQL :
        1) Rapid data access: Indexes are instrumental in drastically slashing the time needed to retrieve data, 
           particularly from large tables. Without indexes, a complete table scan would be required, which can be quite time-consuming.
        2) Boosted query efficiency: Queries that include conditions in the WHERE clause or require table joins see marked improvements in 
           performance with indexing. Such queries leverage indexes to quickly pinpoint rows that fulfill the set criteria.
        3) Data integrity maintenance: Unique indexes act as safeguards against duplicate values within specific columns, 
           thereby maintaining data integrity by ensuring no two rows have identical values in the designated columns.

        Disadvantages of Indexes in PostgreSQL:
        1) Increased storage requirement: The most obvious downside of utilizing indexes is the extra storage space they require. 
           The precise amount depends on the size of the table and the number of indexed columns. Usually, 
           it's a small fraction of the total table size. However, for large datasets, adding multiple indexes can lead to a significant increase in storage usage.
        2) Slower write operations: Every time a row is inserted, updated, or deleted, the index must be updated too. 
           As a result, write operations may become slower. It's crucial to balance read and write operations when considering index usage. 
           If your application relies heavily on write operations, the benefits of faster reads should be carefully weighed against the cost of slower writes.
        3) HOT updates: PostgreSQL employs a mechanism called Multi-Version Concurrency Control (MVCC) for updates. 
           However, indexes can lead to "HOT" (Heap-Only Tuples) updates. Instead of allowing direct in-place updates, 
           each update operation effectively results in a new row version, generating a new entry in each associated index. 
           This leads to increased I/O activity and the addition of dead rows in the database.
        */
    --> Calculating Size of tables and index
        SELECT pg_size_pretty(pg_relation_size('users')); --> 872kb
    --> for username index
        SELECT pg_size_pretty(pg_relation_size('users_username_idx')); --> 184kb
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/7e2a7fef-358e-4e2c-a8c0-b8837fa5cfc7

--> 07: Index Types: 
    --> https://www.timescale.com/learn/database-indexes-in-Postgres
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/545573f3-5d28-4c28-99ae-781016d591c0

--> 08: https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/8fa9e9ea-8827-4130-98ea-315eda3349bd
    --> to see all automatic generated index use this query
        SELECT relname, relkind
        FROM pg_class 
        WHERE relkind = 'i';
    --> so we don't have to create index for primary key column and also column which have unique constraint. postgresql automatic generate index.