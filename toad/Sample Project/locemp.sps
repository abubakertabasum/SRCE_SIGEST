
create or replace package locemp
is
  --// Data Structures //--
  type pky_rt is record(
  employee_id                   locemp.employee_id%type,
  loc_id                        locemp.loc_id%type);

  --// Cursors //--

  cursor allbypky_cur
  is
  select   employee_id, loc_id, created_by, created_on, changed_by,
           changed_on
  from     locemp
   order by employee_id, loc_id;

  cursor allforpky_cur(
  employee_id_in in locemp.employee_id%type,
  loc_id_in in locemp.loc_id%type
  )
  is
  select   employee_id, loc_id, created_by, created_on, changed_by,
           changed_on
  from     locemp
  where    employee_id = allforpky_cur.employee_id_in
  and      loc_id = allforpky_cur.loc_id_in;

  --// Specified columns, all rows for this foreign key. //--
  cursor le_emp_lookup_all_cur(
  employee_id_in in locemp.employee_id%type
  )
  is
  select   employee_id, loc_id, created_by, created_on, changed_by,
           changed_on
  from     locemp
  where    employee_id = le_emp_lookup_all_cur.employee_id_in;

  --// Specified columns, all rows for this foreign key. //--
  cursor le_loc_lookup_all_cur(
  loc_id_in in locemp.loc_id%type
  )
  is
  select   employee_id, loc_id, created_by, created_on, changed_by,
           changed_on
  from     locemp
  where    loc_id = le_loc_lookup_all_cur.loc_id_in;

  --// Cursor management procedures //--

  --// Open the cursors with some options. //--
  procedure open_allforpky_cur(
  employee_id_in in locemp.employee_id%type,
  loc_id_in in locemp.loc_id%type,
  close_if_open in boolean := true
  );

  procedure open_allbypky_cur(
  close_if_open in boolean := true
  );

  procedure open_le_emp_lookup_all_cur(
  employee_id_in in locemp.employee_id%type,
  close_if_open in boolean := true
  );

  procedure open_le_loc_lookup_all_cur(
  loc_id_in in locemp.loc_id%type,
  close_if_open in boolean := true
  );

  --// Close the cursors if they are open. //--
  procedure close_allforpky_cur;
  procedure close_allbypky_cur;
  procedure close_le_emp_lookup_all_cur;
  procedure close_le_loc_lookup_all_cur;
  procedure closeall;

  --// Analyze presence of primary key: is it NOT NULL? //--

  function isnullpky(
  rec_in in locemp%rowtype
  )
  return boolean;

  function isnullpky(
  rec_in in pky_rt
  )
  return boolean;

  --// Emulate aggregate-level record operations. //--

  function recseq(
  rec1 in locemp%rowtype,
  rec2 in locemp%rowtype
  )
  return boolean;

  function recseq(
  rec1 in pky_rt,
  rec2 in pky_rt
  )
  return boolean;

  --// Fetch Data //--

  --// Fetch one row of data for a primary key. //--
  function onerow(
  employee_id_in in locemp.employee_id%type,
  loc_id_in in locemp.loc_id%type
  )
  return locemp%rowtype;


  --// Count of all rows in table and for each foreign key. //--
  function rowcount
  return integer;
  function pkyrowcount(
  employee_id_in in locemp.employee_id%type,
  loc_id_in in locemp.loc_id%type
  )
  return integer;
  function le_emp_lookuprowcount(
  employee_id_in in locemp.employee_id%type
  )
  return integer;
  function le_loc_lookuprowcount(
  loc_id_in in locemp.loc_id%type
  )
  return integer;

  --// Check Constraint Validation //--

  --// Check Constraint: CREATED_BY IS NOT NULL //--
  function notnull_created_by$chk(
  created_by_in in locemp.created_by%type
  )
  return boolean;

  --// Check Constraint: CREATED_ON IS NOT NULL //--
  function notnull_created_on$chk(
  created_on_in in locemp.created_on%type
  )
  return boolean;

  --// Check Constraint: CHANGED_BY IS NOT NULL //--
  function notnull_changed_by$chk(
  changed_by_in in locemp.changed_by%type
  )
  return boolean;

  --// Check Constraint: CHANGED_ON IS NOT NULL //--
  function notnull_changed_on$chk(
  changed_on_in in locemp.changed_on%type
  )
  return boolean;
  procedure validate(
  created_by_in in locemp.created_by%type,
  created_on_in in locemp.created_on%type,
  changed_by_in in locemp.changed_by%type,
  changed_on_in in locemp.changed_on%type,
  record_error in boolean := true
  );

  procedure validate(
  rec_in in locemp%rowtype,
  record_error in boolean := true
  );
  --// Update Processing //--

  procedure reset$frc;

  --// Force setting of NULL values //--

  function created_by$frc(
  created_by_in in locemp.created_by%type default null
  )
  return locemp.created_by%type;

  function created_on$frc(
  created_on_in in locemp.created_on%type default null
  )
  return locemp.created_on%type;

  function changed_by$frc(
  changed_by_in in locemp.changed_by%type default null
  )
  return locemp.changed_by%type;

  function changed_on$frc(
  changed_on_in in locemp.changed_on%type default null
  )
  return locemp.changed_on%type;

  procedure upd(
  employee_id_in in locemp.employee_id%type,
  loc_id_in in locemp.loc_id%type,
  created_by_in in locemp.created_by%type default null,
  created_on_in in locemp.created_on%type default null,
  changed_by_in in locemp.changed_by%type default null,
  changed_on_in in locemp.changed_on%type default null,
  rowcount_out out integer,
  reset_in in boolean default true
  );

  --// Record-based Update //--

  procedure upd(
  rec_in in locemp%rowtype,
  rowcount_out out integer,
  reset_in in boolean default true
  );

  --// Insert Processing //--

  --// Initialize record with default values. //--
  function initrec(
  allnull in boolean := false
  )
  return locemp%rowtype;

  --// Initialize record with default values. //--
  procedure initrec(
  rec_inout in out locemp%rowtype,
  allnull in boolean := false
  );

  procedure ins(
  employee_id_in in locemp.employee_id%type,
  loc_id_in in locemp.loc_id%type,
  created_by_in in locemp.created_by%type default user,
  created_on_in in locemp.created_on%type default sysdate,
  changed_by_in in locemp.changed_by%type default user,
  changed_on_in in locemp.changed_on%type default sysdate,
  upd_on_dup in boolean := false
  );

  --// Record-based insert //--
  procedure ins(
  rec_in in locemp%rowtype,
  upd_on_dup in boolean := false
  );

  --// Delete Processing //--
  procedure del(
  employee_id_in in locemp.employee_id%type,
  loc_id_in in locemp.loc_id%type,
  rowcount_out out integer
  );

  --// Record-based delete //--
  procedure del(
  rec_in in pky_rt,
  rowcount_out out integer
  );

  procedure del(
  rec_in in locemp%rowtype,
  rowcount_out out integer
  );

  --// Delete all records for this LE_EMP_LOOKUP foreign key. //--
  procedure delby_le_emp_lookup(
  employee_id_in in locemp.employee_id%type,
  rowcount_out out integer
  );

  --// Delete all records for this LE_LOC_LOOKUP foreign key. //--
  procedure delby_le_loc_lookup(
  loc_id_in in locemp.loc_id%type,
  rowcount_out out integer
  );

  --// Program called by database initialization script to pin the package. //--
  procedure pinme;
end locemp;
/
