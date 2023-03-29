/*
Symmetric Pairs:  https://www.hackerrank.com/challenges/symmetric-pairs/problem?isFullScreen=true
Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1.
Write a query to output all such symmetric pairs in ascending order by the value of X. List the rows such that X1 ≤ Y1.
Specifically, the line: HAVING COUNT(*)>1 OR a.X!=a.Y
This above code will find a pair that is a duplicate. 
But then distinct will only count this pair once.
The or statement is needed because typically a sym pair are not the same x is less than y.
-----------------
*/ 

-- Second solution with commentsL
with pairs as (SELECT f1.X, f1.Y, 
count(*) as counts --Need to find pairs on second table
FROM Functions f1
INNER JOIN Functions f2 --Doing a self join
ON f1.X = f2.Y -- X1 = Y2 AND
AND f2.X = f1.Y -- X2 = Y1
GROUP BY f1.X, f1.Y --Need to get count
ORDER BY f1.X, f1.Y --Order by X
)

SELECT X, Y
FROM pairs
WHERE X < y -- "rows such that X1 ≤ Y1"
OR (X = Y and counts>1 ) --If more than one pair


--First solution with hints:
SELECT DISTINCT a.*
FROM functions a
INNER JOIN Functions b ON (a.X=b.Y AND a.Y=b.X)
WHERE a.X <= a.Y
GROUP BY a.X, a.Y
HAVING COUNT(*)>1 OR a.X!=a.Y
ORDER BY a.X
;

