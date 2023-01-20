# https://www.hackerrank.com/challenges/interviews/problem?isFullScreen=true
# Hard - Interview
# This is a challenging problem that requires joining three tables before creating two temp tables with a left join

# SELECT COLUMNS Joining contest and college tables:
select C.contest_id,C.hacker_id,C.name,
sum(s.total1), sum(s.total2), sum(V.total3), sum(V.total4) 
from Contests C join Colleges CL using(contest_id) 
Join Challenges CH using(college_id)

#CREATE A NEW TABLE S with submission totals:
left join (select challenge_id, sum(total_submissions) as total1, sum(total_accepted_submissions) as total2 
from Submission_Stats S
group by challenge_id) as S 
using (challenge_id) 

#CREATE A NEW TABLE V that has view totals
left join (select challenge_id, sum(total_views) as total3, sum(total_unique_views) as total4
from View_Stats 
group by challenge_id) as V 
using (challenge_id)

group by C.contest_id,C.hacker_id,C.name
;
