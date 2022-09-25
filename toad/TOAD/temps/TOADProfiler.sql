Rem ================
Rem ToadProfiler.sql
Rem ================
Rem 
Rem --------
Rem Purpose:
Rem --------
Rem Creates the tables and package used for client-side profiler analysis
Rem Modifications to Oracle proftab.sql for use with TOAD.
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
Rem   MODIFIED   (MM/DD/YY)
Rem   dchristian  09/09/99 - Added plsql_profiler_data.text column to hold 
Rem                          source for versioning.  Modified rollup_unit to
Rem                          update text for procedures and triggers.  
Rem   dchristian  08/18/99 - Added run_user, run_proc, and trigger
Rem   dchristian  07/26/99 - Added delete cascade constraints
Rem   schapman    08/24/99 - Added public synonyms and grants to public
Rem                          so that these objects can be installed to
Rem                          a single common schema, e.g., TOAD.
Rem   schapman    01/13/2000 (1). Added install notes about which schema to install
Rem                          these Profiler objects into.
Rem                          (2). Rewrapped the code with the default capitalization
Rem                          effects to avoid errors when bringing in wrapped code
Rem                          into the SQL editor for execution.
Rem 
Rem WARNING: This script destroys all existing profiler data!
Rem 

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
  run_user        VARCHAR2(30),        -- user that executed the procedure
  run_proc        VARCHAR2(256),       -- procedure that was executed                              
  run_date        DATE,                -- start time of run
  run_comment     VARCHAR2(2047),      -- user provided comment for this run
  run_total_time  NUMBER,              -- elapsed time for this run
  run_system_info VARCHAR2(2047),      -- currently unused
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

CREATE OR REPLACE TRIGGER bi_plsql_profiler_runs
before INSERT ON plsql_profiler_runs FOR each ROW
DECLARE
  tabpos NUMBER;
BEGIN
  :NEW.run_user := USER;
  
  tabpos := INSTR(:NEW.run_comment, CHR(8));
  IF tabpos > 0 THEN
    :NEW.run_proc     := SUBSTR(:NEW.run_comment, tabpos+1);
    :NEW.run_comment  := SUBSTR(:NEW.run_comment, 1, tabpos-1);  
  ELSE
    :NEW.run_proc := 'ANONYMOUS BLOCK'; 
  END IF;
END;
/

CREATE OR REPLACE PACKAGE toad_profiler wrapped 
0
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
9
8105000
1
4
0 
e
2 :e:
1PACKAGE:
1TOAD_PROFILER:
1AUTHID:
1CURRENT_USER:
1ROLLUP_UNIT:
1RUN_NUMBER:
1NUMBER:
1UNITNUMBER:
1UNITTYPE:
1VARCHAR2:
1UNITOWNER:
1UNITNAME:
1ROLLUP_RUN:
1ROLLUP_ALL_RUNS:
0

