CREATE OR REPLACE PROCEDURE salary_increase IS
BEGIN
  UPDATE employees e
  SET salary = salary * (
        SELECT CASE 
                 WHEN ep.rating = 5 THEN 1.10
                 WHEN ep.rating = 4 THEN 1.05
                 ELSE 1
               END
        FROM employee_performance ep
        WHERE ep.employee_id = e.employee_id
          AND ep.perf_date = (
            SELECT MAX(ep2.perf_date)
            FROM employee_performance ep2
            WHERE ep2.employee_id = e.employee_id
          )
    ),
    last_salary_review = SYSDATE
  WHERE (last_salary_review IS NULL OR last_salary_review < ADD_MONTHS(SYSDATE, -24))
    AND fire_date IS NULL
    AND EXISTS (
      SELECT 1
      FROM employee_performance ep
      WHERE ep.employee_id = e.employee_id
        AND ep.rating >= 4
        AND ep.perf_date >= ADD_MONTHS(SYSDATE, -12)
    );
END;
/

