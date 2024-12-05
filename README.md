# Introduction
This project was inspired by my desire to identify the most deamded and top paying skills for data analyst jobs, and to develop my SQL skills and knowledge on my path to becoming a data analyst.
# Background
There are numerous skills required for data analyst jobs, but not so many are highly sought after. In today's highly competitive job market, it is crucial for aspiring data nerds to focus on the optimal skills. Hence, a deep dive into the top paying and in-demand skills is required.

# Tools I Used
For this project, I used the following tools;

**SQL:** A programming language designed specifically for managing and manipulating relational databases.

**PostgreSQL:** A powerful, open-source relational database management system suitable for jobs posting data.

**VS Code:** A popular, free source code editor which is used for writing my queries.

**Git and Github:** A version control system used for sharing and tracking changes in a code.

# The Analaysis
## Top Paying Jobs

For this analysis, I structured my query to return only remote data analyst jobs having a yearly average salary.

Here is the code:

``` SQL
SELECT
    job_title_short,
    salary_year_avg
FROM
    job_postings_fact
WHERE
    (salary_year_avg IS NOT NULL AND
    job_location = 'Anywhere') AND job_title_short = 'Data Analyst'
ORDER BY
   salary_year_avg DESC
LIMIT 25;
```

## Top Paying Skills

I wrote a query to return the skills associated with the top paying data analyst remote jobs.

Here is the code:

``` SQL
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title_short,
        salary_year_avg
    FROM
        job_postings_fact
    WHERE
        salary_year_avg IS NOT NULL AND
        job_location = 'Anywhere' AND job_title_short = 'Data Analyst'
)

SELECT
    top_paying_jobs.*,
    skills
FROM
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
## Top Demanded Skills

To get the top demanded skills, I used the INNERJOIN() function to link the jobs posted table to the varous skills table and performed a count of the skills_id.
Here is the code:

``` SQL
SELECT
    skills_dim.skills AS skills,
    COUNT(skills_job_dim.skill_id) AS skill_count
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere'
GROUP BY
   skills
ORDER BY
    skill_count DESC
LIMIT 10;
```
## Top Salary Skills

To find the top salary skills, I structured my query to calculae the average of the salaries associated with the various skills in the skills table and return it inna descending order.
Here is the code:

``` SQL
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
```

## Optimal Jobs

The optimal jobs are those with high demand and high salaries. For this, I combined the queries for most demanded jobs and top paying jobs.

Here is the code:

``` SQL
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS skill_count,
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
   skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    average_yearly_salary DESC,
    skill_count DESC
LIMIT 25;
```

# What I Learned

I learned how to create tables and load data from CSV files to them, create a database and connect it to a data base management system on VS Code, merge tables using JOINs, aggregate functions like SUM(), AVG() among other basic and advanced SQL concepts and functions.

I also learned that the most optimal skills for data analyst jobs are SQL, Excel, Python, Tableau and Power BI.

# Conclusion

Aspiring data analysts should focus on high paying and in-demand skills.


