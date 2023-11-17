/*
Repeated Payments [Stripe SQL HARD Interview Question]
https://datalemur.com/questions/repeated-payments

Sometimes, payment transactions are repeated by accident; 
it could be due to user error, API failure or a retry error that causes a credit card to be charged twice.
Using the transactions table, identify any payments made at the same merchant with the same credit card for the same amount within 10 minutes of each other. 
The first transaction of such payments should not be counted as a repeated payment. 
This means, if there are two transactions performed by a merchant with the same credit card and for the same amount within 10 minutes, there will only be 1 repeated payment.
*/

# Final solution using lag function with EPOCH:
with stripe as(SELECT transaction_id, merchant_id, credit_card_id,
EXTRACT( EPOCH FROM transaction_timestamp-LAG(transaction_timestamp) 
OVER(PARTITION BY merchant_id, credit_card_id, amount ORDER BY transaction_timestamp))/60
as min_diff
FROM transactions
)

SELECT count(transaction_id) as payment_count
FROM stripe
WHERE abs(min_diff)<=10


# My initial solution could occasionally fail if the transactions are on a different day, month, or year. 
# A better method is to use EPOCH within a lag window function. This is also way faster that lessens amount of calculations vasly.
WITH stripe as (
SELECT merchant_id, credit_card_id, amount, 
EXTRACT(year FROM transaction_timestamp) as yr,
EXTRACT(month FROM transaction_timestamp) as mth,
EXTRACT(day FROM transaction_timestamp) as d,
EXTRACT(hour FROM transaction_timestamp) as hr,
EXTRACT(minute FROM transaction_timestamp) as mn
FROM transactions t1
)

SELECT count(DISTINCT s1.merchant_id) as payment_count
FROM stripe s1
INNER JOIN stripe s2
ON s1.merchant_id=s2.merchant_id
AND s1.credit_card_id=s2.credit_card_id
AND s1.amount=s2.amount
AND s1.yr=s2.yr
AND s1.mth=s2.mth
AND s1.d=s2.d
AND (s1.mn-s2.mn<10 OR s1.mn-s2.mn>10)
;
