
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
--тут я считаю количество лет с момента найма 

select employees.first_name, employees.last_name,
EXTRACT(YEAR from sysdate) - EXTRACT(year from hire_date) from employees where extract(month from hire_date) = EXTRACT(month from sysdate)
------------------------------------------------------------------------------
--Написать хранимую процедуру, которая принимает на вход департамент и год,
--а затем выводит на экран список всех сотрудников этого департамента, 
--чьи зарплаты выше средней зарплаты по этому департаменту за заданный год.


-- вот тут главное не забыть про into
CREATE OR REPLACE PROCEDURE Get_AVG_Salary(dep_id IN employees.department_id%TYPE, Hire_year IN NUMBER)
IS
    avg_salary NUMBER;
BEGIN 
    SELECT AVG(salary) INTO avg_salary FROM employees 
    WHERE department_id = dep_id AND EXTRACT(YEAR FROM hire_date) = Hire_year;
    
    DBMS_OUTPUT.PUT_LINE('The average salary in department ' || dep_id || ' in ' || Hire_year || ' is ' || avg_salary);
END;
---------------------------------------------------------------------------------
--здесь надо автоматически присваивать текущую дату найма при добавлении нового сотрудника

create or replace trigger Put_Hire_Date 
    before insert on employees
    for each row
    begin
        :NEW.hire_date := sysdate;
    end;
