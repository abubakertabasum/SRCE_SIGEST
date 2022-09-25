=========+=========+=========+=========+=========+=========+=========+=========
                TOAD (r) Copyright (c) 1995-2000 Quest Software
                    Tool for Oracle Application Developers
                              All Rights Reserved
=========+=========+=========+=========+=========+=========+=========+=========

LAST REVISED: Tuesday, February 1, 2000

                            ------------------
                            Table of Contents:
                            ------------------

                            1. TOAD REQUIREMENTS/INSTALL
                            2. Oracle SQL*Net
                            3. SQL*NET2 CONNECTIONS
                            4. LICENSING ISSUES, ADD-ON MODULES
                            5. LICENSE FILE(s)
                            6. WHAT IS TOAD?
                            7. GETTING STARTED
                            8. PRESERVING PREVIOUS EDITOR OPTIONS
                            9. TECHNICAL SUPPORT

Thank you for your interest in Quest Software products!

----------------------
NOTE:
----------------------

In order to get TOAD working, you MUST enter the software registration
key, contained in file TEMP.KEY, when prompted at TOAD startup.

----------------------------
1. TOAD REQUIREMENTS/INSTALL
----------------------------

(1). For the TOAD temp tables, run TEMPS\TOADPREP.SQL to create a separate TOAD
     schema and create the two tables required for storage and retrieval of the
     Explain Plan results.  Or if you do not want a separate schema for the TOAD 
     Explain Plan tables, run TEMPS\NOTOAD.SQL.
(2). For the TOAD Profiler, run TEMPS\TOADProfiler.sql to create the required
     objects to Profile PL/SQL code.  This is an Oracle 8i feature only.
(3). For the TOAD Security feature, run TEMPS\TOADSecurity.sql to create the
     two tables required for TOAD features covered by the security feature, and
     a list of users and what TOAD features they can execute.
(4). The installation script now takes care of creating folders, and installing
     the files.  No need to unzip TOAD.ZIP anymore.

-----------------
2. Oracle SQL*Net
-----------------

TOAD requires a complete SQL*Net or Net8 installation.  It is not sufficient to
run SQL*Plus and conclude that SQL*Net/Net8 is installed properly because
SQL*Plus does NOT use all of the same infrastructure and components that any
other third party tool, TOAD included, uses to connect to Oracle.

Oracle installers are notorious for breaking windows registry settings, PATH
settings, etc.

If you are having trouble connecting TOAD to Oracle, here are a few things to
check.  Also, you can download a Oracle connection test utility program from
http://www.toadsoft.com/oratoad.zip, which will display the route TOAD takes to
connect to Oracle, and display this information to you.

     -------------------------------------------
     Step (1). Determine your ORACLE_HOME value.
     -------------------------------------------
 
     The first thing to check is the ORACLE_HOME value.  Look in your windows
     registry, via Start|Run|Regedit, drill down to:
     
          HKEY_LOCAL_MACHINE\Software\ORACLE
     
     There should be an entry for ORACLE_HOME, as well as many other entries.  
     Like this:
 
          [HKEY_LOCAL_MACHINE\Software\ORACLE]
          "ORACLE_HOME"="C:\ORAWIN95"

     In this case, my ORACLE_HOME on this Windows 95 box is "c:\orawin95".
 
     If you have Oracle8i or a Oracle product called the "Home Switcher" which
     gives you the option of changing ORACLE_HOME settings to reconfigure your
     computer for access to several different types of Oracle Databases, then
     your registry settings will look like this:
 
          [HKEY_LOCAL_MACHINE\Software\ORACLE\ALL_HOMES]
          "HOME_COUNTER"="1"
          "DEFAULT_HOME"="DEFAULT_HOME"
          "LAST_HOME"="0"
 
          [HKEY_LOCAL_MACHINE\Software\ORACLE\HOME0]
          "ID"="0"
          "ORACLE_HOME"="C:\ORAWIN95"
          "ORACLE_HOME_NAME"="DEFAULT_HOME"

     When Oracle connects, it will look in ALL_HOMES for the "LAST_HOME" value,
     which in this case is zero "0".  It appends zero to "HOME" to produce
     "HOME0", then it looks in HKLM\Software\ORACLE\HOME0 for the ORACLE_HOME
     value.
 
     ----------------------------------------------
     Step (2). Make sure ORACLE_HOME\bin is in PATH
     ----------------------------------------------
 
     In either case, ORACLE_HOME\bin must be in the user's PATH environment
     variable.  Go to a DOS prompt, type "PATH" and see what your path is.  It
     could look like this:
 
          PATH=C:\PROGRA~1\MSOFFICE\OFFICE;C:\WINDOWS;C:\ORAWIN95\BIN;
 
     You could either go through the Control Panel to alter the PATH, or edit
     AUTOEXEC.BAT in the root c:\ folder.
 
     ------------------------------------------------------------------
     Step (3). Make sure the Oracle interface DLL is in the BIN folder.
     ------------------------------------------------------------------
 
     TOAD requires an Oracle interface DLL to connect.  Depending on the
     database version you are connecting to, it is called ORAxy.DLL, where xy
     is the database version, e.g., for 7.0 it is called ORA70.DLL, 7.1 it is
     called ORA71.DLL, etc.  For Net8/Oracle8i, the DLL is called
     ORACLIENT8.DLL.  If this file is not in the BIN folder, then TOAD cannot
     connect.
 
     -----------------------------------
     Step (4). Check for TNS_ADMIN value
     -----------------------------------
 
     Check the registry again for:
 
          [HKEY_LOCAL_MACHINE\Software\ORACLE]

          "TNS_ADMIN"="c:\orawin95\net80\admin"
 
     "TNS_ADMIN" should equal something like "c:\orawin95\network\admin" for 
     Windows 95 machines, and "c:\orant\network\admin" for Windows NT machines.
     TNS_ADMIN can be blank, in which case it will default to the 
     ORACLE_HOME\network\admin folder.

     Look in the tnsnames.ora file.  Make sure you have an entry for the 
     database alias you are using.  After this has been checked, reboot the 
     machine.  Should connect.
 
     SQL*Plus is NOT a good test of a correct SQL*Net install, as SQL*Plus does
     NOT use all of the infrastructure and components of a good SQL*Net install.
     Use TNSPING or TNSPING80 in a DOS prompt.

