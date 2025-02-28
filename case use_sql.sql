use example;
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT,
    hire_date DATE,
    salary DECIMAL(10, 2)
);

-- Insert sample data into `employees`
INSERT INTO employees (employee_id, first_name, last_name, department_id, hire_date, salary)
VALUES
(1, 'John', 'Doe', 1, '2020-01-15', 48000.00),
(2, 'Jane', 'Smith', 2, '2019-04-23', 54000.00),
(3, 'Mary', 'Johnson', 1, '2018-07-10', 60000.00),
(4, 'James', 'Brown', 3, '2021-02-01', 45000.00),
(5, 'Emily', 'Davis', 2, '2020-11-11', 55000.00);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

-- Insert sample data into `departments`
INSERT INTO departments (department_id, department_name)
VALUES
(1, 'Sales'),
(2, 'Marketing'),
(3, 'HR');

-- Case Statemnts Demo--

-- 1. Write a query to display each employee's full name (concatenation of first_name and last_name) and categorize their salary into:
-- "Low Salary" for salaries less than $50,000
-- "Average Salary" for salaries between $50,000 and $100,000
-- "High Salary" for salaries above $100,000 --


select salary, concat( First_name," " ,Last_name) as Full_Name,
case
when salary< 50000 then "Low Salary"
when salary between 50000 and 100000 then "Average Salary"
when salary> 100000 then "High Salary"
end as Salary_Status 
from employees;

-- 2.Write a query that shows the employee's name and assigns a performance rating based on their hire date:
-- Employees hired before 2020 should be labeled as 'Veteran'.
 -- Employees hired in 2020 should be labeled as 'Recent Hire'.
--  Employees hired in 2021 should be labeled as 'New Joiner' --

select first_name,last_name,
case
when year(hire_date) > 2020 then "Veteran"
when year(hire_date)= 2020 then "Recent_Hire"
when year(hire_date)=2021 then "New_ Joiner"
else "Old_Employee"
end as Employee_hire_status
from employees;

-- 3 Create a query to show each employee's salary and categorize them based on the department:
-- For the Sales department, categorize employees with salary greater than $50,000 as "High Earners", otherwise as "Regular Earners".
-- For the Marketing department, categorize employees with salary greater than $55,000 as "Top Performer", otherwise as "Average Performer".
-- For the HR department, categorize everyone as "Standard Salary".--

select e.salary,e.first_name,d.department_name, 
case 
when d.department_name ="sales" and salary>=50000 then "High Eraners"
when d.department_name= "sales" and salary<50000 then "Regular Earners"
when d.department_name="Marketing" and salary>=55000 then "Top Performer"
when d.department_name="Marketing" and salary<55000 then "Average Performer"
when d.department_name="HR"  then "Stanadrd Salary"
end as employee_performance
from employees as e join departments as d  on
e.department_id=d.department_id ;
select * from employees;

-- 4 Write a query to show all employees and indicate whether they are eligible for bonus based on the following conditions:
-- Employees with a salary greater than $55,000 are eligible for a bonus.
-- Employees hired before 2020 are eligible for a bonus.
-- Employees hired after 2020 but with a salary greater than $50,000 are also eligible.--

select salary,first_name,last_name,
case 
-- 5
when salary>=55000 then "Eligible"
when date(hire_date) >2020 then "eligible"
when hire_date<=2020 and salary>=50000 then "Eligible"
else "Not Eligible"
end as Bonus_status
from employees;

-- 5 Write a query to display the employee’s name and department name, and assign a department priority:
-- "High Priority" for employees in the Sales department.
-- "Medium Priority" for employees in the Marketing department.
-- "Low Priority" for employees in the HR department.--

select e.first_name,d.department_name,
case
when department_name="Sales" then "High Priority"
when department_name="Marketing" then "Medium Priority"
when department_name="HR" then "low Priority"
end as Dept_priority
from employees as e join departments as d on
e.department_id =d.department_id;

-- 6  Write a query to display each employee’s salary and determine whether they have a salary increase based on the following logic:
-- If the employee's salary is below $50,000, then return "Increase Needed".
-- If the employee's salary is between $50,000 and $60,000, then return "Normal Salary".
-- If the employee's salary is above $60,000, then return "High Salary".--
select salary,
case
 when salary<50000 then "Increase Needed"
 when salary between 50000 and 60000 then "Normal Salary"
 when salary>=60000 then "High Salary"
 end as salary_insights
 from employees;
 
-- 7 Write a query to display the employee’s name, their department, and whether they are part of the executive team based on the following criteria:
-- Employees from Sales or Marketing with a salary greater than $70,000 should be considered "Executive".
-- All other employees should be labeled as "Non-Executive".

select e.first_name, d.department_name,
case
when (d.department_name="sales" or d.department_name="marketing") and (e.salary>=40000) then "Execuitve"
else "Non-Executive"
end as TEAM 
from employees as e join departments as d on
e.department_id =d.department_id;

-- 8 Create a query to display each employee's hire date and categorize it into the following categories:
-- "Early Hire" if hired before 2020.
-- "Mid Hire" if hired between 2020 and 2021.
-- "Recent Hire" if hired after 2021.

select hire_date,
case
when year(hire_date)<2020 then "Early_hire"
when year(hire_date) between 2020 and 2021 then "MId Hire"
when year(hire_date)>2021 then "Recent Hire"
end as hiring_status
from employees;

-- 9 : Write a query that calculates the employee’s years of service and categorizes the service into:
-- "Less than 1 year" for employees with less than 1 year of service.
-- "1 to 3 years" for employees with 1-3 years of service.
-- "More than 3 years" for employees with more than 3 years of service.

select hire_date,
case
 WHEN TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) < 1 THEN 'Less than 1 year'
        WHEN TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) BETWEEN 1 AND 3 THEN '1 to 3 years'
        WHEN TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) > 3 THEN 'More than 3 years'
        ELSE 'Unknown'
end as years_of_experinece
from employees;

-- 10 Question 10: Write a query that shows each employee's salary and department and categorizes their salary as:
-- "Below Average" for salaries less than the average salary of their department.
-- "Above Average" for salaries greater than the average salary of their department.
-- "Average" for salaries equal to the average salary of their department---

select e.first_name, e.salary, d.department_name,
case 
WHEN e.salary < AVG(e.salary) OVER (PARTITION BY e.department_id) THEN 'Below Average'
           WHEN e.salary > AVG(e.salary) OVER (PARTITION BY e.department_id) THEN 'Above Average'
           ELSE 'Average'
end as salary_info
from employees as e join departments as d on
e.department_id =d.department_id
group by e.avg(salary);













