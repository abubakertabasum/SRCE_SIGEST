set echo off
set head off
set feed off
spool tspc_off.tmp
select 'alter tablespace '||tablespace_name||' offline;'
from dba_tablespaces
where tablespace_name not in ('SYSTEM','OUTLN')
  and status = 'ONLINE';
spool off
set feed on
set echo on
@tspc_off.tmp