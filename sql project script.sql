# Import the Dataset
CREATE DATABASE mysql_project;
USE mysql_project;

# Data Cleaning/Wrangling
SELECT * FROM HR;
DESCRIBE HR;

#Changing the column name 'ï»¿id' to an appropriate name
ALTER TABLE HR
CHANGE COLUMN ï»¿id employer_id varchar(40) NULL;

SET sql_safe_updates = 0;

# Changing 'birthdate' to its appropriate datatype
UPDATE HR
SET birthdate = CASE
  WHEN birthdate LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
  WHEN birthdate LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m-%d-%y'), '%Y-%m-%d')
  ELSE NULL
  END;
  
  SELECT birthdate FROM HR;
  
  ALTER TABLE HR
  MODIFY COLUMN birthdate DATE;

# Changing 'hire_date' to its appropriate datatype
UPDATE HR
SET hire_date = CASE
  WHEN hire_date LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
  WHEN hire_date LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m-%d-%y'), '%Y-%m-%d')
  ELSE NULL
  END;
  
ALTER TABLE HR
MODIFY COLUMN hire_date DATE;

SELECT hire_date FROM HR;

# Changing 'termdate' to its appropriate datatype
UPDATE HR
SET termdate = DATE(STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != '' AND termdate != ' ';

UPDATE HR
SET termdate = NULL
WHERE termdate = '';

ALTER TABLE HR
MODIFY COLUMN termdate DATE;

SELECT termdate FROM HR;

# Adding the column 'age' for easy analysis
ALTER TABLE HR ADD COLUMN age INT;
UPDATE HR
SET age = timestampdiff(YEAR, birthdate, CURDATE());

SELECT birthdate, age FROM HR;

SELECT
  min(age) AS youngest,
  max(age) AS oldest
FROM HR;
