set echo off
set head off
set feed off
spool tspc_on.tmp
select 'alter tablespace '||tablespace_name||' online;'
from dba_tablespaces
where tablespace_name not in ('SYSTEM','OUTLN')
  and status = 'OFFLINE';
spool off
set feed on
set echo on
@tspc_on.tmp