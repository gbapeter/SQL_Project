SELECT
    skills_dim.skills AS skills,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS average_yearly_salary

FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    salary_year_avg IS NOT NULL AND
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere'
GROUP BY
   skills
ORDER BY
    average_yearly_salary DESC
LIMIT 10;