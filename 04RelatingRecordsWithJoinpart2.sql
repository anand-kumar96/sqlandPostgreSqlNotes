--> 1&2:https://github.com/anand-kumar96/SQL/assets/106487247/b5c84d2a-b5df-47be-9dee-c71245c41977  
    --> user who created the comment on a photo
    --> Some Query Questions : https://github.com/anand-kumar96/SQL/assets/106487247/1052ec2a-bd49-4563-b934-22002e9fd5df
    --> we solve  these questions using Joins and Aggregation
    --> Joins: Question1 , Aggregation: Question 2,3,4,5  
    --> notes : https://github.com/anand-kumar96/SQL/assets/106487247/912ac560-6031-4054-a3aa-e833ee8602e7
        
--> 03: Question : https://github.com/anand-kumar96/SQL/assets/106487247/27e8b7a3-77b1-489e-893d-6d9d49e56b60
    --> Answer
        Select contents, username 
        FROM comments
        JOIN users On comments.user_id = users.id;
    --> OR
        Select contents, username 
        FROM users
        JOIN comments On comments.user_id = users.id;
    --> In general ( ON--> is for condition )
        Select column_name 
        From Table1
        Join Table2
        On someCondition;
    --> How it work => it start from FROM then it combine information of two table using join then from result of cobine it Select requird column.
    --> https://github.com/anand-kumar96/SQL/assets/106487247/0baa4694-0cbe-4038-aa8a-73409c51a8f7
    --> https://github.com/anand-kumar96/SQL/assets/106487247/3bbcdfaf-73b1-4333-8f7b-208ec674d1be

--> 04: Question : https://github.com/anand-kumar96/SQL/assets/106487247/8cecd500-b608-4fa8-800f-fd5b39570141
    --> Answer
        Select contents, url 
        FROM comments
        JOIN photos On comments.photo_id = photos.id;
    --> Or
        Select contents, url 
        FROM photos
        JOIN comments On photos.id=comments.photo_id;

--> 05: Practice Question : https://github.com/anand-kumar96/SQL/assets/106487247/6a445701-22d0-4d22-b493-bc659160e9fd
        CREATE Table authors(
          id Serial PRIMARY KEY,
          name VARCHAR(50) 
        );

        CREATE Table books(
          id Serial PRIMARY KEY,
          title VARCHAR(200),
          author_id INTEGER authors(id) ON DELETE CASCADE
        );

        INSERT INTO authors(name)
        VALUES
          ('JK Rowling'),
          ('Stephen King'),
          ('Agatha Christie'),
          ('Dr Seuss');

        INSERT INTO books(title, author_id)
        VALUES
          ('It',2),
          ('Chamber of Secrets',1),
          ('Cat and the Hat',4),
          ('Affair at Styles',3);

    --> Solution Query :
        Select title, name 
        FROM books
        JOIN authors
        On books.author_id = authors.id;

--> 6&7:https://github.com/anand-kumar96/SQL/assets/106487247/3fb4da63-0b3a-4579-b7ad-96fb96ee578f
    --> 01
        Select contents, url 
        FROM comments
        JOIN photos On comments.photo_id = photos.id;
    --> Or
        Select contents, url 
        FROM photos
        JOIN comments On photos.id=comments.photo_id;
    --> above both give same answer but it make some diffrences so use first one

    --> 02: Combing two tables which contain same column name and retriving it may throw error so better to give some name
    --> https://github.com/anand-kumar96/SQL/assets/106487247/94b2f037-e97b-4f36-9891-af35e1cabf98
        Select id 
        FROM photos
        JOIN comments
        On photos.id=comments.photo_id;  --> it will through error : Reference id is ambigous
    --> So specify which id or better use use allias like--> AS photos_id or we can also write alias without as give space and then name : photos_id
        Select photos.id AS photos_id
        FROM photos
        JOIN comments
        On photos.id=comments.photo_id;

    --> 03: Alias Uses to rename table --> best way to write
        Select p.url AS photos_url, c.contents
        FROM photos As p
        JOIN comments As c
        On p.id = c.photo_id;

