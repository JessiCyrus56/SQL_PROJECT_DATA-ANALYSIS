
SELECT 
skills,
round(avg(salary_year_avg),0) as avg_salary
from job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id= skills_job_dim.job_id
inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
where job_title_short= 'Data Analyst' and 
salary_year_avg is not null
GROUP BY skills
order by avg_salary desc
limit 25