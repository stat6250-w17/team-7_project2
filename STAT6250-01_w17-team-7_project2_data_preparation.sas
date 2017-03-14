*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
[Dataset 1 Name] michael_jordan_basic.txt

[Dataset Description] Basic per game stats on Michael Jordan for 
the 1996-1997 and 1997-1998 seasons. He won the NBA championship
during these seasons.

[Experimental Unit Description] Individual basketball games

[Number of Observations] 164                    

[Number of Features] 29

[Data Source] Combined from two seasons:
1. http://www.basketball-reference.com/players/j/jordami01/gamelog/1997 (Note: Click "Share & more", "Get table as CSV", and then copy the data)
2. http://www.basketball-reference.com/players/j/jordami01/gamelog/1998 (Note: Click "Share & more", "Get table as CSV", and then copy the data)

[Data Dictionary] http://www.basketball-reference.com/about/glossary.html

[Unique ID Schema] "Date" column

--------------------------------------------------------------------------------

[Dataset 2 Name] michael_jordan_adv.txt

[Dataset Description] Advanced per game stats on Michael Jordan for
the 1996-1997 and 1997-1998 seasons. He won the NBA championship 
during these seasons.

[Experimental Unit Description] Individual basketball games

[Number of Observations] 164
 
[Number of Features] 23

[Data Source] Combined from two seasons:
1. http://www.basketball-reference.com/players/j/jordami01/gamelog-advanced/1997/ (Note: Click "Share & more", "Get table as CSV", and then copy the data)
2. http://www.basketball-reference.com/players/j/jordami01/gamelog-advanced/1998/ (Note: Click "Share & more", "Get table as CSV", and then copy the data)

[Data Dictionary] http://www.basketball-reference.com/about/glossary.html

[Unique ID Schema] "Date" column

--------------------------------------------------------------------------------

[Dataset 3 Name] lebron_james_basic.txt

[Dataset Description] Basic per game stats on Lebron James for 
the 2011-2012 and 2012-2013 seasons. He won the NBA championship 
during these seasons.

[Experimental Unit Description] Individual basketball games

[Number of Observations] 144
 
[Number of Features] 30 (Note: PlusMinus is an additional feature 
the michael_jordan_basic dataset does not have.)

[Data Source] Combined from two seasons:
1. http://www.basketball-reference.com/players/j/jamesle01/gamelog/2012 (Note: Click "Share & more", "Get table as CSV", and then copy the data)
2. http://www.basketball-reference.com/players/j/jamesle01/gamelog/2013 (Note: Click "Share & more", "Get table as CSV", and then copy the data)

[Data Dictionary] http://www.basketball-reference.com/about/glossary.html

[Unique ID Schema] "Date" column

--------------------------------------------------------------------------------

[Dataset 4 Name] lebron_james_adv.txt

[Dataset Description] Advanced per game stats on Lebron James for the 2011-2012 and 2012-2013 seasons. He won the NBA championship during these seasons.

[Experimental Unit Description] Individual basketball games

[Number of Observations] 144

[Number of Features] 23

[Data Source] Combined from two seasons:
1. http://www.basketball-reference.com/players/j/jamesle01/gamelog-advanced/2012/ (Note: Click "Share & more", "Get table as CSV", and then copy the data)
2. http://www.basketball-reference.com/players/j/jamesle01/gamelog-advanced/2013/ (Note: Click "Share & more", "Get table as CSV", and then copy the data)

[Data Dictionary] http://www.basketball-reference.com/about/glossary.html

[Unique ID Schema] "Date" column
;


* setup environmental parameters;
%let inputDataset1URL =
https://github.com/stat6250/team-7_project2/blob/master/data/michael_jordan_basic.txt?raw=true
;
%let inputDataset1Type = DLM;
%let inputDataset1DSN = michael_basic_raw;

%let inputDataset2URL =
https://github.com/stat6250/team-7_project2/blob/master/data/michael_jordan_adv.txt?raw=true
;
%let inputDataset2Type = DLM;
%let inputDataset2DSN = michael_adv_raw;

%let inputDataset3URL =
https://github.com/stat6250/team-7_project2/blob/master/data/lebron_james_basic.txt?raw=true
;
%let inputDataset3Type = DLM;
%let inputDataset3DSN = lebron_basic_raw;

%let inputDataset4URL =
https://github.com/stat6250/team-7_project2/blob/master/data/lebron_james_adv.txt?raw=true
;
%let inputDataset4Type = DLM;
%let inputDataset4DSN = lebron_adv_raw;

* load raw datasets over the wire, if they doesn't already exist;
%macro loadDataIfNotAlreadyAvailable(dsn,url,filetype);
    %put &=dsn;
    %put &=url;
    %put &=filetype;
    %if
        %sysfunc(exist(&dsn.)) = 0
    %then
        %do;
            %put Loading dataset &dsn. over the wire now...;
            filename tempfile TEMP;
            proc http
                method="get"
                url="&url."
                out=tempfile
                ;
            run;
            proc import
                file=tempfile
                out=&dsn.
                dbms=&filetype.;
				
				delimiter=",";
            run;
            filename tempfile clear;
        %end;
    %else
        %do;
            %put Dataset &dsn. already exists. Please delete and try again.;
        %end;
