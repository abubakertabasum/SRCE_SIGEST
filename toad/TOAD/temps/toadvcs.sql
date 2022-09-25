/*
Name:     TOADVCS.SQL

Purpose:  To set up tables for TOAD to automatically check in and check out
          source when compiling in the Proc Editor.  This does not use
          Microsoft Visual Source Safe.  Instead, it adds, updates, and
          queries records in a custom table.

Version  Date         User        Notes
=======  ===========  ==========  =============================================
1.1      09-FEB-2000  S. Chapman  Added SELECT on TOAD_SOURCE_CTRL to PUBLIC so 
                                  that closing TOAD will query and ask whether 
                                  or not to check source back in.
*/

DROP TABLE TOAD_SOURCE_CTRL CASCADE CONSTRAINTS ; 

CREATE TABLE TOAD_SOURCE_CTRL ( 
  OBJECT_ID            NUMBER        NOT NULL, 
  OBJECT_TYPE          VARCHAR2(12)  NOT NULL, 
  OBJECT_OWNER         VARCHAR2(30)  NOT NULL, 
  OBJECT_NAME          VARCHAR2(30)  NOT NULL, 
  CHECKED_OUT          VARCHAR2(1)   NOT NULL, 
  CHECKED_OUT_BY       VARCHAR2(30), 
  CHECK_OUT_TIMESTAMP  DATE, 
  CHECK_IN_TIMESTAMP   DATE, 
  COMMENTS             VARCHAR2(2000), 
  CONSTRAINT TOAD_SRC_PK
  PRIMARY KEY ( OBJECT_ID ) 
    USING INDEX 
     STORAGE ( INITIAL 10240 NEXT 10240 PCTINCREASE 50 )) 
 STORAGE ( 
   INITIAL 10240 NEXT 10240 PCTINCREASE 50
   MINEXTENTS 1 MAXEXTENTS 121 )
   NOCACHE; 

CREATE INDEX TOAD_SRC_IDX1 ON 
  TOAD_SOURCE_CTRL(CHECKED_OUT, CHECKED_OUT_BY) 
  STORAGE(INITIAL 10240 NEXT 10240 PCTINCREASE 50 ) ; 

GRANT SELECT, INSERT, UPDATE ON TOAD_SOURCE_CTRL TO PUBLIC;

