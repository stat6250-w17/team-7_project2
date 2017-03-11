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

*IL: put long string literals on separate lines;
title1
'Research Question: Which player had the higher True Shooting Percentage?'
;
title2 'Rationale: This includes 2-point, 3-point, and FT attempts to give the most complete measure of who is a better shooter.';
*IL: consider expanding analyses to include more context, to include specific
     values to highlight from the SAS output, and to provide context for the
     significance of the numbers;
footnote1 'Lebron James has the higher True Shooting Percentage';
*
Methodology: For each player the calculate TS% = Points/( 2 * (FGA+(0.44*FTA) ) )
I will create new variables for total points, total Field Goal attempts, 
and total free throw attempts. This result is stored in MJ_LJ_TSperc.
The data is sorted and displayed with the higher TS% as the
first observation.
;

proc print data=MJ_LJ_TSperc;
    id Player;
    var TSperc;
    where not(missing(Player));
run;

title;
footnote;



title1 'Which players Usage Rate had higher correlation with their team winning the game?';
title2 'Rationale: Great players heavily influence the outcome of games and should help their teams win.';
footnote1 'As seen in the scatterplots, there is not much correlation between USGperc and Margin of Victory. This runs counter to what I originally believed.';
*
Methodology: Use PROC CORR to compute correlation and dispaly plots 
between Margin of Victory and Usage Rate Percentage for each player. 
;
*IL: ods graphics on/off isn't needed;
ods graphics on;
proc corr data=MJ_LJ_analytic_file pearson 
        plots=matrix(histogram)
        nosimple;
    by Player notsorted;
    var MarginNum USGperc;
run;
ods graphics off;

title;
footnote;


title1 'Which player had the higher average margin of victory during the seasons?';
title2 'Rationale: Both teams had winning records, but we want to see which team was truly dominating opponents.';
footnote1 'Michael Jordan had the higher margin of victory';
*
Methodology: Using the numeric value in MarginNum, calculate the mean 
for each player.
;

proc means data=MJ_LJ_analytic_file noprint nway;
    var MarginNum;
    class Player;
    output out=MJ_LJ_MarginAvg mean=MarginAvg n=NumGames;
run;

proc sort data=MJ_LJ_MarginAvg;
    by descending MarginAvg;
run;

proc print noobs data=MJ_LJ_MarginAvg;
    var Player MarginAvg NumGames;
run;

title;
footnote;
