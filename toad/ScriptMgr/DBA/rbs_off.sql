set echo off
set head off
set feed off
spool rbs_off.tmp
select 'alter rollback segment '||segment_name||' offline;'
  from dba_rollback_segs
  where segment_name != 'SYSTEM'
    and status = 'ONLINE';
spool off
set feed on
set echo on
@rbs_off.tmp