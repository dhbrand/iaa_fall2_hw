PROC IMPORT OUT= FALL2HW.WELL_TIDE_SUB 
            DATAFILE= "Z:\github\fall_2_orange_hw\data\well_tide_sub.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
