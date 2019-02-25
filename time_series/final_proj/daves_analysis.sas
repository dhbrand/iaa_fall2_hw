
/* using same method as before to create seasonal dummies */
data work.well_tide_trig;
	set fall2hw.well_tide_sub;
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
run;

/* only difference from before is adding the new tide x var */
proc arima data=well_tide_trig plot=all /*plot(only)=(residual(wn))*/;
	identify var=corrected_mean(1) crosscorr=(s1 c1 s2 c2 s3 c3 s4 c4 s5 c5 tide) minic scan esacf p=(0:20) q=(0:20); 
	estimate p=3 q=15 input=(s1 c1 s2 c2 s3 c3 s4 c4 s5 c5 tide);
	forecast back=168 lead=168 out=forecast;
run;
quit;

/* checking for stationarity */
proc arima data=forecast;
identify var=residual stationarity=(adf=2);
run;
quit;

/* adf test looks good */

/* calculating mape */
data mape;
  set forecast (firstobs=17641);
  mape = abs(corrected_mean - forecast)/corrected_mean;
run;

proc means data=mape mean;
  var mape;
run;

/* 0.0651846 */


/* Show predicted versus actual..how are we doing */

data forecast;
set forecast;
time=_n_;
run;

proc sgplot data=forecast;
series x=time y=corrected_mean;
series x=time y=forecast;
run;
quit;

/* we already had the predicted tide values so we
    didn't have to forecast like she did in the notes */


/* from qings code */

data final_data;
	set fall2hw.g561_final;
    if _n_ >75883;
	output;
run;

/* just to zoom in on 2017 SEP, see if there is any lag between rain and well */
data intervention;
	set final_data;
	max1 = max(well);
run;

proc sort data=work.final_data out=work.temp; 
 by descending date; 
run;

proc sgplot data=test;
series x=date y=well; /* rain first, well goes up later. lag on well? */
*series x=date y=tide; 
*series x=date y=rain;
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
		qs1=sin(2*pi*1*_n_/2193);
		qc1=cos(2*pi*1*_n_/2193);
		qs2=sin(2*pi*2*_n_/2193);
		qc2=cos(2*pi*2*_n_/2193);
		qs3=sin(2*pi*3*_n_/2193);
		qc3=cos(2*pi*3*_n_/2193);
		qs4=sin(2*pi*4*_n_/2193);
		qc4=cos(2*pi*4*_n_/2193);
		qs5=sin(2*pi*5*_n_/2193);
		qc5=cos(2*pi*5*_n_/2193);
		qs6=sin(2*pi*6*_n_/2193);
		qc6=cos(2*pi*6*_n_/2193);
		qs7=sin(2*pi*7*_n_/2193);
		qc7=cos(2*pi*7*_n_/2193);
		qs8=sin(2*pi*8*_n_/2193);
		qc8=cos(2*pi*8*_n_/2193);
		well1=lag1(well); 
		well2=lag2(well);
		rain24=lag24(rain);
		if date = '20170911T030000+0000' then int = 1;
		else int = 0;
run;


proc sgplot data=final_data;
series x=date y=well; /* a point intervention around 2017 SEP, probably another intervention at 2018 JUN*/
*series x=date y=tide;
*series x=date y=rain;
run;
quit;

data final_data;
	set final_data;
	if year=2017 and month=9 then SEP=1; else SEP=0;
	if year=2018 and month=6 then JUN=1; else JUN=0;
run;

/* fit 8 sin, 8 cos, regular difference on well, tide, and rain, add a point intervention variable, AR(3) MA(15) */
proc arima data=final_data plot=all /*plot(only)=(residual(wn))*/;
	identify var=well(1) crosscorr=(s1 c1 s2 c2 s3 c3 s4 c4 s5 c5 s6 c6 s7 c7 s8 c8 rain24 tide(1) rain(1) int 
                                    qs1 qc1 qs2 qc2 qs3 qc3 qs4 qc4 qs5 qc5 qs6 qc6 qs7 qc7 qs8 qc8 ) minic scan esacf p=(0:20) q=(0:20) nlag=36; 
	estimate p=3 q=15 input=(s1 c1 s2 c2 s3 c3 s4 c4 s5 c5 s6 c6 s7 c7 s8 c8 rain24 tide(1) rain(1) (/3) int 
                                    qs1 qc1 qs2 qc2 qs3 qc3 qs4 qc4 qs5 qc5 qs6 qc6 qs7 qc7 qs8 qc8);
	forecast back=168 lead=168 out=forecast;
run;
quit;
/*try intervention at more specific level */
/*try add another seasonal component (quarterly seasonality) 365.5/4*24=2193 hours */

/* checking for stationarity */
proc arima data=forecast;
identify var=residual stationarity=(adf=2);
run;
quit;

/* adf test looks good */

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


