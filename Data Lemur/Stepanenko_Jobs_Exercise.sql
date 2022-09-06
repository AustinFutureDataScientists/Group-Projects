SELECT COUNT(DISTINCT(company_id))
FROM
  (
      SELECT j.job_id, j.company_id, j.title, j.description
      FROM job_listings j
      INNER JOIN job_listings l
      ON
          j.company_id=l.company_id
          AND
          j.title=l.title
          AND
          j.description=l.description
          AND
          j.job_id!=l.job_id
  )
  AS REPEATING_JOBS  
