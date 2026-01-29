SELECT
  c.name AS character_name,
  j.name AS job_name,
  c.level,
  ROUND(
    AVG(c.level) OVER (PARTITION BY c.job_id),
    2
  ) AS avg_level_by_job
FROM
  x_characters AS c
JOIN
  x_jobs AS j
    ON c.job_id = j.job_id
WHERE
  c.deleted_at IS NULL
ORDER BY
  j.name,
  c.name;
