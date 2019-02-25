%macro main();

   %if %upcase(&EM_ACTION) eq CREATE %then %do;
      filename temp catalog 'sashelp.emtxtext.cluster_create.source';
      %include temp;
      %create();
   %end;
   %if %upcase(&EM_ACTION) eq TRAIN %then %do;
      filename temp catalog 'sashelp.emtxtext.cluster_train.source';
      %include temp;
      %train();
   %end;
   %if %upcase(&EM_ACTION) eq REPORT %then %do;
      filename temp catalog 'sashelp.emtxtext.cluster_report.source';
      %include temp;
      %report();
   %end;
   %if %upcase(&EM_ACTION) eq SCORE %then %do;
      filename temp catalog 'sashelp.emtxtext.cluster_score.source';
      %include temp;
      %score();
   %end;
%mend main;

%main();
