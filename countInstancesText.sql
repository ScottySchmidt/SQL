/*
Counting Instances in Text, Hard Google StrataScratch:
Find the number of times the words 'bull' and 'bear' occur in the contents. 
We're counting the number of times the words occur so words like 'bullish' should not be included in our count.
Output the word 'bull' and 'bear' along with the corresponding number of occurrences.
----------------
To solve this problem we must:
1. Get count of contents column like '%bear%'
2. Same as above but with bull
3. Union the two cte tables together
4. Put a string 'bull' and 'bear' so matches final report
*/



with bear as(select filename, contents
from google_file_store
WHERE contents LIKE '%bear%'
),

bull as(select filename, contents
from google_file_store
WHERE contents LIKE '%bull%'
)

SELECT 'bull',count(filename)
FROM bull
UNION ALL
SELECT 'bear',count(filename)
FROM bear
