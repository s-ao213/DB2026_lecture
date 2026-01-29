SELECT
    g.name AS guild_name,
    c.name AS character_name,
    SUM(i.price * ci.qty) AS "アイテム総額",
    SUM(SUM(i.price * ci.qty)) OVER (
        PARTITION BY
            g.guild_id
        ORDER BY
            c.character_id
    ) AS "ギルド内累積アイテム総額"
FROM
    x_guild_characters AS gc
    JOIN x_guilds AS g ON gc.guild_id = g.guild_id
    JOIN x_characters AS c ON gc.character_id = c.character_id
    JOIN x_character_items AS ci ON c.character_id = ci.character_id
    JOIN x_items AS i ON ci.item_id = i.item_id
GROUP BY
    g.guild_id,
    g.name,
    c.character_id,
    c.name
ORDER BY
    g.name,
    c.character_id;