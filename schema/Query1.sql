SELECT sch_year, div_num, sch_num, race, ps_enrollment_cnt
FROM postsec_enroll
WHERE gender = 'ALL'
      AND disabil = 'ALL'
      AND disadva = 'ALL'
      AND lep = 'ALL'
AND sch_num !=0
AND div_num !=0
LIMIT 10;

SELECT sch_year, div_num, sch_num, race, s2.subject, avg_score, avg_score_all_races, (CAST ((avg_score - avg_score_all_races) AS DECIMAL) / avg_score_all_races) * 100 AS diff_avg_percent
FROM sol_test_data AS s
  JOIN (
    SELECT sch_year, div_num, sch_num, avg_score AS avg_score_all_races, subject
    FROM sol_test_data
    WHERE gender = 'ALL'
      AND race = 'ALL'
      AND disabil = 'ALL'
      AND disadva = 'ALL'
      AND lep = 'ALL'
      AND test_level = 'ALL'
      AND test_name = 'ALL'
  ) AS s2 USING (sch_year, div_num, sch_num, subject)
    WHERE gender = 'ALL'
      AND race <> 'ALL'
      AND disabil = 'ALL'
      AND disadva = 'ALL'
      AND lep = 'ALL'
      AND test_level = 'ALL'
      AND test_name = 'ALL'
      AND s.div_num = 0
LIMIT 100;

SELECT sch_year, div_num, sch_num, race, AVG(avg_score) AS race_overall_avg
FROM sol_test_data AS s
  JOIN (
    SELECT sch_year, div_num, sch_num, avg_score AS avg_score_all_races, subject
    FROM sol_test_data
    WHERE gender = 'ALL'
      AND race = 'ALL'
      AND disabil = 'ALL'
      AND disadva = 'ALL'
      AND lep = 'ALL'
      AND test_level = 'ALL'
      AND test_name = 'ALL'
  ) AS s2 USING (sch_year, div_num, sch_num, subject)
  
    WHERE gender = 'ALL'
      AND race <> 'ALL'
      AND disabil = 'ALL'
      AND disadva = 'ALL'
      AND lep = 'ALL'
      AND test_level = 'ALL'
      AND test_name = 'ALL'
      AND s.div_num = 0
      GROUP BY sch_year, div_num, sch_num, race
ORDER BY sch_year, race
LIMIT 100;
