USE portfolio;

drop table dbo.udemy_courses_dataset;

-- Creating the Employee table
CREATE TABLE Employee (
    employee_id INT PRIMARY KEY,
    department VARCHAR(50),
    salary DECIMAL(10, 2)
);

-- Inserting 50 random rows into the table
INSERT INTO Employee (employee_id, department, salary)
VALUES 
(1, 'HR', 50000.00),
(2, 'Finance', 75000.00),
(3, 'IT', 65000.00),
(4, 'Sales', 55000.00),
(5, 'Marketing', 58000.00),
(6, 'HR', 52000.00),
(7, 'Finance', 78000.00),
(8, 'IT', 64000.00),
(9, 'Sales', 57000.00),
(10, 'Marketing', 59000.00),
(11, 'HR', 51000.00),
(12, 'Finance', 76000.00),
(13, 'IT', 66000.00),
(14, 'Sales', 56000.00),
(15, 'Marketing', 60000.00),
(16, 'HR', 53000.00),
(17, 'Finance', 74000.00),
(18, 'IT', 63000.00),
(19, 'Sales', 54000.00),
(20, 'Marketing', 61000.00),
(21, 'HR', 55000.00),
(22, 'Finance', 72000.00),
(23, 'IT', 62000.00),
(24, 'Sales', 53000.00),
(25, 'Marketing', 62000.00),
(26, 'HR', 54000.00),
(27, 'Finance', 71000.00),
(28, 'IT', 61000.00),
(29, 'Sales', 52000.00),
(30, 'Marketing', 63000.00),
(31, 'HR', 56000.00),
(32, 'Finance', 69000.00),
(33, 'IT', 60000.00),
(34, 'Sales', 51000.00),
(35, 'Marketing', 64000.00),
(36, 'HR', 57000.00),
(37, 'Finance', 68000.00),
(38, 'IT', 59000.00),
(39, 'Sales', 50000.00),
(40, 'Marketing', 65000.00),
(41, 'HR', 58000.00),
(42, 'Finance', 67000.00),
(43, 'IT', 58000.00),
(44, 'Sales', 49000.00),
(45, 'Marketing', 66000.00),
(46, 'HR', 59000.00),
(47, 'Finance', 66000.00),
(48, 'IT', 57000.00),
(49, 'Sales', 48000.00),
(50, 'Marketing', 67000.00);

SELECT * 
FROM Employee;

-- Grouping average salary by department
SELECT department, 
avg(cast(salary as int)) as average_salary
FROM Employee
Group BY department;

-- I want to update data type of 'salary' column to integer.
ALTER TABLE Employee
ALTER COLUMN salary INT;


-- Comparing average salary department wise and overall wise
SELECT *,
avg(salary) OVER() AS overall_average_salary,
avg(salary) Over(Partition by department) as dept_avg_salary
FROM Employee;

-- Checking new salary after increasing each salary by 15%
SELECT *, 
salary * 1.15 as new_salary
FROM Employee;

-- Checking highest salary in each department
SELECT department,
      max(salary) as top_salary
FROM Employee
Group by department;

-- Using row number for the same operation
WITH top_employees AS (
    SELECT employee_id,
 department,
 salary,
 ROW_NUMBER()OVER(Partition by department Order By salary desc) AS row_num
FROM Employee
)
SELECT employee_id, 
department, 
salary
FROM top_employees
WHERE row_num = 1; -- row number either requires a sub query or a cte

-- top 3 salary in each department
WITH top_employees as (
    SELECT employee_id,
            department, 
            salary,
    RANK() OVER(Partition by department Order By salary desc) as ranks
    FROM Employee
)
SELECT Employee_id,
department,
salary 
FROM top_employees
Where ranks <=3;

-- Increasing salaries of every employee in sales department
UPDATE Employee
Set salary = salary * 1.12;

SELECT salary
FROM Employee
Where department = 'sales';