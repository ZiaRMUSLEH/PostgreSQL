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
SET worker_salary=(SELECT MAX(worker_salary)*0.8 FROM workers)
WHERE worker_id=102;

--Decrease the salary of Tom Hanks to 30 percent more than the lowest salary
UPDATE workers
SET worker_salary=(SELECT MIN(worker_salary)*1.3 FROM workers)
WHERE worker_id=101;

--Increase the salaries by 1000 if the salaries are less then the average salary 
UPDATE workers
SET worker_salary=worker_salary+1000
WHERE worker_salary<(SELECT AVG(worker_salary) FROM workers);

--Make the salaries equal to the average salary if the salaries are less than the average salary
UPDATE workers
SET worker_salary=(SELECT AVG(worker_salary) FROM workers)
WHERE worker_salary<(SELECT AVG(worker_salary) FROM workers);

SELECT * FROM workers;


--Conditions, Statements, Expressions in SQL

--IS NULL Condition
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
SET name='Name will be inserted later'
WHERE name IS NULL;

--Change all null address values to "Address will be inserted later"
UPDATE people
SET address='Address will be inserted later'
WHERE address IS NULL;

--How to delete a record from a table
DELETE FROM people
WHERE ssn=234567890;

--How to delete records which do not have a name value
DELETE FROM people
WHERE name='Name will be inserted later';

--How to delete all records
--DELETE command deletes just the records, it does not destory the table
DELETE FROM people;

DROP TABLE people;
SELECT * FROM people;

--Delete all records whose name is null or address is null

DELETE FROM people
WHERE name IS NULL OR address IS NULL;

--Delete all records whose SSN is greater than 123456789 and less than 345678901

DELETE FROM people
WHERE ssn>123456789 AND ssn<345678901;

--IS NOT NULL Condition
--Delete all records whose name value is not null
DELETE FROM people
WHERE name IS NOT NULL;

--TRUNCATE command

TRUNCATE TABLE people;

--TRUNCATE Command removes all records everytime

--What is the difference between DELETE and TRUNCATE and DROP query?
--The DELETE command deletes one or more existing records from the table in the database. 
--The DROP Command drops the complete table from the database. 
--The TRUNCATE Command deletes all the rows from the existing table, leaving the row with the column names.

SELECT * FROM people;


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

--DQL: Data Query Language.We use "SELECT" keyword to do queries.

--How to select all data from a table
SELECT * FROM workers;

--How to get specific field from a table
SELECT worker_name FROM workers;


--How to get multiple specific field from a table
SELECT worker_name, worker_salary FROM workers;

--How to get specific record
SELECT * FROM workers
WHERE worker_id=101;

--How to get multiple specific records
SELECT * FROM  workers
WHERE worker_id<103;

--Get records whose salary is 2000 or 7000 or 12000
--1.way: Not recommended because of repetition
SELECT * 
FROM workers
WHERE worker_salary=2000 OR worker_salary=7000 OR worker_salary=12000;

--2.way: IN()
SELECT * 
FROM workers
WHERE worker_salary IN(2000, 7000, 12000);--IN() is used in place of repeated "OR" statements.

--How to get a spcific cell
SELECT worker_name
FROM workers
WHERE worker_id=102;

--Interview Question: How to select record whose salary is second highest

--Select maximum salary
--By using "AS" (ALLIES) you can put temporary field names for your queries
SELECT MAX(worker_salary) AS maximum_salary FROM workers;

--Select minimum salary by using AS
SELECT MIN(worker_salary) AS minimum_salary FROM workers;


--Select average salary value by using "AS"
SELECT AVG(worker_salary) AS average_salary FROM workers;

SELECT * FROM workers;

--Count the number of workers
SELECT COUNT(worker_id) AS number_of_workers FROM workers;

--Find the sum of worker_salaries
SELECT SUM(worker_salary) AS sum_of_salaries FROM workers;

--Aggregate Functions: SUM, AVG, COUNT, MAX and MIN.

--Interview Question: Select the second lowest salary
SELECT MIN(worker_salary) AS second_lowest_salary
FROM workers
WHERE worker_salary >(SELECT MIN(worker_salary) FROM workers);--minimum 1200


--Interview Question: How to select records whose salary is the lowest and highest
--1.way:
SELECT * 
FROM workers
WHERE worker_salary=(SELECT MIN(worker_salary) FROM workers)
OR
worker_salary=(SELECT MAX(worker_salary) FROM workers);


--2.way:
SELECT *
FROM workers
WHERE worker_salary IN((SELECT MIN(worker_salary) FROM workers),(SELECT MAX(worker_salary) FROM workers));

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


--Find the employee and company names whose company has more than 15000 employees
SELECT name, company
FROM employees
WHERE company IN(SELECT company FROM companies WHERE number_of_employees>15000);