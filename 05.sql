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

--Select states whose third character is 'o' or 'x'
--1.way
SELECT state
FROM workers
WHERE state LIKE '__o%' OR state LIKE '__x%';

--2.way:
SELECT DISTINCT state
FROM workers
WHERE state ~ '..[ox]';

--Select states whose third character from the end is not 'n' or 'x'
SELECT DISTINCT state
FROM workers
WHERE state ~ '[^nx]..$';

--ORDER BY: To put the records in ascending or descending order we use ORDER BY
--          ORDER BY can be used just with SELECT Statement

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

SELECT * FROM words;

--Put the records in ascending order by using number_of_letters
SELECT *
FROM words
ORDER BY number_of_letters ASC; --ASC is optional if you do not type "ASC" SQL will give the data in ascending order in default.

SELECT *
FROM words
ORDER BY 3 ASC;--3 stands for field number for the given field

--In ORDER BY, instead of field names, field numbers can be used as well

--Put the records in descending order by using word
SELECT * 
FROM words
ORDER BY word DESC;--DESC is not optional if you want to receive the records in descending order

SELECT * 
FROM words
ORDER BY 2 DESC;
------------------------------------
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

--Put the records in descending order by using name field, and ascending order by using points
SELECT *
FROM points
ORDER BY name DESC, point ASC;
-----------------------
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

--ALIES -->

--How to use aliase for table names
--1)Select employee_first_name and state, for employee first name use "firstname" as field name 
--and for state use "employee state" as field name
SELECT e.employee_first_name AS firstname, a.state AS "employee state"
FROM employees e, addresses a
WHERE e.employee_id=a.employee_id;


--How to put multiple fields into one field and use alies for naming the field
--2)Get employee id use "id" as field name, get firstname and lastname put them into the same field and use "full_name" as field name
SELECT employee_id AS id, employee_first_name || ' ' || employee_last_name AS full_name
FROM employees;

--GROUP BY
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

--Find the total salary for every employee

SELECT name, SUM(salary) AS total_salary
FROM workers
GROUP BY name
ORDER BY total_salary ASC;

--Find the number of employees per state in descending order by employee number
SELECT state, COUNT(state) AS number_of_employees
FROM workers
GROUP BY state
ORDER BY number_of_employees DESC;

--Find the number of the employees whose salary is more than $2000 per company
SELECT company, COUNT(company) AS number_of_employees
FROM workers
WHERE salary>2000
GROUP BY company;

--Find the minimum and maximum salary for every company

SELECT company,MIN(salary) AS minimum_salary, MAX(salary) AS maximum_salary
FROM workers
GROUP BY company;

--HAVING CLAUSE
--Find the total salary if it is greater than 2500 for every employee
SELECT name, SUM(salary) AS total_salary
FROM workers
GROUP BY name
HAVING SUM(salary)>2500;

--After GROUP BY use HAVING. We cannot use WHERE after GROUP BY. Because after WHERE condition you cannot use 
--Aggregate Functions like SUM, COUNT, MAX, MIN, AVG

--Find the number of employees if it is more than 1 per state
SELECT state, COUNT(state) AS number_of_employees
FROM workers
GROUP BY state
HAVING COUNT(state)>1;