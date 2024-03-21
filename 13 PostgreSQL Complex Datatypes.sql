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