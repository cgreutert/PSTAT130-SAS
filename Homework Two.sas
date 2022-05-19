* PSTAT 130 HW2 Greutert;
libname home '/home/u59576546';
libname data1 '/home/u59576546/data1';
libname schools '/home/u59576546/data1/';

* 1a;
proc format;
	value $statefmt 'CA' = 'California'
		   		 'OR' = 'Oregon'
		   		 'WA' = 'Washington';
run;

* 1b;
* i;

* HTML file;
proc print data=data1.schools label noobs;
	options linesize=88 date pageno=10;
	title height=7 color=blue justify=right 'School Data';
	var state name focus size founded;
	label state = 'State' 
		  name = 'School Name'
		  focus = 'Academic Focus'
		  size = 'Number of Students'
		  founded = 'Date Founded';
	where state = 'CA' or state = 'WA';
	format state $statefmt.
		   founded date9.;
	run;
* Listing file;
ods listing file='/home/u59576546/school_data.lst';
proc print data=data1.schools label noobs;
	options linesize=88 date pageno=10;
	title height=7 color=blue justify=right 'School Data';
	var state name focus size founded;
	label state = 'State' 
		  name = 'School Name'
		  focus = 'Academic Focus'
		  size = 'Number of Students'
		  founded = 'Date Founded';
	where state = 'CA' or state = 'WA';
	format state $statefmt.
		   founded date9.;
	run;
ods listing close;

*1c;
proc contents data=data1.schools; 
	run;