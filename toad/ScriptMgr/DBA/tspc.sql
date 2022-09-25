set echo off
set feed off

set term off
COLUMN block_size NOPRINT new_value block_size
SELECT value block_size from v$parameter
 where name='db_block_size';
set term on

select c.tablespace_name,
       a.bytes/1048576 Megs_Alloc,
       b.bytes/1048576 Megs_Free,
       (a.bytes-b.bytes)/1048576 Megs_Used,
       b.bytes/a.bytes * 100 Pct_Free,
       (a.bytes-b.bytes)/a.bytes * 100 Pct_Used,
       c.initial_extent/1048576 Init_Ext,
       c.next_extent/1048576 Next_Ext,
       a.minbytes/1048576 Min_Ext,
       a.maxbytes/1048576 Max_Ext,
       nvl(d.num_segs,0) Num_segs,
       nvl(d.num_exts,0) Num_Exts
from (select tablespace_name,
             sum(a.bytes) bytes,
             min(a.bytes) minbytes,
             max(a.bytes) maxbytes
      from sys.dba_data_files a
      group by tablespace_name) a,
     (select a.tablespace_name,
             nvl(sum(b.bytes),0) bytes
      from sys.dba_data_files a,
           sys.dba_free_space b
      where a.tablespace_name = b.tablespace_name (+)
        and a.file_id         = b.file_id (+)
      group by a.tablespace_name) b,
      sys.dba_tablespaces c,
      (select tablespace_name, 
              count(distinct segment_name) num_segs,
              count(extent_id) num_exts
       from sys.dba_extents
       group by tablespace_name) d
where a.tablespace_name = b.tablespace_name(+)
  and a.tablespace_name = c.tablespace_name
  and a.tablespace_name = d.tablespace_name(+)
order by c.tablespace_name;

SELECT 
ts.name Tablespace,
f.FILE# "File#",
SUM(f.LENGTH) "Empty BLocks", 
COUNT(*) "# Pieces", 
MAX(f.LENGTH) "Largest", 
MIN(f.LENGTH) "Smallest", 
ROUND(AVG(f.LENGTH)) "Average", 
SUM(DECODE(SIGN(f.LENGTH-    1048576/&block_size), -1, 1, 0)) "<= 1MB", 
SUM(DECODE(SIGN(f.LENGTH- 10*1048576/&block_size), -1, 1, 0)) -
    SUM(DECODE(SIGN(f.LENGTH-    1048576/&block_size), -1, 1, 0)) "<= 10MB",
SUM(DECODE(SIGN(f.LENGTH-100*1048576/&block_size), -1, 1, 0)) -
    SUM(DECODE(SIGN(f.LENGTH- 10*1048576/&block_size), -1, 1, 0)) "<= 100MB",
SUM(DECODE(SIGN(f.LENGTH-100*1048576/&block_size), -1, 0, 1)) "> 100MB"
FROM 
sys.fet$ f, 
sys.FILE$ tf, 
sys.ts$ ts 
WHERE 
ts.ts#=f.ts# AND 
f.file#=tf.relfile# and 
ts.ts#=tf.ts# 
GROUP BY ts.name, f.FILE#;