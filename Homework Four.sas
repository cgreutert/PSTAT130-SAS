* Homework Four;
* 1;

* 1a;
FILENAME avengers '/home/u59576546/avengers.xlsx';

PROC IMPORT DATAFILE=avengers
	OUT=avengers
	DBMS=XLSX REPLACE; 
	GETNAMES=Yes;
	Sheet='Characters';
RUN;

*1b;
ods listing file='/home/u59576546/avengers.lst';
proc print data=avengers;
options date pageno= 10;
run;
ods listing close;

* 1c;
proc contents data=avengers;
run;

* 2;
data avengersdate;
evaldate1 = mdy(10, 1, 2021);
evaldate2 = mdy(9, 1, 1963);
run;
proc print; run;
*2a;
data avengers2;
set avengers;
if AvengersIntro = . then AvengersIntro = 1339;
if YearIntro = . then YearIntro = 1963;
YearIntro = Year(AvengersIntro);
Days=22554-AvengersIntro;
Gender = Sex;
Years= floor(Days/365.25);
keep Name Appearances Gender AvengersIntro YearIntro Days Years;
run;

proc format;
value genderfmt 0='Male'
				1= 'Female'

* 2b;
proc print data=avengers2 label;
var Name Gender Appearances AvengersIntro YearIntro Years;
format gender genderfmt.
	   appearances comma6.
	   AvengersIntro mmddyy8.;
title Avengers Characters;
label Name= 'Character Name'
Appearances= 'Number of Appearances'
AvengersIntro= 'Date Introduced'
YearIntro= 'Year Introduced'
Years= 'Years Since Introduction';
format gender genderfmt6.;
run;		 

* 2e;
data CharPopularity;
set avengers2(keep= Name AvengersIntro Appearances);
Popularity= Appearances;
format AvengersIntro Date9.
	   Appearances comma6.;
run;

* 2f;
proc format;
value popfmt low-<100= 'Low'
			 100-1000 = 'Medium'
			 1000-high = 'High'; run;

proc sort data=CharPopularity out=CharPopularity;
by popularity;
run;

proc print data=CharPopularity label n;
BY popularity;
PAGEBY popularity; 
id popularity;
var Name AvengersIntro;
title 'Most Popular Avengers';
label Name= 'Character Name'
AvengersIntro= 'Date Introduced';
format popularity popfmt.;
run;







