-- Populate departments
INSERT INTO departments (department_name, location) VALUES ('Shoulder Department', 'Cynthiaport');
INSERT INTO departments (department_name, location) VALUES ('Require Department', 'Sarahmouth');
INSERT INTO departments (department_name, location) VALUES ('Spring Department', 'Priceland');
INSERT INTO departments (department_name, location) VALUES ('Bar Department', 'New Megan');
INSERT INTO departments (department_name, location) VALUES ('Current Department', 'New Cherylside');
INSERT INTO departments (department_name, location) VALUES ('Cause Department', 'Seanborough');
INSERT INTO departments (department_name, location) VALUES ('Agree Department', 'Port Dennis');
INSERT INTO departments (department_name, location) VALUES ('Short Department', 'Robertberg');
INSERT INTO departments (department_name, location) VALUES ('Behavior Department', 'New David');
INSERT INTO departments (department_name, location) VALUES ('Sport Department', 'Sawyerstad');
INSERT INTO departments (department_name, location) VALUES ('List Department', 'Stonetown');
INSERT INTO departments (department_name, location) VALUES ('Something Department', 'East Isaiahchester');
INSERT INTO departments (department_name, location) VALUES ('Imagine Department', 'East Heather');
INSERT INTO departments (department_name, location) VALUES ('Dinner Department', 'Lake Michelle');
INSERT INTO departments (department_name, location) VALUES ('Finish Department', 'New Kerry');
INSERT INTO departments (department_name, location) VALUES ('Here Department', 'East James');
INSERT INTO departments (department_name, location) VALUES ('Every Department', 'Allisonberg');
INSERT INTO departments (department_name, location) VALUES ('Mother Department', 'Lake Richard');
INSERT INTO departments (department_name, location) VALUES ('Car Department', 'North Gailfurt');
INSERT INTO departments (department_name, location) VALUES ('Approach Department', 'South Michael');
INSERT INTO departments (department_name, location) VALUES ('Require Department', 'East Douglas');
INSERT INTO departments (department_name, location) VALUES ('Owner Department', 'East Curtisbury');
INSERT INTO departments (department_name, location) VALUES ('Along Department', 'East Joshuatown');
INSERT INTO departments (department_name, location) VALUES ('Would Department', 'East Micheal');
INSERT INTO departments (department_name, location) VALUES ('Though Department', 'Garciafort');
INSERT INTO departments (department_name, location) VALUES ('Foreign Department', 'Fischerberg');
INSERT INTO departments (department_name, location) VALUES ('Camera Department', 'Jonesville');
INSERT INTO departments (department_name, location) VALUES ('Deep Department', 'Brittanyton');
INSERT INTO departments (department_name, location) VALUES ('Probably Department', 'Fordview');
INSERT INTO departments (department_name, location) VALUES ('Thousand Department', 'North Hunterchester');

