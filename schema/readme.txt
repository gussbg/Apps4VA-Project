GROUP NAME

The Source Awakens ("source")


DESCRIPTION

Our application enables policy makers to view test scores, 
graduation and dropout rates, and postsecondary enrollment rates
in relation to the density of different ethnic groups and genders 
in Virginia schools.


STEPS TO CREATE DATABASE

1. Download "School Subject-Area (XLS)" from 
http://www.doe.virginia.gov/statistics_reports/school_report_card/

2. Use a spreadsheet program to save columns A-I to report_card.csv

3. Run create.sql to create tables with group ownership.

4. Run copy.sh on db.cs.jmu.edu to copy data from VDOE.

5. Run stats.sql to count rows and analyze the tables.
