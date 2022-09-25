
create or replace package employee_tst
is
  -- Define a row which is NOT found in the database table.
  procedure set_norow(
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
  changed_on_in in employee.changed_on%type default sysdate
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

end employee_tst;
/
