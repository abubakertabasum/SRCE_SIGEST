spool expdemo.log
@@tedemo.drp
rem Create new datasources

create table loc (
        loc_ID             NUMBER(3),
        REGIONAL_GROUP          VARCHAR2(20)
        ,created_by VARCHAR2(100) DEFAULT USER
        ,created_on DATE DEFAULT SYSDATE
        ,changed_by VARCHAR2(100) DEFAULT USER
        ,changed_on DATE DEFAULT SYSDATE        
        );




create table DEPARTMENT (
        DEPARTMENT_ID           NUMBER(2),
        NAME                    VARCHAR2(14),
        loc_ID             NUMBER(3)
        ,created_by VARCHAR2(100) DEFAULT USER
        ,created_on DATE DEFAULT SYSDATE
        ,changed_by VARCHAR2(100) DEFAULT USER
        ,changed_on DATE DEFAULT SYSDATE        
        );




create table JOB (
        JOB_ID                  NUMBER(3),
        FUNCTION                VARCHAR2(30)
        ,created_by VARCHAR2(100) DEFAULT USER
        ,created_on DATE DEFAULT SYSDATE
        ,changed_by VARCHAR2(100) DEFAULT USER
        ,changed_on DATE DEFAULT SYSDATE        
        );




create table EMPLOYEE (
        EMPLOYEE_ID             NUMBER(4),
        LAST_NAME               VARCHAR2(15),
        FIRST_NAME              VARCHAR2(15),
        MIDDLE_INITIAL          VARCHAR2(1),
        JOB_ID                  NUMBER(3),
        MANAGER_ID              NUMBER(4),
        HIRE_DATE               DATE DEFAULT SYSDATE,
        SALARY                  NUMBER(7,2),
        COMMISSION              NUMBER(7,2),
        DEPARTMENT_ID           NUMBER(2),
        empno INTEGER,
        ename VARCHAR2(30)
        ,created_by VARCHAR2(100) DEFAULT USER
        ,created_on DATE DEFAULT SYSDATE
        ,changed_by VARCHAR2(100) DEFAULT USER
        ,changed_on DATE DEFAULT SYSDATE        
        );






/* Intersection table, no non-primary key columns. */
create table locemp (
        EMPLOYEE_ID             NUMBER(4),
        loc_ID             NUMBER(3)
        ,created_by VARCHAR2(100) DEFAULT USER
        ,created_on DATE DEFAULT SYSDATE
        ,changed_by VARCHAR2(100) DEFAULT USER
        ,changed_on DATE DEFAULT SYSDATE        
        );




create table salhist (
   employee_id NUMBER(4),
   raise_date DATE,
   salary NUMBER(7,2),
   comments VARCHAR2(2000)
        ,created_by VARCHAR2(100) DEFAULT USER
        ,created_on DATE DEFAULT SYSDATE
        ,changed_by VARCHAR2(100) DEFAULT USER
        ,changed_on DATE DEFAULT SYSDATE        
           );






/* Table with very long names. */
create table table_w_excessively_long_nm (
   first_column_with_very_long_nm INTEGER,
   sec_column_with_very_long_nm VARCHAR2(100)
        ,created_by VARCHAR2(100) DEFAULT USER
        ,created_on DATE DEFAULT SYSDATE
        ,changed_by VARCHAR2(100) DEFAULT USER
        ,changed_on DATE DEFAULT SYSDATE        
   );


rem Insert Data
insert into loc
     values(122, 'NEW YORK', user, sysdate, user, sysdate);
insert into loc
     values(124, 'DALLAS', user, sysdate, user, sysdate);
insert into loc
     values(123, 'CHICAGO', user, sysdate, user, sysdate);
insert into loc
     values(167, 'BOSTON', user, sysdate, user, sysdate);


insert into department
     values(10, 'ACCOUNTING', '122', user, sysdate, user, sysdate);
insert into department
     values(20, 'RESEARCH', '124', user, sysdate, user, sysdate);
insert into department
     values(30, 'SALES', '123', user, sysdate, user, sysdate);
insert into department
     values(40, 'OPERATIONS', '167', user, sysdate, user, sysdate);


insert into department
     values(12, 'RESEARCH12', '122', user, sysdate, user, sysdate);


insert into department
     values(13, 'SALES13', '122', user, sysdate, user, sysdate);