-- Populate jobs
INSERT INTO jobs (job_title, min_salary, max_salary) VALUES ('Chartered certified accountant', 52076.51, 111189.08);
INSERT INTO jobs (job_title, min_salary, max_salary) VALUES ('Building services engineer', 34259.93, 86943.11);
INSERT INTO jobs (job_title, min_salary, max_salary) VALUES ('Administrator, charities/voluntary organisations', 54869.52, 104522.84);
INSERT INTO jobs (job_title, min_salary, max_salary) VALUES ('Forensic psychologist', 49652.82, 79940.52);
INSERT INTO jobs (job_title, min_salary, max_salary) VALUES ('Scientist, research (physical sciences)', 42870.86, 64074.29);
INSERT INTO jobs (job_title, min_salary, max_salary) VALUES ('Loss adjuster, chartered', 39132.74, 97638.11);
INSERT INTO jobs (job_title, min_salary, max_salary) VALUES ('Company secretary', 52875.27, 80132.04);
INSERT INTO jobs (job_title, min_salary, max_salary) VALUES ('Transport planner', 30696.61, 69353.78);
INSERT INTO jobs (job_title, min_salary, max_salary) VALUES ('Management consultant', 46673.33, 78132.93);
INSERT INTO jobs (job_title, min_salary, max_salary) VALUES ('Designer, interior/spatial', 55380.0, 108983.20999999999);
INSERT INTO jobs (job_title, min_salary, max_salary) VALUES ('Chartered management accountant', 34775.07, 61468.53);
INSERT INTO jobs (job_title, min_salary, max_salary) VALUES ('Logistics and distribution manager', 59134.94, 92794.57);
INSERT INTO jobs (job_title, min_salary, max_salary) VALUES ('Diplomatic Services operational officer', 40575.07, 75405.18);
INSERT INTO jobs (job_title, min_salary, max_salary) VALUES ('Designer, industrial/product', 54289.99, 106208.79000000001);
INSERT INTO jobs (job_title, min_salary, max_salary) VALUES ('Social worker', 59158.66, 84677.58);
INSERT INTO jobs (job_title, min_salary, max_salary) VALUES ('Primary school teacher', 43777.01, 96613.29000000001);
INSERT INTO jobs (job_title, min_salary, max_salary) VALUES ('Geoscientist', 43186.75, 102396.26000000001);
INSERT INTO jobs (job_title, min_salary, max_salary) VALUES ('Teacher, primary school', 48046.24, 73403.19);
INSERT INTO jobs (job_title, min_salary, max_salary) VALUES ('Engineer, water', 59118.99, 116698.37);
INSERT INTO jobs (job_title, min_salary, max_salary) VALUES ('Wellsite geologist', 40165.93, 90542.33);
INSERT INTO jobs (job_title, min_salary, max_salary) VALUES ('Trade mark attorney', 36582.77, 87608.59);
INSERT INTO jobs (job_title, min_salary, max_salary) VALUES ('Engineer, civil (consulting)', 39830.19, 92020.04000000001);
INSERT INTO jobs (job_title, min_salary, max_salary) VALUES ('Surveyor, building', 58380.2, 85550.81);
INSERT INTO jobs (job_title, min_salary, max_salary) VALUES ('Forensic psychologist', 57766.31, 86932.16);
INSERT INTO jobs (job_title, min_salary, max_salary) VALUES ('Theatre stage manager', 58633.24, 96398.65);
INSERT INTO jobs (job_title, min_salary, max_salary) VALUES ('Retail banker', 51726.38, 74727.62);
INSERT INTO jobs (job_title, min_salary, max_salary) VALUES ('Sales executive', 51672.7, 84626.53);
INSERT INTO jobs (job_title, min_salary, max_salary) VALUES ('Merchandiser, retail', 56609.04, 105266.19);
INSERT INTO jobs (job_title, min_salary, max_salary) VALUES ('Journalist, broadcasting', 58272.94, 90188.35);
INSERT INTO jobs (job_title, min_salary, max_salary) VALUES ('Minerals surveyor', 30770.58, 63652.39);

-- Populate employees
INSERT INTO employees (
            first_name, last_name, email, hire_date, salary, last_salary_review, fire_date,
            department_id, manager_id, job_id
        ) VALUES (
            'Gary', 'Reese', 'gary.reese@example.com', DATE '2020-01-10', 42574.31, DATE '2021-01-23', NULL,
            27, NULL, 30
        );
INSERT INTO employees (
            first_name, last_name, email, hire_date, salary, last_salary_review, fire_date,
            department_id, manager_id, job_id
        ) VALUES (
            'Angel', 'Gonzalez', 'angel.gonzalez@example.com', DATE '2020-12-05', 69504.39, DATE '2022-05-09', NULL,
            11, NULL, 10
        );
INSERT INTO employees (
            first_name, last_name, email, hire_date, salary, last_salary_review, fire_date,
            department_id, manager_id, job_id
        ) VALUES (
            'Travis', 'Jennings', 'travis.jennings@example.com', DATE '2016-11-06', 57133.56, DATE '2017-08-16', NULL,
            24, NULL, 3
        );
