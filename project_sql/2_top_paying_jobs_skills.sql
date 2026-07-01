WITH top_paying_skill as (
SELECT
job_id,
job_title,
salary_year_avg,
job_posted_date,
name as company_name
 from job_postings_fact
 left join company_dim on job_postings_fact.company_id= company_dim.company_id
where job_title= 'Data Engineer' AND
job_location = 'New York, NY' and 
salary_year_avg is not null
order by salary_year_avg DESC
limit 10
)
select 
*,
skills
from top_paying_skill
INNER JOIN skills_job_dim on skills_job_dim.job_id= top_paying_skill.job_id
inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
order by salary_year_avg DESC