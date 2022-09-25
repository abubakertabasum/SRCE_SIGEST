/*
Date        Author      Description
----------  ----------  -------------------------------------------
01/10/2000  S. Chapman  1. READONLY OVERRIDE added.
  You can assign this new "feature" to users to place TOAD in
  READONLY mode for THAT user.  The license file approach is still
  supported but if you have users that shouldn't be able to alter PROD but
  should have fuller access to DEV, use the security table. 
*/

DROP TABLE TOAD_FEATURES CASCADE CONSTRAINTS ;

CREATE TABLE TOAD_FEATURES ( 
  NAME   VARCHAR2(20)  NOT NULL, 
  DESCR  VARCHAR2(50), 
  CONSTRAINT TOAD_FEAT_PK
  PRIMARY KEY ( NAME ) ); 

INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'SCHEMA BROWSER', 'Enables the Schema Browser (ddl objects)'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'ADD COLUMN', 'SB Add Column Button on the Tables tab'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'ADD CONSTRAINT', 'SB Add Constraint Button on the Tables tab'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'ANALYZE', 'SB Analyze Table(s) button'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'DROP TABLE', 'SB Drop Table Button on the Tables tab'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'DROP TABLES', 'SB Drop ALL Tables Button on the Tables tab'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'ADD INDEX', 'SB Add Index Buttons'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'TUNING MENU', 'Main Menu TUNING menu option'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'VIEW MENU', 'Main Menu VIEW Menu option'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'CREATE MENU', 'Main Menu CREATE menu option'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'VIEW EXTENTS', 'View Menu, View Extents Window'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'VIEW TABLESPACE', 'View Menu, View Tablespaces Window'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'KILL A SESSION ', 'Kill Session Buttons'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'KILL/TRACE WINDOW', 'View Menu, Trace/Kill Window'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'SESSION STATS', 'Tuning Menu, Server Stats Window'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'TABLE PRIVS', 'Database Menu, User Privileges Window'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'DROP INDEX', 'SB Drop Index buttons'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'REBUILD TABLE', 'Database Menu, Rebuild Table Window'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'CREATE INDEX', 'Create Menu, Create Index Window'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES (
'ALTER CONSTRAINT', 'SB Enable/Disable Constraint buttons'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'ANLZE ALL TABLES', 'Database Menu, Analyze All Tables Window'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'IMPORT MENU', 'Main Menu Import Menu'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'CREATE LINK', 'Create Menu, Create Database Link Window'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'COMPILE DEPS', 'SB Compile Dependencies Button'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'COMPILE SCHEMA', 'SB Compile Schema Button'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'REBUILD INDEX', 'SB Rebuild Index Button');
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'TOAD SECURITY', 'Database Menu, TOAD Security Window');
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'READONLY OVERRIDE', 'Place TOAD in READONLY mode for this schema');

CREATE TABLE TOAD_SECURITY ( 
  USER_NAME  VARCHAR2(32)  NOT NULL, 
  FEATURE    VARCHAR2(20)  NOT NULL, 
  CONSTRAINT TOAD_SEC_PK
  PRIMARY KEY ( FEATURE, USER_NAME ) ); 

CREATE UNIQUE INDEX TOAD_SEC_FEAT_IDX ON 
  TOAD_SECURITY(USER_NAME, FEATURE); 


REM  grant all all to the toad tables WITH grant option to any users
REM  who will be using the Security Window to administer TOAD security
REM  features.
REM
REM  GRANT ALL ON TOAD_SECURITY TO SOME_DBA_USER WITH GRANT OPTION;
REM  GRANT ALL ON TOAD_FEATURES TO SOME_DBA_USER WITH GRANT OPTION;

