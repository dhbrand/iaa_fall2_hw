libname fall2hw '\\vmware-host\Shared Folders\Documents\GitHub\fall_2_orange_hw\data';

/* import the final dataset that contains well, tide, and rain*/
PROC IMPORT OUT= FALL2HW.g561_final
            DATAFILE= "\\vmware-host\Shared Folders\Documents\GitHub\fall_2_orange_hw\data\g561_final.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

/* focus on data from June 1st, 2016 and forward*/

data final_data;
	set fall2hw.g561_final;
    if _n_ >75883;
	output;
run;

/* -------just to zoom in on 2017 SEP, see if there is any lag between rain and well  ----- */
   
data test;
	set final_data;
	if year=2017 and month=9;
	output;
run;

proc sgplot data=test;
*series x=date y=well; 
*series x=date y=tide; /* possible lag */
series x=date y=rain; /* rain first, well goes up later. lag on well? */
run;
quit;

/* using same method as before to create seasonal dummies */
data final_data;
	set final_data;
		pi=constant("pi");
		s1=sin(2*pi*1*_n_/8772);
		c1=cos(2*pi*1*_n_/8772);
		s2=sin(2*pi*2*_n_/8772);
		c2=cos(2*pi*2*_n_/8772);
		s3=sin(2*pi*3*_n_/8772);
		c3=cos(2*pi*3*_n_/8772);
		s4=sin(2*pi*4*_n_/8772);
		c4=cos(2*pi*4*_n_/8772);
		s5=sin(2*pi*5*_n_/8772);
		c5=cos(2*pi*5*_n_/8772);
		s6=sin(2*pi*6*_n_/8772);
		c6=cos(2*pi*6*_n_/8772);
		s7=sin(2*pi*7*_n_/8772);
		c7=cos(2*pi*7*_n_/8772);
		s8=sin(2*pi*8*_n_/8772);
		c8=cos(2*pi*8*_n_/8772);
		*qs1=sin(2*pi*1*_n_/2193);
		*qc1=cos(2*pi*1*_n_/2193);
		*qs2=sin(2*pi*2*_n_/2193);
		*qc2=cos(2*pi*2*_n_/2193);
		*well1=lag1(well); 
		*well2=lag2(well);
		*rain24=lag24(rain);
		*tide24=lag24(tide);
run;

/* visualize our dataset*/
proc sgplot data=final_data;
series x=date y=well; /* a point intervention around 2017 SEP*/
*series x=date y=tide;
*series x=date y=rain;
run;
quit;

/* create an Intervention variable */
data final_data;
	set final_data;
	/*if date='20170911T030000+0000' then Intervention=1; else Intervention=0;*/
	if year=2017 and month=9 then SEP=1; else SEP=0;
run;

/* fit 8 sin, 8 cos, regular difference on well, tide, and rain, add a point intervention variable, AR(3) MA(15) */
proc arima data=final_data plot=all /*plot(only)=(residual(wn))*/;
	identify var=well(1) crosscorr=(s1 s2 s3 s4 s5 s6 s7 s8 c1 c2 c3 c4 c5 c6 c7 c8 tide(1) rain(1) SEP) minic scan esacf p=(0:20) q=(0:20) nlag=36; 
	estimate p=3 q=15 input=(s1 s2 s3 s4 s5 s6 s7 s8 c1 c2 c3 c4 c5 c6 c7 c8 tide rain SEP);
	forecast back=168 lead=168 out=forecast;
run;
quit;


/* checking for stationarity */
proc arima data=forecast;
identify var=residual stationarity=(adf=2);
run;
quit;
/* ACF plot is not perfect */

/* calculating mape */
data mape;
  set forecast (firstobs=17641);
  mape = abs(well - forecast)/well;
run;

proc means data=mape mean;
  var mape;
run;

/* 0.0626717 */


/* Show predicted versus actual..how are we doing */

data forecast;
set forecast;
time=_n_;
run;

proc sgplot data=forecast;
series x=time y=well;
series x=time y=forecast;
run;
quit;

/* we already had the predicted tide values so we
    didn't have to forecast like she did in the notes */


