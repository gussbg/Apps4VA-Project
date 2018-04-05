-- Function: race_avg_sol(integer, integer, integer, text, text, text, text, text)

-- DROP FUNCTION race_avg_sol(integer, integer, integer, text, text, text, text, text);

CREATE OR REPLACE FUNCTION race_avg_sol(IN div_num integer, IN sch_num integer, IN sch_year integer, IN race text, IN gender text, IN disabil text, IN lep text, IN disadva text)
  RETURNS TABLE(sch_year integer, subject text, avg_score integer) AS
$BODY$

  SELECT
    sch_year, subject, avg_score
  FROM sol_test_data
  WHERE TRUE
    -- School
    AND div_num = $1
    AND sch_num = $2
    -- School year
    AND sch_year = $3
    -- Race
    AND race = $4
    AND gender = $5
    AND disabil = $6
    AND lep = $7
    AND disadva = $8
    -- All tests (by subject)
    AND test_name = 'ALL'
    AND (test_level = 'ALL' OR test_level = 'ALL EOC')
  ORDER BY sch_year, subject

$BODY$
  LANGUAGE sql STABLE STRICT
  COST 100
  ROWS 1000;

ALTER FUNCTION race_avg_sol(integer, integer, integer, text, text, text, text, text)
  OWNER TO source;

COMMENT ON FUNCTION race_avg_sol(integer, integer, integer, text, text, text, text, text) IS 'Average SOL scores for a given school, year, and race';
