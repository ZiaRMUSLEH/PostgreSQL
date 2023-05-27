--Add UNIQUE constraiınt for worker_address in the workers table
ALTER TABLE workers
ADD CONSTRAINT worker_address_unique UNIQUE (worker_address);--UNIQUE constraint accepts multiple null. 

--When we add a constraint into a field we should be careful about the existing

--Change the data type of worker_address to CHAR(5)
ALTER TABLE workers
ALTER COLUMN worker_address TYPE CHAR(50);

--When we modify a field new size must be greater than or equal to the maximum value of existing value

INSERT INTO workers (worker_address) VALUES('Miami');
SELECT * FROM workers;


--How to write functions in SQL:

--A function is created to do some tasks faster and easier.
--A function can be created for CRUD
--In SQL, every function returns data with a return type.
--Operations that do not return a data we call this operation return type as "Procedure(like void in JAVA)".

CREATE OR REPLACE FUNCTION addF(x NUMERIC, y NUMERIC)
RETURNS NUMERIC
LANGUAGE plpgsql
AS
$$
BEGIN

RETURN x+y;

END

$$

SELECT addF(3, 4) AS Addition;


--Write a function that calculates the volume of the cone.
CREATE OR REPLACE FUNCTION volumeOfCone(r NUMERIC, h NUMERIC)
RETURNS NUMERIC
LANGUAGE plpgsql
AS
$$
BEGIN

RETURN r*r*h*3.14/3;

END

$$

SELECT volumeOfCone(3, 5) AS VolumeOfCone;

SELECT to_char(volumeOfCone(3, 5), '00.0');