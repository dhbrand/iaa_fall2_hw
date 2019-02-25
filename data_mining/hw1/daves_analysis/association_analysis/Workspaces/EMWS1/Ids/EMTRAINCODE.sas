*------------------------------------------------------------*;
* Data Source Setup;
*------------------------------------------------------------*;
libname EMWS1 "Z:\github\fall_2_orange_hw\data_mining\hw1\daves_analysis\association_analysis\Workspaces\EMWS1";
*------------------------------------------------------------*;
* Ids: Creating DATA data;
*------------------------------------------------------------*;
data EMWS1.Ids_DATA (label="")
;
set DM.RESTAURANTDATA;
drop type;
run;
