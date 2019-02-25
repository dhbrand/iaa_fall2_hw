PROC IMPORT OUT= FALL2HW.impwell 
            DATAFILE= "Z:\github\fall_2_orange_hw\data\impwell.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
