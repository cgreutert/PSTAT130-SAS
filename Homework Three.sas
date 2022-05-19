* Homework 3;

*1;
	
	* 1a;
proc sort data=data1.military;
	BY State Type City;
run;
data work.military_sorted;
	set data1.military;
run;

	*1b;
ods listing file='/home/u59576546/militaryhw3.lst';
proc print data=work.military_sorted label n;
	title1 'US Military';
	title2 ' ';
	title3 'Air Force and Army Airports';
	footnote1 'Sorted by State, Military Branch, and City';
	var State Type City Airport;
	label state = 'State Abbreviation'
		  type = 'Military Branch';
	where type ='Air Force' or type = 'Army';
	by State;
	pageby State;
	options nodate pageno=3;	
run;
ods listing close; 	 

* 2;

	*2a;
data work.CarAccidents;
infile '/home/u59576546/data1/CarAccidents.dat';
input Reference $1-7 Day $29-38 Time 40-43 Severity 55 nVehicles 24 VehicleType 62-63;
format Day mmddyy10.;
run;

	*2c;
proc contents data=work.CarAccidents;
run;

	* 2d;
ods listing file='/home/u59576546/carhw3.lst';
proc print data=work.CarAccidents noobs;
	title Car Accidents;
	options date nonumber ps=120 ls=96;
run;
ods listing close;

*3;	

	*3a;
data work.CarAccidents2;
infile '/home/u59576546/data1/CarAccidents.dat';
input @1 Reference $ @29 Day MMDDYY8. @40 Time @51 Weather @24 nVehicles @26 nCasualties;
run;

	* 3b;
ods listing file='/home/u59576546/car2hw3.lst';
proc print data=work.CarAccidents2;
title Car Accidents2;
options number nodate ls=64; 
format Day DATE9.;
run;
ods listing close;

* 4;

	* 4a;
proc datasets library=work;
	modify Caraccidents2;
	label Reference= Reference Number
		  Day = Date of Accident
		  Weather = Weather Condition
		  nVehicles = Number of Vehicles
		  nCasualties = Number of Casualties;
run;
proc contents data=work.Caraccidents2;
run;

	*4b;
proc datasets library=work;
	modify Caraccidents2;
	format Day DATE7.;
	label Reference = Reference ID;
run;
proc contents data=work.caraccidents2;
run;

