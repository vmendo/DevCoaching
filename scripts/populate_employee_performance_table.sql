-- Insert controlled performance ratings for demo

INSERT INTO employee_performance (employee_id, evaluator_id, perf_date, rating) VALUES (1, 7, DATE '2025-01-01', 0);
INSERT INTO employee_performance (employee_id, evaluator_id, perf_date, rating) VALUES (2, 20, DATE '2025-01-01', 2);
INSERT INTO employee_performance (employee_id, evaluator_id, perf_date, rating) VALUES (3, 4, DATE '2025-01-01', 3);
INSERT INTO employee_performance (employee_id, evaluator_id, perf_date, rating) VALUES (4, 21, DATE '2025-01-01', 3);
INSERT INTO employee_performance (employee_id, evaluator_id, perf_date, rating) VALUES (5, 5, DATE '2025-01-01', 3);
INSERT INTO employee_performance (employee_id, evaluator_id, perf_date, rating) VALUES (6, 2, DATE '2025-01-01', 3);
INSERT INTO employee_performance (employee_id, evaluator_id, perf_date, rating) VALUES (7, 13, DATE '2025-01-01', 4);
INSERT INTO employee_performance (employee_id, evaluator_id, perf_date, rating) VALUES (8, 2, DATE '2025-01-01', 4);
INSERT INTO employee_performance (employee_id, evaluator_id, perf_date, rating) VALUES (9, 19, DATE '2025-01-01', 4);
INSERT INTO employee_performance (employee_id, evaluator_id, perf_date, rating) VALUES (10, 5, DATE '2025-01-01', 5);

-- Ensure employee with rating 5 had no salary review in the last 2 years
UPDATE employees
SET last_salary_review = DATE '2021-01-01'
WHERE employee_id = 10;

COMMIT;

