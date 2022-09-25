REM 
REM  This script will create TOAD objects in the current
REM  schema.  If you want to create Explain Plan tables 
REM  in a separate schema called TOAD, load the file
REM  TOADPREP.SQL
REM 
REM                  NOTE   NOTE   NOTE
REM 
REM  The Explain Plan tables will be created in the CURRENT
REM  SCHEMA!
REM 
REM  Ver  Date         Description
REM  ===  ==========  ================   =======================================
REM  1.1  10/06/1999  1. Added STORAGE clauses to the table
REM                      create commands so that not too much
REM                      disk space will be allocated.
REM                   2. Removed obsolete TOAD_TEMP and 
REM                      TOAD_DEP_TEMP.
REM  1.2  03/16/2000  1. Changed index on TOAD_PLAN_TABLE from
REM                      unique to non-unique.
REM  1.3  05/23/2001  1. Added partition-related columns and
REM                      DISTRIBUTION to TOAD_PLAN_TABLE  

DROP TABLE TOAD_PLAN_SQL;

CREATE TABLE TOAD_PLAN_SQL (
USERNAME     VARCHAR2(30),
STATEMENT_ID VARCHAR2(32),
TIMESTAMP    DATE,
STATEMENT    VARCHAR2(2000) )
STORAGE (INITIAL 40K NEXT 24K); 

CREATE UNIQUE INDEX TPSQL_IDX ON
TOAD_PLAN_SQL ( STATEMENT_ID );

DROP TABLE TOAD_PLAN_TABLE;

CREATE TABLE TOAD_PLAN_TABLE (
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

CREATE INDEX TPTBL_IDX ON
TOAD_PLAN_TABLE ( STATEMENT_ID );

DROP   SEQUENCE TOAD_SEQ;
CREATE SEQUENCE TOAD_SEQ START WITH 1 CACHE 20;

DROP   PUBLIC SYNONYM TOAD_PLAN_SQL;
CREATE PUBLIC SYNONYM TOAD_PLAN_SQL FOR TOAD_PLAN_SQL;

DROP   PUBLIC SYNONYM TOAD_PLAN_TABLE;
CREATE PUBLIC SYNONYM TOAD_PLAN_TABLE FOR TOAD_PLAN_TABLE;

DROP   PUBLIC SYNONYM TOAD_SEQ ;
CREATE PUBLIC SYNONYM TOAD_SEQ FOR TOAD_SEQ;

GRANT SELECT, INSERT, UPDATE, DELETE ON TOAD_PLAN_SQL TO PUBLIC;

GRANT SELECT, INSERT, UPDATE, DELETE ON TOAD_PLAN_TABLE TO PUBLIC;

GRANT SELECT, ALTER ON TOAD_SEQ TO PUBLIC;
