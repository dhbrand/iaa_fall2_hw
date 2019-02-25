*------------------------------------------------------------*;
* Data Source Setup;
*------------------------------------------------------------*;
libname EMWS1 "C:\Users\Ryan Carr\OneDrive\Documents\MSA\fall_2_orange_hw\text_analytics\text_analytics_for_tweets\Workspaces\EMWS1";
*------------------------------------------------------------*;
* Ids: Creating DATA data;
*------------------------------------------------------------*;
data EMWS1.Ids_DATA (label="")
/ view=EMWS1.Ids_DATA
;
set TWEETS.TWEETS3;
run;
