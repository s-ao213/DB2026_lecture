SELECT character_id, name, level
FROM a_characters
ORDER BY level DESC
LIMIT 100;

CREATE INDEX idx_characters_level_desc
ON a_characters(level DESC);