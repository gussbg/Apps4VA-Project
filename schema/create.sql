DROP TABLE IF EXISTS school;

CREATE TABLE school (
    div_num integer NOT NULL,
    sch_num integer NOT NULL,
    sch_name text NOT NULL
);

ALTER TABLE school OWNER TO source;

COMMENT ON TABLE school IS 'all schools in Virginia';


DROP TABLE IF EXISTS sol_test_data;

CREATE TABLE sol_test_data
(
  sch_year integer NOT NULL,
  div_num integer NOT NULL,
  sch_num integer NOT NULL,
  race text NOT NULL,
  gender text NOT NULL,
  disabil text NOT NULL,
  lep text NOT NULL,
  disadva text NOT NULL,
  subject text NOT NULL,
  test_name text NOT NULL,
  test_level text NOT NULL,
  avg_score integer,
  pass_advn real NOT NULL,
  pass_prof real NOT NULL,
  pass_rate real NOT NULL,
  fail_rate real NOT NULL
);

ALTER TABLE sol_test_data OWNER to source;

COMMENT ON TABLE sol_test_data IS 'SOL scores';


DROP TABLE IF EXISTS report_card;

CREATE TABLE report_card
(
  division text NOT NULL,
  school text NOT NULL,
  subject text NOT NULL,
  grade text NOT NULL,
  test text NOT NULL,
  pass_2013_2014 text,
  pass_2014_2015 text,
  advanced_2013_2014 text,
  advanced_2014_2015 text
);

ALTER TABLE report_card OWNER to source;

COMMENT ON TABLE report_card IS 'School performance';


DROP TABLE IF EXISTS ontime_cohort;

CREATE TABLE ontime_cohort
(
  sch_year integer NOT NULL,
  div_num integer NOT NULL,
  sch_num integer NOT NULL,
  race text NOT NULL,
  gender text NOT NULL,
  disabil text NOT NULL,
  lep text NOT NULL,
  disadva text NOT NULL,
  cohort_cnt integer NOT NULL,
  diploma_rate real NOT NULL,
  dropout_rate real NOT NULL
);

ALTER TABLE ontime_cohort OWNER TO source;

COMMENT ON TABLE ontime_cohort IS 'On-time graduation rates';


DROP TABLE IF EXISTS division;

CREATE TABLE division (
  div_num integer NOT NULL,
  div_name text NOT NULL,
  loc_code integer NOT NULL,
  loc_type text NOT NULL,
  region integer NOT NULL
);

ALTER TABLE division OWNER TO source;

COMMENT ON TABLE division IS 'division';


DROP TABLE IF EXISTS fall_membership;

CREATE TABLE fall_membership (
  sch_year integer NOT NULL,
  div_num integer NOT NULL,
  sch_num integer NOT NULL,
  grade_num integer NOT NULL,
  race text NOT NULL,
  gender text NOT NULL,
  disabil text NOT NULL,
  lep text NOT NULL,
  disadva text NOT NULL,
  fall_cnt integer NOT NULL
);

ALTER TABLE fall_membership OWNER TO source;

COMMENT ON TABLE fall_membership IS 'fall membership';


DROP TABLE IF EXISTS hs_graduate;

CREATE TABLE hs_graduate
(
  sch_year integer NOT NULL,
  div_num integer NOT NULL,
  sch_num integer NOT NULL,
  race text NOT NULL,
  gender text NOT NULL,
  disabil text NOT NULL,
  lep text NOT NULL,
  disadva text NOT NULL,
  diploma_num integer NOT NULL,
  graduate_cnt integer NOT NULL
);

ALTER TABLE hs_graduate OWNER TO source;

COMMENT ON TABLE hs_graduate IS 'High School Graduation';


DROP TABLE IF EXISTS postsec_enroll;

CREATE TABLE postsec_enroll
(
  sch_year integer NOT NULL,
  div_num integer NOT NULL,
  sch_num integer NOT NULL,
  race text NOT NULL,
  gender text NOT NULL,
  disabil text NOT NULL,
  lep text NOT NULL,
  disadva text NOT NULL,
  enroll_graduate_cnt integer NOT NULL,
  ps_institution_type integer NOT NULL,
  ps_enrollment_cnt integer NOT NULL
);

ALTER TABLE postsec_enroll OWNER TO source;

COMMENT ON TABLE postsec_enroll IS 'College enrollment';
