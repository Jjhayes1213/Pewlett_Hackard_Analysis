-- DROP TABLE dept_emp;
-- CREATE TABLE dept_emp(
-- 	emp_no INT PRIMARY KEY,
-- 	dept_no VARCHAR, 
-- 	to_date DATE, 
-- 	from_date DATE
-- );

-- CREATE TABLE retirement_titles(
-- 	emp_no INT,
-- 	first_name VARCHAR, 
--     last_name VARCHAR,
--    birth_date DATE,
--     title VARCHAR,
-- 	to_date DATE, 
-- 	from_date DATE
-- );

-- DROP TABLE title_removal;
-- CREATE TABLE title_removal(
-- 	first_name VARCHAR, 
--     last_name VARCHAR,
--    birth_date DATE,
--     title VARCHAR,
-- 	from_date DATE,
-- 	to_date DATE, 
-- 	emp_no INT
-- );

-- CREATE TABLE unique_titles(
-- 	emp_no INT,
-- 	first_name VARCHAR, 
-- 	last_name VARCHAR, 
-- 	title VARCHAR
-- );

-- -- 1)Retrieve data from employees table
-- SELECT first_name
-- 	,last_name
-- 	,emp_no
-- FROM employees

-- -- 2)Retrieve data from titles table
-- SELECT titles2
-- 	title
-- 	,from_date
-- 	,to_date
-- FROM titles2	

-- DROP TABLE titles_info;
-- CREATE TABLE titles_info(
-- 	emp_no INT ,
-- 	first_name VARCHAR NOT NULL,
-- 	last_name VARCHAR NOT NULL, 
-- 	birth_date DATE, 
-- 	title VARCHAR NOT NULL, 
-- 	to_date DATE, 
-- 	from_date DATE
-- );


-- --3)Create a new table using the INTO clause
-- --4)Join both tables using the primary key
-- INSERT INTO titles_info SELECT employees.emp_no,
--     employees.first_name,
-- 	employees.last_name,
-- 	employees.birth_date,
-- 	titles2.title,
--     titles2.to_date,
-- 	titles2.from_date
-- FROM employees
-- LEFT JOIN titles2
-- ON titles2.emp_no = employees.emp_no;

-- --5)Filter the data on the birthdate column to retrieve employees who were born between 1952 and 1955
-- DROP TABLE titles3;
-- SELECT emp_no, first_name, last_name, birth_date, title, from_date, to_date
-- INTO titles3
-- FROM titles_info
-- WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
-- SELECT * FROM titles3

-- --6)Export Reirement Titles table from the previous step as retirement_titles.csv 
-- --7)Before you export confirm table image
-- --8)Copy query from Starter code
-- --9)retrieve emp_no from Retirement tables


-- --10)Use Distinct On statement to retrieve the first occurence of employee number
-- SELECT DISTINCT ON (emp_no) first_name,
-- last_name,
-- birth_date,
-- title,
-- from_date,
-- to_date,
-- emp_no

-- FROM retirement_titles
-- ORDER BY emp_no, title, to_date DESC;

-- SELECT * FROM retirement_titles

-- --11,12,13,14)Exclude employees that left company by filtering to_date & keep dates equal to '9999-01-01'
-- SELECT emp_no, first_name, last_name, title
-- -- INTO retirement_info
-- FROM title_removal
-- WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
-- AND (from_date = '9999-01-01')
-- ORDER BY emp_no, first_name, last_name, title DESC;


-- --16,17,18,19,20,21)Retrieve # of titles for Unique Titles table
-- SELECT COUNT(ut.emp_no), ut.title
-- FROM unique_titles as ut
-- GROUP BY title 

--1)Retrieve columns from Employees table
SELECT emp_no
	,first_name
	,last_name
	,emp_no
FROM employees


--2)Retrieve columns from Department Employee table
SELECT from_date
	,to_date
FROM dept_emp

--3)Retrieve columns from Titles table
SELECT title
FROM titles2

--4)Use a Distict On statement to retrieve first occurrence of employee number for a set of rows defined by on clause
SELECT DISTINCT ON (emp_no) 
emp_no,
dept_no,
to_date,
from_date

FROM dept_emp
ORDER BY emp_no, dept_no, to_date DESC;
SELECT * FROM dept_emp

--5)Create a new table using Into Clause
INSERT INTO titles_info SELECT employees.emp_no,
    employees.first_name,
	employees.last_name,
	employees.birth_date,
	titles2.title,
    titles2.to_date,
	titles2.from_date
FROM employees
LEFT JOIN titles2
ON titles2.emp_no = employees.emp_no;


	
--6)Join Employees and Department Employee tables on pk
INSERT INTO dept_emps SELECT employees.emp_no,
	employees.birth_date,
	employees.first_name,
	employees.last_name,
	dept_emp.to_date,
	dept_emp.from_date
FROM employees
LEFT JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no 


-- CREATE TABLE emp_new(
--  	emp_no INT PRIMARY KEY,
-- 	birth_date DATE,
-- 	first_name VARCHAR,
-- 	last_name VARCHAR,
-- 	to_date DATE,
-- 	from_date DATE,
-- 	title VARCHAR
-- );

-- SELECT DISTINCT ON (emp_no) 
-- emp_no,
-- title,
-- to_date,
-- from_date

-- FROM titles2
-- ORDER BY emp_no, title, to_date DESC;
-- SELECT * FROM dept_emp

--7)Join Employees and titles tables on pk
INSERT INTO emp_new SELECT dept_emps.emp_no,
	dept_emps.birth_date,
	dept_emps.first_name,
	dept_emps.last_name,
	dept_emps.to_date,
	dept_emps.from_date,
	title.title
FROM title
LEFT JOIN dept_emps
ON dept_emps.emp_no = title.emp_no 

--8)Filter data on to_date column to all current employees, then filter the data on the birth_date 
--columns (jan 1,1965-12,31,1965)
DROP TABLE mentorship_eligibility;
SELECT emp_no, first_name, last_name, title, birth_date, to_date, from_date
INTO mentorship_eligibility
FROM emp_new
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (from_date = '9999-01-01')
ORDER BY emp_no, first_name, last_name, birth_date DESC;


SELECT * FROM mentorship_eligibility