insert into department
     values(14, 'OPERATIONS14', '122', user, sysdate, user, sysdate);


insert into department
     values(23, 'SALES23', '124', user, sysdate, user, sysdate);


insert into department
     values(24, 'OPERATIONS24', '124', user, sysdate, user, sysdate);


insert into department
     values(34, 'OPERATIONS34', '123', user, sysdate, user, sysdate);


insert into department
     values(43, 'SALES43', '167', user, sysdate, user, sysdate);


insert into job
     values(667, 'CLERK', user, sysdate, user, sysdate);
insert into job
     values(668, 'STAFF', user, sysdate, user, sysdate);
insert into job
     values(669, 'ANALYST', user, sysdate, user, sysdate);
insert into job
     values(670, 'SALESPERSON', user, sysdate, user, sysdate);
insert into job
     values(671, 'MANAGER', user, sysdate, user, sysdate);
insert into job
     values(672, 'PRESIDENT', user, sysdate, user, sysdate);


insert into employee
     values(7369, 'SMITH', 'JOHN', 'Q', 667, 7902, to_date(2446052,
                                                   'J'
                                                   ), 800,
            null, 20, null, null, user, sysdate, user, sysdate);
insert into employee
     values(7499, 'ALLEN', 'KEVIN', 'J', 670, 7698, to_date(2446117,
                                                    'J'
                                                    ),
            1600, 300, 30, null, null, user, sysdate, user, sysdate);
insert into employee
     values(7505, 'DOYLE', 'JEAN', 'K', 671, 7839, to_date(2446160,
                                                   'J'
                                                   ), 2850,
            null, 13, null, null, user, sysdate, user, sysdate);
insert into employee
     values(7506, 'DENNIS', 'LYNN', 'S', 671, 7839, to_date(2446201,
                                                    'J'
                                                    ),
            2750, null, 23, null, null, user, sysdate, user, sysdate);
insert into employee
     values(7507, 'BAKER', 'LESLIE', 'D', 671, 7839, to_date(2446227,
                                                     'J'
                                                     ),
            2200, null, 14, null, null, user, sysdate, user, sysdate);
insert into employee
     values(7521, 'WARD', 'CYNTHIA', 'D', 670, 7698, to_date(2446119,
                                                     'J'
                                                     ),
            1250, 500, 30, null, null, user, sysdate, user, sysdate);
insert into employee
     values(7555, 'PETERS', 'DANIEL', 'T', 670, 7505, to_date(2446156,
                                                      'J'
                                                      ),
            1250, 300, 13, null, null, user, sysdate, user, sysdate);
insert into employee
     values(7557, 'SHAW', 'KAREN', 'P', 670, 7505, to_date(2446158,
                                                   'J'
                                                   ), 1250,
            1200, 13, null, null, user, sysdate, user, sysdate);
insert into employee
     values(7560, 'DUNCAN', 'SARAH', 'S', 670, 7506, to_date(2446217,
                                                     'J'
                                                     ),
            1250, null, 23, null, null, user, sysdate, user, sysdate);
insert into employee
     values(7564, 'LANGE', 'GREGORY', 'J', 670, 7506, to_date(2446218,
                                                      'J'
                                                      ),
            1250, 300, 23, null, null, user, sysdate, user, sysdate);
insert into employee
     values(7566, 'JONES', 'TERRY', 'M', 671, 7839, to_date(2446158,
                                                    'J'
                                                    ),
            2975, null, 20, null, null, user, sysdate, user, sysdate);
insert into employee
     values(7569, 'ALBERTS', 'CHRIS', 'L', 671, 7839, to_date(2446162,
                                                      'J'
                                                      ),
            3000, null, 12, null, null, user, sysdate, user, sysdate);
insert into employee
     values(7600, 'PORTER', 'RAYMOND', 'Y', 670, 7505, to_date(2446171,
                                                       'J'
                                                       ),
            1250, 900, 13, null, null, user, sysdate, user, sysdate);
insert into employee
     values(7609, 'LEWIS', 'RICHARD', 'M', 668, 7507, to_date(2446172,
                                                      'J'
                                                      ),
            1800, null, 24, null, null, user, sysdate, user, sysdate);
