filename temp catalog "sashelp.emtxtext.tmt_doc_score.source";
%include temp;
filename temp catalog "sashelp.emtxtext.row_pivot_normalize.source";
%include temp;
filename temp;
 
libname termloc "C:\Users\Ryan Carr\OneDrive\Documents\MSA\fall_2_orange_hw\data_mining\hw2\data_mining_hw2_cart\Workspaces\EMWS1";
 
%let _multifile=%SYSFUNC(PATHNAME(work))/TextFilter_multi.txt;
%let _multiSLength= %klength(&_multifile);
 
data termloc.TextFilter_tmconfig;
length multiterm $ &_multiSLength;
set termloc.TextFilter_tmconfig;
multiterm=ktrim(symget('_multifile'));
run;
 
proc sql noprint;
select multiencoding into: _tmmultiencoding
from termloc.TextFilter_tmconfig;
quit;
 
filename _multout "&_multifile";
data _NULL_;
set termloc.TextParsing_multiall;
file _multout encoding= "%trim(&_tmmultiencoding)";
put term ':3:' role;
run;
