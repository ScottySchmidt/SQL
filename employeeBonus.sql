/*
Find the number of employees who received the bonus and who didn't: https://platform.stratascratch.com/coding/10081-find-the-number-of-employees-who-received-the-bonus-and-who-didnt?code_type=7

Find the number of employees who received the bonus and who didn't. Bonus values in employee table are corrupted so you should use  values from the bonus table. Be aware of the fact that employee can receive more than bonus.
Output value inside has_bonus column (1 if they had bonus, 0 if not) along with the corresponding number of employees for each.
*/

---SQL Server, MySQL, and Oracle all have same solution: The key to solving this problem is using a CASE statement.
SELECT DISTINCT(e.id), e.first_name, e.last_name, 
CASE 
WHEN e.id IN ( 
SELECT distinct(worker_ref_id) FROM bonus) 
THEN 1
ELSE 0 
END as has_value 
FROM employee e
LEFT JOIN bonus b ON e.id = b.worker_ref_id
ORDER BY has_value DESC;

--NOTE: ChatGPT incorrectly does the CASE statement like CASE WHEN b.worker_ref_id IS NOT NULL THEN 1 ELSE 0 END as has_bonus