insert into employee
     values(7654, 'MARTIN', 'KENNETH', 'J', 670, 7698, to_date(2446337,
                                                       'J'
                                                       ),
            1250, 1400, 30, null, null, user, sysdate, user, sysdate);
insert into employee
     values(7676, 'SOMMERS', 'DENISE', 'D', 668, 7507, to_date(2446175,
                                                       'J'
                                                       ),
            1850, null, 34, null, null, user, sysdate, user, sysdate);
insert into employee
     values(7698, 'BLAKE', 'MARION', 'S', 671, 7839, to_date(2446187,
                                                     'J'
                                                     ),
            2850, null, 30, null, null, user, sysdate, user, sysdate);
insert into employee
     values(7782, 'CLARK', 'CAROL', 'F', 671, 7839, to_date(2446226,
                                                    'J'
                                                    ),
            2450, null, 10, null, null, user, sysdate, user, sysdate);
insert into employee
     values(7788, 'SCOTT', 'DONALD', 'T', 669, 7566, to_date(2446774,
                                                     'J'
                                                     ),
            3000, null, 20, null, null, user, sysdate, user, sysdate);
insert into employee
     values(7789, 'WEST', 'LIVIA', 'N', 670, 7506, to_date(2446160,
                                                   'J'
                                                   ), 1500,
            1000, 23, null, null, user, sysdate, user, sysdate);
insert into employee
     values(7799, 'FISHER', 'MATTHEW', 'G', 669, 7569, to_date(2446777,
                                                       'J'
                                                       ),
            3000, null, 12, null, null, user, sysdate, user, sysdate);
insert into employee
     values(7820, 'ROSS', 'PAUL', 'S', 670, 7505, to_date(2446218,
                                                  'J'
                                                  ), 1300,
            800, 43, null, null, user, sysdate, user, sysdate);
insert into employee
     values(7839, 'KING', 'FRANCIS', 'A', 672, null, to_date(2446387,
                                                     'J'
                                                     ),
            5000, null, 10, null, null, user, sysdate, user, sysdate);
insert into employee
     values(7844, 'TURNER', 'MARY', 'A', 670, 7698, to_date(2446317,
                                                    'J'
                                                    ),
            1500, 0, 30, null, null, user, sysdate, user, sysdate);
insert into employee
     values(7876, 'ADAMS', 'DIANE', 'G', 667, 7788, to_date(2446808,
                                                    'J'
                                                    ),
            1100, null, 20, null, null, user, sysdate, user, sysdate);
insert into employee
     values(7900, 'JAMES', 'FRED', 'S', 667, 7698, to_date(2446403,
                                                   'J'
                                                   ), 950,
            null, 30, null, null, user, sysdate, user, sysdate);
insert into employee
     values(7902, 'FORD', 'JENNIFER', 'D', 669, 7566, to_date(2446403,
                                                      'J'
                                                      ),
            3000, null, 20, null, null, user, sysdate, user, sysdate);
insert into employee
     values(7916, 'ROBERTS', 'GRACE', 'M', 669, 7569, to_date(2446800,
                                                      'J'
                                                      ),
            2875, null, 12, null, null, user, sysdate, user, sysdate);
insert into employee
     values(7919, 'DOUGLAS', 'MICHAEL', 'A', 667, 7799, to_date(2446800,
                                                        'J'
                                                        ),
            800, null, 12, null, null, user, sysdate, user, sysdate);
insert into employee
     values(7934, 'MILLER', 'BARBARA', 'M', 667, 7782, to_date(2446454,
                                                       'J'
                                                       ),
            1300, null, 10, null, null, user, sysdate, user, sysdate);
insert into employee
     values(7950, 'JENSEN', 'ALICE', 'B', 667, 7505, to_date(2446811,
                                                     'J'
                                                     ),
            750, null, 13, null, null, user, sysdate, user, sysdate);
insert into employee
     values(7954, 'MURRAY', 'JAMES', 'T', 667, 7506, to_date(2446812,
                                                     'J'
                                                     ),
            750, null, 23, null, null, user, sysdate, user, sysdate);


insert into locemp
select distinct   employee_id, loc_id, user, sysdate, user, sysdate
from     employee, loc;


insert into salhist
select   employee_id, hire_date, salary, null, user, sysdate, user, sysdate
from     employee;


