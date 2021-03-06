-- @Description Ensures that relnode for an index does not change if reindex command is aborted
-- 

1: BEGIN;
1: REINDEX index idx_btree_reindex_abort_ao;
1: ROLLBACK;
3: SELECT 1 AS relfilenode_same_on_all_segs from gp_dist_random('pg_class')   WHERE relname = 'idx_btree_reindex_abort_ao' GROUP BY relfilenode having count(*) = (SELECT count(*) FROM gp_segment_configuration WHERE role='p' AND content > -1);
3: SELECT 1 as relfilenode_didnot_change from pg_class where relname = 'idx_btree_reindex_abort_ao' and relfilenode = oid;
