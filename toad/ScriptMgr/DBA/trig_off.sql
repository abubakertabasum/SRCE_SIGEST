set echo off
set head off
set feed off
spool trig_off.tmp
select 'alter trigger '||owner||'.'||trigger_name||' disable;'
from all_triggers
where owner not in ('SYS','SYSTEM')
  and status = 'ENABLED';
spool off
set feed on
set echo on
@trig_off.tmp