0
0
31
2
0 a0 1d 97 :2 a0 9a 8f a0
b0 3d 8f a0 b0 3d 8f a0
b0 3d 8f a0 b0 3d 8f a0
b0 3d b4 55 6a 9a 8f a0
b0 3d b4 55 6a 9a b4 55
6a a0 :2 aa 59 58 17 b5 
31
2
0 3 7 14 c 10 1e 33
2f b 3b 48 44 a 50 59
55 43 61 6e 6a 42 76 7f
7b 69 87 68 8c 90 94 ad
a9 a8 b5 a7 ba be c2 d3
d4 d8 dc a5 66 e0 e3 e6
40 
31
2
0 :2 1 9 3 a d 19 27
:2 19 2f 3d :2 2f 5 11 :2 5 1b
28 :2 1b 32 3e :2 32 18 :2 3 d
18 26 :2 18 17 :2 3 d 0 :2 3
5 :6 1 
31
2
0 :3 1 :2 2 :9 3 :c 4 :3 3 :8 5 6
0 :2 6 7 :6 1 
ef
2
:2 0 8 1 :4 0 200 0 5 :2 3
:3 0 4 :3 0 2 :6 0 1 :2 0 5
:a 0 1d 2 :4 0 7 :3 0 6 :7 0
9 8 :5 0 9 :2 7 :3 0 8 :7 0
d c :3 0 a :3 0 9 :7 0 11
10 :4 0 2d d b a :3 0 b
:7 0 15 14 :3 0 a :3 0 c :7 0
19 18 :3 0 1b :2 0 1d 6 1c
0 2b d :a 0 25 3 :4 0 17
2d 15 13 7 :3 0 6 :7 0 21
20 :3 0 23 :2 0 25 1e 24 0
2b e :a 0 29 4 :5 0 27 :2 0
29 26 28 0 2b 2 :3 0 2b
2c 2e 3 2d 2f 2 2e 30
:4 0 4 0 
1b
2
:3 0 1 7 1 b 1 f 1
13 1 17 5 a e 12 16
1a 1 1f 1 22 3 1d 25
29 
1
4
0 
2f
0
1
14
4
a
0 1 1 1 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 
f 2 0
1e 1 3
6 1 2
17 2 0
1f 3 0
b 2 0
7 2 0
26 1 4
13 2 0
3 0 1
0

/

CREATE OR REPLACE PACKAGE BODY toad_profiler wrapped 
0
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
b
8105000
1
4
0 
42
2 :e:
1PACKAGE:
1BODY:
1TOAD_PROFILER:
1ROLLUP_UNIT:
1RUN_NUMBER:
1NUMBER:
1UNITNUMBER:
1UNITTYPE:
1VARCHAR2:
1UNITOWNER:
1UNITNAME:
1TYPE:
1TSOURCETABLE:
14000:
1BINARY_INTEGER:
1SOURCETABLE:
1TRIGGERBODY:
1LONG:
1CNT:
1LNSTART:
1LNEND:
1POS:
1VTEXT:
1CURSOR:
1CLINES:
1LINE#:
1PLSQL_PROFILER_DATA:
1RUNID:
1=:
1UNIT_NUMBER:
1PLSQL_PROFILER_UNITS:
1TOTAL_TIME:
1SUM:
1TRIGGER:
1TRIGGER_BODY:
1ALL_TRIGGERS:
1OWNER:
1TRIGGER_NAME:
11:
1LOOP:
1INSTR:
1CHR:
110:
10:
1SUBSTR:
1-:
1+:
1EXIT:
1LINEREC:
1D:
1TEXT:
1ALL_SOURCE:
1S:
1NAME:
1LINE:
1ROLLUP_RUN:
1CUNITS:
1UNIT_TYPE:
1UNIT_OWNER:
1UNIT_NAME:
1UNITREC:
1ROLLUP_ALL_RUNS:
1CRUNID:
1PLSQL_PROFILER_RUNS:
1RUNIDREC:
1COMMIT:
0

