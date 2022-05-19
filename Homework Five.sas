* Homework Five;
libname home '/home/u59576546';
libname data1 '/home/u59576546/data1';

* 1a;
proc contents data=data1.clinton; run;
proc contents data=data1.bush; run;
proc contents data=data1.obama; run;

*1b;
data clinton;
set data1.clinton;
President = 'Clinton';
run;

data bush;
set data1.bush;
President= 'Bush';
run;

data obama;
set data1.obama;
President= 'Obama';
run;

data work.CabinetTurnover;
set clinton bush obama;
run;

*1c;
proc print data=work.CabinetTurnover; run;
proc contents data=work.CabinetTurnover; run;

*1d;
data orderLookup1;
input President $ order;
datalines;
Obama 1
Bush 2
Clinton 3
;
run;

proc sort data=CabinetTurnover out=CabinetTurnover_s;
by President;
run;

proc sort data=orderLookup1 out=orderLookup_s;
by President;
run;

data CT_ordered;
merge CabinetTurnover_s orderLookup_s;
by President;
run;

proc sort data=CT_ordered;
by order;
run;

* 1e;
proc print data=CT_ordered noobs;
var President Appointee Position;
run;

*1f;
proc print data=data1.cabinetpositions;
run;

*1g;
proc sort data=CT_ordered out=CT_ordered_p;
by Position; run;

proc sort data=data1.CabinetPositions out=CabinetPositions_p;
by Position; run; 

data CT_Final;
merge CT_ordered_p CabinetPositions_p;
by Position;
if Start = "." then delete;
run;

data orderLookup2;
input President $ order1;
datalines;
Clinton 1
Bush 2
Obama 3
;
run;

proc sort data=CT_Final out=CT_Final_e;
by President; run;

proc sort data=orderLookup2 out=orderLookup2_e;
by President; run;

data CT_Final1;
merge CT_Final_e orderLookup2_e;
by President;
run;

proc sort data=CT_Final1;
by order1;
run;

* 1h;
ods listing file= '/home/u59576546/CT_final.lst';
proc print data=CT_final1 N noobs label;
var President Appointee Title Start End;
format Start mmddyy8. End mmddyy8.;
title 'Cabinet Appointees for Presidents 42-44';
label Appointee = 'Appointee Name'
	  Title = 'Position Title'
	  Start = 'Start Date'
	  End = 'End Date';
options nodate pageno= 5;
run;

ods listing close;
