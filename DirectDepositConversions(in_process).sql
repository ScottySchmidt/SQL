/*
Direct Deposit Conversions: https://platform.stratascratch.com/coding/10357-direct-deposit-conversions?code_type=5
Chime counts a "conversion" as members who sets up direct deposit of at least $200 per month, for their payroll, with their employer.
To identify a payroll direct deposit transaction, we look for members who are getting paid similar amounts by the same company on a recurring basis. We therefore look for the following:
•	Members who get paid from the same company.
•	At least two distinct weeks within a 30-day period must show transactions (i.e., at least two transactions within a 30-day period).
•	The amounts of these transactions should differ by no more than $25.
Identify the members converting to direct deposit and the date of conversion. The date of conversion should be the earliest date of the direct deposit transaction that meets these criteria.
*/
-- SQL Server Solution:
-- EmployerTransactions temp table getting next transaction date and amount through employer
WITH EmployerTransactions AS (
    SELECT
        user_id, employer,
        transaction_amount,
        transaction_date,
        LEAD(transaction_amount) OVER (PARTITION BY employer ORDER BY transaction_date) AS next_transaction_amount,
        LEAD(transaction_date) OVER (PARTITION BY employer ORDER BY transaction_date) AS next_transaction_date
    FROM dd_transactions
)

--- Get the user_id, employer and date if differences no more than 25 and within 30-day period:
SELECT user_id, employer, transaction_date
FROM EmployerTransactions
WHERE
    ABS(transaction_amount - next_transaction_amount) <= 25
    AND DATEDIFF(DAY, transaction_date, next_transaction_date) <= 30
ORDER BY user_id
