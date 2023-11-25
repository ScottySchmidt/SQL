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
SELECT id, transaction_date, transaction_amount, employer, user_id
FROM dd_transactions;

