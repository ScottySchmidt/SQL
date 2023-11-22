/*
Top Percentile Fraud: 
ABC Corp is a mid-sized insurer in the US and in the recent past their fraudulent claims have increased significantly for their personal auto insurance portfolio. 
They have developed a ML based predictive model to identify propensity of fraudulent claims. 
Now, they assign highly experienced claim adjusters for top 5 percentile of claims identified by the model.
Your objective is to identify the top 5 percentile of claims from each state. 
Your output should be policy number, state, claim cost, and fraud score.
https://platform.stratascratch.com/coding/10303-top-percentile-fraud?code_type=5
*/


---SQL Server
SELECT
  state,
  claim_cost,
  policy_num,
  fraud_score
FROM (
  SELECT
    state,
    claim_cost,
    policy_num,
    fraud_score,
    PERCENTILE_CONT(0.05) WITHIN GROUP (ORDER BY fraud_score DESC) OVER (PARTITION BY state) AS top_5_percentile
  FROM
    fraud_score
) AS subquery
WHERE
  fraud_score >= top_5_percentile
ORDER BY
  state, fraud_score DESC;
