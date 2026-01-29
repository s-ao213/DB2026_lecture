SELECT
    name,
    job_name,
    level,
    created_at,
    cumulative_avg
FROM
    (
        SELECT
            c.name,
            j.name AS job_name,
            c.level,
            c.created_at,
            ROUND(
                AVG(c.level) OVER (
                    PARTITION BY c.job_id
                    ORDER BY c.created_at
                ),
                2
            ) AS cumulative_avg,
            ROW_NUMBER() OVER (
                PARTITION BY c.job_id
                ORDER BY c.created_at
            ) AS rn
        FROM
            x_characters c
            INNER JOIN x_jobs j
                ON c.job_id = j.job_id
        WHERE
            c.deleted_at IS NULL
    ) sub
WHERE
    cumulative_avg >= 50
    AND rn = 1
ORDER BY
    job_name;
