
--JOINS
--1)INNER JOIN: It returns common data from two tables. 
--2)LEFT JOIN: Returns all data from the first table
--3)RIGHT JOIN: Returns all data from the second table 
--4)FULL JOIN: Returns all data from both table 
--5)SELF JOIN: You will have a single table but you will use it as 2 tables

CREATE TABLE my_companies 
(  
  company_id CHAR(3), 
  company_name VARCHAR(20)
);

INSERT INTO my_companies VALUES(100, 'IBM');
INSERT INTO my_companies VALUES(101, 'GOOGLE');
INSERT INTO my_companies VALUES(102, 'MICROSOFT');
INSERT INTO my_companies VALUES(103, 'APPLE');

SELECT * FROM my_companies;

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

SELECT * FROM orders;

--INNER JOIN
--SELECT company name, order id and order date common companies
SELECT mc.company_name, o.order_id, o.order_date
FROM my_companies mc INNER JOIN orders o
ON o.company_id=mc.company_id;

--2) LEFT JOIN: Returns all data from first table and common data from the second table
--Get company_name,  order id and order date for the companies in my_companies table

SELECT mc.company_name, o.order_id, o.order_date
FROM  orders o LEFT JOIN my_companies mc
ON mc.company_id=o.company_id;

--3)RIGHT JOIN: Returns all data from second table and common data from the first table
--Get company_name,  order id and order date for the companies in my_companies table
SELECT mc.company_name, o.order_id, o.order_date

FROM my_companies mc RIGHT JOIN orders o

ON mc.company_id=o.company_id;

--FULL JOIN:Returns all data from two tables
--Get company_name,  order id and order date for the companies in my_companies table
SELECT mc.company_name, o.order_id, o.order_date
FROM my_companies mc FULL JOIN orders o
ON mc.company_id=o.company_id;

--SELF JOIN:Returns the common data from the table itself

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
--SELF JOIN: IN POSTGERSQL, we can join the same table's fields with "INNER JOIN" but for some other SQL using databases
--like ORACLESQL you should combie the fields of original and copy table by using "SELF JOIN"
SELECT m1.name AS "Employee Name", m2.name AS "Manager Name"
FROM workers m1 INNER JOIN workers m2
ON m1.manager_id=m2.id;

--HOW TO UPDATE A TABLE
--ALTER TABLE
--ALTER TABLE command is used to add, delete or update field of an existing table. 
--ALTER TABLE command is used to add or delete constraints or update the data type of a field in an existing table


--1)How to add a column to an existing table
ALTER TABLE my_companies
ADD company_address TEXT;


--2) How to add a field with default value

ALTER TABLE workers
ADD worker_address VARCHAR(80) DEFAULT 'Miami, FL, US';

--3) How to add multiple fields into a table
ALTER TABLE workers
ADD number_of_workers SMALLINT DEFAULT 0, 
ADD name_of_CEO VARCHAR;

--4)How to drop feilds from a table
ALTER TABLE workers
DROP COLUMN name_of_ceo;

--5)How to rename a field in an existing table
ALTER TABLE workers
RENAME COLUMN worker_address TO company_profession;

--6)How to rename an existing table
ALTER TABLE workers
RENAME TO employees;

--7)How to modify(Add constraint, change data type or change the size) of a field
--NOTE: Be careful about the existing data in a field when you need to add a constraint for it. 

--How to add a constraint into a field
--Add "NOT NULL" constraint for number_of_workers
ALTER TABLE employees
ALTER COLUMN number_of_workers SET NOT NULL;

--How to add UNIQUE constraint
--Add UNIQUE constraint for id
ALTER TABLE employees
ADD CONSTRAINT id_unique UNIQUE(id);

SELECT * FROM employees;