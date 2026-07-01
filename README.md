# Introdution 
📊dive into the data job market! focusing on data analyst roles, this project explores 💰top-paying jobs, in-demand skills and 📈 where high demands meets high salary in data analytics.

SQL queries? check them out here: [project_sql folder](/project_sql/)
# background  
Driven by a quest to navigate the data analyst job market more effectively, the project was born from desire to pin point top-paid and in-demand skills, streamlining others work to find optimal jobs

Data hails from my[SQL course](http//:lukebarousse.com/sql). Its packed with insights on job titles, salaries, locations and essential skills
### the queries i wanted to answer through mySQL queries were:
1.What are the top paying data analyst jobs?  
2.What are the skills required for these top-paying jobs?  
3.What skills are most in demand for data analysts?  
4.Which skills are associated with higher salaries?  
5.What are the most optimal skills to learn?
# tools i used
for my deep dive into data analyst job market, i harnessed the power of several key tools:  
-**sql:** the backbone of my analysis, allowing me to query the data and unearth critical insights   
-**postreSQL:** the chosen database management system, ideal for handling the job posting data  
-**Visual studio code:** my go-to for database management and executing sql queries  
-**Git& GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# the analysis 
Each query for this project aimed at investigating specific aspects of the data analysis job market. here is how i approached each question:  
### 1.top paying jobs
To identify the high-paying jobs, i filtered data analyst postions by average yearly salary and location, focusing on remote jobs. This is the query highlights the high paying opportunities in the field.
```
SELECT
job_id,
job_title,
job_location,
job_schedule_type,
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
```
### 2.Skills for top paying jobs
to understand what skills are required for the top_paying_jobs, i joined the job postings with skills data, providin high insights into what employers value for high compensation roles
WITH top_paying_skill as (
```
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
top_paying_jobs.*,
skills
from top_paying_skill
INNER JOIN skills_job_dim on skills_job_dim.job_id= top_paying_skill.job_id
inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
order by salary_year_avg DESC
```
### 3.In-demand skills for data analyts
This query helped idenify the skills most frequently requested in job postings, directing focus to areas with high demand 
```
SELECT 
skills,
count(skills_job_dim.job_id) as demand_count
from job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id= skills_job_dim.job_id
inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
where job_title_short= 'Data Analyst'
GROUP BY skills
order by demand_count desc
limit 5
```
### 4.Skills based on salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying
```
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
```
### 5.Most optimal skills to learn 
Combining insights from demand and salary data, the query aimed to pinpoint skills that both in high demand and offering strategic focus for skill development
```
SELECT
skills_dim.skill_id,
skills_dim.skills,
COUNT(skills_job_dim.job_id) as demand_count,
ROUND(avg(job_postings_fact.salary_year_avg),0) as avg_salary
from job_postings_fact
INNER join skills_job_dim on job_postings_fact.job_id= skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id= skills_dim.skill_id
where 
job_title_short= 'Data Analyst' and 
salary_year_avg is not null AND
job_work_from_home= TRUE
GROUP BY 
skills_dim.skill_id
HAVING
count(skills_job_dim.job_id)>10
order BY
avg_salary desc,
demand_count DESC
LIMIT 25
```


# what i learned 
i learned alot through out this journey, here :  
-Data aggression: i got comfortable with GROUP BY and turned aggregate functions like AVG(), COUNT() into data summarising sidekicks  
-Analytics: leveled up my real world puzzle solving skills, turning questions into insightful SQL queries 



# conclusions
This project enhanced my SQL skills and provided valuable insights into the data analysis job market. The findings from this analysis serve as a guide for priortizing skill development and job search efforts