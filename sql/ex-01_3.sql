SELECT
    ci.character_id,
    i.name AS item_name,
    ci.qty,
    i.price * ci.qty AS "価格",
    SUM(i.price * ci.qty) OVER (
        PARTITION BY
            ci.character_id
        ORDER BY
            i.item_id
    ) AS "合計金額"
FROM
    x_character_items AS ci
    JOIN x_items AS i ON ci.item_id = i.item_id
ORDER BY
    ci.character_id,
    i.item_id;
