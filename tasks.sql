
--Написать хранимую функцию, которая принимает на вход ID сотрудника
--и возвращает его зарплату за последний год.
--Для этого необходимо использовать таблицы employees и salaries.


create or replace FUNCTION get_last_year_salary (emp_id in NUMBER)
return NUMBER 
is 
    v_salary employees.salary%type;
begin 
    select salary into v_salary from employees
    where employee_id = emp_id
    and hire_date > add_months(sysdate, -12);
    RETURN v_salary;
    end;
  
--------------------------------------------------------------------------------------------------
  
--Написать скрипт, который выводит на экран список всех менеджеров 
--и количества подчиненных каждого менеджера.

SELECT e.employee_id, e.first_name || ' ' || e.last_name AS manager_name, COUNT(*) AS subordinate_count
FROM employees e
JOIN employees s ON e.employee_id = s.manager_id
GROUP BY e.employee_id, e.first_name, e.last_name;
----------------------------------------------------------------------------------
--тут я считаю количество лет с момента наёма 

select employees.first_name, employees.last_name,
EXTRACT(YEAR from sysdate) - EXTRACT(year from hire_date) from employees where extract(month from hire_date) = EXTRACT(month from sysdate)
