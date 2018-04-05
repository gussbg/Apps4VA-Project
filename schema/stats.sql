ANALYZE VERBOSE division;
SELECT count(*) AS div_cnt FROM division;

ANALYZE VERBOSE fall_membership;
SELECT count(*) AS fall_membership_cnt FROM fall_membership;

ANALYZE VERBOSE school;
SELECT count(*) AS sch_cnt FROM school;

ANALYZE VERBOSE report_card;
SELECT count(*) AS rep_cnt FROM report_card;

ANALYZE VERBOSE ontime_cohort;
SELECT count(*) AS ont_coh FROM ontime_cohort;

ANALYZE VERBOSE sol_test_data;
SELECT count(*) AS sol_cnt FROM sol_test_data;

ANALYZE VERBOSE hs_graduate;
SELECT count(*) AS grad_cnt FROM hs_graduate;

ANALYZE VERBOSE postsec_enroll;
SELECT count(*) AS sec_enroll_cnt FROM postsec_enroll;
