---Signup Activation Rate [TikTok SQL Interview Question]
---https://datalemur.com/questions/signup-confirmation-rate

--New TikTok users sign up with their emails. 
--They confirmed their signup by replying to the text confirmation to activate their accounts. 
--Users may receive multiple text messages for account confirmation until they have confirmed their new account.
--Write a query to find the activation rate of the users. Round the percentage to 2 decimal places.
----------------------------------------------------------------------
WITH not_confirm as (
SELECT e.user_id, t.signup_action
FROM emails e
JOIN texts t
USING (email_id)
WHERE t.signup_action='Not Confirmed'
ORDER BY e.user_id
),

--- This t2 is actually not needed I realized later:
t2 as (
SELECT e.user_id, t.signup_action
FROM emails e
JOIN texts t
USING (email_id)
WHERE t.signup_action='Confirmed'
ORDER BY e.user_id
)

SELECT ROUND( 1.0*(SELECT count(user_id) from not_confirm)/(SELECT count(user_id) FROM emails),2);
--- Must do 1.0 * to get decimal form 

---SELECT count(DISTINCT user_id) FROM t2;
---Initially, I thought you had to use DISTINCT to not double count
