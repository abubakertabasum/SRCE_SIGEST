/*
	This is the script for setting up TOAD Features Security.  Log in as TOAD
	and run this script in the TOAD schema.

*/

/*
Date        Description
----------  -------------------------------------------
01/10/2000  READONLY OVERRIDE added.
  You can assign this new "feature" to users to place TOAD in
  READONLY mode for THAT user.  The license file approach is still
  supported but if you have users that shouldn't be able to alter PROD but
  should have fuller access to DEV, use the security table. 
04/01/2001  Obsolete options removed (TUNING menu, IMPORT menu, Drop All Tables).  
  Many options renamed to match new menu structure.
  TOOLS menu and DBA menu options added.
04/18/2001  "All Features of the DBA module" option added.
05/03/2001  "Create and clone users" option restored.
06/15/2001 "Flush SGA" option added, and removed the space from 'KILL A SESSION'
10/23/2001 Added chained rows window option
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
'VIEW MENU', 'Main Menu VIEW Menu option'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'CREATE MENU', 'Main Menu CREATE Menu option'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'VIEW EXTENTS', 'DBA Menu, View Extents Window'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'VIEW TABLESPACE', 'DBA Menu, View Tablespaces Window'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'KILL A SESSION', 'Kill Session Buttons'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'KILL/TRACE WINDOW', 'DBA Menu, Kill/Trace Window'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'SESSION STATS', 'DBA Menu, Server Stats Window'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'TABLE PRIVS', 'Database Menu, User Privileges Window'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'DROP INDEX', 'SB Drop Index buttons'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'REBUILD TABLE', 'Tools Menu, Rebuild Table Window'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'CREATE INDEX', 'Create Menu, Create Index Window'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'ALTER CONSTRAINT', 'SB Enable/Disable Constraint buttons'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'ANLZE ALL TABLES', 'Tools Menu, Analyze All Tables Window'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'CREATE LINK', 'Create Menu, Create Database Link Window'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'COMPILE DEPS', 'SB Compile Dependencies Button'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'COMPILE SCHEMA', 'SB Compile Schema Button'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'REBUILD INDEX', 'SB Rebuild Index Button'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'TOAD SECURITY', 'Tools Menu, TOAD Security Window'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'READONLY OVERRIDE', 'Place TOAD in READONLY mode for this schema'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'NO SAVE PASSWORDS', 'Disable saving Oracle passwords by TOAD'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'TOOLS MENU', 'Main Menu TOOLS Menu option'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'DBA MENU', 'Main Menu DBA Menu option'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'DBA MODULE', 'All of the features of the DBA module'); 
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'CREATE USER', 'Create and clone users');
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES ( 
'FLUSH SGA', 'Enable the Flush SGA Button');
INSERT INTO TOAD_FEATURES ( NAME, DESCR ) VALUES (
'CHAINED ROWS', 'DBA Menu, Chained Rows Window');
COMMIT;

CREATE TABLE TOAD_SECURITY ( 
  USER_NAME  VARCHAR2(32)  NOT NULL, 
  FEATURE    VARCHAR2(20)  NOT NULL, 
  CONSTRAINT TOAD_SEC_PK
  PRIMARY KEY ( FEATURE, USER_NAME ) ); 

CREATE UNIQUE INDEX TOAD_SEC_FEAT_IDX ON 
  TOAD_SECURITY(USER_NAME, FEATURE); 


REM  grant all to the toad tables WITH grant option to any users
REM  who will be using the Security Window to administer TOAD security
REM  features.
REM
REM  GRANT ALL ON TOAD_SECURITY TO SOME_DBA_USER WITH GRANT OPTION;
REM  GRANT ALL ON TOAD_FEATURES TO SOME_DBA_USER WITH GRANT OPTION;

