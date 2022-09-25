
create or replace package loc_tst
is
  -- Define a row which is NOT found in the database table.
  procedure set_norow(
  loc_id_in in loc.loc_id%type,
  regional_group_in in loc.regional_group%type default null,
  created_by_in in loc.created_by%type default user,
  created_on_in in loc.created_on%type default sysdate,
  changed_by_in in loc.changed_by%type default user,
  changed_on_in in loc.changed_on%type default sysdate
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

end loc_tst;
/
