-- Function: ontime_density(integer, integer, integer, text, text, text, text, text);

-- DROP FUNCTION race_avg_sol(integer, integer, integer, text, text, text, text, text);

CREATE OR REPLACE FUNCTION ontime_density(IN div_num integer, IN sch_num integer, IN sch_year integer, IN race text, IN gender text, IN disabil text, IN lep text, IN disadva text)
  RETURNS TABLE(cohort_cnt integer, diploma_rate real, dropout_rate real) AS
$BODY$

  SELECT
    cohort_cnt, diploma_rate, dropout_rate
  FROM ontime_cohort
  WHERE TRUE
    -- School
    AND div_num = $1
    AND sch_num = $2
    -- School year
    AND sch_year = $3
    -- Denominations
    AND race = $4
    AND gender = $5
    AND disabil = $6
    AND lep = $7
    AND disadva = $8
  ORDER BY sch_year

$BODY$
  LANGUAGE sql STABLE STRICT
  COST 100
  ROWS 1000;
ALTER FUNCTION ontime_density(integer, integer, integer, text, text, text, text, text)
  OWNER TO source;
COMMENT ON FUNCTION ontime_density(integer, integer, integer, text, text, text, text, text) IS 'Average diploma rate and dropout rate for a given cohort, school, year, and race';
