/*
Direct Deposit Conversions: https://platform.stratascratch.com/coding/10357-direct-deposit-conversions?code_type=5
Chime counts a "conversion" as members who sets up direct deposit of at least $200 per month, for their payroll, with their employer.
To identify a payroll direct deposit transaction, we look for members who are getting paid similar amounts by the same company on a recurring basis. We therefore look for the following:
•	Members who get paid from the same company.
•	At least two distinct weeks within a 30-day period must show transactions (i.e., at least two transactions within a 30-day period).
•	The amounts of these transactions should differ by no more than $25.
Identify the members converting to direct deposit and the date of conversion. The date of conversion should be the earliest date of the direct deposit transaction that meets these criteria.
*/

-- Self join SQL Server Solution:
with payroll as
(
select a.user_id, a.employer, b.transaction_date
from dd_transactions a
join dd_transactions b
ON a.user_id = b.user_id
AND a.employer = b.employer
AND datediff(day, a.transaction_date, b.transaction_date) < 30
AND abs(a.transaction_amount-b.transaction_amount)<=25 
AND a.transaction_date < b.transaction_date
AND a.user_id IN (SELECT user_id
FROM dd_transactions
GROUP BY user_id, month(transaction_date)
HAVING sum(transaction_amount) >= 200)
)    
SELECT user_id, employer, 
min(transaction_date) as conversion_date
FROM payroll
GROUP BY user_id, employer
ORDER BY user_id, employer


    
-- SQL Server Solution below without self join is complex, currently not correct:
WITH EmployerTransactions AS (
    SELECT
        user_id, employer,
        transaction_amount,
        transaction_date,
        LEAD(transaction_amount) OVER (PARTITION BY employer ORDER BY transaction_date) AS next_transaction_amount,
        LEAD(transaction_date) OVER (PARTITION BY employer ORDER BY transaction_date) AS next_transaction_date
    FROM dd_transactions
)
SELECT user_id, employer, transaction_date
FROM EmployerTransactions
WHERE
    ABS(transaction_amount - next_transaction_amount) <= 25
    AND DATEDIFF(DAY, transaction_date, next_transaction_date) <= 30
ORDER BY user_id
