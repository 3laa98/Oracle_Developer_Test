CREATE OR REPLACE PROCEDURE MarkAttendance (
    P_EMPLOYEE_ID IN NUMBER,
    P_ATTENDANCE_DATE IN DATE,
    P_ATTENDANCE_STATUS IN VARCHAR,
    O_ERROR_CODE OUT VARCHAR,
    O_ERROR_DESC OUT VARCHAR
 ) IS

    V_ERROR_CODE VARCHAR(100);
    V_ERROR_DESC VARCHAR(1000);

    EX_INVALID_STATUS EXCEPTION;
    EX_NULL_VALUES EXCEPTION;

 BEGIN

    IF(P_EMPLOYEE_ID IS NULL OR P_ATTENDANCE_DATE IS NULL OR P_ATTENDANCE_STATUS IS NULL  ) THEN
    V_ERROR_CODE := 'ERR-001';
    V_ERROR_DESC := 'All input parameters must be provided.';
    RAISE EX_NULL_VALUES;
    END IF;

    IF(P_ATTENDANCE_STATUS NOT IN ('Present','Absent')) THEN
    V_ERROR_CODE := 'ERR-002';
    V_ERROR_DESC := 'Invalid Attendance Status. Expected values are Present or Absent.';
    RAISE EX_INVALID_STATUS;
    END IF;

    MERGE INTO ATTENDANCE A
    USING (SELECT P_EMPLOYEE_ID, P_ATTENDANCE_DATE, P_ATTENDANCE_STATUS FROM DUAL) T
    ON (A.C_EMPLOYEEID = T.P_EMPLOYEE_ID AND A.C_ATTENDANCEDATE = T.P_ATTENDANCE_DATE)
    WHEN MATCHED THEN
        UPDATE SET A.C_STATUS = t.P_ATTENDANCE_STATUS
    WHEN NOT MATCHED THEN
        INSERT (C_EMPLOYEEID, C_ATTENDANCEDATE, C_STATUS)
        VALUES (T.P_EMPLOYEE_ID, T.P_ATTENDANCE_DATE, T.P_ATTENDANCE_STATUS);

    O_ERROR_CODE := '1';
    O_ERROR_DESC := 'SUCCESS';

    COMMIT;


EXCEPTION

    WHEN EX_INVALID_STATUS THEN
    O_ERROR_CODE := V_ERROR_CODE;
    O_ERROR_DESC := V_ERROR_DESC;

    WHEN EX_NULL_VALUES THEN
    O_ERROR_CODE := V_ERROR_CODE;
    O_ERROR_DESC := V_ERROR_DESC;

    WHEN OTHERS THEN
    O_ERROR_CODE := SQLCODE;
    O_ERROR_DESC := SQLERRM;

END MarkAttendance;
