CREATE UNIQUE INDEX idx_characters_email
ON a_characters(email);

-- 理由
-- email は等価検索（=）で使用される
-- ログイン処理は高頻度で実行される
-- 1件だけ取得するため選択度が非常に高い
-- UNIQUEにすることで整合性も保証できる