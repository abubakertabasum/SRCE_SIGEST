Rem ================
Rem ToadProfiler.sql
Rem ================
Rem 
Rem --------
Rem Purpose:
Rem --------
Rem Creates the tables and package used for client-side profiler analysis
Rem Modifications to Oracle proftab.sql for use with Toad.
Rem 
Rem --------------
Rem INSTALL NOTES:
Rem --------------
Rem Q: What schema do I install these Profiler objects into?
Rem 
Rem We suggest that you run this script in the TOAD schema.  Alternatively,
Rem you could install these objects in the SYSTEM schema.  If you elect to
Rem install these objects in a private user schema, do NOT run the GRANTS
Rem at the bottom of the script.
Rem 
Rem Usage of these objects is not fully qualified, e.g., 
Rem     [insert into plsql_profiler_data ...]
Rem It relies on the objects to exist in the same user schema or be resolved
Rem via public synonyms to   toad.plsql_profiler_data, 
Rem                        system.plsql_profiler_data, etc.
Rem 
Rem If you have plsql_profiler_data locally and publicly, the profiler will
Rem not operate properly.
Rem
Rem Q: I ran the script but the TOAD_PROFILER package contains errors.
Rem 
Rem Go to the Editor Options window, General Options, Display Options, and
Rem uncheck "Apply Capitalization Effects".  When PL/SQL is wrapped, it is
Rem assumed that the code will remain unchanged when compiling.  The wrapped
Rem code contains Oracle Reserved words, SYS view names, etc. in ASCII, which
Rem get syntax highlighted and capitalization effects applied when you bring 
Rem them into the SQL Edit window.
Rem 
Rem Also, check to see if any of these profiler objects (including TABLES,
Rem TRIGGERS, SEQUENCES, PACKAGES, and SYNONYMS) exist in two or more
Rem schemas at the same time.  Migrate them to only one schema.
Rem 
Rem ----------
Rem Revisions:
Rem ----------  
Rem   (MM/DD/YY)
Rem   09/09/1999 - Added plsql_profiler_data.text column to hold
Rem                          source for versioning.  Modified rollup_unit to
Rem                          update text for procedures and triggers.
Rem   08/18/1999 - Added run_user, run_proc, and trigger
Rem   07/26/1999 - Added delete cascade constraints
Rem   08/24/1999 - Added public synonyms and grants to public
Rem                          so that these objects can be installed to
Rem                          a single common schema, e.g., TOAD.
Rem   01/13/2000 (1). Added install notes about which schema to install
Rem                          these Profiler objects into.
Rem                          (2). Rewrapped the code with the default capitalization
Rem                          effects to avoid errors when bringing in wrapped code
Rem                          into the SQL editor for execution.
Rem   05/24/2000 - Added new columns to plsql_profiler_runs to implement
Rem                            changes in 8.1.6 (run_owner, related_run, run_comment1)
Rem                            Dropped trigger BI_PLSQL_PROFILER_RUNS - the parsing
Rem                            of the procedure from the comment is now performed in
Rem                            TOAD_PROFILER.ROLLUP_RUN.
Rem                          NOTE: The legacy column RUN_USER should be dropped and
Rem                          references to it removed from TOAD_PROFILER package with
Rem                          the next commercial release of Toad!
Rem   08/29/2000 - Added exception handler for cases where trigger source
Rem                            is unavailable (no CREATE ANY TRIGGER privilege)
Rem   11/28/2000 - Finally dropped RUN_USER legacy column
Rem   05/15/2001 - Modified ROLLUP_UNIT to allow for no data in
Rem                            plsql_profiler_data
Rem
Rem WARNING: This script destroys all existing profiler data!
Rem

DROP TRIGGER bi_plsql_profiler_runs;
DROP TABLE plsql_profiler_data cascade constraints;
DROP TABLE plsql_profiler_units cascade constraints;
DROP TABLE plsql_profiler_runs cascade constraints;
DROP sequence plsql_profiler_runnumber;
DROP PUBLIC SYNONYM plsql_profiler_runnumber;
DROP PACKAGE toad_profiler;
DROP PUBLIC SYNONYM plsql_profiler_data;
DROP PUBLIC SYNONYM plsql_profiler_units;
DROP PUBLIC SYNONYM plsql_profiler_runs;
DROP PUBLIC SYNONYM toad_profiler;

