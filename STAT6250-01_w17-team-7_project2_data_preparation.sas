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
