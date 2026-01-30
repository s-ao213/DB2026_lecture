SELECT
    name,
    job,
    level,

    -- 職業ごとの累積平均レベル
    ROUND(
        AVG(level) OVER (
            PARTITION BY job
            ORDER BY created_at
        ),
        2
    ) AS cumulative_avg_level,

    -- 職業ごとの直近2人の平均（移動平均）
    ROUND(
        AVG(level) OVER (
            PARTITION BY job
            ORDER BY created_at
            ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS moving_avg_level

FROM
    s_characters
ORDER BY
    job,
    created_at;
