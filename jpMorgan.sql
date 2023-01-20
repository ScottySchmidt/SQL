# https://datalemur.com/questions/cards-issued-difference
# This is considered an easy problem but worth posting I think

with smallTable AS (
SELECT min(issued_amount) as smallNum, card_name
FROM monthly_cards_issued
GROUP BY card_name
),

bigTable AS (
SELECT max(issued_amount) as bigNum, card_name
FROM monthly_cards_issued
GROUP BY card_name
)

SELECT  card_name, (b.bigNum-s.smallNum) as difference
FROM smallTable s
JOIN bigTable b
USING (card_name)
ORDER BY difference DESC
;
