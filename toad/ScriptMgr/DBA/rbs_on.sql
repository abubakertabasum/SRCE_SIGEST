set echo off
set head off
set feed off
spool rbs_on.tmp
select 'alter rollback segment '||segment_name||' online;'
  from dba_rollback_segs
  where segment_name != 'SYSTEM'
    and status = 'OFFLINE';
spool off
set feed on
set echo on
@rbs_on.tmp