*Homework Seven;
*1;
	*a;
proc report data=data1.beach2019; run;
	*b;
proc gchart data=data1.beach2019;
hbar beach; 
run;
	*c;
proc gchart data=data1.beach2019;
pie beach / sumvar=items
			type=sum
			fill=x
			explode= 'Windy Hill Beach';
	format items COMMA8.;
run;
	*d;
proc gplot data=data1.beach2019;
plot items * hours / vaxis= 0 to 1500 by 500
					 regeqn; *intentionally left out outlier for readability;
where hours <= 30;
symbol c=blue v=star i=rl;
label items= 'Number of Items Cleaned Up'
	  hours= 'Number of Hours of Cleanup';
run;
quit;

	*e;
data Folly(keep= Date Organization) HuntingIsland(keep=Date Items Hours) NorthMyrtle(keep=Date Organization Items Hours)
Surfside(keep= Date Organization Hours) WindyHill(keep=Date Organization Items Hours Weight)
Other(keep=Date Beach Organization Items Hours Weight);
set data1.beach2019;
if beach= 'Folly Beach' then output Folly;
if beach= 'Hunting Island' then output HuntingIsland;
if beach= 'North Myrtle Beach' then output NorthMyrtle;
if beach= 'Surfside Beach' then output Surfside;
if beach= 'Windy Hill Beach' then output WindyHill;
if beach= 'Other' then output Other;
run;

	*g;
data b1;
set data1.beach2019;
HoursRT= sum(HoursRT, Hours);
retain;
run;
proc print data=b1; run;
data b2;
set data1.beach2019;
HoursRT + Hours;
run;
proc print data=b2; run;

	*h;
proc sort data=data1.beach2019 out=beach2019_sorted;
by Beach;
run;
data b3;
set beach2019_sorted;
by Beach;
if First.Beach then TotalHours=0;
TotalHours+Hours;
keep Beach TotalHours;
if Last.Beach;
run;
proc print; run;
	
	*i;
data work.projections;
set b3;
do i=1 to 3;
Year= i;
if Year=1 then hours_proj=TotalHours*1.07;
else if Year ~= 1 then hours_proj=hours_proj*1.07;
output;
end;
drop i TotalHours;
label hours_proj= 'Projected Cleanup Hours';
format hours_proj 7.3;
run;
proc report data=work.projections; run;
