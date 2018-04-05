--
-- SOL scores by race and subject and the race's difference from the school's average.
--

DROP FUNCTION IF EXISTS query4(sch_year integer, div_num integer, sch_num integer, race text, subject text, avg_score integer, avg_score_all_races integer, diff_avg_percent decimal);

CREATE FUNCTION query4(sch_year integer, div_num integer, sch_num integer, race text, subject text, avg_score integer, avg_score_all_races integer, diff_avg_percent decimal )
RETURNS TABLE(sch_year integer, div_num integer, sch_num integer, race text,subject text, avg_score_all_races integer, diff_avg_percent decimal ) AS $$

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

$$ LANGUAGE SQL STABLE STRICT;

ALTER FUNCTION query4(sch_year integer, div_num integer, sch_num integer, race text, subject text, avg_score integer, avg_score_all_races integer, diff_avg_percent decimal ) OWNER TO source;
