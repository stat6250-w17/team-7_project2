*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;
*IL: use line breaks to create paragraphs in comment blocks;
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


*******************************************************************************;
* Research Question 1 Analysis ;
*******************************************************************************;
*IL: don't wrap string literals;
title1
"Research Question 1: Which player has higher overall Effective Field Goal percentage?"
;

title2
"Rationale: Shooting is a fundamental point of comparison for basketball players."

;

footnote1
"Effective Field Goal Percentage is a statistic that adjusts for the fact that  a
 3-point field goal is worth more than a 2-point field goal."
;

footnote2
"Lebron James is leading this statistic, however, more analysis should be done on
 overall Field Goal Percentage to make sure that he maintains overall lead in 
 Field Goals."
;

*
Note: 
Methodology: Effective Field Goal Percentage (EFG%) is calculated by the formula
(Field_Goals + 0.5*Three_Points)/Field_Goal_Attempts. This is a measure of 
offensive ratings.
;


proc print data = FGP;
    id player;
    var FGperc;
    where not(missing(Player));
run;

title;
footnote;



*******************************************************************************;
* Research Question 2 Analysis;
*******************************************************************************;

title1
"Research Question 2: Which player had the higher True Shooting Percentage?"
;

title2
"Rationale: True Shooting Percentage is a measure of offensive efficiency."
;

footnote1
"True Shooting Percentage measures the overall accuracy of shooting the ball and
 is considered more accurate than Field Goal Percentage, Three Point Field Goal
 Percentage and Free Throws Percentage measured individually."
;

footnote2
"Lebron James seems to be leading this measure by a wide margin and he is also
 leading in all other individual shooting measures thus maintaining a comfortable
 lead in shooting efficiency over Michael Jordan."
;

*
Note: 
Methodology: True shooting percentage measures a players efficiency at shooting 
the ball and is considered more accurate than Field Goal Percentage, Three Point
Field Goal Percentage and Free Throws Percentage. It is calculated using the 
formula Total_points/(2*True_Shooting_Attempts).
;


proc print data = TSPerc;
    id player;
    var TSP;
    where not(missing(Player));
run;

title;
footnote;


*******************************************************************************;
* Research Question 3 Analysis;
*******************************************************************************;

title1
"Research Question 3: Which player had the higher Turnover Percentage?"
;

title2
"Rationale: Turnover Percentage is a measure of defensive efficiency."
;

footnote1
"This is a defensive metric which estimates the number of turnovers a player 
 commits per 100 possessions. A turnover occurs when the player loses the 
 possession of the ball to opposing team before he takes a shot at his team's
 basket."
;

footnote2
"Since Michael Jordan has lower turnovers than Lebron James, he seems to have
 a better control over the ball compared to Lebron James."
;


*
Note: 
Methodology: A Turnover occurs when a team loses possession of the ball to the
opposing team before a player takes a shot at his team's basket. It can be 
calculated by the formula Total_Turnovers/(Field_Goal_Attempts+0.44*
Free_Throw_Attempts+Total_Turnovers)
;


proc print data = TOVPerc;
    id player;
    var TOVP;
    where not(missing(Player));
run;




title;
footnote;

