
create or replace procedure give_bonus(
dept_in in employee.department_id%type,
bonus_in in number
)
/*
|| Give the same bonus to each employee in the
|| specified department, but only if they have
|| been with the company for at least 6 months.
*/
is
  dept_rec department%rowtype;

  fdbk integer;
begin
/* Retrieve all information for the specified department. */
dept_rec := te_department.onerow(dept_in
            );

/* Make sure the department ID was valid. */
if te_department.isnullpky(dept_rec
   ) then
dbms_output.put_line('Invalid department ID specified: ' || dept_in
);
else
/* Display the header. */
dbms_output.put_line('Applying Bonuses of ' || bonus_in || ' to the ' ||
                     dept_rec.name ||
                     ' Department'
);
end if;

/* Make sure that the appropriate cursor is closed. */

te_employee.close_emp_dept_lookup_all_cur;

/* For each employee in the specified department... */
for rec in te_employee.emp_dept_lookup_all_cur(dept_in
           ) loop
if add_months(sysdate,
   -6
   ) > rec.hire_date then
/* Use the encapsulated update procedure
   specifically for this column. */

te_employee.upd$salary(rec.employee_id,
rec.salary + bonus_in,
fdbk
);

/* Make sure the update was successful. */
if fdbk = 1 then
dbms_output.put_line('* Bonus applied to ' || rec.last_name
);
else
dbms_output.put_line('* Unable to apply bonus to ' || rec.last_name
);
end if;
end if;
end loop;
end;
/
