--> 01: https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/38fae19e-ac92-47ce-bef5-4ba066ec3ba5
    --> Recursive CTE: A recursive CTE references itself. It returns the result subset, then it repeatedly (recursively) 
    --> references itself, and stops when it returns all the results.
    --> Recursive CTEs are used primarily when you want to query hierarchical data or graphs.
    --> Syntax
        WITH RECURSIVE cte_name AS (
        cte_query_definition (the anchor member)
 
        UNION ALL
        cte_query_definition (the recursive member)
        )

        SELECT *
        FROM   cte_name;

    --> Example
        WITH RECURSIVE countdown(val) AS (
        SELECT 40 AS val
        UNION ALL
        SELECT val - 1
        FROM countdown
        WHERE val > 1
        )

        SELECT val as count_number
        FROM countdown
        ORDER BY val;

    --> Below code is recursive CTE
        WITH RECURSIVE countdown(val) AS (
        SELECT 40 AS val
        UNION ALL
        SELECT val - 1
        FROM countdown
        WHERE val > 1
        )
 
--> 02: Step by Step Explanation
        WITH RECURSIVE countdown(val) AS (
        SELECT 40 AS val --> Initialor Non Recursive Query
        UNION ALL
        SELECT val - 1 FROM countdown WHERE val > 1 --> Recursive Query
        )
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/83d932f8-471a-49f2-a251-2f32c214eeac
    --> Define the results table and working table seperately with the name mention i.e. val
    --> then run the non-recursive statement : 
        SELECT 3 AS val
    --> put the results of it in result and working table i.e val as 3
    --> now run recursive statement 
        SELECT val - 1 FROM countdown WHERE val > 1
    --> replace the countdown  table referencing to working table
    --> now execute it
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/5c7e8c4e-18ca-4bc0-b7d7-de4a27f446c7

--> 03: Why We use Recursive CTE ?
    --> How Suggestion work in instagram and facebook : Suppose I am following The Rock and Kevin Hart , 
    --> while The Rock following justinbieber and Kevin Hart following jennifer lopez and Snoop Dogg.
    --> then instagram think or make assumption i am interested in Justin Beiber a, Jennifer lopez and Snoop Dogg.
    --> and continue one level deeper etc
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/8c670625-6aab-4d65-80cc-5214c3301224
    --> how can we do that ? : We can do using join statement but there is issue we can not go deep and deep means 
    --> x--follow--> y --follow--> z--follow--> a
    --> means we can not get all the following followers so we will use Recursive CTC.
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/e5d425a1-c162-4f23-ad57-ab8ad48c67a3
    --> Since above image also showing tree type structure so use Recursive CTE.

--> 04: leader_id : user which is followed by someone, follower_id : user who is following
        WITH RECURSIVE suggestions(leader_id, follower_id, depth) As (
            SELECT leader_id, follower_id, 1 As depth
            FROM followers
            WHERE follower_id = 1000
	    UNION
            SELECT followers.leader_id, followers.follower_id, depth + 1
            FROM followers
            JOIN suggestions ON suggestions.leader_id = followers.leader_id
            WHERE depth < 3
        )

        SELECT DISTINCT users.id, users.username
        FROM users
        JOIN suggestions
        ON users.id = suggestions.leader_id
        WHERE suggestions.depth > 1
        LIMIT 30;
    