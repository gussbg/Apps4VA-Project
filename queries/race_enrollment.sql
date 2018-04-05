-- Function: race_enrollment(integer, integer, integer, integer, text, text, text, text, text)

-- DROP FUNCTION race_enrollment(integer, integer, integer, integer, text, text, text, text, text);

CREATE OR REPLACE FUNCTION race_enrollment(IN div_num integer, IN sch_num integer, IN sch_year integer, IN grade_num integer, IN race text, IN gender text, IN disabil text, IN lep text, IN disadva text)
  RETURNS TABLE (race text, fall_cnt integer) AS
$BODY$

  SELECT
    race, fall_cnt
  FROM fall_membership
  WHERE TRUE
    -- School
    AND div_num = $1
    AND sch_num = $2
    -- School year
    AND sch_year = $3
    -- Grade
    AND grade_num = $4
    -- Race
    AND race = $5
    -- Other attributes
    AND gender = $6
    AND disabil = $7
    AND lep = $8
    AND disadva = $9

  ORDER BY sch_year

$BODY$
  LANGUAGE sql STABLE STRICT
  COST 100
  ROWS 1000;
ALTER FUNCTION race_enrollment(integer, integer, integer, integer, text, text, text, text, text)
  OWNER TO source;
COMMENT ON FUNCTION race_enrollment(integer, integer, integer, integer, text, text, text, text, text) IS 'Returns the fall enrollment and the race for given parameters such as race, gender, etc.';

