-- ----------------------------------- Window Functions ----------------------------------------------------
-- 1. Fetch the employee id's of each department, their name, department id and 
-- the number of employees in each department, 
-- include only department id 80 and those commission percentage is more than 30% 
use hr;
select employee_id,first_name,department_id,count(employee_id) over (partition by department_id order by employee_id) from employees
where department_id=80 and commission_pct>0.30 ;

-- 2. Fetch the employee id's , their name, manager id, salary, average salary
-- of employees reporting under each manager and the difference between them
Use hr;
select employee_id,first_name,manager_id,salary,(avg(salary) over (partition by manager_id)) as Avg_Salary
from employees;
-- group by employee_id,first_name,manager_id,salary

-- 3. Fetch the employee id's , their name, job id, salary, total salary of employees job id level, 
-- and the proportion of their salary to their total salary in each job id
SELECT EMPLOYEE_ID,FIRST_NAME,JOB_ID,
SUM(SALARY) OVER(PARTITION BY JOB_ID) AS TOTAL,
(SALARY/(SUM(SALARY) OVER(PARTITION BY JOB_ID))) AS PROP FROM EMPLOYEES;

use hr;
-- 4. For each employee, fetch the employee id, department id, job id, start_date and 
-- their UNIQUE rank (use row number() consider start_date)
-- sort by start date and then by hire date both in descending order.
SELECT E.EMPLOYEE_ID,E.DEPARTMENT_ID,E.JOB_ID,J.START_DATE from EMPLOYEES E 
JOIN (SELECT J.EMPLOYEE_ID,J.START_DATE,ROW_NUMBER() OVER(ORDER BY J.START_DATE DESC) AS RNK FROM JOB_HISTORY J) AS J
ON E.EMPLOYEE_ID=J.EMPLOYEE_ID
ORDER BY E.HIRE_DATE DESC;

SELECT J.EMPLOYEE_ID,J.START_DATE,ROW_NUMBER() OVER(ORDER BY J.START_DATE DESC) AS RNK FROM JOB_HISTORY J;
SELECT E.EMPLOYEE_ID,E.DEPARTMENT_ID,E.JOB_ID,J.START_DATE from EMPLOYEES E
JOIN JOB_HISTORY J
ON E.EMPLOYEE_ID=J.EMPLOYEE_ID;

-- 5. For For each employee, fetch the employee id, department id, job id, their rank (without skip levels) by commission_pct. 
-- Order the employees details by hire_date with recent hire_date coming first.
select employee_id,department_id,job_id,hire_date,rank() over(partition by commission_pct order by hire_date desc) from employees;

-- 6. Divide the employees into 10 groups with highest paid employees coming first.
-- For each employee fetch the emp id, department id salary and the group they belong to
select employee_id,department_id,salary, Ntile(10) over(order by salary desc) as grp 
from employees;

-- 7. For each employee, fetch the emp id, department id salary  and sum of salary up to the current
-- hire_date when sorted by the hired date.
select employee_id,department_id,salary, sum(salary) over(order by hire_date desc) from employees;

