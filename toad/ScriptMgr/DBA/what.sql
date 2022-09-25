set echo off
set feed off
select tablespace_name, owner, segment_type, count(*), sum(bytes)
from sys.dba_extents
group by tablespace_name, owner, segment_type
order by tablespace_name, owner, segment_type;