--> 01: pgAdmin: install it
    --> Tool to manage and inspect a Postgres database.
    --> Can connect to local or remote database.
    --> Can view/change just about anything in PG.
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/bc1b0c4e-6e92-45bd-9285-a62aff667125

--> 02: Data Types
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/c5906513-addc-456d-8683-6aef2909838b
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/2b802199-cd44-43f8-a53c-6f2e6338cc32
    --> Numbers, Currency, Binary, Date/Time, Character, JSON, Geometric, Range, Arrays, Bollean, XML, UUID
    --> Numbers: ***
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/e71c3e70-4019-4150-8865-571e601a8382
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/6aa3e40d-ea85-4886-96f0-04dfac637a39

--> 03: Fast Rule on Storing Numbers
    --> https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/dfe12501-d4f7-4214-accb-32677e8153fa

--> 04: Play with Query Editor
        Select (2.0); --> ?column? numeric 2.o
        SELECT (2.0 :: INTEGER); --> int4 Integer 2
        SELECT (2.0 :: SMALLINT);
        SELECT (1.9999 :: DECIMAL - 1.9998 :: DECIMAL);

--> 05: Character Type : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/858d13fb-d132-4827-bbe2-988a93e6eae3
        SELECT ('CHCHSCHShh':: CHAR(3)) --> CHC
        SELECT ('C':: CHAR(3)) -->C  --> two spaces automatically added right of C
    --> CHAR(N)=> n length of character
    --> VARCHAR => Store any length of string
    --> VARCHAR(50) => Store a string upto 50 characters automatically remove extra characters
    --> TEXT => Store any length of String

--> 06: Boolean Data Types : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/9fccd886-74a5-428d-890f-d2f58d5e352a
    --> true,yes,on,1,t,y ---> TRUE, false,no,off,0,f,n --> FALSE, null --> NULL
        SELECT('yes':: Boolean), SELECT('y':: Boolean), SELECT('1':: Boolean), SELECT('t':: Boolean), SELECT('on':: Boolean) -->TRUE
        SELECT('no':: Boolean), SELECT('n':: Boolean), SELECT('0':: Boolean), SELECT('f':: Boolean), SELECT('off':: Boolean) -->FALSE
        SELECT(null:: Boolean) --> NULL

--> 07: Times, Date and TimesStamp : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/ee36e3c8-2c76-49a7-ac46-8933f208358c
    --> DATE    
        SELECT('1980-11-20'::DATE) --> 1980-11-20
        SELECT('Nov-20-1980'::DATE) --> 1980-11-20
        SELECT('20-Nov-1980'::DATE) --> 1980-11-20
        SELECT('1980-November-20'::DATE) --> 1980-11-20
        SELECT('November 20,1980'::DATE) --> 1980-11-20
        
    --> TIME: TIME WITHOUT TIME ZONE --> 24 hour format  
        SELECT('01:23 AM'::TIME) --> 01:23:00
        SELECT('05:23 PM'::TIME) --> 17:23:00
        SELECT('20:34'::TIME) --> 20:34:00

    --> TIME: TIME WITH TIME ZONE --> 24 hour format : https://github.com/anand-kumar96/sqlandPostgreSqlNotes/assets/106487247/f6738aee-282a-4792-b0e3-99d3ef5fdeb8
        SELECT('01:23 AM EST'::TIME WITH TIME ZONE) --> 01:23:00-05:00 -> Mwans 5 hours behind UTC time zone
        SELECT('05:23 PM PST'::TIME WITH TIME ZONE) --> 17:23:00-08:00
        SELECT('05:23 PM UTC'::TIME WITH TIME ZONE) --> 17:23:00+00:00
    
    --> TIMESTAMP WITH TIME ZONE
        SELECT('Nov-20-1980 05:23 PM PST':: TIMESTAMP WITH TIME ZONE) --> 1980-11-21 06:53:00+05:30
        
--> 08: INTERVAL
    --> 1 day--> 1 day
    --> 1 D --> 1 day
    --> 1 D 1 M 1 S --> 1 day 1 min 1 second
        SELECT('1 day':: INTERVAL) --> 1 day
        SELECT('1 D':: INTERVAL) --> 1 day
        SELECT('1 D 1 M 1 S':: INTERVAL) --> 1 day 00:01:01
        SELECT('NOV-20-1980 1:23 AM IST':: TIMESTAMP WITH TIME ZONE) - ('1 D'::INTERVAL); --> 1980-11-19 04:53:00+05:30