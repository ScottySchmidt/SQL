#https://www.hackerrank.com/challenges/the-report/forum
#Medium SQL - Generate Report
#Using a JOIN ON BETWEEN is biggest challenge and IF statement

SELECT 
if (marks>70, name, "NULL"),
g.grade,
s.marks
FROM students s
INNER JOIN grades g 
on s.marks BETWEEN g.min_mark AND g.max_mark
ORDER BY g.grade DESC, name, s.marks ASC;  
