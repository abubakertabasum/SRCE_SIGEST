Select level, SubStr( lpad('    ',2*(Level-1)) || operation  || '   ' || 
object_name || '   ' || options || '   ' || 
decode(id, null , ' ',  decode(position, null,' ', 'Cost = ' || position) ),1,100)  
 || '  '  || nvl(other_tag, ' ') Operation 
from TOAD_PLAN_TABLE 
start with id = 0 and statement_id = :STATEMENT_ID 
connect by 
prior id = parent_id and statement_id = :STATEMENT_ID


