--
-- Averaged SOL scores of all Virginia Students by race
--

DROP FUNCTION IF EXISTS query3(sch_year integer, div_num integer, sch_num integer, race integer, AVG(avg_score) AS race_overall_avg integer);

CREATE FUNCTION query3(sch_year integer, div_num integer, sch_num integer, race integer, AVG(avg_score) AS race_overall_avg integer) AS $$

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

$$ LANGUAGE SQL STABLE STRICT;

ALTER FUNCTION query3(sch_year integer, div_num integer, sch_num integer, race integer, AVG(avg_score) AS race_overall_avg integer) OWNER TO absent;