INSERT INTO employees (
            first_name, last_name, email, hire_date, salary, last_salary_review, fire_date,
            department_id, manager_id, job_id
        ) VALUES (
            'Thomas', 'Garcia', 'thomas.garcia@example.com', DATE '2016-05-03', 85760.12, DATE '2017-11-29', NULL,
            12, 2, 28
        );
INSERT INTO employees (
            first_name, last_name, email, hire_date, salary, last_salary_review, fire_date,
            department_id, manager_id, job_id
        ) VALUES (
            'Nicole', 'Martinez', 'nicole.martinez@example.com', DATE '2017-12-22', 79294.38, DATE '2018-10-28', NULL,
            20, 3, 27
        );
INSERT INTO employees (
            first_name, last_name, email, hire_date, salary, last_salary_review, fire_date,
            department_id, manager_id, job_id
        ) VALUES (
            'Michael', 'Tate', 'michael.tate@example.com', DATE '2021-10-16', 43745.03, DATE '2023-05-23', NULL,
            7, 1, 27
        );
INSERT INTO employees (
            first_name, last_name, email, hire_date, salary, last_salary_review, fire_date,
            department_id, manager_id, job_id
        ) VALUES (
            'Danielle', 'Jacobs', 'danielle.jacobs@example.com', DATE '2021-12-31', 32564.38, DATE '2024-04-26', NULL,
            16, 5, 19
        );
INSERT INTO employees (
            first_name, last_name, email, hire_date, salary, last_salary_review, fire_date,
            department_id, manager_id, job_id
        ) VALUES (
            'Edward', 'Webb', 'edward.webb@example.com', DATE '2020-11-04', 45033.37, DATE '2021-07-23', DATE '2023-04-18',
            24, 1, 9
        );
INSERT INTO employees (
            first_name, last_name, email, hire_date, salary, last_salary_review, fire_date,
            department_id, manager_id, job_id
        ) VALUES (
            'Amy', 'Thomas', 'amy.thomas@example.com', DATE '2020-02-14', 55790.32, DATE '2022-05-13', NULL,
            25, 7, 21
        );
INSERT INTO employees (
            first_name, last_name, email, hire_date, salary, last_salary_review, fire_date,
            department_id, manager_id, job_id
        ) VALUES (
            'Laura', 'Henderson', 'laura.henderson@example.com', DATE '2022-03-11', 99676.88, DATE '2023-04-07', NULL,
            30, 4, 20
        );
INSERT INTO employees (
            first_name, last_name, email, hire_date, salary, last_salary_review, fire_date,
            department_id, manager_id, job_id
        ) VALUES (
            'Michelle', 'Anderson', 'michelle.anderson@example.com', DATE '2022-10-30', 39132.38, DATE '2023-06-29', NULL,
            7, 8, 10
        );
INSERT INTO employees (
            first_name, last_name, email, hire_date, salary, last_salary_review, fire_date,
            department_id, manager_id, job_id
        ) VALUES (
            'Caitlin', 'Harris', 'caitlin.harris@example.com', DATE '2019-10-08', 102592.35, DATE '2022-12-28', NULL,
            12, 4, 29
        );
INSERT INTO employees (
            first_name, last_name, email, hire_date, salary, last_salary_review, fire_date,
            department_id, manager_id, job_id
        ) VALUES (
            'Danielle', 'Hopkins', 'danielle.hopkins@example.com', DATE '2019-10-29', 72009.9, DATE '2023-01-21', NULL,
            23, 3, 2
        );
INSERT INTO employees (
            first_name, last_name, email, hire_date, salary, last_salary_review, fire_date,
            department_id, manager_id, job_id
        ) VALUES (
            'Angela', 'Cruz', 'angela.cruz@example.com', DATE '2016-02-29', 84839.13, DATE '2023-07-16', NULL,
            16, 4, 17
        );
INSERT INTO employees (
            first_name, last_name, email, hire_date, salary, last_salary_review, fire_date,
            department_id, manager_id, job_id
        ) VALUES (
            'Michael', 'Gibson', 'michael.gibson@example.com', DATE '2016-10-26', 119989.05, DATE '2017-07-30', NULL,
            3, 4, 1
        );
