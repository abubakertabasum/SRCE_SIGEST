set echo off
set feed off
select owner, trigger_name, status
from all_triggers
where owner not in ('SYS','SYSTEM')
order by owner, trigger_name;