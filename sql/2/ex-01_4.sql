CREATE INDEX idx_characters_created_at
ON a_characters(created_at);

-- 理由
-- 範囲検索にB-treeは有効
-- 新規順にデータが追加されるため効きやすい
-- 期間検索は実務で非常に多い