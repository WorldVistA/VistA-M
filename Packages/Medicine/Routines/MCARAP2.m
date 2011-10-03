MCARAP2 ;WASH ISC/SAE-MEDICINE AUTO INSTRUMENT INTERFACE SUMMARY PRINT ;7/25/94  07:45
 ;;2.3;Medicine;;09/13/1996
 ;
QMARK W @IOF,"Choose S, U, or A to select report, or ^ to exit",!,"Enter Patient's name, or press return for all Patients"
 W !,"   E.G. (LAST or LAST,FIRST or LAST,FIRST MI)"
 W !!,"TEST DATE:  Date test was perfomed"
 W !,"FIRST TRANS:  Date/time first transferral attempt of record was made"
 W !,"LAST TRANS:  Date/time last transferral attempt was made"
 W !,"PATIENT:  Patient name as transmitted from Instrument System"
 W !,"SSN:  ID transmitted from Instrument System"
 W !,"TRIES:  Number of times individual record's transferral was attempted"
 W !,"ERR:  Reason for failure to pass DHCP validity checks"
 W !!,"Error codes indicate record transferrral attempt was unsuccessful:",!,?5,"D",?10,"Date and/or Time transmitted were not valid"
 W !,?5,"S",?10,"SSN lookup in DHCP Patient File was unsuccessful",!,?5,"N",?10,"Name transmitted does not match name in DHCP Patient File"
 W !,?5,"L",?10,"ECG File Load attempt was unsuccessful"
 W !,?5,"M",?10,"Machine Diagnosis was null"
 W !,?5,"P",?10,"Provider lookup was unsuccessful"
 W !!,"At end of report is a statistical tally of total number of ""LAST TRANS"" attempts",!,"  made for requested category during designated date range"
 ;W !!,"Record transferral attempts within only the past month are available"
 Q
 ;
QMARK2  ;Displays definitions of integer error codes
 W @IOF,!!,"Error codes >50 indicate record transferrral attempt was unsuccessful:",!!,?5,"51",?10,"Date is a null data field"
 W !,?5,"51",?10,"Time is a null data field"
 W !,?5,"52",?10,"Date/Time not DD-MON-YYYR@HH:MM",!,?5,"53",?10,"Date/Time rejected by %DT"
 W !,?5,"54",?10,"Social Security Number is not numeric",!,?5,"54",?10,"Social Security Number is a null data field"
 W !,?5,"55",?10,"Social Security Number not in patient file",!,?5,"56",?10,"Name does not match patient file"
 W !,?5,"57",?10,"Name is a null data field",!,?5,"58",?10,"ECG record not filed"
 W !,?5,"59",?10,"ECG record undefined-Diagnosis not filed",!,?5,"60",?10,"ECG record undefined-Medication not filed"
 W !,?5,"62",?10,"Diagnosis is a null data field"
 W !,?5,"63",?10,"Interpreted By is a null data field"
 W !,?5,"64",?10,"Interpreted By does not match name in New User file"
 Q
