
--Delete records if there is 'Orange' as product name in customers_likes table
DELETE FROM customers_likes
WHERE EXISTS (SELECT liked_product FROM customers_likes WHERE liked_product='Orange');

SELECT * FROM companies;
SELECT * FROM employees;

--Find the name of the companies, company ids maximum and minimum salaries per company
SELECT company, company_id,(SELECT MAX(salary) FROM employees WHERE employees.company= companies.company) AS max_salary_per_company,
                           (SELECT MIN(salary) FROM employees WHERE employees.company= companies.company) AS min_salary_per_company
						   

FROM companies;

--LIKE CONDITION-->It is used with wildcards
--WILDCARDS-->useful expressions to do search operations
--1) % Wildcard:It represents zero or more characters

--Select employee names which start with 'E'
SELECT name
FROM employees
WHERE name LIKE 'E%';


--Select employee names which ends with 'e'
SELECT name
FROM employees
WHERE name LIKE '%e';


--Select employee names which starts with 'B' and ends with 't'
SELECT name
FROM employees
WHERE name LIKE 'B%t';

--Select employee names which has 'a' in any position

SELECT name
FROM employees
WHERE name LIKE '%a%';

--Select employee names which has 'e' and 'r' in any position
SELECT name
FROM employees
WHERE name LIKE '%e%r%' OR name LIKE '%r%e%';

--2)Underscore WildCard: '_' represents a single character
--Select state whose second character is 'e' and forth is 'n'

SELECT state
FROM employees
WHERE state LIKE '_e_n%';

--Select state whose last second character is 'i'
SELECT state
FROM employees
WHERE state LIKE '%i_';

--Select 'states' whose second character is 'e' and it has at least 6 characters
SELECT state
FROM employees
WHERE state LIKE '_e____%';


--Select state which has 'i' in any position after second character 

SELECT state
FROM employees
WHERE state LIKE '__%i%';


--NOT  LIKE Condition
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


--Select words which do not have 'h' in any position
SELECT word
FROM words
WHERE word NOT LIKE '%h%';


--Select words which do not end with 't' and do not end 'f' 
SELECT word
FROM words
WHERE word NOT LIKE '%t' AND word NOT LIKE '%f';

--Select words which start with any character, not followed by 'a', not followed by 'e'
SELECT word
FROM words
WHERE word NOT LIKE '_a%' AND word NOT LIKE '_e%';

--REGEXP_LIKE Condition: You can use regular expressions with REGEXP_LIKE Condition
--Select words whose first character is 'h', last character is 't' and second character is 'o', or 'a', or 'i'
--1.way:
SELECT word
FROM words
WHERE word LIKE 'ho%t' OR word LIKE 'ha%t' OR word LIKE 'hi%t';

--2.way: By using REGEXP_LIKE Condition
SELECT word
FROM words
WHERE REGEXP_LIKE(word, 'h[oai](.*)t');

--OR use ~
SELECT word
FROM words
WHERE word ~ 'h[oai](.*)t';


--Select words whose first character is 'h', last character is 't' and second character is from 'a' to  'e'
SELECT word
FROM words
WHERE word  ~ 'h[a-e](.*)t';

--Select words whose first character is 's' or 'a' or 'y'
SELECT word
FROM words
WHERE word ~ '^[say](.*)';-- '^' means first character if you use it before brackets

--Select words whose last character is 'm' or 'a' or 'f'
SELECT word
FROM words
WHERE word ~ '(.*)[maf]$'; --$ means last character when you use it after the brackets

---Select words which have 'a' in any position
--1.way
SELECT word
FROM words
WHERE word ~ 'a';
--2.way
SELECT word
FROM words
WHERE word ~ '(.*)a(.*)';--> 3.way:'%a%'

--Select words which have characters from 'd' to 't' at the beginning followed by any character and then 'l'
SELECT word
FROM words
WHERE word ~ '^[d-t].l';--> '.' means one character

--Select words which have characters from 'd' to 't' at the beginning followed by any two characters and then 'e'
SELECT word
FROM words
WHERE word ~ '^[d-t]..e';

--Select employee names which do not start with 'E' and do not end with 'y'
SELECT * FROM employees;
--1.way:
SELECT name
FROM employees
WHERE name NOT LIKE 'E%y';
--2.way:

SELECT name
FROM employees
WHERE name ~ '^[^E](.*)[^y]$';-- if you use '^' inside the brackets it means the character different from the identified chracter 

--Select states whose third character is 'o' or 'x'
--Select states whose third character from the end is not "n" or "x"