INSERT INTO employees (
            first_name, last_name, email, hire_date, salary, last_salary_review, fire_date,
            department_id, manager_id, job_id
        ) VALUES (
            'Steven', 'Johnson', 'steven.johnson@example.com', DATE '2021-03-18', 110711.69, DATE '2024-02-21', NULL,
            30, 2, 30
        );
INSERT INTO employees (
            first_name, last_name, email, hire_date, salary, last_salary_review, fire_date,
            department_id, manager_id, job_id
        ) VALUES (
            'Jo', 'Harmon', 'jo.harmon@example.com', DATE '2016-09-12', 118270.53, DATE '2018-04-10', NULL,
            10, 12, 29
        );
INSERT INTO employees (
            first_name, last_name, email, hire_date, salary, last_salary_review, fire_date,
            department_id, manager_id, job_id
        ) VALUES (
            'Adam', 'Ball', 'adam.ball@example.com', DATE '2017-09-06', 64460.2, DATE '2024-04-08', NULL,
            11, 13, 23
        );
INSERT INTO employees (
            first_name, last_name, email, hire_date, salary, last_salary_review, fire_date,
            department_id, manager_id, job_id
        ) VALUES (
            'Steven', 'Kelley', 'steven.kelley@example.com', DATE '2018-11-25', 48930.69, DATE '2022-09-18', NULL,
            4, 5, 5
        );
INSERT INTO employees (
            first_name, last_name, email, hire_date, salary, last_salary_review, fire_date,
            department_id, manager_id, job_id
        ) VALUES (
            'Christy', 'Ellis', 'christy.ellis@example.com', DATE '2021-06-21', 31120.3, DATE '2022-07-27', NULL,
            14, 3, 5
        );
INSERT INTO employees (
            first_name, last_name, email, hire_date, salary, last_salary_review, fire_date,
            department_id, manager_id, job_id
        ) VALUES (
            'Mary', 'Holmes', 'mary.holmes@example.com', DATE '2021-01-06', 37028.33, DATE '2021-07-29', NULL,
            1, 15, 15
        );
INSERT INTO employees (
            first_name, last_name, email, hire_date, salary, last_salary_review, fire_date,
            department_id, manager_id, job_id
        ) VALUES (
            'Charles', 'Larsen', 'charles.larsen@example.com', DATE '2016-11-12', 117442.22, DATE '2019-07-09', DATE '2020-09-05',
            20, 21, 19
        );
INSERT INTO employees (
            first_name, last_name, email, hire_date, salary, last_salary_review, fire_date,
            department_id, manager_id, job_id
        ) VALUES (
            'Sarah', 'Fernandez', 'sarah.fernandez@example.com', DATE '2022-01-07', 82917.46, DATE '2022-04-11', NULL,
            20, 8, 23
        );
INSERT INTO employees (
            first_name, last_name, email, hire_date, salary, last_salary_review, fire_date,
            department_id, manager_id, job_id
        ) VALUES (
            'Aaron', 'Hoffman', 'aaron.hoffman@example.com', DATE '2021-05-04', 69212.77, DATE '2024-01-10', NULL,
            7, 12, 3
        );
INSERT INTO employees (
            first_name, last_name, email, hire_date, salary, last_salary_review, fire_date,
            department_id, manager_id, job_id
        ) VALUES (
            'Carla', 'Hensley', 'carla.hensley@example.com', DATE '2018-04-18', 70561.53, DATE '2022-08-28', NULL,
            24, 4, 18
        );
INSERT INTO employees (
            first_name, last_name, email, hire_date, salary, last_salary_review, fire_date,
            department_id, manager_id, job_id
        ) VALUES (
            'Jessica', 'Russell', 'jessica.russell@example.com', DATE '2019-07-03', 82490.87, DATE '2022-11-09', NULL,
            4, 10, 11
        );
