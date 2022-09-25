set echo off
set head off
set feed off
spool tspc_coal.tmp
select 'alter tablespace '||tablespace_name||' coalesce;'
  from dba_tablespaces;
spool off
set feed on
set echo on
@tspc_coal.tmp