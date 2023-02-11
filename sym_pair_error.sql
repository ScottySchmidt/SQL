https://www.hackerrank.com/challenges/symmetric-pairs/problem?isFullScreen=true
Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1.
Write a query to output all such symmetric pairs in ascending order by the value of X. List the rows such that X1 ≤ Y1.

My current solution is close even with research. 
This pronlem is confusing to understand and will posted a newly corrected solution later.
---------------

SELECT  t1.X, t1.Y
FROM functions t1
INNER JOIN functions t2
WHERE (t1.X<t2.Y) AND 
(t2.X=t1.Y)
GROUP BY t1.X, t1.Y
HAVING ( (t1.X=t1.Y) AND (count(*)>1) )
OR (t1.X<t1.Y)
ORDER BY t1.X
;
