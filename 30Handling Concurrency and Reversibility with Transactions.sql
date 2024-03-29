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
        CREATE TABLE account(
        id SERIAL PRIMARY KEY,
        name VARCHAR(20) NOT NULL,
        balance INTEGER NOT NULL,
        CHECK(balance > 0)
        );
    --> Inserting data
        INSERT INTO account(name, balance)
        VALUES ('Alyson', 100),
               ('Ziya', 100);

--> 03: 