SELECT
    name,
    level,
    ROW_NUMBER() OVER (
        ORDER BY level DESC
    ) AS rn
FROM
    x_characters
WHERE
    deleted_at IS NULL
ORDER BY
    rn
LIMIT 5;
