--> 01: The Repository Pattern
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/b4f26c74-385a-4bc3-bd24-5b1849043548
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/bf6f092d-7eeb-4b49-88bc-2c3fddc5026e
    --> there are various way to implement it, as object with plain function, as an instance of a class, as a class with static methods anything.

--> 02: Creating a repository
    --> various way to create 

--> 03: Accessing the API (Postman, Thunder client, Rest client)
    --> 1 using postman : i already know
    --> 2 using thunder client : Already Know

    --> 3 using Rest client : add restclient extension in vs code and create a file request.hhtp
    --> now paste url and right click and just send request to send another write ### then another url
        http://localhost:3005/users

        ###
        http://localhost:3005/users

--> 04: Since in javascript we use cameCase convention so created_at can be writter as createdAt
    --> So we need to Casting
        users[0].created_at;

    --> We have 3 option available
    --> 1 we rename the column : but thats not a good idea since we will not follow then sql convention.
    --> 2 We can change the database level
    --> 3 after doing any query we will do some proccessing or parsing 

--> 05: Fixing Casting
    --> Converting snake_case or kebab-case to camelCase.
        exports.toCamelCase = (rows) => {
            const parsedRows = rows.map(row => {
                const replaced = {};
                for(let key in row) {
                const camelCase = key.replace(/([-_][a-z])/gi, ($1) =>
                $1.toUpperCase().replace('_','')
                );
                replaced[camelCase] = row[key];
                }
                return replaced;
            })
        return parsedRows;
        }

--> 06: Finding particular user