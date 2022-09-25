
create or replace package loc
is
  --// Data Structures //--
  type pky_rt is record(
  loc_id                        loc.loc_id%type);

  type i_regional_group_rt is record(
  regional_group                loc.regional_group%type);

  --// Cursors //--

  curso r allbypky_cur
  is
  select   loc_id, regional_group, created_by, created_on, changed_by,
           changed_on
  from     loc
   order by loc_id;

  cursor allforpky_cur(
  loc_id_in in loc.loc_id%type
  )
  is
  select   loc_id, regional_group, created_by, created_on, changed_by,
           changed_on
  from     loc
  where    loc_id = allforpky_cur.loc_id_in;

  --// Cursor management procedures //--

  --// Open the cursors with some options. //--
  procedure open_allforpky_cur(
  loc_id_in in loc.loc_id%type,
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
  rec_in in loc%rowtype
  )
  return boolean;

  function isnullpky(
  rec_in in pky_rt
  )
  return boolean;

  --// Emulate aggregate-level record operations. //--

  function recseq(
  rec1 in loc%rowtype,
  rec2 in loc%rowtype
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
  loc_id_in in loc.loc_id%type
  )
  return loc%rowtype;

  --// For each unique index ... //--

  function i_regional_group$pky(
  regional_group_in in loc.regional_group%type
  )
  return pky_rt;

  function i_regional_group$val(
  loc_id_in in loc.loc_id%type
  )
  return i_regional_group_rt;

  function i_regional_group$row(
  regional_group_in in loc.regional_group%type
  )
  return loc%rowtype;


  --// Count of all rows in table and for each foreign key. //--
  function rowcount
  return integer;
  function pkyrowcount(
  loc_id_in in loc.loc_id%type
  )
  return integer;

  --// Check Constraint Validation //--

  --// Check Constraint: loc_ID IS NOT NULL //--
  function notnull_loc_id$chk(
  loc_id_in in loc.loc_id%type
  )
  return boolean;

  --// Check Constraint: CREATED_BY IS NOT NULL //--
  function notnull_created_by$chk(
  created_by_in in loc.created_by%type
  )
  return boolean;

  --// Check Constraint: CREATED_ON IS NOT NULL //--
  function notnull_created_on$chk(
  created_on_in in loc.created_on%type
  )
  return boolean;

  --// Check Constraint: CHANGED_BY IS NOT NULL //--
  function notnull_changed_by$chk(
  changed_by_in in loc.changed_by%type
  )
  return boolean;

  --// Check Constraint: CHANGED_ON IS NOT NULL //--
  function notnull_changed_on$chk(
  changed_on_in in loc.changed_on%type
  )
  return boolean;
  procedure validate(
  loc_id_in in loc.loc_id%type,
  created_by_in in loc.created_by%type,
  created_on_in in loc.created_on%type,
  changed_by_in in loc.changed_by%type,
  changed_on_in in loc.changed_on%type,
  record_error in boolean := true
  );

  procedure validate(
  rec_in in loc%rowtype,
  record_error in boolean := true
  );
  --// Update Processing //--

  procedure reset$frc;

  --// Force setting of NULL values //--

  function regional_group$frc(
  regional_group_in in loc.regional_group%type default null
  )
  return loc.regional_group%type;

  function created_by$frc(
  created_by_in in loc.created_by%type default null
  )
  return loc.created_by%type;

  function created_on$frc(
  created_on_in in loc.created_on%type default null
  )
  return loc.created_on%type;

  function changed_by$frc(
  changed_by_in in loc.changed_by%type default null
  )
  return loc.changed_by%type;

  function changed_on$frc(
  changed_on_in in loc.changed_on%type default null
  )
  return loc.changed_on%type;

  procedure upd(
  loc_id_in in loc.loc_id%type,
  regional_group_in in loc.regional_group%type default null,
  created_by_in in loc.created_by%type default null,
  created_on_in in loc.created_on%type default null,
  changed_by_in in loc.changed_by%type default null,
  changed_on_in in loc.changed_on%type default null,
  rowcount_out out integer,
  reset_in in boolean default true
  );

  --// Record-based Update //--

  procedure upd(
  rec_in in loc%rowtype,
  rowcount_out out integer,
  reset_in in boolean default true
  );

  --// Insert Processing //--

  --// Initialize record with default values. //--
  function initrec(
  allnull in boolean := false
  )
  return loc%rowtype;

  --// Initialize record with default values. //--
  procedure initrec(
  rec_inout in out loc%rowtype,
  allnull in boolean := false
  );

  procedure ins(
  loc_id_in in loc.loc_id%type,
  regional_group_in in loc.regional_group%type default null,
  created_by_in in loc.created_by%type default user,
  created_on_in in loc.created_on%type default sysdate,
  changed_by_in in loc.changed_by%type default user,
  changed_on_in in loc.changed_on%type default sysdate,
  upd_on_dup in boolean := false
  );

  --// Record-based insert //--
  procedure ins(
  rec_in in loc%rowtype,
  upd_on_dup in boolean := false
  );

  --// Delete Processing //--
  procedure del(
  loc_id_in in loc.loc_id%type,
  rowcount_out out integer
  );

  --// Record-based delete //--
  procedure del(
  rec_in in pky_rt,
  rowcount_out out integer
  );

  procedure del(
  rec_in in loc%rowtype,
  rowcount_out out integer
  );

  --// Program called by database initialization script to pin the package. //--
  procedure pinme;
end loc;
/
