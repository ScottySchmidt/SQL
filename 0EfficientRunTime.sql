/*
Some of my solutions used non_sargable query which can slow down runtime. 
I realized this months after working on these SQL problems.

ChatGPT: "When it comes to SQL queries,  a non-sargable query can indeed be slower compared to a sargable query. 
The term "sargable" stands for "search argument able, 
and it refers to a query that can take advantage of indexes effectively to optimize the search process.
*/


# Incorrect: Non-sargable query. While this is easy to read it has slower runtime:
SELECT * FROM orders WHERE YEAR(order_date) = 2022;

# Correct: here's an example of a sargable query that involves a date column:
SELECT * FROM orders WHERE order_date >= '2022-01-01' AND order_date < '2023-01-01';
