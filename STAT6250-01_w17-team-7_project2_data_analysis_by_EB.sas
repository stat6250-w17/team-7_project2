*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to 
address questions about two of the greatest basketball 
players to ever live: Michael Jordan and Lebron James

Dataset Name: MJ_LJ_analytic_file created in external file
STAT6250-01_w17-team-7_project2_data_preparation.sas, which is assumed to be
in the same directory as this file

See included file for dataset properties
;

* environmental setup;

* set relative file import path to current directory (using standard SAS trick);
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";

* load external file that generates analytic dataset;
%include '.\STAT6250-01_w17-team-7_project2_data_preparation.sas';


title1 'Research Question: Which player had the higher True Shooting Percentage?';
title2 'Rationale: This includes 2-point, 3-point, and FT attempts to give the most complete measure of who is a better shooter.';
footnote1 'The player with the higest True Shooting Percentage is displayed';

*
Methodology: For each player the calculate TS% = Points/(2 * (FGA+0.44)*FTA)
I will create new variables for total points, total Field Goal attempts, 
and total free throw attempts. The data is sorted so the higher TS% is the
first observation and this is displayed.

* some SAS code;

title;
footnote;



title1 'Which player's Usage Rate had higher correlation with their team winning the game?;
title2 'Rationale: Great players heavily influence the outcome of games and should help their teams win.';
footnote1 'The player whose Usage Rate has a higher correlation to winning is displayed';


*
Methodology: Use PROC LOGISTIC to compute a simple binary regession model 
with this factor: Usage Rate as it relates to individual game wins.
;

* some SAS code;

title;
footnote;


title1 'Which player had the higher average margin of victory during the season?';
title2 'Rationale: Both players' teams had winning records, but we want to see which team was truly dominating opponents.';
footnote1 'The player with the higher margin of victory is displayed';

*
Methodology: Extract the numeric value from the Margin attribute.
Sum this value for each player and display the player with the higher value.
;

* some SAS code;

title;
footnote;
