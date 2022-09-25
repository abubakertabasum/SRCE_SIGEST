/*
	This script allows you to update your existing TOAD Security tables
	to version 7.2 of TOAD.  It removes all data from the TOAD_FEATURES
	table and repopulates the table with an updated list of privileges.  Your users
	will still have (or not have) the privileges that are common to the older
        version and the newer version.  You may then want to grant the new options 
        to your users.

	Log in as TOAD, and run this script through SQL*Plus or the SQL Editor.
*/

TRUNCATE TABLE TOAD_FEATURES REUSE STORAGE;

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
commit;