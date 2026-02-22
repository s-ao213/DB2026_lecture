-- 単一インデックス
CREATE INDEX idx_characters_job
ON a_characters(job_id);

CREATE INDEX idx_characters_level
ON a_characters(level);

EXPLAIN ANALYZE
SELECT *
FROM a_characters
WHERE job_id = 3
  AND level >= 70;

-- 単一削除
DROP INDEX idx_characters_job;
DROP INDEX idx_characters_level;

-- 複合インデックス
CREATE INDEX idx_characters_job_level
ON a_characters(job_id, level);

EXPLAIN ANALYZE
SELECT *
FROM a_characters
WHERE job_id = 3
  AND level >= 70;