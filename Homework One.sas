* Homework One;
libname data1 '/home/u59576546/data1';

* #1;
libname home '/home/u59576546';

* #2;
proc print data=data1.chicago label noobs;
label Date = 'Departure Date'
	  Flight = 'Flight Number'
	  Boarded = 'Passengers Boarded'
	  Transfer = 'Passengers Transferred';
var Date Flight Boarded Transfer;
sum Boarded; run;

*#3;
DATA tech_co;
input company $ yr_founded ceo $ revenue_2020;
datalines;
Amazon 1994 Jassy 386.1
Apple 1976 Cook 274.5
Google 1998 Pichai 181.7
Microsoft 1975 Nadella 143
Netflix 1997 Hastings 25;
proc print data=tech_co label noobs;
label company= 'Company'
	  yr_founded = 'Year Founded'
	  ceo = 'Chief Executive Officer'
	  revenue_2020 = '2020 Revenue (billions USD)';
run;
	 