INSERT INTO employees (
            first_name, last_name, email, hire_date, salary, last_salary_review, fire_date,
            department_id, manager_id, job_id
        ) VALUES (
            'Brian', 'Warner', 'brian.warner@example.com', DATE '2019-02-07', 76702.12, DATE '2019-05-19', NULL,
            27, 15, 30
        );
INSERT INTO employees (
            first_name, last_name, email, hire_date, salary, last_salary_review, fire_date,
            department_id, manager_id, job_id
        ) VALUES (
            'Michelle', 'Berger', 'michelle.berger@example.com', DATE '2022-07-14', 84582.94, DATE '2023-11-17', NULL,
            20, 19, 21
        );
INSERT INTO employees (
            first_name, last_name, email, hire_date, salary, last_salary_review, fire_date,
            department_id, manager_id, job_id
        ) VALUES (
            'Jessica', 'Pope', 'jessica.pope@example.com', DATE '2016-02-07', 116685.65, DATE '2016-06-26', NULL,
            25, 8, 6
        );
INSERT INTO employees (
            first_name, last_name, email, hire_date, salary, last_salary_review, fire_date,
            department_id, manager_id, job_id
        ) VALUES (
            'Jessica', 'Patterson', 'jessica.patterson@example.com', DATE '2016-11-22', 39988.41, DATE '2021-09-01', DATE '2024-01-19',
            22, 2, 27
        );

-- Populate salary history
INSERT INTO salary_history (
            employee_id, old_salary, new_salary, change_date, reason
        ) VALUES (
            9, 109591.9, 113975.58, DATE '2024-12-17', 'Responsibility very away today purpose tell.'
        );
INSERT INTO salary_history (
            employee_id, old_salary, new_salary, change_date, reason
        ) VALUES (
            26, 73234.42, 80557.86, DATE '2025-04-23', 'Feeling spend mention hot there part.'
        );
INSERT INTO salary_history (
            employee_id, old_salary, new_salary, change_date, reason
        ) VALUES (
            4, 46923.22, 51146.31, DATE '2025-02-06', 'As shake growth.'
        );
INSERT INTO salary_history (
            employee_id, old_salary, new_salary, change_date, reason
        ) VALUES (
            8, 34575.52, 37341.56, DATE '2024-01-18', 'Agency believe them include difference try side.'
        );
INSERT INTO salary_history (
            employee_id, old_salary, new_salary, change_date, reason
        ) VALUES (
            19, 118475.64, 130323.2, DATE '2023-07-24', 'Very age study social Republican his.'
        );
INSERT INTO salary_history (
            employee_id, old_salary, new_salary, change_date, reason
        ) VALUES (
            23, 61433.35, 65733.68, DATE '2023-05-31', 'Part government recently before.'
        );
INSERT INTO salary_history (
            employee_id, old_salary, new_salary, change_date, reason
        ) VALUES (
            8, 106648.15, 113047.04, DATE '2023-09-21', 'Glass letter beat business view quite forward.'
        );
INSERT INTO salary_history (
            employee_id, old_salary, new_salary, change_date, reason
        ) VALUES (
            1, 70833.31, 77916.64, DATE '2024-07-31', 'Focus expect throughout marriage case sign bank.'
        );
INSERT INTO salary_history (
            employee_id, old_salary, new_salary, change_date, reason
        ) VALUES (
            12, 40673.67, 42300.62, DATE '2023-05-15', 'Item federal such none meeting during current.'
        );
INSERT INTO salary_history (
            employee_id, old_salary, new_salary, change_date, reason
        ) VALUES (
            6, 60074.94, 62477.94, DATE '2025-01-26', 'Candidate whose action card drop total.'
        );
INSERT INTO salary_history (
            employee_id, old_salary, new_salary, change_date, reason
        ) VALUES (
            15, 52778.26, 55944.96, DATE '2025-04-12', 'Usually seek fine evening to peace.'
        );
INSERT INTO salary_history (
            employee_id, old_salary, new_salary, change_date, reason
        ) VALUES (
            7, 103072.38, 113379.62, DATE '2025-03-02', 'Teacher with crime where mean.'
        );
