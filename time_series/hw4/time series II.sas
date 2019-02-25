libname fall2hw '\\vmware-host\Shared Folders\Documents\GitHub\fall_2_orange_hw\Data';

data fall2hw.well_trig;
	set fall2hw.impwell;
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

proc arima data=fall2hw.well_trig plot=all /*plot(only)=(residual(wn))*/;
	identify var=corrected_mean(1) crosscorr=(s1 c1 s2 c2 s3 c3 s4 c4 s5 c5) minic scan esacf p=(0:20) q=(0:20); 
	estimate p=3 q=15 input=(s1 c1 s2 c2 s3 c3 s4 c4 s5 c5);
	forecast back=168 lead=168 out=forecast;
run;
quit;

/* calculating mape */
data mape;
  set forecast (firstobs=17641);
  mape = abs(corrected_mean - forecast)/corrected_mean;
run;

proc means data=mape mean;
  var mape;
run;

/* 0.0651800 */

/*export for formatting in excel*/
proc export data=work.forecast
   outfile='C:\Users\Ryan Carr\Documents\MSA\finalwell.csv'
   dbms=csv
   replace;
run;
