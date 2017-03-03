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
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
"Research Question: Compare the 2 players Minutes Played (MP)."
;

title2
"Rationale: The 2 great players can be assessed based on the total time they have played throughout the season."
;

footnote1
"the average time played per game for each player is xxxx"
;

*
Note: 

Methodology: use Proc Means to calculate the sum of Minutes Played (MP) for each player. 

;
proc means data=MJ_LJ_analytic_file sum noprint;
	var MP;
	class Player;
	output out= mins_played;
run;
  
proc print noobs data = mins_played(obs=5);
run;

title;
footnote;

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
"Research Question: What is the Total Points (PTS) for each of the 2 players?"
;

title2
"Rationale: The sum of total points of each game for each player is desired for further analysis."
;

footnote1
" the average points made for both the players is XXXX"
;

*
Methodology: use Proc Means to calculate the sum of total points (PTS) for each player
Note: Refer to topics on proc mean. 
;

proc sql;
select player, avg(PTS)as Points from MJ_LJ_analytic_file group by player;
quit;

title;
footnote;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
"Research Question: Is there a correlation between time played and points made over throughout the season?"
;

title2
"Rationale: This is a different way of slicing the data."
;

footnote1
"Table shows the games with most scores for the 2 players."
;

*
Note: 

Methodology: Use proc sgplot to plot the points made (PTS) over minutes played for the 2 players to provide a visual comparison of the 2. 

;

proc sgplot data=Mj_lj_analytic_file;
  scatter x=MP y=PTS / group=Player;
run;

title;
footnote;