INSERT INTO salary_history (
            employee_id, old_salary, new_salary, change_date, reason
        ) VALUES (
            2, 61055.24, 64108.0, DATE '2023-05-20', 'Within field read throughout.'
        );
INSERT INTO salary_history (
            employee_id, old_salary, new_salary, change_date, reason
        ) VALUES (
            11, 52994.68, 55644.41, DATE '2025-04-04', 'Receive consumer against level.'
        );
INSERT INTO salary_history (
            employee_id, old_salary, new_salary, change_date, reason
        ) VALUES (
            13, 81903.5, 85179.64, DATE '2024-11-12', 'Offer strong drop better officer finish computer.'
        );
INSERT INTO salary_history (
            employee_id, old_salary, new_salary, change_date, reason
        ) VALUES (
            18, 39214.29, 41567.15, DATE '2024-12-11', 'Believe cultural new institution guy.'
        );
INSERT INTO salary_history (
            employee_id, old_salary, new_salary, change_date, reason
        ) VALUES (
            23, 114935.74, 120682.53, DATE '2024-12-31', 'Word impact claim call.'
        );
INSERT INTO salary_history (
            employee_id, old_salary, new_salary, change_date, reason
        ) VALUES (
            10, 92406.02, 100722.56, DATE '2025-02-12', 'Result people certain check data mouth condition.'
        );
INSERT INTO salary_history (
            employee_id, old_salary, new_salary, change_date, reason
        ) VALUES (
            5, 87405.71, 94398.17, DATE '2024-08-29', 'Name management game woman author instead.'
        );
INSERT INTO salary_history (
            employee_id, old_salary, new_salary, change_date, reason
        ) VALUES (
            5, 77608.31, 86145.22, DATE '2023-05-16', 'Form speak role believe opportunity very.'
        );
INSERT INTO salary_history (
            employee_id, old_salary, new_salary, change_date, reason
        ) VALUES (
            19, 96844.01, 104591.53, DATE '2025-03-07', 'Return hot up happy bit hand.'
        );
INSERT INTO salary_history (
            employee_id, old_salary, new_salary, change_date, reason
        ) VALUES (
            28, 51482.02, 56115.4, DATE '2024-12-12', 'Middle keep lose education building decision push.'
        );
INSERT INTO salary_history (
            employee_id, old_salary, new_salary, change_date, reason
        ) VALUES (
            8, 66208.96, 71505.68, DATE '2024-09-25', 'Everything participant manager bad collection factor language then.'
        );
INSERT INTO salary_history (
            employee_id, old_salary, new_salary, change_date, reason
        ) VALUES (
            20, 37622.04, 39503.14, DATE '2024-03-29', 'Medical summer arm light.'
        );
INSERT INTO salary_history (
            employee_id, old_salary, new_salary, change_date, reason
        ) VALUES (
            15, 115847.65, 128590.89, DATE '2023-06-16', 'Shoulder top worker sing such.'
        );
INSERT INTO salary_history (
            employee_id, old_salary, new_salary, change_date, reason
        ) VALUES (
            21, 60445.01, 66489.51, DATE '2024-07-04', 'Manage along finally.'
        );
INSERT INTO salary_history (
            employee_id, old_salary, new_salary, change_date, reason
        ) VALUES (
            14, 41452.28, 43110.37, DATE '2023-06-18', 'Well edge century contain debate.'
        );
INSERT INTO salary_history (
            employee_id, old_salary, new_salary, change_date, reason
        ) VALUES (
            21, 111689.83, 125092.61, DATE '2024-04-25', 'Agree on black police.'
        );
INSERT INTO salary_history (
            employee_id, old_salary, new_salary, change_date, reason
        ) VALUES (
            19, 38747.77, 41072.64, DATE '2024-04-25', 'Might decide how various set.'
        );
INSERT INTO salary_history (
            employee_id, old_salary, new_salary, change_date, reason
        ) VALUES (
            19, 60753.81, 63791.5, DATE '2025-02-16', 'Consider service service skin hear reason.'
        );