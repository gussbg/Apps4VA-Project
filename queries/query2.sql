--
-- Race percentages
--

DROP FUNCTION IF EXISTS query2(sch_year integer, div_num integer, sch_num integer, race integer, s2.subject text, avg_score integer, avg_score_all_races integer, (CAST ((avg_score - avg_score_all_races) AS DECIMAL) / avg_score_all_races) * 100 AS diff_avg_percent));

CREATE FUNCTION query2(sch_year integer, div_num integer, sch_num integer, race integer, s2.subject text, avg_score integer, avg_score_all_races integer, (CAST ((avg_score - avg_score_all_races) AS DECIMAL) / avg_score_all_races) * 100 AS diff_avg_percent) AS $$

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

ALTER FUNCTION query2(sch_year integer, div_num integer, sch_num integer, race integer, s2.subject text, avg_score integer, avg_score_all_races integer, (CAST ((avg_score - avg_score_all_races) AS DECIMAL) / avg_score_all_races) * 100 AS diff_avg_percent)) OWNER TO absent;