%mend;

%loadDataIfNotAlreadyAvailable(
    &inputDataset1DSN.,
    &inputDataset1URL.,
    &inputDataset1Type.
)
%loadDataIfNotAlreadyAvailable(
    &inputDataset2DSN.,
    &inputDataset2URL.,
    &inputDataset2Type.
)
%loadDataIfNotAlreadyAvailable(
    &inputDataset3DSN.,
    &inputDataset3URL.,
    &inputDataset3Type.
)
%loadDataIfNotAlreadyAvailable(
    &inputDataset4DSN.,
    &inputDataset4URL.,
    &inputDataset4Type.
)

*Horizontally merge Michael data;
data michael_merged;
	merge michael_basic_raw michael_adv_raw;
	by Date;
	Player = "Michael Jordan"; *add Player attribute;
	Result = scan(Margin,1); *seperate Margin into 2 variables;
	Margin = scan(Margin,2);
run;

* Horizontally merge Lebron data;
data lebron_merged;
	merge lebron_basic_raw lebron_adv_raw;
	by Date;
	Player = "Lebron James"; *add Player attribute;
	Result = scan(Margin,1); *seperate Margin into 2 variables;
	Margin = scan(Margin,2);
run;

* Vertically merge the Michael and Lebron data;
proc append base=michael_merged data=lebron_merged force;
run;

data michael_merged;
	set michael_merged;
	MarginNum = input(Margin, 8.0);
	if Result = 'L' then MarginNum = -1 * MarginNum;
run;

* build analytic dataset from raw datasets with the least number of columns and
minimal cleaning/transformation needed to address research questions in
corresponding data-analysis files;

data MJ_LJ_analytic_file;
	retain
		Player
		Date
		Result
		MarginNum
		MP
		FG
		FGA
		ThreeP
		ThreePA
		FT
		FTA
		TRB
		AST
		STL
		BLK
		TOV
		PF
		PTS
		USGperc
	;
	keep
		Player
		Date
		Result
		MarginNum
		MP
		FG
		FGA
		ThreeP
		ThreePA
		FT
		FTA
		TRB
		AST
		STL
		BLK
		TOV
		PF
		PTS
		USGperc
	;
	set michael_merged;
run;

*For use in finding player with best True Shooting Percentage;
proc means data=MJ_LJ_analytic_file sum noprint;
	var PTS FGA FTA;
	class Player;
	output out=MJ_LJ_TSperc sum=PTStotal FGAtotal FTAtotal;
run;

data MJ_LJ_TSperc;
	set MJ_LJ_TSperc;
	TSperc = PTStotal / ( 2 * (FGAtotal + (0.44*FTAtotal) ) );
run;



* ### YM Question 1, data prep ### ;

proc sort data=MJ_LJ_analytic_file; by player;

proc means data=MJ_LJ_analytic_file mean noprint;
	var FG FGA;
	class Player;
	
	output out=FGP mean=AvgFG AvgFGA
run;

data FGP;
	set FGP;
	FGperc = (AvgFG/AvgFGA)*100;
run;


* ### YM Question 2, data prep ### ;

proc sort data=MJ_LJ_analytic_file; by player;

proc means data=MJ_LJ_analytic_file mean noprint;
	var PTS MP;
	class Player;
	
	output out=PSratio mean=AvgPTS AvgMP
run;

data PSratio;
	set PSratio;
	PSR = (AvgMP/AvgPTS);
run;

* ### YM Question 3, data prep ### ;


proc sort data=MJ_LJ_analytic_file; by player;

proc means data=MJ_LJ_analytic_file sum noprint;
	var STL PF;
	class Player;
	
	output out=PFratio sum=SumSTL SumPF
run;

data PFratio;
	set PFratio;
	PFR = (SumSTL/SumPF);
run;


* Trying TS% ;

proc sort data=MJ_LJ_analytic_file; by player;

proc means data=MJ_LJ_analytic_file sum noprint;
	var FGA FTA PTS;
	class Player;
	
	output out=TSPerc sum=SumFGA SumFTA SumPTS
run;

data TSPerc;
	set TSPerc;
	TSP = (SumPTS/(2*(SumFGA+(0.44*sumFTA))))*100;
run;


proc means data=MJ_LJ_analytic_file sum noprint;
	var FGA FTA TOV;
	class Player;
	
	output out=TOVPerc sum=SumFGA SumFTA SumTOV
run;

data TOVPerc;
	set TOVPerc;
	TOVP = (SumTOV/(2*(SumFGA+(0.44*sumFTA)+SumTOV)))*100;
run;

