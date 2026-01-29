SELECT
    name,
    job_name,
    level,
    rank_no
FROM
    (
        SELECT
            c.name,
            j.name AS job_name,
            c.level,
            RANK() OVER (
                PARTITION BY c.job_id
                ORDER BY c.level DESC
            ) AS rank_no
        FROM
            x_characters c
            INNER JOIN x_jobs j
                ON c.job_id = j.job_id
        WHERE
            c.deleted_at IS NULL
    ) sub
WHERE
    rank_no <= 2
ORDER BY
    job_name,
    rank_no;
