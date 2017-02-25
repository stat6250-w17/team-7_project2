* MS's SAS analysis;
*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding college-preparation trends at CA public K-12 schools

Dataset Name: cde_2014_analytic_file created in external file
STAT6250-01_w17-team-0_project2_data_preparation.sas, which is assumed to be
in the same directory as this file

See included file for dataset properties
;

* environmental setup;
%let dataPrepFileName = STAT6250-01_w17-team-0_project2_data_preparation.sas;
%let sasUEFilePrefix = team-0_project2;

* load external file that generates analytic dataset cde_2014_analytic_file
using a system path dependent on the host operating system, after setting the
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
"Research Question: "
;

title2
"Rationale: ."
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


title;
footnote;

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
"Research Question: "
;

title2
"Rationale: ."
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


title;
footnote;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
"Research Question: "
;

title2
"Rationale: ."
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


title;
footnote;