--> 08: https://github.com/anand-kumar96/SQL/assets/106487247/76943313-a5e2-400c-b6a9-0fe586018b23
    --> Inserting photos referencing user_id Null
        INSERT INTO photos (url,user_id)
        VALUES ('http://banner.jpg',NULL);

        Select p.url, u.username
        FROM photos As p
        JOIN users As u
        On u.id = p.user_id;
    --> above command giving all existing url and username But when we are inserting a photos which referencing user_id : Null and running above command
    --> then it will give still original value not quering photos with Null user_id so how we get it ? 
   
--> 09: Ques: Why extra photo that added will null user_id not get added into our join result set ? 
    --> Ans:
        Select p.url, u.username 
        FROM photos As p
        JOIN users As u
        On u.id = p.user_id;
    --> Behand the scene it will take all rows of photos and now join users w.r.t user_id and since user_id=Null not exist in users -> id so it will not select in overall result see images
    --> https://github.com/anand-kumar96/SQL/assets/106487247/2f7bd20c-9b95-4556-be27-e36f75462389
    --> https://github.com/anand-kumar96/SQL/assets/106487247/454d55af-ee47-4430-9562-a1606c7ec7c0
    --> So there is diferent types of joints 

--> 10: There are Four Kinds Of joins 1) Inner Join 2) Left Join 3) Right Join 4) Full Join
    --> https://github.com/anand-kumar96/SQL/assets/106487247/a1931330-cb3e-4380-8aae-4d5a1883fb00
    --> https://github.com/anand-kumar96/SQL/assets/106487247/79abed4b-bc6d-4a2e-8867-455a7bbbde1a
    --> Inner Join              --> Left Join              --> Right Join            --> Full Join
        Select url, username       Select url, username       Select url, username       Select url, username
        FROM photos As p           FROM photos As p           FROM photos As p           FROM photos As p
        Inner JOIN users As u      LEFT JOIN users As u       RIGHT JOIN users As u      FULL JOIN users As u     
        On u.id = p.user_id;       On u.id = p.user_id;       On u.id = p.user_id;       On u.id = p.user_id;     

--> 11: All join Example
    --> Inner Join
        Select url, username
        FROM photos As p
        Inner JOIN users As u
        On u.id = p.user_id;

    --> Left Join : Insert a photos with user_id Null
        INSERT INTO photos (url,user_id)
        VALUES ('http://banner.jpg',NULL);

        Select url, username
        FROM photos As p
        LEFT JOIN users As u
        On u.id = p.user_id;

    --> Right Join : Insert a new User which doesnot post any photos
        INSERT INTO users (username)
        VALUES ('Gerard_Mitchell42');

        Select url, username
        FROM photos As p
        RIGHT JOIN users As u
        On u.id = p.user_id;

    --> Full Join
        Select url, username
        FROM photos As p
        FULL JOIN users As u
        On u.id = p.user_id;
--> 12: Ques: Does table order Matters ? 
    --> Ans: Yes it matters a lot when we are using left and right join see the image
    --> https://github.com/anand-kumar96/SQL/assets/106487247/e08837a3-ca16-4d23-ab20-bcb2a69f60b1

--> 13: Practice Question: https://github.com/anand-kumar96/SQL/assets/106487247/3b74a1c5-f3c7-49cc-aa84-844e7d8a8537
--> 14: Solution two possible solution using left and right join
    --> Solution 1 :
        Select title, name 
        FROM authors 
        LEFT JOIN books
        On books.author_id = authors.id;
    --> Solution 2 :
        Select title, name 
        FROM books  
        RIGHT JOIN authors
        On authors.id = books.author_id;
