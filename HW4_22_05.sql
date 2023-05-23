select * FROM employees;
SELECT department_id, MAX(salary > 10000) AS has_high_earning_employee
FROM employees
GROUP BY department_id
HAVING has_high_earning_employee=1;



SELECT department_id, MIN(salary > 10000) AS all_employees_earn_more
FROM employees
GROUP BY department_id
HAVING all_employees_earn_more = 1;

-- Операторы MIN и MAX в MySQL используются для вычисления минимального и максимального 
-- значений в столбцах или выражениях. 