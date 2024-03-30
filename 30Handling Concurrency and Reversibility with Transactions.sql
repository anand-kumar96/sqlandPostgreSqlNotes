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
          2    Alyson     50
      */

    --> in 2nd query tool execute 
        SELECT * FROM accounts;
      /* id    name   balance   
          1    Gia       100
          2    Alyson     100
      */
    --> Because both query are executing in different enviroment.