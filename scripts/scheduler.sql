BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
    job_name        => 'JOB_ANNUAL_SALARY_INCREASE',
    job_type        => 'STORED_PROCEDURE',
    job_action      => 'salary_increase',
    start_date      => TO_TIMESTAMP_TZ('2026-01-01 00:00:00 Europe/Madrid', 'YYYY-MM-DD HH24:MI:SS TZR'),
    repeat_interval => 'FREQ=YEARLY;BYMONTH=1;BYMONTHDAY=1',
    enabled         => TRUE,
    comments        => 'Annual salary increase for qualified employees'
  );
END;
/
