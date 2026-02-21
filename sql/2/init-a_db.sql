DROP TABLE IF EXISTS a_characters;

CREATE TABLE a_characters (
    character_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    level INT NOT NULL,
    job_id INT NOT NULL,
    guild_id INT,
    gender CHAR(1),
    email VARCHAR(100) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO
    a_characters (name, level, job_id, guild_id, gender, email, created_at)
SELECT
    'Character_' || gs,
    (RANDOM() * 100)::INT,
    (RANDOM() * 10)::INT + 1,
    (RANDOM() * 50)::INT + 1,
    CASE
        WHEN RANDOM() > 0.5 THEN 'M'
        ELSE 'F'
    END,
    'user' || gs || '@example.com',
    NOW() - (RANDOM() * INTERVAL '365 days')
FROM
    GENERATE_SERIES(1, 100000) AS gs;