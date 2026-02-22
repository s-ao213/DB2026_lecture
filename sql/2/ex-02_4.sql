EXPLAIN ANALYZE
SELECT DISTINCT c.name
FROM a_characters c
JOIN a_character_items ci
  ON c.character_id = ci.character_id
JOIN a_items i
  ON ci.item_id = i.item_id
WHERE i.rarity = 'SSR';

CREATE INDEX idx_character_items_item
ON a_character_items(item_id);

EXPLAIN ANALYZE
SELECT DISTINCT c.name
FROM a_characters c
JOIN a_character_items ci
  ON c.character_id = ci.character_id
JOIN a_items i
  ON ci.item_id = i.item_id
WHERE i.rarity = 'SSR';

DROP INDEX idx_character_items_item;