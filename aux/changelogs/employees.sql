-- liquibase formatted sql
-- changeset HR:1748000580681 stripComments:false logicalFilePath:salary-increase-by-performance/hr/tables/employees.sql runAlways:false runOnChange:false replaceIfExists:true failOnError:true
-- sqlcl_snapshot src/database/hr/tables/employees.sql:ce37a333326cb59a2f4ee470d0113b1b96b93f15:0487fc786d6731683b66d9a70afbda0bcad25863:alter

ALTER TABLE "HR"."EMPLOYEES" DROP CONSTRAINT "CHK_SALARY_POSITIVE"
/

ALTER TABLE "HR"."EMPLOYEES" DROP CONSTRAINT "CHK_DATES"
/

alter table hr.employees
    add constraint chk_dates
        check ( fire_date is null
                or fire_date > hire_date ) enable
/

alter table hr.employees add constraint chk_salary_positive check ( salary > 0 ) enable
/

