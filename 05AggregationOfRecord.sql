--> 01: AGGREGATION OF RECORDS
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/19dc7689-526a-438c-8823-6e3f7482c804

--> 02: Grouping --> Group By : Reduces many rows down to fewer rows
        Select user_id 
        FROM comments
        GROUP BY user_id;
    --> It selects all unique user_id and take each row and assign to a group based on its user_id :--> selecting user_id but we can not select subgroup column directly like : content etc for this we have to use aggreate or clause
        https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/a9beb58d-346d-4c8b-959b-3b3489e50c7b
        https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/f4794de2-4428-4f0d-baf8-d8f07746c4b0
    --> Query: 
        Select contents 
        FROM comments
        GROUP BY user_id;
    --> Error: column "comments.contents" must appear in the GROUP BY clause or be used in an aggregate function

--> 03: Aggregate Function : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/d307cf8a-1004-4b42-957f-bbf522d730ac
    --> Query;
        Select user_id, COUNT(user_id)
        FROM comments
        GROUP BY user_id;
    --> Ans:
        user_id	       count
        1	        23
        3	        17
        5       	20
        4       	22
        2	        18
          
    -->  Other Query
    -->    Max : 100         Min: 1            Avg: 50.5         Count:100           Sum:5050
        Select MAX(id)    Select MIN(id)     Select AVG(id)    Select COUNT(id)    Select SUM(id)  
        FROM comments;    FROM comments;     FROM comments;    FROM comments;      FROM comments;

    -->  We can not use it :-> column "comments.id" must appear in the GROUP BY clause or be used in an aggregate function
        Select SUM(id), id 
        FROM comments;

--> 04: Group By and Aggregate combine
        Select user_id, Max(id)       Select user_id, Count(id)
        From comments                 From comments
        Group By user_id;             Group By user_id;
    --> Ans:
        user_id	  max                user_id	count
           1	  79                   1	 23
           3	  100                  3	 17
           5	  99                   5	 20
           4	  96                   4	 22
           2	  91                   2	 18

--> 05: When We use Aggregate function count--> then null value not counted 
    --> Since we have 21 photos in photos table and 20 user with 1 user_id null and if we do this query then it given--> 20
        Select Count(user_id) 
        FROM photos;

    --> 20 Ans. Because it didnot counted null user_id
    --> to handle it better to count number of rows =>   Select Count(*) 
        Select Count(*) 
        FROM photos;
    --> 21 Ans. 
        Select user_id,Count(*) 
        FROM comments
        Group BY user_id;

        user_id	  count
         1	   23
         3	   17
         5	   20
         4	   22
         2	   18

--> 06: Find the number of comments for each photo
        Select Count(*)
        FROM comments
        GROUP BY photo_id;
    --> Ans :
        photo_id   count
          1	    19
          3	    25
          5	    20
          2	    19
          4	    17
    -->             
        Select photo_id, Count(*)
        FROM comments
        GROUP BY photo_id
        ORDER BY photo_id ASC;

        photo_id  count
          1	   19
          2	   19
          3	   25
          4 	   17
          5	   20
-->7&8: Exercise :
    --> Write a query that print an author's id and the number of books they have authored.
        Select author_id, Count(*)
        FROM books
        GROUP BY author_id;
    --> Ans:
        author_id	auther_total_books
           3	            1
           4	            1
           2           	    1
           1	            1
-->9&10:Exercise: Grouping with a jpoin
    --> Question: Write a query that will print an author's name and the number of books they have authored.
        Select name,Count(*) as auther_total_books
        FROM books
        JOIN authors
        ON authors.id = books.author_id
        GROUP BY authors.name;
    --> Ans:
          name	     auther_total_books
        JK Rowling	   1
        Dr Seuss	   1
        Agatha Christie    1
        Stephen King	   1

--> 11: Different Keywords : https://github.com/anand-kumar96/SQL/assets/106487247/3b98009f-5f76-43fd-8df8-19dd92606feb
    --> Having is Similar to where it is used to filter the set of groups so used with groups.
        : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/17442f49-eaa2-4f54-a1ce-43501ed20687
        : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/3a9b1a89-8a56-48e7-a257-72061ad4a031
        : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/1a4f2250-77ee-48ce-aa6b-001ddf590f66
                  
--> 12: Find the number of comments for each photo where the photo_id is less than 3 and the photo has more that 2 comments
        Select photo_id, Count(*) as total_comments
        FROM comments
        WHERE photo_id < 3 --> to filter individual row
        Group BY photo_id
        HAVING Count(*) > 2; --> filter groups    
    --> Or this way
        Select photo_id, Count(*) as total_comments
        FROM comments
        Group BY photo_id
        HAVING photo_id < 3 AND Count(*) > 2; 
    --> Ans:
        photo_id  total_comments
          1	     19
          2	     19

--> 13: Question: https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/2b9a9b5d-db3a-4141-8925-8c7c0c144a2f
        Select user_id, Count(*)
        FROM comments
        WHERE photo_id <= 50
        Group BY user_id
        HAVING Count(*) > 20 ;
    --> Ans.
        user_id	  count
          1	   23
          4	   22

-->14&15:Question: https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/1c1ca2a2-21e3-4b99-9105-9a3bca9eab84
    --> Explanation : 
        https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/05f1a524-6245-4937-bd73-e53162dd2be6
        https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/16822c24-7c5c-43cc-97fd-321af96d120f
        https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/be0876a7-4bca-4931-b511-98796b57d623
    --> Solution
        Select manufacturer,SUM(price*units_sold) As total_revenue
        FROM phones 
        Group BY manufacturer
        HAVING Sum(price*units_sold) > 2000000;
