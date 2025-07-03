CREATE DATABASE IF NOT EXISTS nested_demo;
USE nested_demo;

CREATE TABLE IF NOT EXISTS Employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50),
    salary INT
);

INSERT INTO Employees (emp_id, name, department, salary) VALUES
(1, 'Alice', 'HR', 40000),
(2, 'Bob', 'IT', 60000),
(3, 'Charlie', 'Finance', 55000),
(4, 'David', 'IT', 65000),
(5, 'Eva', 'HR', 42000),
(6, 'Frank', 'Finance', 58000),
(7, 'Grace', 'IT', 61000);

SELECT name, salary
FROM Employees
WHERE salary > (
    SELECT AVG(salary) FROM Employees
);

SELECT 
    name,
    department,
    salary,
    (SELECT AVG(salary)
     FROM Employees e2
     WHERE e2.department = e1.department) AS dept_avg_salary
FROM Employees e1;

SELECT department, avg_salary
FROM (
    SELECT department, AVG(salary) AS avg_salary
    FROM Employees
    GROUP BY department
) AS dept_summary
WHERE avg_salary > 50000;

SELECT name, salary
FROM Employees
WHERE salary = (
    SELECT MAX(salary) FROM Employees
);

SELECT department
FROM Employees
GROUP BY department
HAVING COUNT(*) > 2;

SELECT name, department, salary
FROM Employees
WHERE department IN (
    SELECT department
    FROM Employees
    GROUP BY department
    HAVING AVG(salary) > 50000
);
