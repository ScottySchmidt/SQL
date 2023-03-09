/*
Hard SQL Problem: https://leetcode.com/problems/human-traffic-of-stadium/
Find Three Days in a row where stadium has more than 100 people
Filter by more than 100 people
*/

#SELECT t1.id, t1.visit_date, t1.people 
select DISTINCT t1.*
FROM stadium t1, stadium t2, stadium t3
WHERE t1.people>=100 AND t2.people>=100 AND t3.people>=100

#Search for three in a row:
AND 
(
#Table1            Table2                  Table3
 t1.id-t2.id=1  AND t2.id-t3.id=1  AND t1.id-t3.id=2 -- next two rows
 OR
#Table2                    Table1                  Table3
  t2.id - t1.id = 1   AND t1.id - t3.id = 1  AND t2.id-t3.id=2 -- middle
OR 
#Table3              Table2            Table1
 t3.id-t2.id=1 AND t2.id-t1.id=1 AND t3.id-t1.id=2 -- previous two rows
)
ORDER BY t1.id
;
# The most challenging part is being able to comprehend when Table2 comes first (line 16)
# I found this problem challenging and practical.
# This problem would be very useful for finding complex patterns in large databases 
