REM 
REM  This script will create TOAD objects in their own
REM  schema. If you DO NOT want to create a unique system
REM  schema for TOAD objects, load the file NOTOAD.SQL
REM 
REM  Otherwise, start a new Oracle connection as SYSTEM ( or
REM  any other user with privileges to create a new USER)
REM  and, while connected as that user,  execute the following
REM  by clicking the third toolbar button in a SQL Edit OR
REM  by selecting the menu option "SQL_Window/Execute as Script"
REM 
REM 
REM  Ver  Date        Description
REM  ===  ==========  =======================================
REM  1.1  10/06/1999  1. Added STORAGE clauses to the table
REM                   create commands so that not too much
REM                   disk space will be allocated.
REM                   2. Removed obsolete TOAD_TEMP and
REM                   TOAD_DEP_TEMP.
REM  1.2  11/17/1999  1. Changed index on TOAD_PLAN_TABLE from
REM                   unique to non-unique.
REM  1.3  05/23/2001  1. Added partition-related columns and
REM                   DISTRIBUTION to TOAD_PLAN_TABLE
REM  1.4  01/18/2001  1. Added OBJECTNAME function


CREATE USER TOAD IDENTIFIED BY TOAD
DEFAULT TABLESPACE USER_DATA
TEMPORARY TABLESPACE TEMPORARY_DATA
QUOTA UNLIMITED ON USER_DATA
QUOTA 0K ON SYSTEM;

GRANT CONNECT TO TOAD;

GRANT RESOURCE TO TOAD;

GRANT CREATE PUBLIC SYNONYM TO TOAD;

DROP TABLE TOAD.TOAD_PLAN_SQL;

CREATE TABLE TOAD.TOAD_PLAN_SQL (
USERNAME     VARCHAR2(30),
STATEMENT_ID VARCHAR2(32),
TIMESTAMP    DATE,
STATEMENT    VARCHAR2(2000) )
STORAGE (INITIAL 40K NEXT 24K); 

CREATE UNIQUE INDEX TOAD.TPSQL_IDX ON
TOAD.TOAD_PLAN_SQL ( STATEMENT_ID );

DROP TABLE TOAD.TOAD_PLAN_TABLE;

CREATE TABLE TOAD.TOAD_PLAN_TABLE (
STATEMENT_ID    VARCHAR2(32),
TIMESTAMP       DATE,
REMARKS         VARCHAR2(80),
OPERATION       VARCHAR2(30),
OPTIONS         VARCHAR2(30),
OBJECT_NODE     VARCHAR2(128),
OBJECT_OWNER    VARCHAR2(30),
OBJECT_NAME     VARCHAR2(30),
OBJECT_INSTANCE NUMBER,
OBJECT_TYPE     VARCHAR2(30),
SEARCH_COLUMNS  NUMBER,
ID              NUMBER,
COST            NUMBER,
PARENT_ID       NUMBER,
POSITION        NUMBER,
CARDINALITY     NUMBER,
OPTIMIZER       VARCHAR2(255),
BYTES           NUMBER,
OTHER_TAG       VARCHAR2(255),
PARTITION_ID    NUMBER,
PARTITION_START VARCHAR2(255),
PARTITION_STOP  VARCHAR2(255),
DISTRIBUTION    VARCHAR2(30),
OTHER           LONG)
STORAGE(INITIAL 80K NEXT 36K) ; 

CREATE INDEX TOAD.TPTBL_IDX ON
TOAD.TOAD_PLAN_TABLE ( STATEMENT_ID );

DROP   SEQUENCE TOAD.TOAD_SEQ;
CREATE SEQUENCE TOAD.TOAD_SEQ START WITH 1 CACHE 20;

DROP   PUBLIC SYNONYM TOAD_PLAN_SQL;
CREATE PUBLIC SYNONYM TOAD_PLAN_SQL FOR TOAD.TOAD_PLAN_SQL;

DROP   PUBLIC SYNONYM TOAD_PLAN_TABLE;
CREATE PUBLIC SYNONYM TOAD_PLAN_TABLE FOR TOAD.TOAD_PLAN_TABLE;

DROP   PUBLIC SYNONYM TOAD_SEQ ;
CREATE PUBLIC SYNONYM TOAD_SEQ FOR TOAD.TOAD_SEQ;

CONNECT TOAD/TOAD;

GRANT SELECT, INSERT, UPDATE, DELETE ON TOAD.TOAD_PLAN_SQL TO PUBLIC;

GRANT SELECT, INSERT, UPDATE, DELETE ON TOAD.TOAD_PLAN_TABLE TO PUBLIC;

GRANT SELECT, ALTER ON TOAD.TOAD_SEQ TO PUBLIC;

CREATE OR REPLACE function ObjectName(in_object_id in number) return
varchar
is
  return_string varchar2(100);
begin
  select OWNER||'.'||OBJECT_NAME
    into return_string
    from all_objects
    where object_id = in_object_id;
  return return_string;
end ObjectName;
/

Grant execute on ObjectName to public;

