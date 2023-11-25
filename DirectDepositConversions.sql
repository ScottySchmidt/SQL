/*
Chime counts a "conversion" as members who sets up direct deposit of at least $200 per month, for their payroll, with their employer.
To identify a payroll direct deposit transaction, we look for members who are getting paid similar amounts by the same company on a recurring basis. We therefore look for the following:
•	Members who get paid from the same company.
•	At least two distinct weeks within a 30-day period must show transactions (i.e., at least two transactions within a 30-day period).
•	The amounts of these transactions should differ by no more than $25.
Identify the members converting to direct deposit and the date of conversion. 
The date of conversion should be the earliest date of the direct deposit transaction that meets these criteria.
https://platform.stratascratch.com/coding/10357-direct-deposit-conversions?code_type=3
*/

--SQL Server
WITH EmployerTransactions AS (
    SELECT
        employer,
        transaction_amount,
        transaction_date,
        LEAD(transaction_amount) OVER (PARTITION BY employer ORDER BY transaction_date) AS next_transaction_amount,
        LEAD(transaction_date) OVER (PARTITION BY employer ORDER BY transaction_date) AS next_transaction_date
    FROM
        dd_transactions
)

SELECT
    employer,
    transaction_amount AS first_transaction_amount,
    transaction_date AS first_transaction_date,
    next_transaction_amount AS second_transaction_amount,
    next_transaction_date AS second_transaction_date
FROM
    EmployerTransactions
WHERE
    ABS(transaction_amount - next_transaction_amount) <= 25
    AND DATEDIFF(DAY, transaction_date, next_transaction_date) <= 30;

