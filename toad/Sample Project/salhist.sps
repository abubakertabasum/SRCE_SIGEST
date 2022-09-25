
create or replace package salhist
is
  --// Data Structures //--
  type pky_rt is record(
  employee_id                   salhist.employee_id%type,
  raise_date                    salhist.raise_date%type);

  --// Cursors //--

  cursor allbypky_cur
  is
  select   employee_id, raise_date, salary, comments, created_by, created_on,
           changed_by, changed_on
  from     salhist
   order by employee_id, raise_date;

  cursor allforpky_cur(
  employee_id_in in salhist.employee_id%type,
  raise_dain in salhist.raise_date%type
  )
  is
  select   employee_id, raise_date, salary, comments, created_by, created_on,
           changed_by, changed_on
  from     salhist
  where    employee_id = allforpky_cur.employee_id_in
  and      raise_date = allforpky_cur.raise_dain;

  --// Specified columns, all rows for this foreign key. //--
  cursor salhist_emp_lookup_all_cur(
  employee_id_in in salhist.employee_id%type
  )
  is
  select   employee_id, raise_date, salary, comments, created_by, created_on,
           changed_by, changed_on
  from     salhist
  where    employee_id = salhist_emp_lookup_all_cur.employee_id_in;

  --// Cursor management procedures //--

  --// Open the cursors with some options. //--
  procedure open_allforpky_cur(
  employee_id_in in salhist.employee_id%type,
  raise_dain in salhist.raise_date%type,
  close_if_open in boolean := true
  );

  procedure open_allbypky_cur(
  close_if_open in boolean := true
  );

  procedure open_salhist_emp_lookup_all_cu(
  employee_id_in in salhist.employee_id%type,
  close_if_open in boolean := true
  );

  --// Close the cursors if they are open. //--
  procedure close_allforpky_cur;
  procedure close_allbypky_cur;
  procedure close_salhist_emp_lookup_all_c;
  procedure closeall;

  --// Analyze presence of primary key: is it NOT NULL? //--

  function isnullpky(
  rec_in in salhist%rowtype
  )
  return boolean;

  function isnullpky(
  rec_in in pky_rt
  )
  return boolean;

  --// Emulate aggregate-level record operations. //--

  function recseq(
  rec1 in salhist%rowtype,
  rec2 in salhist%rowtype
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
  employee_id_in in salhist.employee_id%type,
  raise_dain in salhist.raise_date%type
  )
  return salhist%rowtype;


  --// Count of all rows in table and for each foreign key. //--
  function rowcount
  return integer;
  function pkyrowcount(
  employee_id_in in salhist.employee_id%type,
  raise_dain in salhist.raise_date%type
  )
  return integer;
  function salhist_emp_lookuprowcount(
  employee_id_in in salhist.employee_id%type
  )
  return integer;

  --// Check Constraint Validation //--

  --// Check Constraint: salary > 0 //--
  function sal_positive$chk(
  salary_in in salhist.salary%type
  )
  return boolean;

  --// Check Constraint: CREATED_BY IS NOT NULL //--
  function notnull_created_by$chk(
  created_by_in in salhist.created_by%type
  )
  return boolean;

  --// Check Constraint: CREATED_ON IS NOT NULL //--
  function notnull_created_on$chk(
  created_on_in in salhist.created_on%type
  )
  return boolean;

  --// Check Constraint: CHANGED_BY IS NOT NULL //--
  function notnull_changed_by$chk(
  changed_by_in in salhist.changed_by%type
  )
  return boolean;

  --// Check Constraint: CHANGED_ON IS NOT NULL //--
  function notnull_changed_on$chk(
  changed_on_in in salhist.changed_on%type
  )
  return boolean;
  procedure validate(
  salary_in in salhist.salary%type,
  created_by_in in salhist.created_by%type,
  created_on_in in salhist.created_on%type,
  changed_by_in in salhist.changed_by%type,
  changed_on_in in salhist.changed_on%type,
  record_error in boolean := true
  );

  procedure validate(
  rec_in in salhist%rowtype,
  record_error in boolean := true
  );
  --// Update Processing //--

  procedure reset$frc;

  --// Force setting of NULL values //--

  function salary$frc(
  salary_in in salhist.salary%type default null
  )
  return salhist.salary%type;

  function comments$frc(
  comments_in in salhist.comments%type default null
  )
  return salhist.comments%type;

  function created_by$frc(
  created_by_in in salhist.created_by%type default null
  )
  return salhist.created_by%type;

  function created_on$frc(
  created_on_in in salhist.created_on%type default null
  )
  return salhist.created_on%type;

  function changed_by$frc(
  changed_by_in in salhist.changed_by%type default null
  )
  return salhist.changed_by%type;

  function changed_on$frc(
  changed_on_in in salhist.changed_on%type default null
  )
  return salhist.changed_on%type;

  procedure upd(
  employee_id_in in salhist.employee_id%type,
  raise_dain in salhist.raise_date%type,
  salary_in in salhist.salary%type default null,
  comments_in in salhist.comments%type default null,
  created_by_in in salhist.created_by%type default null,
  created_on_in in salhist.created_on%type default null,
  changed_by_in in salhist.changed_by%type default null,
  changed_on_in in salhist.changed_on%type default null,
  rowcount_out out integer,
  reset_in in boolean default true
  );

  --// Record-based Update //--

  procedure upd(
  rec_in in salhist%rowtype,
  rowcount_out out integer,
  reset_in in boolean default true
  );

  --// Insert Processing //--

  --// Initialize record with default values. //--
  function initrec(
  allnull in boolean := false
  )
  return salhist%rowtype;

  --// Initialize record with default values. //--
  procedure initrec(
  rec_inout in out salhist%rowtype,
  allnull in boolean := false
  );

  procedure ins(
  employee_id_in in salhist.employee_id%type,
  raise_dain in salhist.raise_date%type,
  salary_in in salhist.salary%type default null,
  comments_in in salhist.comments%type default null,
  created_by_in in salhist.created_by%type default user,
  created_on_in in salhist.created_on%type default sysdate,
  changed_by_in in salhist.changed_by%type default user,
  changed_on_in in salhist.changed_on%type default sysdate,
  upd_on_dup in boolean := false
  );

  --// Record-based insert //--
  procedure ins(
  rec_in in salhist%rowtype,
  upd_on_dup in boolean := false
  );

  --// Delete Processing //--
  procedure del(
  employee_id_in in salhist.employee_id%type,
  raise_dain in salhist.raise_date%type,
  rowcount_out out integer
  );

  --// Record-based delete //--
  procedure del(
  rec_in in pky_rt,
  rowcount_out out integer
  );

  procedure del(
  rec_in in salhist%rowtype,
  rowcount_out out integer
  );

  --// Delete all records for this SALHIST_EMP_LOOKUP foreign key. //--
  procedure delby_salhist_emp_lookup(
  employee_id_in in salhist.employee_id%type,
  rowcount_out out integer
  );

  --// Program called by database initialization script to pin the package. //--
  procedure pinme;
end salhist;
/
/*
||------------------------------------------------------
|| PL/Generator Report on Invalid Identifiers
|| for package salhist based on salhist
||------------------------------------------------------
|| The following list shows those identifiers which
|| were invalid (usually because the names were too
|| long). It also shows the corrected name that was
|| used in the code, as well as a description of the
|| purpose that code element serves in the package.
||------------------------------------------------------
|| Invalid: open_salhist_emp_lookup_all_cur
||   New name: open_salhist_emp_lookup_all_cu
||    Purpose: "Opens cursor returning rows for foreign key"
||
|| Invalid: close_salhist_emp_lookup_all_cur
||   New name: close_salhist_emp_lookup_all_c
||    Purpose: "Closes cursor returning rows for foreign key"
||
||------------------------------------------------------
*/
