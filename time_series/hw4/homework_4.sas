libname fall2hw 'C:\Users\Ryan Carr\OneDrive\Documents\MSA\fall_2_orange_hw\data';

proc print data=fall2hw.impwell (obs =10);
run;

/*create sine and cosine variables to model the seasonality*/
data fall2hw.impwell;
	set fall2hw.impwell;
	pi=constant("pi");
	s1=sin(2*pi*1*_n_/8766);
	c1=cos(2*pi*1*_n_/8766);
	s2=sin(2*pi*2*_n_/8766);
	c2=cos(2*pi*2*_n_/8766);
	s3=sin(2*pi*3*_n_/8766);
	c3=cos(2*pi*3*_n_/8766);
	s4=sin(2*pi*4*_n_/8766);
	c4=cos(2*pi*4*_n_/8766);
	s5=sin(2*pi*5*_n_/8766);
	c5=cos(2*pi*5*_n_/8766);
	s6=sin(2*pi*6*_n_/8766);
	c6=cos(2*pi*6*_n_/8766);
run;

/*
proc arima data=fall2hw.impwell plots=all;
	identify var=Corrected_Mean crosscorr=(s1 c1 s2 c2 s3 c3 s4 c4) nlag=2160 minic scan esacf p=(0:12) q=(0:12);
	estimate input=(s1 c1 s2 c2 s3 c3 s4 c4) method=ML;
	forecast back=2160 lead=2160;
run;

proc arima data=fall2hw.impwell plots=all;
	identify var=Corrected_Mean crosscorr=(s1 c1 s2 c2 s3 c3 s4 c4) nlag=2160;
	estimate input=(s1 c1 s2 c2 s3 c3 s4 c4) method=ML;
	forecast back=2160 lead=2160;
run;
*/

proc arima data=time.impwell plot=all /*plot(only)=(residual(wn))*/;
	identify var=Corrected_Mean(1,8760) crosscorr=(s1 c1 s2 c2 s3 c3 s4 c4 s5 c5) minic scan esacf p=(0:20) q=(0:20); 
	estimate p=3 q=15 input=(s1 c1 s2 c2 s3 c3 s4 c4 s5 c5);
	forecast back=8760 lead=8760 noprint out=resid;
	
	run;
quit;

proc export data=work.resid
   outfile='C:\Users\Ryan Carr\Documents\MSA\Femalelist.csv'
   dbms=csv
   replace;
run;
