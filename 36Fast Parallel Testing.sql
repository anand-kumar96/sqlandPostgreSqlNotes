--> 01: https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/e7a9f0ae-a9fb-4b1d-9a1e-994783d9930d
    /*  Jest is a powerful and versatile testing framework that simplifies the process of writing and running tests 
        for JavaScript projects. Whether you're working on a Node.js backend, a front-end JavaScript application, or a 
        full-stack project, Jest can help you ensure the quality and reliability of your codebase through automated testing.
    */
    --> jest running all test file parallaly at same time.

--> 02: Supertest
    /*  Supertest is a popular library used for testing HTTP servers in JavaScript projects. 
        It allows you to make HTTP requests to your server and assert the responses, enabling you to test your API endpoints 
        in an automated and controlled manner.
                                            Overall, Supertest is a powerful and flexible tool for testing HTTP servers in JavaScript projects. 
        It simplifies the process of testing API endpoints, ensuring that your server behaves as expected and meets your 
        application's requirements.
    */
    --> writing fnction to get count of user
        static async count () {
            const {rows} = await pool.query(`SELECT COUNT(*) FROM users`);

            return rows[0].count;
        }
    --> writing test for user Count
        const request = require('supertest');
        const buildApp = require('../../app');
        const UserRepo = require('../../reopository/userRepository');

        --> automation test to check user
        it('create a user', async() => {
            const startingCount = await UserRepo.count();
            expect(startingCount).toEqual(0);

            await request(buildApp())
                .post('/users')
                .send({username:'testuser', bio:'test bio'})
                .expect(200);
            
            const finishCount = await UserRepo.count();
            expect(finishCount).toEqual(1);
        })

--> 03: Connecting to database for test
    --> to run test add script : "test":"jest"
    --> We are going to get a lot of error so sit tight and ready for turbosutting

    /*   TypeError: Cannot read properties of null (reading 'query')
      34 |     /// SOLVING SECURITY ISSUE
      35 |     query(sql, params) {
    > 36 |         return this._pool.query(sql,params);
         |                           ^
      37 |        }
      38 | }
      39 |

      at Pool.query (src/pool.js:36:27)
      at Function.query (src/reopository/userRepository.js:68:35)
      at Object.count (src/test/routes/userRoutes.test.js:7:42)
    */
    --> this error is from pool.js that pool is null: because initially pool is null and it defined when it is connected to database
    --> but our connect function is only executed inside index.js so that's why we are getting error
-->04:  first connect to db
        npm run test

    /* expect(received).toEqual(expected) // deep equality
        Expected: 0
        Received: "1"

        20 | it('create a user', async() => {
        21 |     const startingCount = await UserRepo.count();
        > 22 |     expect(startingCount).toEqual(0);
            |                           ^
        23 |
        24 |     await request(buildApp())
        25 |         .post('/users')

        at Object.toEqual (src/test/routes/userRoutes.test.js:22:27)
    */

    --> above error : Jest did not exit one second after the test run has completed. it means databse connection didnot close 
    --> automatically after, acutally db connection didnot close automatically so we should have to write code
        afterAll(()=>{
            return pool.close();
        })

--> 05: Multi-DB Setup
    --> above error due to we are expecting 0 users but we are getting 1 users in db because we rae trying to access socailnetwork
    --> database in two mode one in app development mode and another is app test mode
    --> in bpoth senario we are connecting to same database due to which since database has already one users that's why 
    --> in test mode return count as 1 and our test is failing.

    --> we can solve it different ways
    --> 1 we can delete all the tables before testing the app from db which is such a bad approach.
    --> 2 Instead we can create another database socialnetwork-test and we test here. this is good solution
    --> so create database in pg admin
    --> now change database name in connect function and run test
        npm run test

    --> ERROR =>  error: relation "users" does not exist
    --> because we just created database not run any migration in db so that's why we getting error

--> 06: set DATABASE_URL=postgres://postgres:123456@Anand@localhost:5432/socialnetwork-test&&npm run migrate up
    /*  ### MIGRATION 1712051903171_add-users-table (UP) ###
        CREATE TABLE users(
            id SERIAL PRIMARY KEY,
            created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
            bio VARCHAR(400),
            username VARCHAR(30) NOT NULL
        );
        ;
        INSERT INTO "public"."pgmigrations" (name, run_on) VALUES ('1712051903171_add-users-table', NOW());
        Migrations complete!
    */
    --> now run test again
     /* expect(received).toEqual(expected) // deep equality
        Expected: 0
        Received: "0"

        25 | it('create a user', async() => {
        26 |     const startingCount = await UserRepo.count();
        > 27 |     expect(startingCount).toEqual(0);
            |                           ^
        28 |
        29 |     await request(buildApp())
        30 |         .post('/users')

        at Object.toEqual (src/test/routes/userRoutes.test.js:27:27)
     */
    --> above rror is typo error because we are expecting 0 as integer while received as string so
    --> to solve it while returing count we parse it in int.
    --> running test again => test pass
    /*  PASS  src/test/routes/userRoutes.test.js
        √ create a user (57 ms)

        Test Suites: 1 passed, 1 total
        Tests:       1 passed, 1 total
        Snapshots:   0 total
        Time:        1.388 s, estimated 2 s
        Ran all test suites.
    */

    --> running again will through error because while in first test pass db have 1 users created taht's why we getting error
    --> we can solve it in different way
    --> 1 before testing clean the db
    --> 2 or change test code little bit
        --> automation test to check user
        it('create a user', async() => {
            const startingCount = await UserRepo.count();

            await request(buildApp())
                .post('/users')
                .send({username:'testuser', bio:'test bio'})
                .expect(200);
            
            const finishCount = await UserRepo.count();
            expect(finishCount - startingCount).toEqual(1);
        })
    --> now it will pass the test

--> 07: Issues with Parallel testing
    --> 