insert into salhist
select   employee_id,
         add_months(hire_date,
         decode(department_id / 10,
         1, 6,
         2, 12,
         3, 18,
         9
         )
         ),
         salary + least(rownum * 1000,
                  2500
                  ), null, user, sysdate, user,
         sysdate
from     employee;


/* Check constraints */



alter TABLE DEPARTMENT ADD CONSTRAINT DEPTNO_NN
   CHECK (DEPARTMENT_ID IS NOT NULL);


alter TABLE EMPLOYEE ADD CONSTRAINT EMPNO_NN
   CHECK (EMPLOYEE_ID IS NOT NULL);


alter TABLE EMPLOYEE ADD CONSTRAINT EMPLOYEE$DEPTNO_NN
   CHECK (DEPARTMENT_ID IS NOT NULL);


alter TABLE EMPLOYEE ADD CONSTRAINT EMPLOYEE$COMPLEX
   CHECK (DEPARTMENT_ID > 0 AND (salary > 0 OR salary IS NULL));


alter TABLE JOB ADD CONSTRAINT JOBID_NN
   CHECK (JOB_ID IS NOT NULL);


alter TABLE JOB ADD CONSTRAINT JOBFN_NN
   CHECK (FUNCTION IS NOT NULL);


alter TABLE loc ADD CONSTRAINT LOC_NN
   CHECK (loc_ID IS NOT NULL);


alter TABLE salhist ADD CONSTRAINT SAL_POSITIVE
   CHECK (salary > 0);


/* Primary keys */



alter TABLE DEPARTMENT ADD CONSTRAINT DEPT_PK
   PRIMARY KEY (DEPARTMENT_ID);


alter TABLE EMPLOYEE ADD CONSTRAINT EMP_PK
   PRIMARY KEY (EMPLOYEE_ID);


alter TABLE JOB ADD CONSTRAINT JOB_PK
   PRIMARY KEY (JOB_ID);


alter TABLE loc ADD PRIMARY KEY (loc_ID);


alter TABLE locemp ADD CONSTRAINT LOCEMP_PK
   PRIMARY KEY (EMPLOYEE_ID, LOC_ID);


alter TABLE salhist ADD CONSTRAINT SALHIST_PK
   PRIMARY KEY (EMPLOYEE_ID, RAISE_DATE);


alter TABLE table_w_excessively_long_nm ADD CONSTRAINT table_w_excessively_long_pk
   PRIMARY KEY (sec_column_with_very_long_nm);


/* Foreign keys */



alter TABLE DEPARTMENT ADD CONSTRAINT DEPT_LOC_LOOKUP
   FOREIGN KEY (loc_ID) REFERENCES loc;


alter TABLE EMPLOYEE ADD CONSTRAINT EMP_JOB_LOOKUP
   FOREIGN KEY (JOB_ID) REFERENCES JOB;


alter TABLE EMPLOYEE ADD CONSTRAINT EMP_MGR_LOOKUP
   FOREIGN KEY (MANAGER_ID) REFERENCES EMPLOYEE;


alter TABLE EMPLOYEE ADD CONSTRAINT EMP_DEPT_LOOKUP
   FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENT;


alter TABLE salhist ADD CONSTRAINT SALHIST_EMP_LOOKUP
   FOREIGN KEY (employee_ID) REFERENCES employee;


alter TABLE locemp ADD CONSTRAINT LE_LOC_LOOKUP
   FOREIGN KEY (loc_ID) REFERENCES loc;


alter TABLE locemp ADD CONSTRAINT LE_EMP_LOOKUP
   FOREIGN KEY (employee_ID) REFERENCES employee;


alter TABLE table_w_excessively_long_nm ADD CONSTRAINT table_w_excessively_long_fk
   FOREIGN KEY (first_column_with_very_long_nm) REFERENCES employee;




create sequence employee_id_seq;


create sequence loc_id_seq;


create sequence department_id_seq;


create sequence seq$job;




create unique INDEX i_regional_group on loc (regional_group);


create unique INDEX i_department_name on department (name);


create unique INDEX i_job_function on job (function);


create unique INDEX i_employee_name on employee (last_name, first_name, middle_initial);




create index very_long_index_name_again ON table_w_excessively_long_nm (
   first_column_with_very_long_nm, sec_column_with_very_long_nm);




spool OFF
