CREATE TABLE EMPLOYEES (
    C_EMPLOYEEID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    C_FIRSTNAME  VARCHAR(50) NOT NULL,
    C_LASTNAME   VARCHAR(50) NOT NULL,
    C_BIRTHDATE DATE NOT NULL,
    C_DEPARTMENT VARCHAR(50) NOT NULL,
    C_HIREDATE   DATE NOT NULL,

    CONSTRAINT UQ_EMPLOYEE UNIQUE (C_FIRSTNAME, C_LASTNAME, C_BIRTHDATE)

);



CREATE TABLE ATTENDANCE (
    C_ATTENDANCEID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    C_EMPLOYEEID NUMBER NOT NULL,
    C_ATTENDANCEDATE DATE NOT NULL,
    C_STATUS VARCHAR(10) CHECK (C_STATUS IN ('Present', 'Absent')),
    C_CREATED_AT DATE DEFAULT SYSDATE,
    C_UPDATED_AT DATE,

    CONSTRAINT FK_EMPLOYEEID FOREIGN KEY (C_EMPLOYEEID) REFERENCES EMPLOYEES(C_EMPLOYEEID)
)
PARTITION BY RANGE (C_ATTENDANCEDATE)
(
    PARTITION P_2025_01 VALUES LESS THAN (TO_DATE('2025-02-01', 'YYYY-MM-DD')),
    PARTITION P_2025_02 VALUES LESS THAN (TO_DATE('2025-03-01', 'YYYY-MM-DD')),
    PARTITION P_2025_03 VALUES LESS THAN (TO_DATE('2025-04-01', 'YYYY-MM-DD')),
    PARTITION P_2025_04 VALUES LESS THAN (TO_DATE('2025-05-01', 'YYYY-MM-DD')),
    PARTITION P_2025_05 VALUES LESS THAN (TO_DATE('2025-06-01', 'YYYY-MM-DD')),
    PARTITION P_2025_06 VALUES LESS THAN (TO_DATE('2025-07-01', 'YYYY-MM-DD')),
    PARTITION P_2025_07 VALUES LESS THAN (TO_DATE('2025-08-01', 'YYYY-MM-DD')),
    PARTITION P_2025_08 VALUES LESS THAN (TO_DATE('2025-09-01', 'YYYY-MM-DD')),
    PARTITION P_2025_09 VALUES LESS THAN (TO_DATE('2025-10-01', 'YYYY-MM-DD')),
    PARTITION P_2025_10 VALUES LESS THAN (TO_DATE('2025-11-01', 'YYYY-MM-DD')),
    PARTITION P_2025_11 VALUES LESS THAN (TO_DATE('2025-12-01', 'YYYY-MM-DD')),
    PARTITION P_2025_12 VALUES LESS THAN (TO_DATE('2026-01-01', 'YYYY-MM-DD')),
);

CREATE BITMAP INDEX IDX_ATTENDANCE_STATUS ON ATTENDANCE(C_STATUS);
CREATE INDEX IDX_ATTENDANCE_EMPLOYEEID ON ATTENDANCE(C_EMPLOYEEID);

