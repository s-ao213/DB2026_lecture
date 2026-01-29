SELECT
    name,
    job_name,
    level,
    created_at,
    cumulative_avg_level,
    moving_avg_level
FROM
    (
        SELECT
            c.name,
            j.name AS job_name,
            c.level,
            c.created_at,

            -- 職業ごとの累積平均（小数第2位まで）
            ROUND(
                AVG(c.level) OVER (
                    PARTITION BY
                        c.job_id
                    ORDER BY
                        c.created_at
                    ROWS BETWEEN
                        UNBOUNDED PRECEDING AND CURRENT ROW
                ),
                2
            ) AS cumulative_avg_level,

            -- 職業ごとの直近3人の移動平均（小数第2位まで）
            ROUND(
                AVG(c.level) OVER (
                    PARTITION BY
                        c.job_id
                    ORDER BY
                        c.created_at
                    ROWS BETWEEN
                        2 PRECEDING AND CURRENT ROW
                ),
                2
            ) AS moving_avg_level,

            -- 各職業内での新しい順ランキング
            ROW_NUMBER() OVER (
                PARTITION BY
                    c.job_id
                ORDER BY
                    c.created_at DESC
            ) AS rn

        FROM
            x_characters c
            INNER JOIN x_jobs j
                ON c.job_id = j.job_id
        WHERE
            c.deleted_at IS NULL
    ) sub
WHERE
    cumulative_avg_level >= 50
    AND rn <= 5
ORDER BY
    job_name,
    created_at;
