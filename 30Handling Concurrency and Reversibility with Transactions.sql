--> 01: What is Transcation ? 
    --> Transactions group a set of tasks into a single execution unit. 
    --> Each transaction begins with a specific job and ends when all the tasks in the group successfully completed. 
    --> If any of the tasks fail, the transaction fails. Therefore, a transaction has only 
    --> two results: success or failure.
    /*  Properties of Transactions
        Transactions have the following four standard properties, usually referred to by the acronym ACID.
        a) Atomicity − ensures that all operations within the work unit are completed successfully. 
           Otherwise, the transaction is aborted at the point of failure and all the previous 
           operations are rolled back to their former state.
        b) Consistency − ensures that the database properly changes states upon a successfully committed transaction.
        c) Isolation − enables transactions to operate independently of and transparent to each other.
        d) Durability − ensures that the result or effect of a committed transaction persists in case of a system failure.
    */
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/d2b9bea3-965e-4d29-baac-8fbcdf8f534d

--> 02: Creating account table
        CREATE TABLE accounts (
        id SERIAL PRIMARY KEY,
        name VARCHAR(20) NOT NULL,
        balance INTEGER NOT NULL,
        CHECK(balance > 0)
        );
    --> Inserting data
        INSERT INTO accounts (name, balance)
        VALUES ('Alyson', 100),
               ('Gia', 100);

--> 03: Opening and Closing Transaction
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/29c8af7d-36b8-47fd-92d4-52262304d285
    --> open two query tool window and execute BEGIN in one of them then it will create seperate transaction
    --> To Start Transaction in first query tool write command 
        BEGIN; 
    --> now first query :
        UPDATE accounts
        SET balance = balance - 50
        WHERE name = 'Alyson';
        
        SELECT * FROM accounts;
    --> in this connection we get
      /* id    name   balance   
          1    Gia       100
          2    Alyson    50
      */

    --> in 2nd query tool execute 
        SELECT * FROM accounts;
      /* id    name   balance   
          1    Gia       100
          2    Alyson    100
      */
    --> Because both query are executing in different enviroment.
    /*
        Transactional Control Commands:
        Transactional control commands are only used with the DML Commands such as - INSERT, UPDATE and DELETE. 
        They cannot be used while creating tables or dropping them because these operations are automatically 
        committed in the database. Following commands are used to control transactions.

        COMMIT − to save the changes.
        ROLLBACK − to roll back the changes.
        SAVEPOINT − creates points within the groups of transactions in which to ROLLBACK.
        SET TRANSACTION − Places a name on a transaction.
    */
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/c529a5aa-0310-4f7a-ba40-35e8a49bd12b
    --> 1 COMMIT : to merge changes back into main pool.
        /*
        The COMMIT command is the transactional command used to save changes invoked by a transaction. 
        It saves all the transactions occurred on the database since the last COMMIT or ROLLBACK.
        */

    --> 2 ROLLBACK: used to dump all pending changes and delete the seperate workspace.
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/bcacfb90-872b-4cba-8aee-f7afef3d06aa
        /*
        The ROLLBACK command is the transactional command used to undo transactions that have not already been saved to the database. 
        This command can only undo transactions since the last COMMIT or ROLLBACK.
        */

    --> 3 Running a bad command will put the transaction in an 'aborted' state - you must rollback. in such situation
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/2f2f3fd8-f802-4d27-a90b-21272ffae2e6

    --> 4 Losing the connection (crashing) willautomatically rollback the transaction
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/7f1688f6-ee14-4e70-bd0a-203cc493325a

    --> now commit from first query tool
        COMMIT;
    --> now execute in both query tool below command we will get same output
        SELECT * FROM accounts;

--> 04: Transaction Cleanup on crash
    --> Case 1: We are going to open a transaction and  substract 50 dollar from Alyson then simulate a crash 
        : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/0571fbf1-2d07-49a2-ac73-83f3f2a6552f
    --> When crash occur during a transaction postgress automatically delete that transaction and not commit any the of change data back to main data.
    --> first of all reset all rows and make 100 dollar both have
        UPDATE accounts
        SET balance = 100;
    --> Start from here
        BEGIN;
    --> now do one transaction
        UPDATE accounts 
        SET balance = balance - 50
        WHERE name = 'Alyson';
    --> to crash go to above dashboard and close both below idle
    --> we will find that transaction is terminated so postgress terminate it => now we can see that both have 100 dollar
        SELECT * FROM accounts;    

--> 05: Closing Aborted transaction
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/b36428db-30b7-42fb-b145-4a646b10257a
        BEGIN;

        SELECT * FROM gshchsgchsc;
        /*
        ERROR:  relation "gshchsgchsc" does not exist
        LINE 1: SELECT * FROM gshchsgchsc;
       */
    --> Since We got an error after running any command transaction will be aborted
        SELECT * FROM accounts;
    --> ERROR: current transaction is aborted, commands ignored until end of transaction block 
    --> So end the transaction block we use ROLLBACK;
        ROLLBACK;
        
    --> now it won't throgh error
        SELECT * FROM accounts;