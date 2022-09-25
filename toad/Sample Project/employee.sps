
create or replace package employee
is
  --// Data Structures //--
  type pky_rt is record(
  employee_id                   employee.employee_id%type);

  type i_employee_name_rt is record(
  
  last_name                     employee.last_name%type,
  first_name                    employee.first_name%type,
  middle_initial                employee.middle_initial%type);

  --// Cursors //--

  cursor allbypky_cur
  is
  select   employee_id, last_name, first_name, middle_initial, job_id,
           manager_id, hire_date, salary, commission, department_id, empno,
           ename, created_by, created_on, changed_by, changed_on
  from     employee
   order by employee_id;

  cursor allforpky_cur(
  employee_id_in in employee.employee_id%type
  )
  is
  select   employee_id, last_name, first_name, middle_initial, job_id,
           manager_id, hire_date, salary, commission, department_id, empno,
           ename, created_by, created_on, changed_by, changed_on
  from     employee
  where    employee_id = allforpky_cur.employee_id_in;

  --// Specified columns, all rows for this foreign key. //--
  cursor emp_dept_lookup_all_cur(
  department_id_in in employee.department_id%type
  )
  is
  select   employee_id, last_name, first_name, middle_initial, job_id,
           manager_id, hire_date, salary, commission, department_id, empno,
           ename, created_by, created_on, changed_by, changed_on
  from     employee
  where    department_id = emp_dept_lookup_all_cur.department_id_in;

  --// Specified columns, all rows for this foreign key. //--
  cursor emp_job_lookup_all_cur(
  job_id_in in employee.job_id%type
  )
  is
  select   employee_id, last_name, first_name, middle_initial, job_id,
           manager_id, hire_date, salary, commission, department_id, empno,
           ename, created_by, created_on, changed_by, changed_on
  from     employee
  where    job_id = emp_job_lookup_all_cur.job_id_in;

  --// Specified columns, all rows for this foreign key. //--
  cursor emp_mgr_lookup_all_cur(
  manager_id_in in employee.manager_id%type
  )
  is
  select   employee_id, last_name, first_name, middle_initial, job_id,
           manager_id, hire_date, salary, commission, department_id, empno,
           ename, created_by, created_on, changed_by, changed_on
  from     employee
  where    manager_id = emp_mgr_lookup_all_cur.manager_id_in;

  --// Cursor management procedures //--

  --// Open the cursors with some options. //--
  procedure open_allforpky_cur(
  employee_id_in in employee.employee_id%type,
  close_if_open in boolean := true
  );

  procedure open_allbypky_cur(
  close_if_open in boolean := true
  );

  procedure open_emp_dept_lookup_all_cur(
  department_id_in in employee.department_id%type,
  close_if_open in boolean := true
  );

  procedure open_emp_job_lookup_all_cur(
  job_id_in in employee.job_id%type,
  close_if_open in boolean := true
  );

  procedure open_emp_mgr_lookup_all_cur(
  manager_id_in in employee.manager_id%type,
  close_if_open in boolean := true
  );

  --// Close the cursors if they are open. //--
  procedure close_allforpky_cur;
  procedure close_allbypky_cur;
  procedure close_emp_dept_lookup_all_cur;
  procedure close_emp_job_lookup_all_cur;
  procedure close_emp_mgr_lookup_all_cur;
  procedure closeall;

  --// Analyze presence of primary key: is it NOT NULL? //--

  function isnullpky(
  rec_in in employee%rowtype
  )
  return boolean;

  function isnullpky(
  rec_in in pky_rt
  )
  return boolean;

  --// Emulate aggregate-level record operations. //--

  function recseq(
  rec1 in employee%rowtype,
  rec2 in employee%rowtype
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
  employee_id_in in employee.employee_id%type
  )
  return employee%rowtype;

  --// For each unique index ... //--

  function i_employee_name$pky(
  last_name_in in employee.last_name%type,
  first_name_in in employee.first_name%type,
  middle_initial_in in employee.middle_initial%type
  )
  return pky_rt;

  function i_employee_name$val(
  employee_id_in in employee.employee_id%type
  )
  return i_employee_name_rt;

  function i_employee_name$row(
  last_name_in in employee.last_name%type,
  first_name_in in employee.first_name%type,
  middle_initial_in in employee.middle_initial%type
  )
  return employee%rowtype;


  --// Count of all rows in table and for each foreign key. //--
  function rowcount
  return integer;
  function pkyrowcount(
  employee_id_in in employee.employee_id%type
  )
  return integer;
  function emp_dept_lookuprowcount(
  department_id_in in employee.department_id%type
  )
  return integer;
  function emp_job_lookuprowcount(
  job_id_in in employee.job_id%type
  )
  return integer;
  function emp_mgr_lookuprowcount(
  manager_id_in in employee.manager_id%type
  )
  return integer;

  --// Check Constraint Validation //--

  --// Check Constraint: DEPARTMENT_ID > 0 AND (salary > 0 OR salary IS NULL) //--
  function employee$complex$chk(
  department_id_in in employee.department_id%type,
  salary_in in employee.salary%type
  )
  return boolean;

  --// Check Constraint: DEPARTMENT_ID IS NOT NULL //--
  function notnull_department_id$chk(
  department_id_in in employee.department_id%type
  )
  return boolean;

  --// Check Constraint: EMPLOYEE_ID IS NOT NULL //--
  function notnull_employee_id$chk(
  employee_id_in in employee.employee_id%type
  )
  return boolean;

  --// Check Constraint: HIRE_DATE IS NOT NULL //--
  function notnull_hire_date$chk(
  hire_dain in employee.hire_date%type
  )
  return boolean;

  --// Check Constraint: CREATED_BY IS NOT NULL //--
  function notnull_created_by$chk(
  created_by_in in employee.created_by%type
  )
  return boolean;

  --// Check Constraint: CREATED_ON IS NOT NULL //--
  function notnull_created_on$chk(
  created_on_in in employee.created_on%type
  )
  return boolean;

  --// Check Constraint: CHANGED_BY IS NOT NULL //--
  function notnull_changed_by$chk(
  changed_by_in in employee.changed_by%type
  )
  return boolean;

  --// Check Constraint: CHANGED_ON IS NOT NULL //--
  function notnull_changed_on$chk(
  changed_on_in in employee.changed_on%type
  )
  return boolean;
  procedure validate(
  employee_id_in in employee.employee_id%type,
  hire_dain in employee.hire_date%type,
  salary_in in employee.salary%type,
  department_id_in in employee.department_id%type,
  created_by_in in employee.created_by%type,
  created_on_in in employee.created_on%type,
  changed_by_in in employee.changed_by%type,
  changed_on_in in employee.changed_on%type,
  record_error in boolean := true
  );

  procedure validate(
  rec_in in employee%rowtype,
  record_error in boolean := true
  );
  --// Update Processing //--

  procedure reset$frc;

  --// Force setting of NULL values //--

  function last_name$frc(
  last_name_in in employee.last_name%type default null
  )
  return employee.last_name%type;

  function first_name$frc(
  first_name_in in employee.first_name%type default null
  )
  return employee.first_name%type;

  function middle_initial$frc(
  middle_initial_in in employee.middle_initial%type default null
  )
  return employee.middle_initial%type;

  function job_id$frc(
  job_id_in in employee.job_id%type default null
  )
  return employee.job_id%type;

  function manager_id$frc(
  manager_id_in in employee.manager_id%type default null
  )
  return employee.manager_id%type;

  function hire_date$frc(
  hire_dain in employee.hire_date%type default null
  )
  return employee.hire_date%type;

  function salary$frc(
  salary_in in employee.salary%type default null
  )
  return employee.salary%type;

  function commission$frc(
  commission_in in employee.commission%type default null
  )
  return employee.commission%type;

  function department_id$frc(
  department_id_in in employee.department_id%type default null
  )
  return employee.department_id%type;

  function empno$frc(
  empno_in in employee.empno%type default null
  )
  return employee.empno%type;

  function ename$frc(
  ename_in in employee.ename%type default null
  )
  return employee.ename%type;

  function created_by$frc(
  created_by_in in employee.created_by%type default null
  )
  return employee.created_by%type;

  function created_on$frc(
  created_on_in in employee.created_on%type default null
  )
  return employee.created_on%type;

  function changed_by$frc(
  changed_by_in in employee.changed_by%type default null
  )
  return employee.changed_by%type;

  function changed_on$frc(
  changed_on_in in employee.changed_on%type default null
  )
  return employee.changed_on%type;

  procedure upd(
  employee_id_in in employee.employee_id%type,
  last_name_in in employee.last_name%type default null,
  first_name_in in employee.first_name%type default null,
  middle_initial_in in employee.middle_initial%type default null,
  job_id_in in employee.job_id%type default null,
  manager_id_in in employee.manager_id%type default null,
  hire_dain in employee.hire_date%type default null,
  salary_in in employee.salary%type default null,
  commission_in in employee.commission%type default null,
  department_id_in in employee.department_id%type default null,
  empno_in in employee.empno%type default null,
  ename_in in employee.ename%type default null,
  created_by_in in employee.created_by%type default null,
  created_on_in in employee.created_on%type default null,
  changed_by_in in employee.changed_by%type default null,
  changed_on_in in employee.changed_on%type default null,
  rowcount_out out integer,
  reset_in in boolean default true
  );

  --// Record-based Update //--

  procedure upd(
  rec_in in employee%rowtype,
  rowcount_out out integer,
  reset_in in boolean default true
  );

  --// Insert Processing //--

  --// Initialize record with default values. //--
  function initrec(
  allnull in boolean := false
  )
  return employee%rowtype;

  --// Initialize record with default values. //--
  procedure initrec(
  rec_inout in out employee%rowtype,
  allnull in boolean := false
  );

  procedure ins(
  employee_id_in in employee.employee_id%type,
  last_name_in in employee.last_name%type default null,
  first_name_in in employee.first_name%type default null,
  middle_initial_in in employee.middle_initial%type default null,
  job_id_in in employee.job_id%type default null,
  manager_id_in in employee.manager_id%type default null,
  hire_dain in employee.hire_date%type default sysdate,
  salary_in in employee.salary%type default null,
  commission_in in employee.commission%type default null,
  department_id_in in employee.department_id%type default null,
  empno_in in employee.empno%type default null,
  ename_in in employee.ename%type default null,
  created_by_in in employee.created_by%type default user,
  created_on_in in employee.created_on%type default sysdate,
  changed_by_in in employee.changed_by%type default user,
  changed_on_in in employee.changed_on%type default sysdate,
  upd_on_dup in boolean := false
  );

  --// Record-based insert //--
  procedure ins(
  rec_in in employee%rowtype,
  upd_on_dup in boolean := false
  );

  --// Delete Processing //--
  procedure del(
  employee_id_in in employee.employee_id%type,
  rowcount_out out integer
  );

  --// Record-based delete //--
  procedure del(
  rec_in in pky_rt,
  rowcount_out out integer
  );

  procedure del(
  rec_in in employee%rowtype,
  rowcount_out out integer
  );

  --// Delete all records for this EMP_DEPT_LOOKUP foreign key. //--
  procedure delby_emp_dept_lookup(
  department_id_in in employee.department_id%type,
  rowcount_out out integer
  );

  --// Delete all records for this EMP_JOB_LOOKUP foreign key. //--
  procedure delby_emp_job_lookup(
  job_id_in in employee.job_id%type,
  rowcount_out out integer
  );

  --// Delete all records for this EMP_MGR_LOOKUP foreign key. //--
  procedure delby_emp_mgr_lookup(
  manager_id_in in employee.manager_id%type,
  rowcount_out out integer
  );

  --// Program called by database initialization script to pin the package. //--
  procedure pinme;
end employee;
/
