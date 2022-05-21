/* Employee_Detailsemployee_details table*/
-- 1.  Write a query to show the Department & Joining year for Jennice & Daniel.
select first_name from employees
order by first_name asc;
select e1.first_name,year(hire_date),e2.department_name from employees as e1
join departments as e2 on e1.department_id = e2.department_id
where e1.first_name = ('Daniel') or
e1.first_name = ('Jennifer');
select * from employees;

-- 2. Write a query to show the employee detail where Sr. Leads are earning more than Asst. Managers.
select * from employees
where job_id='SA_REP' and  salary > (select salary from employees where job_id='ST_MAN');

select salary from employees where job_id='ST_MAN';

-- 3. Using the HR Schema, Write a Query to print the name and  a message 'Well Paid' or 'Underpaid' if the salary is above or below 6500$ respectively.
select *,
case when salary >= 6500 then 'Well Paid'
else 'Underpaid' end as salary_status
from employees;

-- 4. Write a query in SQL to display the department name, city, and state province for each department.
select * from departments;
select * from job_history;
select d.department_name,l.city,ifnull(l.state_province,city) from departments as d
join locations as l on d.location_id=l.location_id;

-- 5. Write a query in SQL to display the job title, department name, full name (first and last name ) of employee, 
# and starting date for all the jobs which started on or after 1st January, 1993 and ending with on or before 31 August, 1997.
select j.job_title,d.department_name,concat(e.first_name,' ',e.last_name) as full_name ,jh.start_date,jh.end_date from employees as e
join departments as d on e.department_id=d.department_id
join job_history as jh on d.department_id=jh.department_id
join jobs as j on jh.job_id=j.job_id
where  (jh.start_date >= '1993-01-01') and (jh.end_date <= '1997-08-31');

-- 6. Write a query to display the employee id, employee name (first name and last name ) 
-- for all employees who earn more than the average salary. (HR schema)
select employee_id,concat(first_name,' ',last_name) as employeee_name,salary from employees
where salary > (select avg(salary) from employees);
                             
-- 7. Write a query to display the employee name( first name and last name ) and 
-- hiredate for all employees in the same department as Clara. Exclude Clara. (HR schema)
select concat(first_name,' ',last_name) as employeee_name,hire_date from employees
where department_id = (select department_id from employees where first_name='Clara')
and first_name != 'Clara';

-- 8. Write a query in SQL to display the first and last name, salary, and 
-- department ID for those employees who earn less than the average salary, 
-- and also work at the department where the employee Laura is working as a first name holder. (HR schema)
select first_name,last_name,hire_date from employees
where department_id = (select department_id from employees where first_name='Clara')
and first_name != 'Clara';

-- 9. Display 5th highest salary of employee using subquery (HR schema)
select * from employees e1 
where 4 = (select count(distinct salary) from employees e2
where e2.salary > e1.salary);
        
-- 10. Write a query to display net Salary of employees even if the commission is not given . (HR schema)
 select ifnull((Salary + commission_pct),salary) as net from employees;