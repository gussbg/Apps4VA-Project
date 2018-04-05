-- Function: all_races_enrollment(integer, integer, integer, text, text, text, text)

-- DROP FUNCTION all_races_enrollment(integer, integer, integer, text, text, text, text);

CREATE OR REPLACE FUNCTION all_races_enrollment(IN div_num integer, IN sch_num integer, IN sch_year integer, IN grade_num integer, IN gender text, IN disabil text, IN lep text, IN disadva text)
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
    -- Other attributes
    AND grade_num = $4
    AND gender = $5
    AND disabil = $6
    AND lep = $7
    AND disadva = $8

    ORDER BY race DESC;

$BODY$
  LANGUAGE sql STABLE STRICT
  COST 100
  ROWS 1000;
ALTER FUNCTION all_races_enrollment(integer, integer, integer, integer, text, text, text, text)
  OWNER TO source;
COMMENT ON FUNCTION all_races_enrollment(integer, integer, integer, integer, text, text, text, text) IS 'Returns the fall enrollment and all races for given parameters such as race, gender, etc.';

