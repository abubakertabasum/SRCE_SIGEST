
create or replace package job_tst
is
  -- Define a row which is NOT found in the database table.
  procedure set_norow(
  job_id_in in job.job_id%type,
  function_in in job.function%type default null,
  created_by_in in job.created_by%type default user,
  created_on_in in job.created_on%type default sysdate,
  changed_by_in in job.changed_by%type default user,
  changed_on_in in job.changed_on%type default sysdate
  );

  -- Test unique index related functionality.
  procedure uind(
  maxrows in integer := null
  );

  -- Test primary key related functionality.
  procedure pky(
  maxrows in integer := null
  );

  -- Test foreign key related functionality.
  procedure fky(
  maxrows in integer := null
  );

  -- Test validation (check constraint) functionality.
  procedure validate;

  -- Test lookup functions.
  procedure lookups(
  maxrows in integer := null
  );

  -- Test insert functionality.
  procedure ins(
  maxrows in integer := null
  );

  -- Test update functionality.
  procedure upd(
  maxrows in integer := null
  );

  -- Test delete functionality.
  procedure del(
  maxrows in integer := null
  );

  -- Test the data caching feature.
  procedure load;

end job_tst;
/
