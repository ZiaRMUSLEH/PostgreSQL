--After GROUP BY use HAVING. We cannot use WHERE after GROUP BY. Because after WHERE condition you cannot use 
--Aggregate Functions like SUM, COUNT, MAX, MIN, AVG

--Find the number of employees if it is more than 1 per state

SELECT state, COUNT(state) AS number_of_employees
FROM workers
GROUP BY state
HAVING COUNT(state)>1;

--Find the minimum salary if it is more than 2000 for every company
SELECT company, MIN(salary) AS minimum_salary_per_company
FROM workers
GROUP BY company
HAVING MIN(salary)>2000;



--Find the maximum salary if it is less than 3000 for every state
SELECT state, MAX(salary)
FROM workers
GROUP BY state
HAVING MAX(salary)<3000;

--UNION OPERATOR
--1)It is used to combine the result of 2 queries
--2)UNION Operator returns unique records everytime, if there are repeated records it removes the repeated ones
--3)By using "UNION Operator" we are able to put different fields into a single field like in the following example

--Find the state whose salary is greater than 3000, employee names less than 2000 without duplication.
SELECT state AS "State Or Employee name", salary
FROM workers
WHERE salary>3000

UNION

SELECT company AS "State Or Employee name", salary
FROM workers
WHERE salary<2000



--UNION ALL Operator
--Find the state whose salary is greater than 3000, employee names less than 2000 with duplication.

SELECT state AS "State Or Employee name", salary
FROM workers
WHERE salary>3000

UNION ALL --Does the same wit UNION, just it returms repeated records if there is any.

SELECT name AS "State Or Employee name", salary
FROM workers
WHERE salary<2000

--INTERSECT Operator
--Returns common records of 2 queries
--It returns unique data

--Find all common employee names whose salary is greater than 1000, less than 2000

SELECT name
FROM workers
WHERE salary>1000

INTERSECT

SELECT name
FROM workers
WHERE salary<2000

--Find all common employee names whose salary is greater than 2000 and company name is IBM, APPLE or GOOGLE
SELECT name
FROM workers
WHERE salary>2000

INTERSECT

SELECT name
FROM workers
WHERE company IN('IBM', 'APPLE', 'GOOGLE');


SELECT * FROM workers;

--EXCEPT Operator: It is used to extract one query result from another one
--                 It returns unique records
--Find the employee names whose salary is less than 3000 and not working in GOOGLE
SELECT name
FROM workers
WHERE salary<3000

EXCEPT

SELECT name
FROM workers
WHERE company='GOOGLE';

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

--2) LEFT JOIN: Returns all data from first table
--Get company_name,  order id and order date for the companies in my_companies table

SELECT mc.company_name, o.order_id, o.order_date
FROM my_companies mc LEFT JOIN orders o
ON mc.company_id=o.company_id;