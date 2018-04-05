#!/bin/sh
# Run this script directly on the db server.

echo COPY school FROM vdoe
psql -c "COPY (
    SELECT div_num, sch_num, sch_name
    FROM school
  ) TO STDOUT;" vdoe | \
  psql -c "COPY school FROM STDIN;" source

echo COPY sol_test_data FROM vdoe
psql -c "COPY (
    SELECT
      sch_year, div_num, sch_num,
      race, gender, disabil, lep, disadva,
      subject, test_name, test_level, avg_score,
       pass_advn, pass_prof, pass_rate, fail_rate
    FROM sol_test_data
  ) TO STDOUT;" vdoe | \
  psql -c "COPY sol_test_data FROM STDIN;" source

echo COPY report_card FROM csv
psql -c "\copy report_card FROM report_card.csv WITH CSV HEADER" source

echo COPY ontime_cohort FROM vdoe
psql -c "COPY (
    SELECT
      sch_year, div_num, sch_num,
      race, gender, disabil, lep, disadva,
      cohort_cnt, diploma_rate, dropout_rate
    FROM ontime_cohort
  ) TO STDOUT;" vdoe | \
  psql -c "COPY ontime_cohort FROM STDIN;" source

echo COPY division FROM vdoe
psql -c "COPY (
    SELECT div_num, div_name, loc_code, loc_type, region
    FROM division
  ) TO STDOUT;" vdoe | \
  psql -c "COPY division FROM STDIN;" source

echo COPY fall_membership FROM vdoe
psql -c "COPY (
    SELECT sch_year, div_num, sch_num, grade_num, race, gender, disabil,
      lep, disadva, fall_cnt
    FROM fall_membership
  ) TO STDOUT;" vdoe | \
  psql -c "COPY fall_membership FROM STDIN;" source

echo COPY hs_graduate FROM vdoe
psql -c "COPY (
    SELECT sch_year, div_num, sch_num, race, gender, disabil, lep, disadva, 
      diploma_num, graduate_cnt
    FROM hs_graduate
  ) TO STDOUT;" vdoe | \
  psql -c "COPY hs_graduate FROM STDIN;" source

echo COPY postsec_enroll FROM vdoe
psql -c "COPY (
    SELECT sch_year, div_num, sch_num, race, gender, disabil, lep, disadva,
      enroll_graduate_cnt, ps_institution_type, ps_enrollment_cnt
    FROM postsec_enroll
  ) TO STDOUT;" vdoe | \
  psql -c "COPY postsec_enroll FROM STDIN;" source
