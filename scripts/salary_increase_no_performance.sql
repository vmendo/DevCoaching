CREATE OR REPLACE PROCEDURE salary_increase IS
BEGIN
  UPDATE employees
  SET salary = salary * 1.05,
      last_salary_review = SYSDATE
  WHERE (last_salary_review IS NULL OR last_salary_review < ADD_MONTHS(SYSDATE, -24))
    AND fire_date IS NULL;
END;
/

