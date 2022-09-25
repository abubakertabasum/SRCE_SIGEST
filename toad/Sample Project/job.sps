
create or replace package job
is
  --// Data Structures //--
  type pky_rt is record(
  job_id                        job.job_id%type);

  type i_job_function_rt is record(
  function                      job.function%type);

  --// Cursors //--

  cursor allbypky_cur
  is
  select   job_id, function, created_by, created_on, changed_by, changed_on
  from     job
   order by job_id;

  cursor allforpky_cur(
  job_id_in in job.job_id%type
  )
  is
  select   job_id, function, created_by, created_on, changed_by, changed_on
  from     job
  where    job_id = allforpky_cur.job_id_in;

  --// Cursor management procedures //--

  --// Open the cursors with some options. //--
  procedure open_allforpky_cur(
  job_id_in in job.job_id%type,
  close_if_open in boolean := true
  );

  procedure open_allbypky_cur(
  close_if_open in boolean := true
  );

  --// Close the cursors if they are open. //--
  procedure close_allforpky_cur;
  procedure close_allbypky_cur;
  procedure closeall;

  --// Analyze presence of primary key: is it NOT NULL? //--

  function isnullpky(
  rec_in in job%rowtype
  )
  return boolean;

  function isnullpky(
  rec_in in pky_rt
  )
  return boolean;

  --// Emulate aggregate-level record operations. //--

  function recseq(
  rec1 in job%rowtype,
  rec2 in job%rowtype
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
  job_id_in in job.job_id%type
  )
  return job%rowtype;

  --// For each unique index ... //--

  function i_job_function$pky(
  function_in in job.function%type
  )
  return pky_rt;

  function i_job_function$val(
  job_id_in in job.job_id%type
  )
  return i_job_function_rt;

  function i_job_function$row(
  function_in in job.function%type
  )
  return job%rowtype;


  --// Count of all rows in table and for each foreign key. //--
  function rowcount
  return integer;
  function pkyrowcount(
  job_id_in in job.job_id%type
  )
  return integer;

  --// Check Constraint Validation //--

  --// Check Constraint: FUNCTION IS NOT NULL //--
  function notnull_function$chk(
  function_in in job.function%type
  )
  return boolean;

  --// Check Constraint: JOB_ID IS NOT NULL //--
  function notnull_job_id$chk(
  job_id_in in job.job_id%type
  )
  return boolean;

  --// Check Constraint: CREATED_BY IS NOT NULL //--
  function notnull_created_by$chk(
  created_by_in in job.created_by%type
  )
  return boolean;

  --// Check Constraint: CREATED_ON IS NOT NULL //--
  function notnull_created_on$chk(
  created_on_in in job.created_on%type
  )
  return boolean;

  --// Check Constraint: CHANGED_BY IS NOT NULL //--
  function notnull_changed_by$chk(
  changed_by_in in job.changed_by%type
  )
  return boolean;

  --// Check Constraint: CHANGED_ON IS NOT NULL //--
  function notnull_changed_on$chk(
  changed_on_in in job.changed_on%type
  )
  return boolean;
  procedure validate(
  job_id_in in job.job_id%type,
  function_in in job.function%type,
  created_by_in in job.created_by%type,
  created_on_in in job.created_on%type,
  changed_by_in in job.changed_by%type,
  changed_on_in in job.changed_on%type,
  record_error in boolean := true
  );

  procedure validate(
  rec_in in job%rowtype,
  record_error in boolean := true
  );
  --// Update Processing //--

  procedure reset$frc;

  --// Force setting of NULL values //--

  function function$frc(
  function_in in job.function%type default null
  )
  return job.function%type;

  function created_by$frc(
  created_by_in in job.created_by%type default null
  )
  return job.created_by%type;

  function created_on$frc(
  created_on_in in job.created_on%type default null
  )
  return job.created_on%type;

  function changed_by$frc(
  changed_by_in in job.changed_by%type default null
  )
  return job.changed_by%type;

  function changed_on$frc(
  changed_on_in in job.changed_on%type default null
  )
  return job.changed_on%type;

  procedure upd(
  job_id_in in job.job_id%type,
  function_in in job.function%type default null,
  created_by_in in job.created_by%type default null,
  created_on_in in job.created_on%type default null,
  changed_by_in in job.changed_by%type default null,
  changed_on_in in job.changed_on%type default null,
  rowcount_out out integer,
  reset_in in boolean default true
  );

  --// Record-based Update //--

  procedure upd(
  rec_in in job%rowtype,
  rowcount_out out integer,
  reset_in in boolean default true
  );

  --// Insert Processing //--

  --// Initialize record with default values. //--
  function initrec(
  allnull in boolean := false
  )
  return job%rowtype;

  --// Initialize record with default values. //--
  procedure initrec(
  rec_inout in out job%rowtype,
  allnull in boolean := false
  );

  procedure ins(
  job_id_in in job.job_id%type,
  function_in in job.function%type default null,
  created_by_in in job.created_by%type default user,
  created_on_in in job.created_on%type default sysdate,
  changed_by_in in job.changed_by%type default user,
  changed_on_in in job.changed_on%type default sysdate,
  upd_on_dup in boolean := false
  );

  --// Record-based insert //--
  procedure ins(
  rec_in in job%rowtype,
  upd_on_dup in boolean := false
  );

  --// Delete Processing //--
  procedure del(
  job_id_in in job.job_id%type,
  rowcount_out out integer
  );

  --// Record-based delete //--
  procedure del(
  rec_in in pky_rt,
  rowcount_out out integer
  );

  procedure del(
  rec_in in job%rowtype,
  rowcount_out out integer
  );

  --// Program called by database initialization script to pin the package. //--
  procedure pinme;
end job;
/