CREATE TABLE plsql_profiler_runs
(
  runid           NUMBER primary key,  -- unique run identifier,
                                       -- from plsql_profiler_runnumber
  related_run     NUMBER,              -- runid of related run (for client
                                       --   server correlation)
  run_owner       VARCHAR2(32),        -- user that executed the procedure
  run_proc        VARCHAR2(256),       -- procedure that was executed
  run_date        DATE,                -- start time of run
  run_comment     VARCHAR2(2047),      -- user provided comment for this run
  run_total_time  NUMBER,              -- elapsed time for this run
  run_system_info VARCHAR2(2047),      -- currently unused
  run_comment1    VARCHAR2(256),       -- additional comment
  spare1          VARCHAR2(256)        -- unused
);

COMMENT ON TABLE plsql_profiler_runs IS
        'Run-specific information for the PL/SQL profiler';

CREATE TABLE plsql_profiler_units
(
  runid              NUMBER references plsql_profiler_runs ON DELETE cascade,
  unit_number        NUMBER,           -- internally generated library unit #
  unit_type          VARCHAR2(32),     -- library unit type
  unit_owner         VARCHAR2(32),     -- library unit owner name
  unit_name          VARCHAR2(32),     -- library unit name
  -- timestamp on library unit, can be used to detect changes to
  -- unit between runs
  unit_timestamp     DATE,
  total_time         NUMBER DEFAULT 0 NOT NULL,
  spare1             NUMBER,           -- unused
  spare2             NUMBER,           -- unused
  primary key (runid, unit_number)
);

COMMENT ON TABLE plsql_profiler_units IS
        'Information about each library unit in a run';

