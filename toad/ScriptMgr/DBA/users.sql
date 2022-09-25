set echo off
set feed off
select a.username,
       count(b.object_id),
       a.default_tablespace,
       a.temporary_tablespace
from dba_users a, dba_objects b
where a.username = b.owner(+)
group by a.username, a.default_tablespace,
         a.temporary_tablespace;