On the Login window, there is now a <SQL*Net Help> button to display the
information TOAD collected about your SQL*Net configuration, such as multiple
homes, client DLL version, PATH, and so on.

You can select an Oracle Home for the TOAD home, copy the results for tech
support, etc.

-----------------------
3. SQL*NET2 CONNECTIONS
-----------------------

TOAD also requires that all Oracle connections utilize 32 bit SQL*NET2 via TNS.
Therefore, any Oracle database accessed through TOAD must have appropriate
entries in the SQLNET2.INI and the TNSNAMES.ORA files.   If you are an Oracle
developer, you already know this and are most likely already using TNS
entries for server/protocol mapping.

Optionally, you can connect to Personal Oracle databases using "2:" as the 
database name (other possible options for Personal Oracle are LOCAL and 
BEQ-LOCAL).

-----------------------------------
4. LICENSING ISSUES, ADD-ON MODULES
-----------------------------------

If you want to upgrade from TOAD Evaluation version to TOAD Commercial version,
obtain a software registration key from www.quest.com.  Enter it and 
re-register TOAD from evaluation version to commercial version by starting TOAD,
and selecting the "Help|Register TOAD" menu item.  The evaluation key is good 
for 30 days.  The commercial key is good indefinitely.  The evaluation version 
is identical in every other way to the commercial version.

As of July, 1999, there are now three add on modules for TOAD: PL/SQL Debugger,
SQLab Tuner, and SQLab Xpert Tuner.  The TOAD evaluation software registration 
key has all three of these modules activated, for you to evaluate those
products, too.  The SQLab Tuner and Xpert Tuner requires a separate software 
installation.  The PL/SQL Debugger code is built into TOAD.EXE.

There is also an add-on product from RevealNet called PL/Formatter, that will
format your SQL for you, inside of TOAD.  See http://www.revealnet.com for more 
information about the product.  PL/Formatter for TOAD is $95/copy + maintenance. 
To purchase, contact Quest Sales at (949) 720-1434, or send email to 
info@quest.com.

With TOAD versions 6.1.6.25 and later, the minimum version of PL/Formatter that
will work with TOAD is v2.0.4.  If you have a lower version of PL/Formatter, 
TOAD will warn you with a dialog box at TOAD startup.  You can set a wealth of 
formatting options in the "View|PL/Formatter Options" dialog, including: 
General Layout: Tabs, Margins, Indenting, Linefeeds, and Header; Case: Keywords,
Variables, Built-Ins, Built-In Packages, and PL/Vision; Specific Statements: 
Select; Comments; Comment Generation: Dependencies, and Recommendations.  If
you do not have the PL/Formatter product installed, then the menu item on the 
View menu will be disabled.  Note that the trial version of PL/Formatter will 
not work with TOAD.  You must purchase the commercial version of PL/Formatter 
in order to get it working with TOAD.

For example, given this query, select it, click the right mouse button, and 
select "Format SQL" from the popup menu.

	select first_name, last_name from employee where first_name like 'S%'
        order by last_name

