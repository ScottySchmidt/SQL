/*
Find the number of employees who received the bonus and who didn't: https://platform.stratascratch.com/coding/10081-find-the-number-of-employees-who-received-the-bonus-and-who-didnt?code_type=7

Find the number of employees who received the bonus and who didn't. Bonus values in employee table are corrupted so you should use  values from the bonus table. Be aware of the fact that employee can receive more than bonus.
Output value inside has_bonus column (1 if they had bonus, 0 if not) along with the corresponding number of employees for each.
*/

--SQL Server and MySQL Solution, Hard level but more so medium in my opinion:
with emp_cte as( 
SELECT DISTINCT(e.id),
CASE
WHEN e.id IN (SELECT worker_ref_id
FROM bonus)
THEN 1 ELSE 0
END as has_value
FROM employee e
LEFT JOIN bonus b
ON e.id = b.worker_ref_id
)

SELECT has_value, 
count(has_value) as n_employees
FROM emp_cte
GROUP BY has_value
ORDER BY has_value

/* SQL OUTPUT:
has_value	n_employees
0	        27
1	        3
/*


--NOTE: Can also do a case statement, ChatGPT incorrectly does the CASE statement like CASE WHEN b.worker_ref_id IS NOT NULL THEN 1 ELSE 0 END as has_bonus
