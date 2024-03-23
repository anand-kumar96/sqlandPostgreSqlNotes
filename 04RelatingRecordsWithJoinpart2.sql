--> 1&2:https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/e005a2f9-3c3c-4313-bb6e-c626328a00d5
    --> user who created the comment on a photo
    --> Some Query Questions : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/e8ccbf33-cd5f-49f8-a3bb-fc4104ff04fc
    --> we solve  these questions using Joins and Aggregation
    --> Joins: Question1 , Aggregation: Question 2,3,4,5  
    --> notes : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/09e29194-48d8-4a97-bbaf-6ce849ee5290
        
--> 03: Question : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/d2e9966a-df6a-46f9-804c-6fe7f40f2370
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
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/c9d72b18-b856-4d8d-ad85-013002405ed8
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/a3aa45de-f5c8-4bcc-8235-1c5030e974ea

--> 04: Question : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/c7ca72dd-5a86-4628-8d60-25bb671b47b8
    --> Answer
        Select contents, url 
        FROM comments
        JOIN photos On comments.photo_id = photos.id;
    --> Or
        Select contents, url 
        FROM photos
        JOIN comments On photos.id=comments.photo_id;

--> 05: Practice Question : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/c98cb3fc-9904-4a13-aab7-7a69b710bd97
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

--> 6&7:https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/62f3163a-daff-4850-9135-36013b8f443b
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
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/124873ae-78b7-4119-a96e-da37ce2dcc0a
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

--> 08: https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/1969ea8b-acd0-4129-a228-32dd02a8a721
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
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/7cc5f5f2-1e9a-4730-9564-af7684da4016
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/c25d2ee9-1631-42b3-bebf-b792e6754df5
    --> So there is diferent types of joints 

--> 10: There are Four Kinds Of joins 1) Inner Join 2) Left Join 3) Right Join 4) Full Join
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/2691c3a1-343a-4e01-8dbd-107feaa1f2d2
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/1e2e01b4-4150-4b88-b5bd-e723fabc69ff
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
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/5bdef4a7-c90f-435a-95c8-2a4b6f595dce

--> 13: Practice Question: https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/89877cf1-95a1-4a46-a254-b525d8675809
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
    --> Question : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/410c5814-7696-48bf-a1b4-dd819bc94c6e
    --> Statement : Select all photos and comment which is created and commented by same user
    --> Ans: 
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/e59ddb15-1adb-4ff7-a90c-51aaf314d1a8
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/6c83f7e3-a21b-4d7f-b6bf-2938803d48c2
        Select url, contents
        FROM comments As c
        JOIN photos as p
        ON c.photo_id = p.id
        WHERE c.user_id = p.user_id;
--> 16: But how to print username also Since We don't have access --> We use some advance techniques of join
    --> We use Three way Join --> Means we merge together 3 differents Tables
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/cea972de-9a1d-4112-8d7a-b3796deb95ee
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/d720d25b-a198-4dd3-b8d8-03e60d815b1c
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
                



          
