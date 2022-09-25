set echo off
set head off
set feed off
spool trig_on.tmp
select 'alter trigger '||owner||'.'||trigger_name||' enable;'
from all_triggers
where owner not in ('SYS','SYSTEM')
  and status = 'DISABLED';
spool off
set feed on
set echo on
@trig_on.tmp