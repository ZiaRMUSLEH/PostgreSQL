
--How to create a table 
CREATE TABLE students(

	student_id CHAR(5) PRIMARY KEY,
	student_name VARCHAR,
	email_address VARCHAR NOT NULL,
	student_age NUMERIC(2) CHECK(student_age>0),
	phone_number CHAR(10) UNIQUE
)

--How to see all data in a table
SELECT  * FROM students;

--How to insert data into a table for specific 
INSERT INTO students VALUES('11111', 'Tom Hanks', 'th@gmail.com', 15, '1234567890');
INSERT INTO students VALUES('11112', 'Brad Pitt', 'bp@gmail.com', 22, '2345678901');
INSERT INTO students VALUES('113',  'Tom Hanks', 'th@gmail.com', 12, '6234567890');
--How to update existing data in a table
INSERT INTO students(student_id, email_address,phone_number) VALUES ('11114', 'abc@gmail.com', '4567890987');
INSERT INTO students(email_address, phone_number, student_id) VALUES ('xyz@gmail.com', '5678904567', '11115');


--Example 1:Change 113 student_id to 11113
UPDATE students
SET student_id = '11113'
WHERE student_id = '113';

SELECT * FROM students;

--Example 2: Change Tom Hanks to Anthony Quinn
UPDATE students
SET student_name = 'Anthony Quinn'
WHERE student_name = 'Tom Hanks';

--Example 3: Change bp@gmail.com to null
UPDATE students
SET email_address =NULL
WHERE email_address = 'bp@gmail.com';

--Example 4: Update all student ages to the maximum age value
UPDATE students
SET student_age = (SELECT MAX(student_age) FROM students)

--Example 5: Create a parents table with parent_id, parent_name, student_id, parent_address, parent_dob fields
CREATE TABLE parents(
	
	parent_id CHAR(5)  PRIMARY KEY,
	parent_name VARCHAR,
	student_id CHAR(5),
	parent_address VARCHAR,
	parent_dob DATE
	
)

--Example 6: Insert 4 records into the parents table
INSERT INTO parents VALUES('21111', 'Mark Hanks', '11111', 'Miami, FL', '1994-10-23');
INSERT INTO parents VALUES('21112', 'Andy Pitt', '11112', 'New York, USA', '1987-2-13');
INSERT INTO parents VALUES('21113', 'John Walker', '11113', 'Berlin, Germany', '1975-12-5');
INSERT INTO parents VALUES('21114', 'Mary Star', '11114', 'Istanbul, Turkey', '1975-10-1');

--Example 7: Change all date of births to the minimum date of birth in the parents 

UPDATE parents
SET parent_dob = (SELECT MIN(parent_dob) FROM parents);


--How to DELETE a table from database
DROP TABLE parents;
---*************************
--Create workers table whose fields are worker_id, worker_name, worker_salary.
--worker_id will have primary key with the name worker_id_pk
--Insert 4 records into the workers table
--See the table on the console
CREATE TABLE workers(

	worker_id SMALLINT,
    worker_name VARCHAR(50),
    worker_salary NUMERIC,
	CONSTRAINT worker_id_pk PRIMARY KEY (worker_id)
)

INSERT INTO workers VALUES(101, 'Tom Hanks', 12000);
INSERT INTO workers VALUES(102, 'Brad Pitt', 2000);
INSERT INTO workers VALUES(103, 'Aisha Can', 7000);
INSERT INTO workers VALUES(104, 'Angie Ocean', 12000);

SELECT * FROM workers;

--Increase the salary of "Brad Pitt" to 20 percent less than the highest salary
UPDATE workers
SET worker_salary = (SELECT MAX(worker_salary) *0.8 FROM workers )
WHERE worker_name = 'Brad Pitt';

--Decrease the salary of Tom Hanks to 30 percent more than the lowest salary
UPDATE workers
SET worker_salary = (SELECT MIN(worker_salary)*1.3 FROM workers)
WHERE worker_name = 'Tom Hanks';

--Increase the salaries by 1000 if the salaries are less then the average salary ---
UPDATE workers
SET worker_salary = worker_salary+1000
WHERE worker_salary<(SELECT AVG(worker_salary) FROM workers);

