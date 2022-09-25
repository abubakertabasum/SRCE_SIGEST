set echo off
set feed off
select machine, process, osuser, username,
       schemaname, status, lockwait, sid,
       serial#, module, action
from v$session
where username is not null
  and osuser is not null
order by machine, osuser, username,
         schemaname, status, module;