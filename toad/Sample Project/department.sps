
create or replace package department
is
  --// Data Structures //--
  type pky_rt is record(
  

  department_id department.department_id%type);

  type i_department_name_rt is record(
  name department.name%type);
  --// Cursors //--
  cursor allbypky_cur
  is  select   department_id, name, loc_id, created_by, created_on, changed_by,
           changed_on  from     department   order by department_id;
  cursor allforpky_cur(department_id_in in department.department_id%type)
  is  select   department_id, name, loc_id, created_by, created_on, changed_by,
           changed_on  from department  where department_id = allforpky_cur.department_id_in;
  --// Specified columns, all rows for this foreign key. //--
  cursor dept_loc_lookup_all_cur(loc_id_in in department.loc_id%type)
  is select   department_id, name, loc_id, created_by, created_on, changed_by,
           changed_on
  from     department where    loc_id = dept_loc_lookup_all_cur.loc_id_in;
  --// Cursor management procedures //--

  --// Open the cursors with some options. //--
  procedure open_allforpky_cur(department_id_in in department.department_id%type,
  close_if_open in boolean := true
  );
  procedure open_allbypky_cur(close_if_open in boolean := true);
  procedure open_dept_loc_lookup_all_cur(loc_id_in in department.loc_id%type,
  close_if_open in boolean := true
  );
  --// Close the cursors if they are open. //--
  procedure close_allforpky_cur;
  procedure close_allbypky_cur;
  procedure close_dept_loc_lookup_all_cur;
  procedure closeall;
  --// Analyze presence of primary key: is it NOT NULL? //--
  function isnullpky(rec_in in department%rowtype) return boolean;
  function isnullpky(rec_in in pky_rt)
  return boolean;
  --// Emulate aggregate-level record operations. //--
  function recseq(rec1 in department%rowtype, rec2 in department%rowtype)
  return boolean;
  function recseq(rec1 in pky_rt, rec2 in pky_rt)
  return boolean;
  --// Fetch Data //--
  --// Fetch one row of data for a primary key. //--
  function onerow(department_id_in in department.department_id%type)
  return department%rowtype;
  --// For each unique index ... //--
  function i_department_name$pky(name_in in department.name%type) return pky_rt;
  function i_department_name$val(department_id_in in department.department_id%type
  )
  return i_department_name_rt;
  function i_department_name$row(name_in in department.name%type)
  return department%rowtype;
  --// Count of all rows in table and for each foreign key. //--
  function rowcount return integer;
  function pkyrowcount(department_id_in in department.department_id%type)
  return integer;
  function dept_loc_lookuprowcount(loc_id_in in department.loc_id%type)
  return integer;
  --// Check Constraint Validation //--
  --// Check Constraint: DEPARTMENT_ID IS NOT NULL //--
  function notnull_department_id$chk(department_id_in in department.department_id%type
  )
  return boolean;
  --// Check Constraint: CREATED_BY IS NOT NULL //--
  function notnull_created_by$chk(created_by_in in department.created_by%type)
  return boolean;
  --// Check Constraint: CREATED_ON IS NOT NULL //--
  function notnull_created_on$chk(created_on_in in department.created_on%type)
  return boolean;
  --// Check Constraint: CHANGED_BY IS NOT NULL //--
  function notnull_changed_by$chk(changed_by_in in department.changed_by%type) return boolean;
  --// Check Constraint: CHANGED_ON IS NOT NULL //--
  function notnull_changed_on$chk(changed_on_in in department.changed_on%type)
  return boolean;
  procedure validate(department_id_in in department.department_id%type,
  created_by_in in department.created_by%type, created_on_in in department.created_on%type,
  changed_by_in in department.changed_by%type, changed_on_in in department.changed_on%type,
  record_error in boolean := true
  );
  procedure validate(rec_in in department%rowtype,
  record_error in boolean := true
  );
  --// Update Processing //--
  procedure reset$frc;
  --// Force setting of NULL values //--
  function name$frc(name_in in department.name%type default null)
  return department.name%type;
  function loc_id$frc(loc_id_in in department.loc_id%type default null)
  return department.loc_id%type;
  function created_by$frc(created_by_in in department.created_by%type
  default null
  )
  return department.created_by%type;
  function created_on$frc(created_on_in in department.created_on%type
  default null
  )
  return department.created_on%type;
  function changed_by$frc(changed_by_in in department.changed_by%type
  default null
  )
  return department.changed_by%type;
  function changed_on$frc(changed_on_in in department.changed_on%type
  default null
  )
  return department.changed_on%type;
  procedure upd(department_id_in in department.department_id%type, name_in in department.name%type default null,
  loc_id_in in department.loc_id%type default null, created_by_in in department.created_by%type default null,
  created_on_in in department.created_on%type default null, changed_by_in in department.changed_by%type default null,
  changed_on_in in department.changed_on%type default null, rowcount_out out integer, reset_in in boolean default true
  );
  --// Record-based Update //--
  procedure upd(rec_in in department%rowtype, rowcount_out out integer,
  reset_in in boolean default true
  );
  --// Insert Processing //--
  --// Initialize record with default values. //--
  function initrec(allnull in boolean := false) return department%rowtype;
  --// Initialize record with default values. //--
  procedure initrec(rec_inout in out department%rowtype, allnull in boolean := false
  );
  procedure ins(department_id_in in department.department_id%type,
  name_in in department.name%type default null,
  loc_id_in in department.loc_id%type default null,
  created_by_in in department.created_by%type default user,
  created_on_in in department.created_on%type default sysdate,
  changed_by_in in department.changed_by%type default user,
  changed_on_in in department.changed_on%type default sysdate,
  upd_on_dup in boolean := false
  );
  --// Record-based insert //--
  procedure ins(rec_in in department%rowtype, upd_on_dup in boolean := false);
  --// Delete Processing //--
  procedure del(department_id_in in department.department_id%type,
  rowcount_out out integer
  );
  --// Record-based delete //--
  procedure del(rec_in in pky_rt, rowcount_out out integer);
  procedure del(rec_in in department%rowtype, rowcount_out out integer);
  --// Delete all records for this DEPT_LOC_LOOKUP foreign key. //--
  procedure delby_dept_loc_lookup(loc_id_in in department.loc_id%type,
  rowcount_out out integer
  );
  --// Program called by database initialization script to pin the package. //--
  procedure pinme;
end department;
/