--> 15: 'Where'  Clause with join : where always should after join means => From--> Join --> Where
    --> Question : https://github.com/anand-kumar96/SQL/assets/106487247/fe9ef2f7-5b93-4f61-bf6a-c71ba68cbde2
    --> Statement : Select all photos and comment which is created and commented by same user
    --> Ans: 
    --> https://github.com/anand-kumar96/SQL/assets/106487247/850ce908-223a-4d11-99c3-4dfeec9cf9f5
    --> https://github.com/anand-kumar96/SQL/assets/106487247/a9eaf928-837a-4575-b001-7b3482b9d237
        Select url, contents
        FROM comments As c
        JOIN photos as p
        ON c.photo_id = p.id
        WHERE c.user_id = p.user_id;
--> 16: But how to print username also Since We don't have access --> We use some advance techniques of join
    --> We use Three way Join --> Means we merge together 3 differents Tables
    --> https://github.com/anand-kumar96/SQL/assets/106487247/e8d25992-e4fe-4c98-9799-d2fa3ef49d89
    --> https://github.com/anand-kumar96/SQL/assets/106487247/5fbfe6a1-6adb-4d95-86ba-c2a96813fbec
    --> Selecting url, contents, username 
        Select url,contents,username
        FROM comments As c 
        JOIN photos AS p 
        ON p.id = c.photo_id 
        JOIN users As u 
        On u.id = c.user_id;
    --> Selecting url, contents, username actual question in which select all url,contents which is created by same user
        Select url,contents,username
        FROM comments As c 
        JOIN photos AS p 
        ON p.id = c.photo_id 
        JOIN users As u 
        On u.id = c.user_id
        WHERE c.user_id = p.user_id;
    --> Best way
        Select url,contents,username
        FROM comments As c 
        JOIN photos AS p 
        ON p.id = c.photo_id 
        JOIN users As u 
        On u.id = c.user_id AND u.id = p.user_id;

--> 17: Creating reviews table
        CREATE TABLE reviews(
        id Serial PRIMARY KEY,
        rating INTEGER,
        reviewer_id INTEGER REFERENCES authors(id),
        book_id INTEGER REFERENCES books(id)
        );
        INSERT INTO reviews(rating, reviewer_id,book_id)
        VALUES
          (3,1,2),
          (4,2,1),
          (5,3,3);

--> 18: Query Selecting title, name, rating by same users who created books and also write review
        Select title, name , rating
        FROM reviews as r
        JOIN books as b
        On  b.id = r.book_id
        JOIN authors as a 
        On a.id = b.author_id AND a.id = r.reviewer_id ;
    --> Result:
        title	               name	        rating
        Chamber of Secrets	 JK Rowling	     3
        It	              Stephen King	     4
                
    --> reviews table : reviews       
        id	  rating	reviewer_id	    book_id
        1 	    3	        1     	      2
        2	    4	        2	          1
        3	    5	        3	          3    
            
    --> books table : books     
        id	 title	             author_id
        1   	It	                 2
        2	   Chamber of Secrets    1
        3	   Cat and the Hat     	 4
        4	   Affair at Styles      3  
                
    --> reviews join books : reviews with books      
        id	  rating	reviewer_id	    id     title	             author_id
        1 	   3	        1     	     2	   Chamber of Secrets     	1
        2	   4	        2	         1	      It	                2
        3	   5	        3	         3     Cat and the Hat     	    4
                
    --> authors table : authors    
        id	  name
        1	  JK Rowling
        2	  Stephen King
        3	  Agatha Christie
        4	  Dr Seuss
                
    --> reviews join books join authors: reviews with books with authors                  
        id	rating	reviewer_id	     id     title	               author_id    id       name
        1 	  3	        1     	     2	    Chamber of Secrets     	1           1	       JK Rowling
        2	  4	        2	         1	    It	                    2           2	       Stephen King
        3	  5	        3	         3      Cat and the Hat       	4          NULL        NULL
            
    --> Ans:
        title	             name	        rating
        Chamber of Secrets	 JK Rowling	     3
        It	                 Stephen King	 4
                



          
