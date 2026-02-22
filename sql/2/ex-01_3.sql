CREATE INDEX idx_items_rarity
ON a_items(rarity);

CREATE INDEX idx_character_items_item
ON a_character_items(item_id);

-- 理由
-- rarityでまず絞り込み
-- その後 item_id で中間テーブルへJOIN
-- 多対多は中間テーブルがボトルネックになりやすい