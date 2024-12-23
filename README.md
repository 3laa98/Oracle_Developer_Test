# Oracle_Developer_Test

SETUP:
1. Execute Intialize_table.sql, that will create requested tables in Part one.
2. Execute Mark_Attendancr_Table.sql, that will create the stored procedure for adding attendance records.

Testing the Solution:
1. All we have to do is call MarkAttendance as the following:

DECLARE

V_ERROR_CODE VARCHAR(100);
V_ERROR_DESC VARCHAR(1000);

BEGIN
MarkAttendance(
    P_EMPLOYEE_ID => 1,
    P_ATTENDANCE_DATE => TO_DATE('2025-01-01T13:30:00'),
    P_ATTENDANCE_STATUS => 'Absent',
    O_ERROR_CODE => V_ERROR_CODE,
    O_ERROR_DESC => V_ERROR_DESC
    );

    DBMS_OUTPUT.PUT_LINE(V_ERROR_CODE);
    DBMS_OUTPUT.PUT_LINE(V_ERROR_DESC);

END;
