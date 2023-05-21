--            CONSTRAINTS

--1)Primary Key:It is for making records unique.
--            It does not accept "null" as value
--            It does not accept "repeated data", all data in primary key must be unique
--            A table can have just one "single primary key" field.

--           Field Name - Data Type - Constraint
--           student_id   VARCHAR     Primary Key

--2)Foreign Key: It is for creating relationships between the tables.
--             It accepts "null" as value
--             It accepts repeated data
--             A table can have multiple foreign key fields.

--3)Unique Key: It is for making data in a field unique.
--            When you insert a data in a "Unique Key Field", Postgre will check if it is matching with the existing ones.
--            When you update a data in a "Unique Key Field", Postgre will check if it is matching with the existing ones.
--            If there is any value matching with the existing values, Postgre will give error.
--            It accepts "null" as value for multiple times.

--            Field Name    -  Data Type - Constraint
--            email_address     VARCHAR     UNIQUE

--4)Check: It checks conditions we out for the data/value

--            Field Name    -  Data Type - Constraint
--            student_age      INTEGER     CHECK(student_age>0)

--5)NOT NULL: It tells to Postgre  not to accept "null" values for the specified fields.
--           To make a field "Required Field" we use "NOT NULL" constraint 

--            Field Name    -  Data Type - Constraint
--            ssn               VARCHAR     NOT NULL

--    DATA TYPES IN POSTGRESQL
--1)Boolean: It has 3 values  i)true  ii)false   iii)null
--           Boolean can be used like "Bool"

--          is_retired BOOLEAN OR is_retired BOOL


--2)CHAR: It is for fixed length Strings
--      CHAR(n) does not accept more than "n" characters.
--      CHAR(n) accepts "n" or less than "n" characters
--      CHAR means CHAR(1)

--      social_security_number CHAR(9)

--3)VARCHAR/TEXT: It is for Strings
--               VARCHAR and TEXT are completely same data types for PostgreSql
--               address  VARCHAR or address TEXT

--4)NUMERIC: This is for storing numeric values(whole or decimal)

--           price NUMERIC(5, 2)--> 437.87
--                              --> "5" is called "precision" and it displays total number of digits that is acceptable for data input
--                              --> "2" is called "scale" and it displays the number of digits in decimal part
--                              If you use more than 5 digits in total, PostgreSql will give error
--                              If you use more than 2 digits for decimal part, PostgreSql will give error
--                              Using less number than 5 is allowed in PostgreSQL


--          price NUMERIC(5, 0) --> whole number 45643
--           price NUMERIC(5) -->whole number

-- price NUMERIC --> There is no any limit for "precision" and "scale" parts of the input

--5)DATE: It is for storing date values
--         Default the format is like "yyyy-mm-dd"
--         When you insert data, if you donot use the default given format, it gives error

--          date_of_birth  DATE 

--          If you need to store current date automatically you can use 
--          registration_date  DATE CURRENT_DATE

--6)TIME : It is for storing time values
--         Default the format is like "hh-mm-ss"
--         When you insert data, if you donot use the default given format, it gives error

--        appointment_time   TIME 

--7)JSON: If we need to store data in key-value structure you can use JSON data type
--        apple: 12, orange:15, apricot:13
--        fruit_prices JSON 


--How to create a table 

CREATE TABLE students(
   
	student_id CHAR(5) PRIMARY KEY,
	student_name VARCHAR,
	email_address VARCHAR NOT NULL,
	student_age NUMERIC(2) CHECK(student_age>0),
	phone_number CHAR(10) UNIQUE

)

--How to see all data in a table
SELECT * FROM students;

--How to insert data into a table
INSERT INTO students VALUES('11111', 'Tom Hanks', 'th@gmail.com', 15, '1234567890');
INSERT INTO students VALUES('11112', 'Brad Pitt', 'bp@gmail.com', 22, '2345678901');
INSERT INTO students VALUES('113',  'Tom Hanks', 'th@gmail.com', 12, '6234567890');

--How to insert data into a table for specific 
INSERT INTO students(student_id, email_address, phone_number) VALUES ('11114', 'abc@gmail.com', '4567890987');
INSERT INTO students(email_address, phone_number, student_id) VALUES ('xyz@gmail.com', '5678904567', '11115');

--How to update existing data in a table
--Example 1:Change 113 student_id to 11113
UPDATE students
SET student_id='11113'
WHERE student_id='113';

--Example 2: Change Tom Hanks to Anthony Quinn

UPDATE students
SET student_name='Anthony Quinn'
WHERE student_name='Tom Hanks';

--Example 3: Change bp@gmail.com to null

UPDATE students
SET email_address=null
WHERE email_address='bp@gmail.com';

--Example 4: Update all student ages to the maximum age value

UPDATE students
SET student_age=(SELECT MAX(student_age) FROM students);
				 
--Example 5: Create a parents table with parent_id, parent_name, student_id, parent_address, parent_dob fields

CREATE TABLE parents(

             parent_id CHAR(5) PRIMARY KEY, 
	         parent_name TEXT,
	         student_id CHAR(5),
	         parent_address TEXT,
	         parent_dob DATE
)

SELECT * FROM parents;

--Examğle 6: Insert 4 records into the parents table
INSERT INTO parents VALUES('21111', 'Mark Hanks', '11111', 'Miami, FL', '1994-10-23');
INSERT INTO parents VALUES('21112', 'Andy Pitt', '11112', 'New York, USA', '1987-2-13');
INSERT INTO parents VALUES('21113', 'John Walker', '11113', 'Berlin, Germany', '1975-12-5');
INSERT INTO parents VALUES('21114', 'Mary Star', '11114', 'Istanbul, Turkey', '1975-10-1');

--Example 7: Change all date of births to the minimum date of birth in the parents
UPDATE parents
SET parent_dob=(SELECT MIN(parent_dob) FROM parents);







--How to DELETE a table from database
DROP TABLE students;