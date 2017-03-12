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


*******************************************************************************;
* Research Question 1 Analysis ;
*******************************************************************************;

title1
"Research Question 1: Which player had the higher overall FG percentage?"
;

title2
"Rationale: Shooting is a fundamental point of comparison for basketball players."

;

footnote1
"The Player with Highest FG percentage is Lebron James."
;

footnote2
""
;

footnote3
""
;

*
Note: 
Methodology: Use proc means to calculate the FG percentage
;


proc print data = FGP;
	id player;
	var FGperc;
	where not(missing(Player));
run;

title;
footnote;

*******************************************************************************;
* Research Question 2 Analysis ;
*******************************************************************************;

title1
"Research Question: Which player had the had the higher points scored - to - minutes played ratio?"
;

title2
"Rationale: This is a measure of offensive efficiency."
;

footnote1
"Michael Jordan Seems to have a better shooting ratio since he takes less time to score points"
;

footnote2
""
;

footnote3
""
;

*
Note: 
Methodology: Use means to calculate the Average of total points and minutes played by each player to get a ratio
;


proc print data = PSratio;
	id player;
	var PSR;
	where not(missing(Player));
run;

title;
footnote;


*******************************************************************************;
* Research Question 3 Analysis;
*******************************************************************************;

title1
"Research Question: Which player had the higher steals - to - fouls ratio??"
;

title2
"Rationale: This is a measure of defensive efficiency."
;

footnote1
"Lebron James seems to have Higher Steals and Lower Fouls"
;

footnote2
""
;

footnote3
""
;

*
Note: 
Methodology: Use proc means to calculate the sum of total steals and total player fouls to get steals to foul ratio
;


proc print data = PFratio;
	id player;
	var PFR;
	where not(missing(Player));
run;




title;
footnote;





*******************************************************************************;
* Research Question 4 Analysis;
*******************************************************************************;

title1
"Research Question: Which player had the higher True Shooting Percentage?"
;

title2
"Rationale: This is a measure of offensiv efficiency."
;

footnote1
"Lebron James or Michael Jordan"
;

footnote2
""
;

footnote3
""
;

*
Note: 
Methodology: Use proc means to calculate the sum of total steals and total player fouls to get steals to foul ratio
;


proc print data = TSPerc;
	id player;
	var TSP;
	where not(missing(Player));
run;




title;
footnote;

