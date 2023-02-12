/* https://www.hackerrank.com/challenges/occupations/problem?isFullScreen=true
Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. 
The output column headers should be Doctor, Professor, Singer, and Actor, respectively.
Note: Print NULL when there are no more names corresponding to an occupation.

Need more pratice with pivot tables had to do lots of research and did not use the pivot way.
Will attempt this problem again shortly as pivot tables are very pracatical. 

Notes:
1. Must use max (or min) since there is a groupby clause. 
2. Most use the rownumber () order by name so pivot table can be sorted by name.
3. Using the pivot way is more useful instead of using hundreds of potential case statements that could change.

Solution without pivot using case statements
--------------------
*/

SELECT 
max(CASE WHEN occupation='Doctor' THEN name END),
max(CASE WHEN occupation='Professor' THEN name END),
max(CASE WHEN occupation='Singer' THEN name END),
max(CASE WHEN occupation='Actor' THEN name END)

FROM (SELECT name, occupation, ROW_NUMBER() OVER(PARTITION BY occupation ORDER BY name) as rn
      FROM occupations
     ) t
     
GROUP BY rn


---Solution with PIVOT_TABLE SQL SERVER:
SELECT Doctor, Professor, Singer, Actor
FROM (SELECT name, occupation, 
row_number() OVER (PARTITION BY occupation ORDER BY name ) as rn
FROM occupations) t 
pivot ( 
    max(NAME)
    FOR [OCCUPATION] IN ([Doctor], [Professor], [Singer],  [Actor])
      ) p
      ;


