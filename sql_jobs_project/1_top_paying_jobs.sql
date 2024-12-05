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