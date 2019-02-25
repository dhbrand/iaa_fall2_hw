if upcase(NAME) = "AGE" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "CONTACTS" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "DAY" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "DAYS_SINCE" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "DEFAULT" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "EDUCATION" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "JOB" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "LOAN" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "MORTGAGE" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "PHONE_TYPE" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "Q_YNO" then do;
ROLE = "ASSESS";
end;
else 
if upcase(NAME) = "Q_YYES" then do;
ROLE = "ASSESS";
end;
else 
if upcase(NAME) = "TOTAL_CONTACTS" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "_NODE_" then do;
ROLE = "SEGMENT";
LEVEL = "NOMINAL";
end;
