*------------------------------------------------------------*;
* Data Source Setup;
*------------------------------------------------------------*;
libname EMWS1 "C:\Users\Ryan Carr\OneDrive\Documents\MSA\fall_2_orange_hw\data_mining\hw2\data_mining_hw2_cart\Workspaces\EMWS1";
*------------------------------------------------------------*;
* Ids: Creating DATA data;
*------------------------------------------------------------*;
data EMWS1.Ids_DATA (label="")
/ view=EMWS1.Ids_DATA
;
set TWEETS.TWEETS1;
run;