0
0
240
2
0 a0 1d a0 97 9a 8f a0
b0 3d 8f a0 b0 3d 8f a0
b0 3d 8f a0 b0 3d 8f a0
b0 3d b4 a0 55 6a 9d a0
51 a5 1c a0 40 a8 c 77
a3 a0 1c 81 b0 a3 a0 1c
81 b0 a3 a0 1c 81 b0 a3
a0 1c 81 b0 a3 a0 1c 81
b0 a3 a0 1c 81 b0 a3 a0
51 a5 1c 81 b0 a0 f4 8f
a0 b0 3d 8f a0 b0 3d b4
bf c8 a0 ac a0 b2 ee :2 a0
7e b4 2e :2 a0 7e b4 2e a
10 ac d0 e5 e9 bd b7 11
a4 b1 :3 a0 9f a0 d2 ac a0
b2 ee :2 a0 7e b4 2e :2 a0 7e
b4 2e a 10 ac d0 eb e7
:2 a0 7e b4 2e :2 a0 7e b4 2e
a 10 ef f9 e9 a0 7e 6e
b4 2e a0 ac :2 a0 b2 ee :2 a0
7e b4 2e :2 a0 7e b4 2e a
10 ac e5 d0 b2 e9 a0 51
d a0 51 d :5 a0 51 a5 b
51 a0 a5 b d a0 7e 51
b4 2e 5a :2 a0 a5 b :3 a0 a5
b d b7 :2 a0 a5 b :4 a0 7e
a0 b4 2e 5a a5 b d b7
:2 19 3c :2 a0 7e a0 7e a0 b4
2e 5a b4 2e 7e 51 b4 2e
d :2 a0 7e 51 b4 2e d :2 a0
7e 51 b4 2e 5a 2b b7 a0
47 b7 19 3c 91 :3 a0 a5 b
a0 37 a0 7e 6e b4 2e :2 a0
b9 :2 a0 6b :3 a0 6b a5 b e7
:2 a0 6b a0 7e b4 2e :2 a0 6b
a0 7e b4 2e a 10 :2 a0 6b
a0 7e a0 6b b4 2e a 10
ef f9 e9 b7 :2 a0 b9 :2 a0 6b
a0 ac :2 a0 b9 b2 ee :2 a0 6b
a0 7e b4 2e :2 a0 6b a0 7e
b4 2e a 10 :2 a0 6b a0 7e
b4 2e a 10 :2 a0 6b a0 7e
a0 6b b4 2e a 10 ac d0
eb e7 :2 a0 6b a0 7e b4 2e
:2 a0 6b a0 7e b4 2e a 10
:2 a0 6b a0 7e a0 6b b4 2e
a 10 ef f9 e9 b7 :2 19 3c
b7 a0 47 b7 a4 a0 b1 11
68 4f 9a 8f a0 b0 3d b4
a0 55 6a f4 8f a0 b0 3d
b4 bf c8 :4 a0 ac a0 b2 ee
:2 a0 7e b4 2e a0 7e 51 b4
2e a 10 ac d0 a0 de ac
e5 e9 bd b7 11 a4 b1 91
:2 a0 a5 b a0 37 :4 a0 6b :2 a0
6b :2 a0 6b :2 a0 6b a5 57 b7
a0 47 b7 a4 a0 b1 11 68
4f 9a a0 b4 55 6a f4 b4
bf c8 a0 ac a0 b2 ee ac
d0 a0 de ac e5 e9 bd b7
11 a4 b1 91 :2 a0 37 :3 a0 6b
a5 57 b7 :2 a0 47 a0 57 a0
b4 e9 b7 a4 a0 b1 11 68
4f b1 b7 a4 11 a0 b1 56
4f 17 b5 
240
2
0 3 7 8 c 16 2f 2b
2a 37 44 40 29 4c 55 51
3f 5d 6a 66 3e 72 7b 77
65 83 64 88 8c 90 b3 98
9c 9f a0 a8 ac ad ae 94
ce be c2 ca bd e9 d9 dd
e5 bc 100 f0 f4 fc d8 11b
10b 10f 117 d7 132 122 126 12e
10a 14d 13d 141 149 109 168 154
158 15b 15c 164 13c 16f 173 18b
187 13b 193 19c 198 186 1a4 185
1a9 1ac 1b0 1b4 1b5 1b9 1ba 1c1
1c5 1c9 1cc 1cd 1d2 1d6 1da 1dd
1de 1 1e3 1e8 1e9 1ed 1f3 1f8
183 1fd 209 139 20d 211 215 219
21c 220 224 225 229 22a 231 235
239 23c 23d 242 246 24a 24d 24e
1 253 258 259 25d 107 261 265
269 26c 26d 272 276 27a 27d 27e
1 283 288 28e 28f 294 298 29b
2a0 2a1 2a6 2aa 2ab 2af 2b3 2b4
2bb 2bf 2c3 2c6 2c7 2cc 2d0 2d4
2d7 2d8 1 2dd 2e2 2e3 2e9 2ed
2ee 2f3 2f7 2fa 2fe 302 305 309
30d 311 315 319 31d 320 d5 321
324 328 ba 329 32d 331 334 337
338 33d 340 344 348 62 349 34d
351 355 3c 356 27 35a 35e 362
363 365 369 36d 371 375 378 37c
37d 382 385 386 388 38c 38e 392
396 399 39d 3a1 3a4 3a8 3ab 3af
3b0 3b5 3b8 3b9 3be 3c1 3c4 3c5
3ca 3ce 3d2 3d6 3d9 3dc 3dd 3e2
3e6 3ea 3ee 3f1 3f4 3f5 3fa 3fd
403 405 409 410 412 416 419 41d
421 425 429 42a 42c 430 432 436
439 43e 43f 444 448 44c 44e 452
456 459 45d 461 465 468 469 46b
46d 471 475 478 47c 47f 480 485
489 48d 490 494 497 498 1 49d
4a2 4a6 4aa 4ad 4b1 4b4 4b8 4bb
4bc 1 4c1 4c6 4cc 4cd 4d2 4d4
4d8 4dc 4de 4e2 4e6 4e9 4ed 4ee
4f2 4f6 4f8 4f9 500 504 508 50b
50f 512 513 518 51c 520 523 527
52a 52b 1 530 535 539 53d 540
544 547 548 1 54d 552 556 55a
55d 561 564 568 56b 56c 1 571
576 577 57b 57f 581 585 589 58c
590 593 594 599 59d 5a1 5a4 5a8
5ab 5ac 1 5b1 5b6 5ba 5be 5c1
5c5 5c8 5cc 5cf 5d0 1 5d5 5da
5e0 5e1 5e6 5e8 5ec 5f0 5f3 5f5
5f9 600 602 606 60a 60c 618 61c
61e 637 633 632 63f 631 644 648
64c 650 668 664 663 670 662 675
678 67c 680 684 688 68c 68d 691
692 699 69d 6a1 6a4 6a5 6aa 6ae
6b1 6b4 6b5 1 6ba 6bf 6c0 6c4
660 6c8 6c9 6cf 6d4 62f 6d9 6e5
6e9 6eb 6ef 6f3 6f7 6f8 6fa 6fe
700 704 708 70c 710 713 717 71b
71e 722 726 729 72d 731 734 735
73a 73c 740 747 749 74d 751 753
75f 763 765 776 77a 77b 77f 783
793 794 797 79b 79f 7a0 7a4 7a5
7ac 7ad 7b1 7b5 7b7 7b8 7be 7c3
7c8 7ca 7d6 7da 7dc 7e0 7e4 7e8
7ea 7ee 7f2 7f6 7f9 7fa 7ff 801
805 809 810 814 819 81d 81e 823
825 829 82d 82f 83b 83f 841 843
845 849 855 859 85b 85e 860 869 
240
2
0 :2 1 9 e d 19 27 :2 19
2f 3d :2 2f 5 11 :2 5 1b 28
:2 1b 32 3e :2 32 18 :3 3 8 21
2a 29 21 39 :3 18 :2 3 :3 f :2 3
:3 f :2 3 :3 7 :2 3 :3 b :2 3 :3 b :2 3
:3 7 :2 3 9 12 11 :2 9 :2 3 a
11 1c :2 11 24 2f :2 24 10 :2 3
:2 c 17 12 17 b 13 :3 11 22
30 :3 2e :2 b 12 :3 5 :5 3 c 25
:2 f 13 :2 f 24 1f 24 f 17
:3 15 26 34 :3 32 :2 f 1f 8 7
25 b 13 :3 11 22 30 :3 2e :2 b
:3 5 8 11 13 :2 11 :2 e 20 e
9 e 21 29 :3 27 37 46 :3 44
:2 21 9 :5 7 12 :2 7 12 :2 7 9
12 18 25 29 :2 25 2e 31 :2 12
9 d 13 15 :2 13 c b 17
:2 b 1f 26 33 :2 1f b 18 b
17 :2 b 1f 26 33 3d 42 43
:2 3d 3c :2 1f b :5 9 14 1c 1f
24 25 :2 1f 1e :2 14 2d 2e :2 14
:2 9 10 13 14 :2 10 :2 9 14 1a
1c :2 1a 13 9 7 b :2 1d :2 5
9 14 1b 27 :2 14 33 5 a
13 15 :2 13 10 24 10 2a 2c
2a 33 3f :2 47 :2 33 2a f :2 11
19 :3 17 28 :2 2a 38 :3 36 :3 f :2 11
19 17 :2 21 :2 17 :2 f :3 9 1f 10
24 10 2a 2c 2a :2 13 1d 28
1d 18 1d 14 :2 16 1d :3 1b 2a
:2 2c 34 :3 32 :3 14 :2 16 1d :3 1b :2 14
2a :2 2c 33 31 :2 3b :2 31 :2 14 18
c b 2a f :2 11 19 :3 17 28
:2 2a 38 :3 36 :3 f :2 11 19 17 :2 21
:2 17 :2 f :3 9 :4 7 33 9 5 :2 3
7 :4 3 d 18 26 :2 18 17 5
:2 3 c 13 1e :2 13 12 :2 5 e
1b 26 32 :2 e 9 e f 17
:3 15 26 31 33 :2 31 :2 f 9 7
:2 12 9 :2 7 :5 5 9 14 1b :2 14
27 5 7 13 1f :2 27 34 :2 3c
13 :2 1b 27 :2 2f :2 7 27 9 5
:2 3 7 :4 3 d 5 0 :2 3 c
0 :2 5 :2 e 19 14 19 14 7
:2 36 2d :2 7 :5 5 9 15 1c 5
7 12 :2 1b :2 7 1c 9 e :6 5
:2 3 7 :8 3 5 :5 1 
240
2
0 :4 1 :9 5 :c 6 5 8 :2 5 :a 8
:5 9 :5 a :5 b :5 c :5 d :5 e :7 f :d 12
:5 13 :c 14 :4 13 :5 12 :2 16 :8 17 :c 18 :3 17
16 :c 19 :3 16 :5 1c :3 1d :10 1e :4 1d :3 20
:3 21 23 :c 24 :6 26 :a 27 26 :10 29 :2 28
:2 26 :10 2c :7 2d :8 2f 23 30 :4 1c :8 34
:5 35 :d 36 :10 37 :9 38 :2 37 :3 36 35 :6 3a
:7 3b :10 3c :7 3d :2 3c :9 3d :2 3c :3 3b 3a
:10 3e :9 3f :2 3e :3 3a :2 39 :2 35 34 41
34 :2 15 42 :4 5 :6 45 47 :2 45 :8 47
:5 48 :3 49 :c 4a 49 48 :3 4b :2 48 :5 47
:7 4d :8 4e :6 4f :2 4e 4d 50 4d :2 4c
51 :4 45 54 55 0 :2 54 55 0
:2 55 :c 56 :5 55 :4 58 :6 59 58 :2 5a 58
:5 5b :2 57 5c :4 54 :4 5 5d :5 1 
86b
2
:3 0 1 :4 0 2 :3 0 3 :6 0 1
:2 0 4 :a 0 1ae 2 :4 0 6a ef
5 3 6 :3 0 5 :7 0 8 7
:3 0 d6 d9 9 7 6 :3 0 7
:7 0 c b :3 0 9 :3 0 8 :7 0
10 f :3 0 d2 d4 d b 9
:3 0 a :7 0 14 13 :3 0 9 :3 0
b :7 0 18 17 :3 0 c :3 0 1a
:2 0 1ae 5 1c :2 0 1e 0 26
1ac 9 :3 0 e :2 0 13 1f 21
:6 0 f :3 0 23 15 25 22 :3 0
d 26 1e :4 0 c1 c9 19 17
d :3 0 29 :7 0 2c 2a 0 1ac
10 :6 0 c3 c5 1d 1b 12 :3 0
2e :7 0 31 2f 0 1ac 11 :6 0
6 :3 0 33 :7 0 36 34 0 1ac
13 :6 0 75 8c 21 1f 6 :3 0
38 :7 0 3b 39 0 1ac 14 :6 0
6 :3 0 3d :7 0 40 3e 0 1ac
15 :7 0 71 27 25 6 :3 0 42
:7 0 45 43 0 1ac 16 :6 0 9
:3 0 e :2 0 23 47 49 :6 0 4c
4a 0 1ac 17 :6 0 18 :3 0 19
:a 0 3 6f :3 0 32 71 2b 29
6 :3 0 5 :7 0 51 50 :3 0 6
:3 0 7 :7 0 55 54 :3 0 4e 59
0 57 :3 0 1a :3 0 2e 1b :3 0
30 5d 6a 0 6b :3 0 1c :3 0
5 :3 0 1d :2 0 34 61 62 :3 0
1e :3 0 7 :3 0 1d :2 0 37 66
67 :3 0 63 69 68 :4 0 5b 5e
0 6c :6 0 6d :2 0 70 4e 59
71 0 1ac 73 70 72 :6 0 6f
1 :5 0 1f :3 0 20 :3 0 21 :3 0
21 :2 0 20 :3 0 77 0 78 0
3a 1b :3 0 3c 7c 89 0 8a
:3 0 1c :3 0 5 :3 0 1d :2 0 40
80 81 :3 0 1e :3 0 7 :3 0 1d
:2 0 43 85 86 :3 0 82 88 87
:4 0 7a 7d 0 8b :3 0 1c :3 0
5 :3 0 1d :2 0 46 90 91 :3 0
1e :3 0 7 :3 0 1d :2 0 49 95
96 :3 0 92 98 97 :2 0 74 9b
99 0 9c 0 3e 0 9a :2 0
1a9 8 :3 0 1d :2 0 22 :4 0 4e
9e a0 :3 0 23 :3 0 4c 11 :3 0
24 :3 0 51 a6 b3 0 b4 :3 0
25 :3 0 a :3 0 1d :2 0 55 aa
ab :3 0 26 :3 0 b :3 0 1d :2 0
58 af b0 :3 0 ac b2 b1 :3 0
b6 b7 :5 0 a3 a7 0 53 0
b5 :2 0 113 13 :3 0 27 :2 0 b9
ba 0 113 14 :3 0 27 :2 0 bc
bd 0 113 28 :3 0 15 :3 0 29
:3 0 11 :3 0 2a :3 0 2b :2 0 5b
27 :2 0 13 :3 0 5d c0 ca 0
110 15 :3 0 1d :2 0 2c :2 0 64
cd cf :3 0 d0 :2 0 10 :3 0 13
:3 0 62 2d :3 0 11 :3 0 14 :3 0
67 d5 da 0 dc 10 :3 0 13
:3 0 6c dd df 2d :3 0 11 :3 0
14 :3 0 15 :3 0 2e :2 0 14 :3 0
6e e5 e7 :3 0 e8 :2 0 71 e1
ea e0 eb 0 ed 75 ee 0
ed 0 f0 d1 dc 0 f0 77
0 110 14 :3 0 14 :3 0 2f :2 0
15 :3 0 2e :2 0 14 :3 0 7a f5
f7 :3 0 f8 :2 0 7d f3 fa :3 0
2f :2 0 27 :2 0 80 fc fe :3 0
f1 ff 0 110 13 :3 0 13 :3 0
2f :2 0 27 :2 0 83 103 105 :3 0
101 106 0 110 30 :3 0 15 :3 0
1d :2 0 2c :2 0 88 10a 10c :3 0
10d :3 0 10e :3 0 110 8b 112 28
:4 0 110 :4 0 113 91 114 a1 113
0 115 86 0 1a9 31 :3 0 19
:3 0 5 :3 0 7 :3 0 96 117 11a
28 :3 0 116 11b 8 :3 0 1d :2 0
22 :4 0 9b 11f 121 :3 0 1b :3 0
32 :3 0 123 124 32 :3 0 33 :2 0
4 126 127 0 10 :3 0 31 :3 0
1a :3 0 12a 12b 0 99 129 12d
128 12e 32 :3 0 1c :3 0 130 131
0 5 :3 0 1d :2 0 a0 134 135
:3 0 32 :3 0 1e :3 0 137 138 0
7 :3 0 1d :2 0 a3 13b 13c :3 0
136 13e 13d :2 0 32 :3 0 1a :3 0
140 141 0 31 :3 0 1d :2 0 1a
:3 0 143 145 0 a6 144 147 :3 0
13f 149 148 :2 0 125 14c 14a 0
14d 0 9e 0 14b :2 0 14e a9
1a4 1b :3 0 32 :3 0 14f 150 32
:3 0 33 :2 0 4 152 153 0 33
:3 0 ab 34 :3 0 35 :3 0 157 158
ad 15a 17f 0 180 :3 0 35 :3 0
c :3 0 15c 15d 0 8 :3 0 1d
:2 0 b1 160 161 :3 0 35 :3 0 25
:3 0 163 164 0 a :3 0 1d :2 0
b4 167 168 :3 0 162 16a 169 :2 0
35 :3 0 36 :3 0 16c 16d 0 b
:3 0 1d :2 0 b7 170 171 :3 0 16b
173 172 :2 0 35 :3 0 37 :3 0 175
176 0 31 :3 0 1d :2 0 1a :3 0
178 17a 0 ba 179 17c :3 0 174
17e 17d :4 0 156 15b 0 181 :3 0
154 182 32 :3 0 1c :3 0 184 185
0 5 :3 0 1d :2 0 bd 188 189
:3 0 32 :3 0 1e :3 0 18b 18c 0
7 :3 0 1d :2 0 c0 18f 190 :3 0
18a 192 191 :2 0 32 :3 0 1a :3 0
194 195 0 31 :3 0 1d :2 0 1a
:3 0 197 199 0 c3 198 19b :3 0
193 19d 19c :2 0 151 1a0 19e 0
1a1 0 af 0 19f :2 0 1a2 c6
1a3 0 1a2 0 1a5 122 14e 0
1a5 c8 0 1a6 cb 1a8 28 :3 0
11d 1a6 :4 0 1a9 cd 1ad :3 0 1ad
4 :3 0 d1 1ad 1ac 1a9 1aa :6 0
1ae 1 0 5 1c 1ad 23b :2 0
38 :a 0 200 6 :4 0 f2 1de dd
db 6 :3 0 5 :7 0 1b3 1b2 :3 0
18 :3 0 1b5 :2 0 200 1b0 1b7 :2 0
39 :a 0 7 1dc :3 0 1 1d7 e1
df 6 :3 0 5 :7 0 1bc 1bb :3 0
1b9 1c0 0 1be :3 0 1e :3 0 3a
:3 0 3b :3 0 3c :3 0 e3 1f :3 0
e8 1c7 1d4 0 1d5 :3 0 1c :3 0
5 :3 0 1d :2 0 ec 1cb 1cc :3 0
20 :3 0 1d :2 0 2c :2 0 ef 1cf
1d1 :3 0 1cd 1d3 1d2 :4 0 1c5 1c8
0 1e :3 0 ea 1d6 0 1d9 :4 0
1da :2 0 1dd 1b9 1c0 1de 0 1fe
1e0 1dd 1df :6 0 1dc 1 :6 0 1de
3d :3 0 39 :3 0 5 :3 0 f4 1e2
1e4 28 :3 0 1e1 1e5 4 :3 0 5
:3 0 3d :3 0 1e :3 0 1ea 1eb 0
3d :3 0 3a :3 0 1ed 1ee 0 3d
:3 0 3b :3 0 1f0 1f1 0 3d :3 0
3c :3 0 1f3 1f4 0 f6 1e8 1f6
:2 0 1f8 fc 1fa 28 :3 0 1e7 1f8
:4 0 1fb fe 1ff :3 0 1ff 38 :3 0
100 1ff 1fe 1fb 1fc :6 0 200 1
0 1b0 1b7 1ff 23b :2 0 3e :a 0
234 9 :4 0 18 :4 0 204 :2 0 234
202 205 :2 0 3f :a 0 a 217 :4 0
207 20a 0 208 :3 0 1c :3 0 102
40 :3 0 104 20e :2 0 210 :5 0 20c
20f 0 1c :3 0 1 212 106 211
0 214 :4 0 215 :2 0 218 207 20a
219 0 232 108 219 21b 218 21a
:6 0 217 1 :6 0 219 41 :3 0 3f
:3 0 28 :3 0 21c 21d 38 :3 0 41
:3 0 1c :3 0 221 222 0 10a 220
224 :2 0 226 10c 229 28 :3 0 3f
:3 0 21f 226 :4 0 22f 42 :3 0 22c
22d :2 0 22e 42 :5 0 22b :2 0 22f
10e 233 :3 0 233 3e :3 0 111 233
232 22f 230 :6 0 234 1 0 202
205 233 23b :3 0 239 0 239 :3 0
239 23b 237 238 :6 0 23c :2 0 3
:3 0 113 0 4 239 23e :2 0 2
23c 23f :8 0 
117
2
:3 0 1 6 1 a 1 e 1
12 1 16 5 9 d 11 15
19 1 20 1 24 1 28 1
2d 1 32 1 37 1 3c 1
41 1 48 1 46 1 4f 1
53 2 52 56 1 5a 1 5c
1 6e 2 5f 60 2 64 65
1 79 1 7b 1 8d 2 7e
7f 2 83 84 2 8e 8f 2
93 94 1 a2 2 9d 9f 1
a5 1 a4 2 a8 a9 2 ad
ae 1 c4 4 c2 c6 c7 c8
1 d3 2 cc ce 2 d7 d8
1 db 1 de 2 e4 e6 3
e2 e3 e9 1 ec 2 ef ee
2 f4 f6 2 f2 f9 2 fb
fd 2 102 104 1 114 2 109
10b 5 cb f0 100 107 10f 4
b8 bb be 112 2 118 119 1
12c 2 11e 120 1 12f 2 132
133 2 139 13a 2 142 146 1
14d 1 155 1 159 1 183 2
15e 15f 2 165 166 2 16e 16f
2 177 17b 2 186 187 2 18d
18e 2 196 19a 1 1a1 2 1a4
1a3 1 1a5 3 9c 115 1a8 9
27 2b 30 35 3a 3f 44 4b
6f 1 1b1 1 1b4 1 1ba 1
1bd 4 1c1 1c2 1c3 1c4 1 1c6
1 1d8 2 1c9 1ca 2 1ce 1d0
1 1db 1 1e3 5 1e9 1ec 1ef
1f2 1f5 1 1f7 1 1fa 1 1dc
1 20b 1 20d 1 213 1 216
1 223 1 225 2 229 22e 1
217 3 1ae 200 234 
1
4
0 
23e
0
1
14
b
1b
0 1 2 2 2 1 6 6
1 9 9 0 0 0 0 0
0 0 0 0 
32 2 0
1e1 8 0
2d 2 0
e 2 0
116 5 0
1b0 1 6
3c 2 0
28 2 0
5 1 2
16 2 0
41 2 0
207 9 a
1ba 7 0
1b1 6 0
53 3 0
4f 3 0
a 2 0
6 2 0
37 2 0
1b9 6 7
1e 2 0
21c b 0
4e 2 3
46 2 0
202 1 9
12 2 0
4 0 1
0

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

