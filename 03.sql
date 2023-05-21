

--Interview Question: How to select record whose salary is second highest
SELECT MAX(worker_salary)
FROM workers
WHERE worker_salary<(SELECT MAX(worker_salary) FROM workers);

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


--.Find the 3.highest salary
--1.way:
SELECT MAX(worker_salary)
FROM workers
WHERE worker_salary<(SELECT MAX(worker_salary)
FROM workers
WHERE worker_salary<(SELECT MAX(worker_salary) FROM workers));

--2.way:ORDER BY -->puts the records in natural order
SELECT * 
FROM workers
ORDER BY worker_salary DESC
OFFSET 2 ROW
FETCH NEXT 1 ROW ONLY;

--Fetch the 2.lowest
SELECT *
FROM workers
ORDER BY worker_salary ASC
OFFSET 1 ROW
FETCH NEXT 1 ROW ONLY;

SELECT * FROM workers;

--Find the company names and company ids which are in Florida.

SELECT company, company_id
FROM companies
WHERE company IN(SELECT company FROM employees WHERE state='Florida');


--Find employee names and states whose company id is greater than 100

SELECT name, state
FROM employees
WHERE company IN(SELECT company FROM companies WHERE company_id>'100');

--Find the company name, number of employees and average salary for every company
SELECT company, number_of_employees,
(SELECT AVG(salary) FROM employees WHERE employees.company=companies.company)
FROM companies; 


SELECT * FROM companies;
SELECT * FROM employees;

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

SELECT *
FROM customers_products;

--Find the records that has the product_name value as Orange, Apple or Palm
--1.way:
SELECT *
FROM customers_products
WHERE product_name='Orange' OR product_name='Apple' OR product_name='Palm';

--IN()
SELECT *
FROM customers_products 
WHERE product_name IN('Orange', 'Apple', 'Palm');--instead of using 'OR' repeatedly you can use 'IN()'.


--Find the records that has not the product_name value as Orange, Apple or Palm
--NOT IN()

SELECT *
FROM customers_products
WHERE product_name NOT IN('Orange', 'Apple', 'Palm');


--Find the product_names that have product_id less than 30 or equal to 30 and greater than 20 or equal to 20
--1.way:
SELECT product_name
FROM customers_products
WHERE product_id>=20 AND product_id<=30;

--2.way: By using 'BETWEEN' condition
SELECT product_name
FROM customers_products
WHERE product_id BETWEEN 20 AND 30;--the limits is inclusive

--Select the records whose product id is less than 20 greater than 25
--NOT BETWEEN
SELECT * 
FROM customers_products
WHERE product_id NOT BETWEEN 20 AND 25;



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
DROP table customers_likes;
--EXISTS COndition-->
--If the customer_name field has "Lary" among the customer_name field, update all customer_name field as "No Name".
UPDATE customers_likes
SET customer_name='No name'
WHERE EXISTS (SELECT customer_name FROM customers_likes WHERE customer_name='Lary');

--If the product_id has 60 among the product_id field update all liked product_id to 50
UPDATE customers_likes
SET product_id='50'
WHERE EXISTS (SELECT product_id FROM customers_likes WHERE product_id='60');

--If Lary exists in customer name then update it with 'No Name'
UPDATE customers_likes
SET customer_name='No name'
WHERE customer_name='Lary';




--.Find the 3.highest salary--
--Find the company name, number of employees and average salary for every company--
--If the customer_name field has "Lary" among the customer_name field, update all customer_name field as "No Name".--
--If Lary exists in customer name then update it with 'No Name'--