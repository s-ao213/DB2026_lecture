DROP TABLE IF EXISTS a_character_items;

DROP TABLE IF EXISTS a_characters;

DROP TABLE IF EXISTS a_items;

DROP TABLE IF EXISTS a_jobs;

DROP TABLE IF EXISTS a_guilds;

CREATE TABLE a_jobs (job_id SERIAL PRIMARY KEY, job_name VARCHAR(50) NOT NULL, role VARCHAR(20));

CREATE TABLE a_guilds (
    guild_id SERIAL PRIMARY KEY,
    guild_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE a_items (
    item_id SERIAL PRIMARY KEY,
    item_name VARCHAR(100) NOT NULL,
    rarity VARCHAR(20),
    power INT
);

CREATE TABLE a_characters (
    character_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    level INT NOT NULL,
    job_id INT NOT NULL REFERENCES a_jobs (job_id),
    guild_id INT REFERENCES a_guilds (guild_id),
    gender CHAR(1),
    email VARCHAR(100) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE a_character_items (
    character_id INT REFERENCES a_characters (character_id),
    item_id INT REFERENCES a_items (item_id),
    quantity INT DEFAULT 1,
    PRIMARY KEY (character_id, item_id)
);

INSERT INTO
    a_jobs (job_name, role)
VALUES
    ('Warrior', 'Attack'),
    ('Mage', 'Magic'),
    ('Priest', 'Support'),
    ('Archer', 'Attack'),
    ('Paladin', 'Defense'),
    ('Assassin', 'Attack'),
    ('Summoner', 'Magic'),
    ('Monk', 'Attack');

INSERT INTO
    a_guilds (guild_name)
SELECT
    'Guild_' || gs
FROM
    GENERATE_SERIES(1, 20) AS gs;

INSERT INTO
    a_items (item_name, rarity, power)
SELECT
    'Item_' || gs,
    CASE
        WHEN RANDOM() < 0.05 THEN 'SSR'
        WHEN RANDOM() < 0.20 THEN 'SR'
        WHEN RANDOM() < 0.50 THEN 'R'
        ELSE 'N'
    END,
    (RANDOM() * 100)::INT
FROM
    GENERATE_SERIES(1, 200) AS gs;

INSERT INTO
    a_characters (name, level, job_id, guild_id, gender, email, created_at)
SELECT
    'Character_' || gs,
    (RANDOM() * 100)::INT,
    (RANDOM() * 7)::INT + 1,
    (RANDOM() * 19)::INT + 1,
    CASE
        WHEN RANDOM() > 0.5 THEN 'M'
        ELSE 'F'
    END,
    'user' || gs || '@example.com',
    NOW() - (RANDOM() * INTERVAL '365 days')
FROM
    GENERATE_SERIES(1, 100000) AS gs;

INSERT INTO
    a_character_items (character_id, item_id, quantity)
SELECT
    c.character_id,
    i.item_id,
    (RANDOM() * 5)::INT + 1
FROM
    a_characters c
    CROSS JOIN LATERAL (
        SELECT
            item_id
        FROM
            a_items
        ORDER BY
            RANDOM()
        LIMIT
            (FLOOR(RANDOM() * 5) + 1)::INT
    ) i;
