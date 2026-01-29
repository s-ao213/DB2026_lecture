SELECT
    j.name AS job_name,
    CASE
        WHEN c.level < 50 THEN 'Low'
        ELSE 'High'
    END AS level_group,
    COUNT(*) AS cnt
FROM
    x_characters c
    INNER JOIN x_jobs j
        ON c.job_id = j.job_id
WHERE
    c.deleted_at IS NULL
GROUP BY
    CUBE (
        j.name,
        CASE
            WHEN c.level < 50 THEN 'Low'
            ELSE 'High'
        END
    )
ORDER BY
    job_name,
    level_group;
