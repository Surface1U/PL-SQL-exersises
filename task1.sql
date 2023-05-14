
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
    