CREATE TABLE plsql_profiler_data
(
  runid           NUMBER,           -- unique (generated) run identifier
  unit_number     NUMBER,           -- internally generated library unit #
  line#           NUMBER NOT NULL,  -- line number in unit
  text            VARCHAR2(4000),   -- source for the line
  total_occur     NUMBER,           -- number of times line was executed
  total_time      NUMBER,           -- total time spent executing line
  min_time        NUMBER,           -- minimum execution time for this line
  max_time        NUMBER,           -- maximum execution time for this line
  spare1          NUMBER,           -- unused
  spare2          NUMBER,           -- unused
  spare3          NUMBER,           -- unused
  spare4          NUMBER,           -- unused
  primary key (runid, unit_number, line#),
  foreign key (runid, unit_number) references plsql_profiler_units  ON DELETE cascade
);

COMMENT ON TABLE plsql_profiler_data IS
        'Accumulated data from all profiler runs';

CREATE OR REPLACE package toad_profiler is

  procedure rollup_unit(run_number IN number, UnitNumber IN number,
    UnitType IN varchar2, UnitOwner IN varchar2, UnitName IN varchar2);

  procedure rollup_run(run_number IN number);

  procedure rollup_all_runs;

end toad_profiler;
/

CREATE OR REPLACE package body toad_profiler is
  -- compute the total time spent executing this unit - the sum of the
  -- time spent executing lines in this unit (for this run)
  --
  procedure rollup_unit(run_number IN number, UnitNumber IN number,
    UnitType IN varchar2, UnitOwner IN varchar2, UnitName IN varchar2) is
  --
  TYPE TSourceTable IS TABLE OF VARCHAR2(4000) INDEX BY BINARY_INTEGER;
  SourceTable TSourceTable;
  TriggerBody long;
  FoundTriggerSource boolean;
  Cnt number;
  LnStart number;
  LnEnd   number;
  Pos number;
  vText varchar2(4000);
  IsWrapped boolean;
  TotalTime number;
  --
  -- Select the lines for the unit to find source code
  cursor cLines(run_number number, UnitNumber number) is
    select line# from plsql_profiler_data
    where runid = run_number and unit_number = UnitNumber;
  begin
    select sum(total_time) into TotalTime
      from plsql_profiler_data
      where runid = run_number and unit_number = UnitNumber;

    if TotalTime IS NULL then
      TotalTime := 0;
    end if;

    update plsql_profiler_units set total_time = TotalTime
    where runid = run_number and unit_number = UnitNumber;
    --
    -- Get trigger source into index-by table
    if UnitType = 'TRIGGER' then
      begin
        FoundTriggerSource := True;
        select trigger_body into TriggerBody
          from all_triggers where owner = UnitOwner and trigger_name = UnitName;
      exception
        when NO_DATA_FOUND then
          FoundTriggerSource := False;
      end;
      --
      if FoundTriggerSource then
        Cnt     := 1;
        LnStart := 1;
        --
        loop
          LnEnd := INSTR(TriggerBody, CHR(10), 1, Cnt);
          --
          if (LnEnd = 0) then
            SourceTable(Cnt) := SubStr(TriggerBody, LnStart);
          else
            SourceTable(Cnt) := Substr(TriggerBody, LnStart, (LnEnd-LnStart));
          end if;
          --
          LnStart := LnStart + (LnEnd-LnStart)+1;
          Cnt := Cnt+1;
          --
          exit when (lnEnd = 0);
        end loop;
      end if;
    -- see if the code is wrapped
    else
      begin
        select upper(text) into vtext from all_source s
          where s.type = UnitType and s.owner = UnitOwner and
                s.name = UnitName and s.line = 1;
        IsWrapped := (INSTR(vText, ' WRAPPED') > 0);
      exception
        when NO_DATA_FOUND then
          IsWrapped := False;
      end;
    end if;
    --
    -- Get the source for each line in unit
    Cnt := 1;
    for linerec in cLines(run_number, UnitNumber) loop
      if UnitType = 'TRIGGER' then
        if FoundTriggerSource then
          vText := SourceTable(linerec.line#);
        else
          if Cnt = 1 then
            vText := '<source unavailable>';
          else
            vText := null;
          end if;
        end if;
      else
        if IsWrapped then
          if Cnt = 1 then
            vText := '<wrapped>';
          else
            vText := null;
          end if;
        else
          begin
            select text into vtext from all_source s
              where s.type = UnitType and s.owner = UnitOwner and
                    s.name = UnitName and s.line = linerec.line#;
          exception
            when NO_DATA_FOUND then
              vText := null;
          end;
        end if;
      end if;
      -- store the source line
      update plsql_profiler_data d set d.text = vText
      where d.runid = run_number and d.unit_number = UnitNumber and
            d.line# = linerec.line#;
      Cnt := Cnt+1;
    end loop;
  end rollup_unit;
  -- rollup all units for the given run
  --
  procedure rollup_run(run_number IN number) is
    tabpos number;
    comment varchar2(2047);
    proc varchar2(256);
    --
    -- only select those units which have not been rolled up yet
    cursor cunits(run_number number) is
      select unit_number, unit_type, unit_owner, unit_name
        from plsql_profiler_units
        where runid = run_number and total_time = 0
        order by unit_number asc;
  begin
    -- parse the RUN_COMMENT column to get the procedure name
  	-- (note: this replaces the BI_PLSQL_PROFILER_RUNS trigger.
    select run_proc, run_comment into proc, comment
	  from plsql_profiler_runs where runid = run_number;
    if proc is null then
      tabpos := INSTR(comment, CHR(8));
        if tabpos > 0 THEN
          proc := SUBSTR(comment, tabpos+1);
          comment := SUBSTR(comment, 1, tabpos-1);
        else
          proc := 'ANONYMOUS BLOCK';
        end if;
        update plsql_profiler_runs
          set run_owner = USER, run_proc = proc, run_comment = comment
          where runid = run_number;
    end if;
    -- end HACK
    --
    for unitrec in cunits(run_number) loop
      rollup_unit(run_number, unitrec.unit_number, unitrec.unit_type,
                  unitrec.unit_owner, unitrec.unit_name);
    end loop;
  end rollup_run;
  -- rollup all runs
  --
  procedure rollup_all_runs is
    cursor crunid is
      select runid from plsql_profiler_runs order by runid asc;
  begin
    for runidrec in crunid loop
      rollup_run(runidrec.runid);
    end loop crunid;
    commit;
  end rollup_all_runs;
end toad_profiler;
/

CREATE PUBLIC SYNONYM plsql_profiler_data  FOR plsql_profiler_data;
CREATE PUBLIC SYNONYM plsql_profiler_units FOR plsql_profiler_units;
CREATE PUBLIC SYNONYM plsql_profiler_runs  FOR plsql_profiler_runs;

GRANT SELECT, INSERT, UPDATE, DELETE ON plsql_profiler_data  TO PUBLIC;
GRANT SELECT, INSERT, UPDATE, DELETE ON plsql_profiler_units TO PUBLIC;
GRANT SELECT, INSERT, UPDATE, DELETE ON plsql_profiler_runs  TO PUBLIC;

CREATE PUBLIC SYNONYM toad_profiler FOR toad_profiler;
GRANT execute ON toad_profiler TO PUBLIC;

CREATE sequence plsql_profiler_runnumber START WITH 1 nocache;
CREATE PUBLIC SYNONYM plsql_profiler_runnumber FOR plsql_profiler_runnumber;
GRANT SELECT ON plsql_profiler_runnumber TO PUBLIC;

