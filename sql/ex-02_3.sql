SELECT
    name,
    job_name,
    level,
    avg_level
FROM
    (
        SELECT
            c.name,
            j.name AS job_name,
            c.level,
            ROUND(
                AVG(c.level) OVER (
                    PARTITION BY c.job_id
                ),
                2
            ) AS avg_level,
            ROW_NUMBER() OVER (
                PARTITION BY c.job_id
                ORDER BY c.created_at DESC
            ) AS rn
        FROM
            x_characters c
            INNER JOIN x_jobs j
                ON c.job_id = j.job_id
        WHERE
            c.deleted_at IS NULL
    ) sub
WHERE
    rn <= 3
ORDER BY
    job_name,
    rn;