--Make the salaries equal to the average salary if the salaries are less than the average salary
UPDATE workers
SET worker_salary = (SELECT AVG (worker_salary) FROM workers)
WHERE worker_salary< (SELECT AVG (worker_salary) FROM workers);

SELECT * FROM workers;

CREATE TABLE people
(
ssn INT,
name VARCHAR(50),
address VARCHAR(80)     
);

INSERT INTO people VALUES(123456789, 'Mark Star', 'Florida');
INSERT INTO people VALUES(234567890, 'Angie Way', 'Virginia');
INSERT INTO people VALUES(345678901, 'Maryy Tien', 'New Jersey');
INSERT INTO people(ssn, address) VALUES(456789012, 'Michigan');
INSERT INTO people(ssn, address) VALUES(567890123, 'California');
INSERT INTO people(ssn, name) VALUES(567890123, 'California');


--Change all null values to "Name will be inserted later"
UPDATE people
SET name = 'Name will be inserted later'
WHERE name IS NULL;

SELECT * FROM people;

--Change all null address values to "Address will be inserted later"
UPDATE people
SET address = 'Address will be inserted later'
WHERE address IS NULL;

--How to delete records which do not have a name value---
DELETE FROM  people
WHERE name = 'Name will be inserted later';

--How to delete all records
DELETE FROM people;
TRUNCATE TABLE people;


--Delete all records whose name is null or address is null
DELETE FROM people
WHERE name IS NULL OR address IS NULL;

--Delete all records whose SSN is greater than 123456789 and less than 345678901
DELETE FROM people
WHERE ssn>123456789 AND ssn<345678901;
--Delete all records whose name value is not null
DELETE FROM people
WHERE name IS NOT NULL;

SELECT * FROM people;

DROP TABLE workers;

CREATE TABLE workers(
  worker_id SMALLINT,
  worker_name VARCHAR(50),
  worker_salary NUMERIC,
  
  CONSTRAINT worker_id_pk PRIMARY KEY(worker_id)

)

INSERT INTO workers VALUES(101, 'Ali Can', 1200);
INSERT INTO workers VALUES(102, 'Veli Han', 2000);
INSERT INTO workers VALUES(103, 'Aisha Can', 7000);
INSERT INTO workers VALUES(104, 'Angie Ocean', 12000);

SELECT * FROM workers;

--How to select all data from a table
SELECT * FROM workers;
--How to get specific field from a table
SELECT worker_id FROM workers;
--How to get multiple specific field from a table
SELECT worker_id, worker_name FROM workers;
--How to get specific record
SELECT * FROM workers 
WHERE worker_id = 101;

--How to get multiple specific records
SELECT * FROM workers 
WHERE worker_id IN(101, 102);

SELECT * FROM workers 
WHERE worker_id< 102;


--Get records whose salary is 2000 or 7000 or 12000
SELECT * FROM workers
WHERE worker_salary IN(2000, 7000, 12000);

--How to get a spcific cell
SELECT worker_name FROM workers
WHERE worker_name = 'Veli Han';

SELECT worker_name
FROM workers
WHERE worker_id=102;

--Interview Question: How to select record whose salary is second highest--
SELECT MAX (worker_salary) FROM workers
WHERE worker_salary<(SELECT MAX(worker_salary) FROM workers);

SELECT * FROM workers
ORDER BY worker_salary
OFFSET 1 ROW 
FETCH NEXT 1 ROW ONLY;


--Select maximum salary
SELECT MAX (worker_salary) FROM workers AS maximum_salary;

--Select minimum salary by using AS
SELECT MIN(worker_salary) FROM workers AS minimum_salary;

--Select average salary value by using "AS"
SELECT AVG(worker_salary) FROM workers AS average_salary;

--Count the number of workers
SELECT COUNT(worker_name) FROM workers;
--Find the sum of worker_salaries
SELECT SUM(worker_salary) FROM workers;
--Interview Question: Select the second lowest salary
SELECT MIN(worker_salary) FROM workers
WHERE worker_salary> (SELECT MIN(worker_salary)FROM workers );

