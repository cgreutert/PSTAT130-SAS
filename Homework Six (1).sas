*Homework Six;
*1;
	*1a;
proc means data=data1.heart;
run;

proc contents data=data1.heart; run;

	*1d;
proc means data=data1.heart min median max maxdec=2;
var Age RestingBP Cholesterol MaxHR;
run;

	*1e;
proc means data=data1.heart min median max maxdec=2;
var Age RestingBP Cholesterol MaxHR;
class ChestPainType;
run;

*2;
	*2a;
proc freq data=data1.heart;
run;

	*2b;
proc format;
value agefmt 20-29 = 'Twenties'
			 30-39 = 'Thirties'
			 40-49 = 'Forties'
			 50-59 = 'Fifties'
			 60-69 = 'Sixties'
			 70-79 = 'Seventies';
run;

	*2c;
proc freq data=data1.heart;
format age agefmt.;
Tables Age ChestPainType;
run;

	*2d;
proc freq data=data1.heart;
format age agefmt.;
tables Age * ChestPainType;
run;

	*2e;
proc format;
value $ucfmt 'asy' = 'ASY'
			 'nap' = 'NAP';
run;
proc freq data=data1.heart;
format ChestPainType $ucfmt. Age agefmt.;
tables Age * ChestPainType;
run;

*3;
	*3a;
proc means data=data1.heart min max range maxdec=2;
var Cholesterol;
run;
data heart1;
set data1.heart;
if Cholesterol= 0 then Cholesterol = .;
format age agefmt. ChestPainType $ucfmt.;
run;
proc means data=heart1 min max range maxdec=2;
var Cholesterol;
run;

	*3b;
proc tabulate data=heart1; 
class ChestPainType Age;
var Cholesterol;
table ChestPainType;
table Age*Cholesterol*median;
run;

	*3c;
proc format;
value chfmt low-200 = 'Good'
			200-239 = 'Borderline'
			240-high = 'High';
run;

	*3d;
proc tabulate data=heart1;
format Cholesterol chfmt.;
class Age Cholesterol;
table Age all, Cholesterol all;
run;
	*3g;
proc tabulate data=heart1;
format Cholesterol chfmt.;
var MaxHR;
class Age Cholesterol;
table Age*MaxHR*mean all, Cholesterol all;
run;

*4;
	*4a;
proc report data=heart1;
column ChestPainType Age MaxHR;
where Age ~= . and ChestPainType ~= ' ';
run;

	*4b;
ods listing file='/home/u59576546/heart2.lst';
proc report data=heart1 headskip;
title ‘Average Max Heart Rate by Chest Pain Type and Age Group’;
options pageno=3 nodate;
column ChestPainType Age MaxHR;
where Age ~= . and ChestPainType ~= ' ';
define ChestPainType / 'Chest Pain Type' group width= 15;
define Age / group;
define MaxHR / 'Max Heart Rate' mean format=3.0 width= 14;
break after ChestPainType / summarize ol ul;
rbreak after / summarize dol;
run;
ods listing close;