--> 01: What is Materialized View ?
    --> A materialized view is a database object that contains the results of a query. 
    --> It can be a local copy of data that is located remotely, or a subset of the rows and/or columns of a table or join result, 
    --> or a summary using an aggregate function. Materialized views are created by combining data 
    --> from multiple existing tables for faster data retrieval. 
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/bf93c96d-b904-4dcf-8a18-330d71f79447
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/f2d74308-8145-4227-847e-d4f849766289
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/9dcd90f2-75bb-4ed7-8665-49783da29079

--> 02: Grouping by week
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/cb2bea3d-79aa-4b78-ace3-885c97a23b8f
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/51a15e0a-abee-416e-874c-d42283ed5521 

--> 03: Reminder on left Join
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/b998535b-08e4-498f-93eb-994a0e0c7a86

-->04:  Writing Slow Query
        SELECT *
        FROM likes
        LEFT JOIN posts ON posts.id = likes.post_id
        LEFT JOIN comments ON comments.id = likes.comment_id;

    --> DATE_TRUNC() is a function used to round or truncate a timestamp to the interval you need.
    --> When used to aggregate data, it allows you to find time-based trends like daily purchases or messages per second.
        SELECT 
        date_trunc('week', COALESCE(posts.created_at, comments.created_at)) AS week
        FROM likes
        LEFT JOIN posts ON posts.id = likes.post_id
        LEFT JOIN comments ON comments.id = likes.comment_id
        Order By week;

    --> final solution 
        SELECT 
        date_trunc('week', COALESCE(posts.created_at, comments.created_at)) AS week,
        Count(posts.id) as num_likes_for_posts,
        Count(comments.id) as num_likes_for_comments
        FROM likes
        LEFT JOIN posts ON posts.id = likes.post_id
        LEFT JOIN comments ON comments.id = likes.comment_id
        GROUP BY week
        Order By week;

--> 05: Creating Materialized View to increase Performance
    --> Since above query takes long times so we will increase performance using Materialize View
        CREATE MATERIALIZED VIEW weekly_likes AS (
        SELECT 
        date_trunc('week', COALESCE(posts.created_at, comments.created_at)) AS week,
        Count(posts.id) as num_likes_for_posts,
        Count(comments.id) as num_likes_for_comments
        FROM likes
        LEFT JOIN posts ON posts.id = likes.post_id
        LEFT JOIN comments ON comments.id = likes.comment_id
        GROUP BY week
        Order By week
        );
        --> it incresed the performance
        SELECT * FROM weekly_likes;
    --> But it has biggest downside that if any thing change in table means any new post is created or deleted 
    --> this this cache is not updated lets assume we delete all the post bfore '2010-02-01' then it will not update 
        DELETE FROM posts 
        WHERE created_at < '2010-02-01';

    --> after running below command we are getting same result means old result
        Select * from weekly_likes;
    --> so to refresh materialized view when ever any thing change occur we execute below command
        REFRESH MATERIALIZED VIEW weekly_likes;
    --> now it updated
        Select * from weekly_likes;
    --> So we are going to use materialized view when the value is not going to change often