gets formatted into this:

	/* Formatted by PL/Formatter v2.0.8.0 on 1999/07/12 08:26  (08:26 AM) */
	SELECT first_name, last_name
	  FROM employee
	 WHERE first_name LIKE 'S%'

------------------
5. LICENSE FILE(s)
------------------

TOAD will require a valid license file upon startup.  This file must be named
TOAD.LIC.  TOAD is distributed with two license files named:  FULLTOAD.LIC and 
READONLY.LIC.  If you want to install a readonly version of TOAD for a user, 
copy READONLY.LIC over TOAD.LIC.

----------------
6. WHAT IS TOAD?
----------------

TOAD is an acronym for Tool for Oracle Application Development.  TOAD was begun
in 1995 as a personal development aid and has grown to be used daily by many 
thousands of developers.  There are similar tools on the market, but none can 
better TOAD's simple developer oriented interface, the author's attention to 
users, or the PRICE.

So, what you must remember when evaluating TOAD or while using TOAD is that 
TOAD is first and foremost a developer's aid.  The interface is simple by 
design.  The features are either what I personally want in an Oracle tool or 
what TOAD users have requested.   TOAD wasn't built on features that were 
"cool" or fun to implement; nor with an interface that looked "slick" since,
generally, the slicker it looks, the worse it is to operate.  If there is a 
feature that is lacking, a report that is missing, an interface implementation
that is nagging, send an email to support@quest.com  If it isn't there, it 
probably hasn't been requested.

------------------
7. GETTING STARTED
------------------

When TOAD first loads, the main MDI screen appears and an initial TOAD Login 
Window is displayed.  This window will prompt for a Database, UserName, and 
Password (typical Oracle stuff).  The database name should be one of the valid
Oracle TNS entries.  The user and password are the user/password for the schema
to which you want to connect.   For example, one of the sample schemas that
is installed with Personal Oracle v7.3 has a user/password of DEMO/DEMO.   The 
TNS entry may be (and this value will vary according to your installation) 
either LOCAL or BEQ-LOCAL.

Previous connections will display in a list on the left of the Login window.
TOAD does store passwords for previous logins if the appropriate option is 
enabled.  On most TOAD screens, the Oracle connection active for that screen 
will display in the first or second panel of the status bar at the bottom of 
that particular screen.  This is important to note because with several
connections active, you will need to know which connection is currently active 
for the active window.

Several TOAD functions also require the creation of Oracle tables; for example,
Explain Plan.  To create these tables, load the file \TEMPS\TOADPREP.SQL into
a SQL Edit Window; and then follow the on-screen instructions.  TOADPREP will
require creation of a new Oracle schema named TOAD.   Alternatively, if you
want to create the required Oracle tables but do not want to create a new
schema, load and execute the script file \TEMPS\NOTOAD.SQL.  NOTOAD will
create the objects in the current schema and grant public access to them
for all other users.  If you already have a PLAN_TABLE in your database, you
do not HAVE to create any TOAD objects.

-------------------------------------
8. PRESERVING PREVIOUS EDITOR OPTIONS
-------------------------------------

As of TOAD v6.3.1.17, there are new file formats:  

     HTML, INI, JAVA, PLSQL, and TEXT.

As a result, these files have been renamed:

(All files are in the \TOAD\temps folder)

Functionality                 OLD FILENAME     NEW FILENAME
=============                 ============     ============
Code Completion Templates     TOAD.DCI         PLSQL.DCI
Editor Key Assignments        EDITKEYS.BIN     PLSQLKEYS.BIN
Editor Options                EDITOPTS.TXT     PLSQLOPTS.TXT
Auto Correct Substitutions    TOADSUB.TXT      PLSQLSUB.TXT
Editor Parsing Script         TOADSCR.TXT      PLSQLSCR.TXT

Note:  many new functions require the updated PLSQLSCR.TXT file.  If you
have made custom changes to your TOADSCR.TXT file, we suggest that you
merge the changes into the new plsqlscr.txt file and do NOT merely rename
toadscr.txt to plsqlscr.txt.

If you want to preserve your Code Completion templates, Editor Key
Assignments, Editor Options, Auto Correct Substitutions, or custom
parser edits, rename or copy your files from OLD to NEW and DO NOT
unpack the new filenames from the TOAD.ZIP archive.

E.g., to preserve your Editor Options, do this:

     c:
     cd "program files\quest software\toad\temps"
     copy editopts.txt plsqlopts.txt

and DO NOT unpack plsqlopts.txt from the TOAD.ZIP archive to the
\TOAD\temps folder.

If you installed TOAD from the installation script, any overwritten files
are copied to the TOAD\backup folder.  Look in TOAD\backup for your old
copies of any overwritten files.

--------------------
9. TECHNICAL SUPPORT
--------------------

www.quest.com
support@quest.com

