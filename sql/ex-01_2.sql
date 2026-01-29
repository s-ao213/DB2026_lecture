SELECT
    c.name AS character_name,
    j.name AS job_name,
    c.level,
    c.created_at,
    ROUND(
        AVG(c.level) OVER (
            PARTITION BY
                c.job_id
            ORDER BY
                c.created_at
        ),
        2
    ) AS cumulative_avg_level
FROM
    x_characters AS c
    JOIN x_jobs AS j ON c.job_id = j.job_id
WHERE
    c.deleted_at IS NULL
ORDER BY
    j.name,
    c.created_at;
