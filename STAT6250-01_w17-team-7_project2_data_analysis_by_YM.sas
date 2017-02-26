*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

This file uses the following analytic dataset to 
address questions about two of the greatest basketball 
players to ever live: Michael Jordan and Lebron James

Dataset Name: MJ_LJ_analytic_file created in external file
STAT6250-01_w17-team-7_project2_data_preparation.sas, which is assumed to be
in the same directory as this file
See included file for dataset properties
;

* environmental setup;
%let dataPrepFileName = STAT6250-01_w17-team-7_project2_data_preparation.sas;
%let sasUEFilePrefix = team-7_project2;

 set relative file import path to current directory (using standard SAS trick);
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";

* load external file that generates analytic dataset;
%include '.\STAT6250-01_w17-team-7_project2_data_preparation.sas';

*using a system path dependent on the host operating system, after setting the
relative file import path to the current directory, if using Windows;
%macro setup;
    %if
        &SYSSCP. = WIN
    %then
        %do;
            X
            "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))"""
            ;           
            %include ".\&dataPrepFileName.";
        %end;
    %else
        %do;
            %include "~/&sasUEFilePrefix./&dataPrepFileName.";
        %end;
%mend;
%setup

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
"Research Question: Compare the 2 players dribbles and shots."
;

title2
"Rationale: The 2 great players can be assessed based on their dribbles that resulted in scores."
;

footnote1
"Table shows a comparison of the dribles for each player"
;

footnote2
""
;

footnote3
""
;

*
Note: 

Methodology: 

;
proc means data=MJ_LJ_analytic_file sum noprint;
	var PTS FGA FTA;
	class Player;
	output out=MJ_LJ_TSperc sum=PTStotal FGAtotal FTAtotal;
run;

data MJ_LJ_TSperc;
	set MJ_LJ_TSperc;
	TSperc = PTStotal / ( 2 * (FGAtotal + (0.44*FTAtotal) ) );
run;

proc print data=MJ_LJ_TSperc;
	id Player;
	var TSperc;
	where not(missing(Player));
run;

title;
footnote;

title;
footnote;

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
"Research Question: Number of total dribbles for both the great players in all the games."
;

title2
"Rationale: This is a way to distinguish between great shooters, and great play makers."
;

footnote1
""
;

footnote2
""
;

footnote3
""
;

*
Note: 

Methodology: Using Proc Mean canculate calculate the mean for the 2 playes.

;
proc logistic data=MJ_LJ_analytic_file descending;
	by Player notsorted;
    model Result = USGperc;
run;

title;
footnote;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
"Research Question: What are the games with most scores for the 2 great players?"
;

title2
"Rationale: This is a different way of slicing the data."
;

footnote1
""
;

footnote2
""
;

footnote3
""
;

*
Note: 

Methodology: 

;
data MJ_LJ_Margin;
	set MJ_LJ_analytic_file;
	MarginNum = input(Margin, 8.0);
	if Result = 'L' then MarginNum = -1 * MarginNum;
run;

proc means data=MJ_LJ_Margin sum;
	var MarginNum;
	class Player;
	*output out=MJ_LJ_Margin sum=MarginTotal;
run;

title;
footnote;

