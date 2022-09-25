
create or replace package salhist_tst
is
  -- Define a row which is NOT found in the database table.
  procedure set_norow(
  employee_id_in in salhist.employee_id%type,
  raise_dain in salhist.raise_date%type,
  salary_in in salhist.salary%type default null,
  comments_in in salhist.comments%type default null,
  created_by_in in salhist.created_by%type default user,
  created_on_in in salhist.created_on%type default sysdate,
  changed_by_in in salhist.changed_by%type default user,
  changed_on_in in salhist.changed_on%type default sysdate
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

end salhist_tst;
/