--Interview Question: How to select records whose salary is the lowest and highest
SELECT * FROM workers
WHERE worker_salary IN ((SELECT MIN(worker_salary) FROM workers),(SELECT MAX(worker_salary) FROM workers));
SELECT * FROM workers;

-----------------**************************

CREATE TABLE employees 
(  
  id CHAR(9), 
  name VARCHAR(50), 
  state VARCHAR(50), 
  salary SMALLINT,
  company VARCHAR(20)
);

INSERT INTO employees VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM');
INSERT INTO employees VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE');
INSERT INTO employees VALUES(345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM');
INSERT INTO employees VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE');
INSERT INTO employees VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT');
INSERT INTO employees VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE');
INSERT INTO employees VALUES(123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');

SELECT * FROM employees;

CREATE TABLE companies 
(  
  company_id CHAR(9), 
  company VARCHAR(20),
  number_of_employees SMALLINT
);

INSERT INTO companies VALUES(100, 'IBM', 12000);
INSERT INTO companies VALUES(101, 'GOOGLE', 18000);
INSERT INTO companies VALUES(102, 'MICROSOFT', 10000);
INSERT INTO companies VALUES(103, 'APPLE', 21000);

SELECT * FROM companies;


--Find the employee and company names whose company has more than 15000 employees--
SELECT name, company 
FROM employees
WHERE company IN (SELECT company FROM companies WHERE number_of_employees>15000);

------------------************************************************


--.Find the 3.highest salary
SELECT salary FROM  employees
ORDER BY salary DESC
OFFSET 2 ROW
FETCH NEXT 1 ROW ONLY ;

--Find the company names and company ids which are in Florida.
SELECT company_id, company
FROM companies 
WHERE company IN (SELECT company FROM employees WHERE state = 'Florida');
--Find employee names and states whose company id is greater than 100
SELECT name, state
FROM employees
WHERE company IN (SELECT company FROM companies WHERE company_id>'100');
--Find the company name, number of employees and average salary for every company
SELECT company, number_of_employees, 
(SELECT AVG(salary) FROM employees WHERE employees.company=companies.company)
FROM companies;


CREATE TABLE customers_products
( 
  product_id INT,
  customer_name VARCHAR(50),
  product_name VARCHAR(50)
);
 
INSERT INTO customers_products VALUES (10, 'Mark', 'Orange');
INSERT INTO customers_products VALUES (10, 'Mark', 'Orange');
INSERT INTO customers_products VALUES (20, 'John', 'Apple');
INSERT INTO customers_products VALUES (30, 'Amy', 'Palm');
INSERT INTO customers_products VALUES (20, 'Mark', 'Apple');
INSERT INTO customers_products VALUES (10, 'Adem', 'Orange');
INSERT INTO customers_products VALUES (40, 'John', 'Apricot');
INSERT INTO customers_products VALUES (20, 'Eddie', 'Apple');  
SELECT * FROM customers_products;

--Find the records that has the product_name value as Orange, Apple or Palm
SELECT * FROM customers_products
WHERE product_name IN ('Orange','Apple','Palm');

--Find the records that has not the product_name value as Orange, Apple or Palm
SELECT * FROM customers_products
WHERE product_name NOT IN ('Orange','Apple','Palm');

--Find the product_names that have product_id less than 30 or equal to 30 and greater than 20 or equal to 20
SELECT product_name FROM customers_products
WHERE product_id<= 30 OR product_id>= 20;

--Select the records whose product id is less than 20 greater than 25
SELECT * FROM customers_products
WHERE product_id NOT BETWEEN 20 AND 25;

DROP TABLE customers_likes;

CREATE TABLE customers_likes
( 
  product_id CHAR(10),
  customer_name VARCHAR(50),
  liked_product VARCHAR(50)
);


INSERT INTO customers_likes VALUES (10, 'Mark', 'Orange');
INSERT INTO customers_likes VALUES (50, 'Mark', 'Pineapple');
INSERT INTO customers_likes VALUES (60, 'John', 'Avocado');
INSERT INTO customers_likes VALUES (30, 'Lary', 'Cherries');
INSERT INTO customers_likes VALUES (20, 'Mark', 'Apple');
INSERT INTO customers_likes VALUES (10, 'Adem', 'Orange');
INSERT INTO customers_likes VALUES (40, 'John', 'Apricot');
INSERT INTO customers_likes VALUES (20, 'Eddie', 'Apple');

SELECT * FROM customers_likes;

--If the customer_name field has "Lary" among the customer_name field, update all customer_name field as "No Name".--
UPDATE customers_likes
SET customer_name = 'No name'
WHERE EXISTS (SELECT customer_name FROM customers_likes WHERE customer_name = 'Lary');

--If the product_id has 60 among the product_id field update all liked product_id to 50
UPDATE customers_likes
SET product_id = '50'
WHERE EXISTS (SELECT product_id FROM customers_likes WHERE product_id = '60');

--If Lary exists in customer name then update it with 'No Name'---
UPDATE customers_likes
SET customer_name = 'No name'
WHERE customer_name = 'Lary';

SELECT * FROM customers_likes;

--Delete records if there is 'Orange' as product name in customers_likes table
DELETE FROM customers_likes
WHERE EXISTS (SELECT liked_product FROM customers_likes WHERE liked_product = 'Orange');

--Find the name of the companies, company ids maximum and minimum salaries per company
SELECT company, company_id, 
(SELECT MAX (salary) FROM employees WHERE employees.company=companies.company)AS maximum_salary,
(SELECT MIN (salary) FROM employees WHERE employees.company=companies.company)AS minimum_slary
FROM companies;

SELECT * FROM companies;
SELECT * FROM employees;
--Select employee names which start with 'E'
SELECT name FROM employees
WHERE name LIKE 'E%';
--Select employee names which ends with 'e'
SELECT name FROM employees
WHERE name LIKE '%e';
--Select employee names which starts with 'B' and ends with 't'
SELECT name FROM employees
WHERE name LIKE 'B%t';
--Select employee names which has 'a' in any position
SELECT name FROM employees
WHERE name LIKE '%a%';
--Select employee names which has 'e' and 'r' in any position---
SELECT name FROM employees
WHERE name LIKE '%e%' OR name LIKE '%r%';
--Select state whose second character is 'e' and forth is 'n'
SELECT state FROM employees
WHERE state LIKE '_e_n%';
--Select state whose last second character is 'i'
SELECT state FROM employees
WHERE state LIKE '%i_';
--Select 'states' whose second character is 'e' and it has at least 6 characters
SELECT state FROM employees
WHERE state LIKE '_e____%';
--Select state which has 'i' in any position after second character
SELECT state FROM employees
WHERE state LIKE '__%i%';

SELECT * FROM employees;

CREATE TABLE words
( 
  word_id CHAR(10) UNIQUE,
  word VARCHAR(50) NOT NULL,
  number_of_letters SMALLINT
);

INSERT INTO words VALUES (1001, 'hot', 3);
INSERT INTO words VALUES (1002, 'hat', 3);
INSERT INTO words VALUES (1003, 'hit', 3);
INSERT INTO words VALUES (1004, 'hbt', 3);
INSERT INTO words VALUES (1008, 'hct', 3);
INSERT INTO words VALUES (1005, 'adem', 4);
INSERT INTO words VALUES (1006, 'selena', 6);
INSERT INTO words VALUES (1007, 'yusuf', 5);

--Select words which do not have 'h' in any position
SELECT word FROM words
WHERE word NOT LIKE '%h%';
--Select words which do not end with 't' and do not end 'f' 
SELECT word FROM words
WHERE word NOT LIKE '%t' AND word NOT LIKE '%f';
--Select words which start with any character, not followed by 'a', not followed by 'e'
SELECT word FROM words
WHERE word NOT LIKE '_a%' AND word NOT LIKE '_e%';
--Select words whose first character is 'h', last character is 't' and second character is 'o', or 'a', or 'i'
SELECT word FROM words
WHERE word ~ '^h[oai](.*)t$';
--Select words whose first character is 'h', last character is 't' and second character is from 'a' to  'e'
SELECT word FROM words
WHERE word ~ '^h[a-e](.*)t$';
--Select words whose first character is 's' or 'a' or 'y'
SELECT word FROM words
WHERE word ~ '^[say](.*)';
--Select words whose last character is 'm' or 'a' or 'f'
SELECT word FROM words
WHERE word ~ '(.*)[maf]$';

---Select words which have 'a' in any position
SELECT word FROM words
WHERE word ~ '(.*)a(.*)';
--Select words which have characters from 'd' to 't' at the beginning followed by any character and then 'l'
SELECT word FROM words
WHERE word ~ '^[d-t].l(.*)';

--Select words which have characters from 'd' to 't' at the beginning followed by any two characters and then 'e'
SELECT word FROM words
WHERE word ~ '^[d-t]..e(.*)';
--Select employee names which do not start with 'E' and do not end with 'y'
SELECT name FROM employees
WHERE name ~ '^[^E](.*)[^y]$';

--Select states whose third character is 'o' or 'x'
SELECT state FROM employees
WHERE state ~ '..[ox](.*)';
--Select states whose third character from the end is not "n" or "x"
SELECT state FROM employees
WHERE state ~ '(.*)[^nx]..$';

DROP TABLE workers;

CREATE TABLE workers
(  
  id CHAR(9), 
  name VARCHAR(50), 
  state VARCHAR(50), 
  salary SMALLINT,
  company VARCHAR(20)
);

INSERT INTO workers VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM');
INSERT INTO workers VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE');
INSERT INTO workers VALUES(345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM');
INSERT INTO workers VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE');
INSERT INTO workers VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT');
INSERT INTO workers VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE');
INSERT INTO workers VALUES(123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');

DROP TABLE words;

CREATE TABLE words
( 
  word_id CHAR(10) UNIQUE,
  word VARCHAR(50) NOT NULL,
  number_of_letters SMALLINT
);

INSERT INTO words VALUES (1001, 'hot', 3);
INSERT INTO words VALUES (1002, 'hat', 3);
INSERT INTO words VALUES (1003, 'hit', 3);
INSERT INTO words VALUES (1004, 'hbt', 3);
INSERT INTO words VALUES (1008, 'hct', 3);
INSERT INTO words VALUES (1005, 'adem', 4);
INSERT INTO words VALUES (1006, 'selena', 6);
INSERT INTO words VALUES (1007, 'yusuf', 5);

--Put the records in ascending order by using number_of_letters
SELECT * FROM words
ORDER BY number_of_letters ASC;
--Put the records in descending order by using word
SELECT * FROM words
ORDER BY word DESC;


CREATE TABLE points
(
    name VARCHAR(50),
    point SMALLINT
);

INSERT INTO points values('Ali', 25);
INSERT INTO points values('Veli', 37);
INSERT INTO points values('Kemal', 43);
INSERT INTO points values('Ali', 36);
INSERT INTO points values('Ali', 25);
INSERT INTO points values('Veli', 29);
INSERT INTO points values('Ali', 45);
INSERT INTO points values('Veli', 11);
INSERT INTO points values('Ali', 125);

SELECT *
FROM points


--Put the records in descending order by using name field, and ascending order by using points--
SELECT * FROM points
ORDER BY name DESC, points ASC;

DROP TABLE employees;

CREATE TABLE employees 
(  
  employee_id CHAR(9), 
  employee_first_name VARCHAR(20),
  employee_last_name VARCHAR(20)
);

INSERT INTO employees VALUES(14, 'Chris', 'Tae');
INSERT INTO employees VALUES(11, 'John', 'Walker');
INSERT INTO employees VALUES(12, 'Amy', 'Star');
INSERT INTO employees VALUES(13, 'Brad', 'Pitt');
INSERT INTO employees VALUES(15, 'Chris', 'Way');

SELECT * FROM employees;

CREATE TABLE addresses 
(  
  employee_id CHAR(9), 
  street VARCHAR(20),
  city VARCHAR(20),
  state CHAR(2),
  zipcode CHAR(5)
);

INSERT INTO addresses VALUES(11, '32nd Star 1234', 'Miami', 'FL', '33018');
INSERT INTO addresses VALUES(12, '23rd Rain 567', 'Jacksonville', 'FL', '32256');
INSERT INTO addresses VALUES(13, '5th Snow 765', 'Hialeah', 'VA', '20121');
INSERT INTO addresses VALUES(14, '3rd Man 12', 'Weston', 'MI', '12345');
INSERT INTO addresses VALUES(15, '11th Chris 12', 'St. Johns', 'FL', '32259');

SELECT * FROM addresses;


--1)Select employee_first_name and state, for employee first name use "firstname" as field name 
--and for state use "employee state" as field name

SELECT employee_first_name AS firstname,
(SELECT state FROM addresses WHERE addresses.employee_id=employees.employee_id)AS "employee state"
FROM employees;

SELECT e.employee_first_name AS firstname, a.state AS "employee state"
FROM employees e, addresses a
WHERE e.employee_id=a.employee_id;


--2)Get employee id use "id" as field name, get firstname and lastname put them into the same ---
---field and use "full_name" as field name

SELECT employee_id AS id, 
employee_first_name ||' '||employee_last_name AS full_name
FROM employees;

DROP TABLE workers;

CREATE TABLE workers 
(  
  id CHAR(9), 
  name VARCHAR(50), 
  state VARCHAR(50), 
  salary SMALLINT,
  company VARCHAR(20)
);

INSERT INTO workers VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM');
INSERT INTO workers VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE');
INSERT INTO workers VALUES(345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM');
INSERT INTO workers VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE');
INSERT INTO workers VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT');
INSERT INTO workers VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE');
INSERT INTO workers VALUES(123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');

SELECT * FROM workers;

--Find the total salary for every employee---
SELECT name , 
SUM(salary)AS total_salary
FROM workers
GROUP BY name;

--Find the number of employees per state in descending order by employee number
SELECT state, COUNT(id) AS employee_number
FROM workers
GROUP BY state
ORDER BY employee_number DESC;

--Find the number of the employees whose salary is more than $2000 per company----
SELECT company, COUNT (id) number_of_employees
FROM workers
GROUP BY company
HAVING SUM (salary)>2000;


--Find the minimum and maximum salary for every company
SELECT company, 
MAX (salary) AS max_salary,
MIN (salary) AS min_salary
FROM workers
GROUP BY company;

--Find the number of employees if it is more than 1 per state
SELECT state, COUNT (employee_id) AS number_of_employees
FROM addresses
GROUP BY state
HAVING COUNT (employee_id)>1;

SELECT state, COUNT(name) AS number_of_employees
FROM workers
GROUP BY state
HAVING COUNT(state)>1;


--Find the minimum salary if it is more than 2000 for every company
SELECT company, MIN (salary) AS minimum_salary
FROM workers
GROUP BY company
HAVING MIN (salary)>2000;


--Find the maximum salary if it is less than 3000 for every state
SELECT state, MAX (salary) AS maximum_salary
FROM workers
GROUP BY state
HAVING MAX(salary)<3000;

--Find the state whose salary is greater than 3000, employee names less than 2000 without duplication.
SELECT state
FROM workers
WHERE salary >3000

UNION

SELECT name
FROM workers
WHERE salary<2000;

--Find the state whose salary is greater than 3000, employee names less than 2000 with duplication.
SELECT state
FROM workers
WHERE salary>3000
UNION ALL
SELECT name
FROM workers
WHERE salary<2000;

--Find all common employee names whose salary is greater than 1000, less than 2000
SELECT name
FROM workers
WHERE salary>1000
INTERSECT
SELECT name
FROM workers
WHERE salary<2000;


--Find all common employee names whose salary is greater than 2000 and company name is IBM, APPLE or GOOGLE
SELECT name
FROM workers
WHERE salary>2000
INTERSECT
SELECT name
FROM workers
WHERE company IN ('IBM','APPLE','GOOGLE');

--Find the employee names whose salary is less than 3000 and not working in GOOGLE
SELECT name
FROM workers
WHERE salary <3000
EXCEPT 
SELECT name
FROM workers
WHERE company = 'GOOGLE';

CREATE TABLE my_companies 
(  
  company_id CHAR(3), 
  company_name VARCHAR(20)
);

INSERT INTO my_companies VALUES(100, 'IBM');
INSERT INTO my_companies VALUES(101, 'GOOGLE');
INSERT INTO my_companies VALUES(102, 'MICROSOFT');
INSERT INTO my_companies VALUES(103, 'APPLE');

CREATE TABLE orders 
(  
  company_id CHAR(3),   
  order_id CHAR(3),
  order_date DATE
);

INSERT INTO orders VALUES(101, 11, '17-Apr-2020');
INSERT INTO orders VALUES(102, 22, '18-Apr-2020');
INSERT INTO orders VALUES(103, 33, '19-Apr-2020');
INSERT INTO orders VALUES(104, 44, '20-Apr-2020');
INSERT INTO orders VALUES(105, 55, '21-Apr-2020');

--SELECT company name, order id and order date common companies
SELECT mc.company_name, o.order_id, o.order_date
FROM my_companies mc INNER JOIN orders o
ON mc.company_id=o.company_id;

--Get company_name,  order id and order date for the companies in my_companies table
SELECT mc.company_name, o.order_id, o.order_date
FROM my_companies mc LEFT JOIN orders o
ON mc.company_id=o.company_id;
--Get company_name,  order id and order date for the companies in my_companies table
SELECT mc.company_name, o.order_id, o.order_date
FROM orders o RIGHT JOIN my_companies mc
ON mc.company_id=o.company_id;
--Get company_name,  order id and order date for the companies in my_companies table
SELECT mc.company_name, o.order_id, o.order_date
FROM orders o FULL JOIN my_companies mc
ON mc.company_id=o.company_id;

DROP TABLE workers;


CREATE TABLE workers 
(  
  id CHAR(2), 
  name VARCHAR(20),
  title VARCHAR(60),
  manager_id CHAR(2) 
);

INSERT INTO workers VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO workers VALUES(2, 'John Walker', 'QA', 3);
INSERT INTO workers VALUES(3, 'Angie Star', 'QA Lead', 4);
INSERT INTO workers VALUES(4, 'Amy Sky', 'CEO', 5);

SELECT * FROM workers;
--Create a table which displays the manager of employees
SELECT m2.name AS employee_name, m1.name AS manager_name
FROM workers m2 INNER JOIN workers m1
ON m2.manager_id =  m1.id 


--1)How to add a column to an existing table
ALTER TABLE my_companies
ADD company_address VARCHAR;
--2) How to add a field with default value
ALTER TABLE my_companies
ADD state_new TEXT DEFAULT 'Florida';
--3) How to add multiple fields into a table
ALTER TABLE my_companies
ADD state_1 TEXT, ADD state_2 NUMERIC;
--4)How to drop feilds from a table
ALTER TABLE my_companies
DROP state_2;
SELECT * FROM my_companies;
--5)How to rename a field in an existing table
ALTER TABLE my_companies
RENAME company_name TO name;
--6)How to rename an existing table----
ALTER TABLE our_companies
RENAME  TO my_companies;

--7)How to modify(Add constraint, change data type or change the size) of a field
--How to add a NOT NULL constraint into a field----
ALTER TABLE my_companies
ALTER COLUMN name SET NOT NULL;

--How to add UNIQUE constraint---
ALTER TABLE my_companies
ADD CONSTRAINT company_id_unique UNIQUE(company_id);


--Change the data type of worker_address to CHAR(5)----
ALTER TABLE my_companies
ALTER COLUMN name TYPE TEXT;

SELECT * FROM my_companies;

--How to write functions in SQL:-----
--Write a function that calculates the volume of the cone.
CREATE FUNCTION volumeOfCone(r NUMERIC, h NUMERIC)
RETURNS NUMERIC
LANGUAGE plpgsql
AS
$$
BEGIN
RETURN r*r*h*3.14/3;
END
$$

SELECT volumeOfCone (3,5) AS volumeOfCone;

SELECT to_char(volumeOfCone (3,5),'00.0');
---r*r*h*3.14/3
----***********************