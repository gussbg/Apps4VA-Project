--
-- Racial density and difference from average
--

DROP FUNCTION IF EXISTS race_density(sch_year integer, div_num integer, sch_num integer, race text, race_cnt integer, total_cnt integer, race_percnt decimal,subject text, avg_score integer, avg_score_all_races integer, diff_avg_percent decimal );

CREATE FUNCTION race_percent(sch_year integer, div_num integer, sch_num integer, race text, race_cnt integer, total_cnt integer, race_percnt decimal,subject text, avg_score integer, avg_score_all_races integer, diff_avg_percent decimal )
RETURNS TABLE(sch_year integer, div_num integer, sch_num integer, race text, race_cnt integer, total_cnt integer, race_percnt decimal,subject text, avg_score integer, avg_score_all_races integer, diff_avg_percent decimal ) AS $$

SELECT sch_year, div_num, sch_num, race, fall_cnt AS race_cnt, total_cnt, (CAST (fall_cnt AS DECIMAL) / total_cnt) * 100 AS race_prcnt, subject, avg_score, avg_score_all_races, (CAST ((avg_score - avg_score_all_races) AS DECIMAL) / avg_score_all_races) * 100 AS diff_avg_percent
FROM  fall_membership AS f
  JOIN (
    SELECT sch_year, div_num, sch_num, fall_cnt AS total_cnt
    FROM fall_membership
    WHERE gender = 'ALL'
      AND disabil = 'ALL'
      AND disadva = 'ALL'
      AND lep = 'ALL'
      AND race = 'ALL'
      AND grade_num = 0) AS f2 USING (sch_year, div_num, sch_num)
    JOIN (
    SELECT *
    FROM sol_test_data
    WHERE gender = 'ALL'
      AND disabil = 'ALL'
      AND disadva = 'ALL'
      AND lep = 'ALL'
      AND test_level = 'ALL'
      AND test_name = 'ALL'
    ) AS s USING (sch_year, div_num, sch_num, race)
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
WHERE f.gender = 'ALL'
  AND f.disabil = 'ALL'
  AND f.disadva = 'ALL'
  AND f.lep = 'ALL'
  AND grade_num = 0
LIMIT 100;

$$ LANGUAGE SQL STABLE STRICT;

ALTER FUNCTION race_percent(sch_year integer, div_num integer, sch_num integer, race text, race_cnt integer, total_cnt integer, race_percnt decimal,subject text, avg_score integer, avg_score_all_races integer, diff_avg_percent decimal ) OWNER TO source;
