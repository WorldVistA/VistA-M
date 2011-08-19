IBDFU5A ;ALB/CJM - ENCOUNTER FORM - (contains Xecutable help);3/29/93
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
HELP6 ;help for choosing print condition
 W "Choose FOR EVERY APPOINTMENT if the form should print for every appointment.",!
 W !,"Choose ONLY FOR EARLIEST APPOINTMENT if the form should print once per",!,"patient, even if he has multiple appointments",!
 W !,"Choose ONLY IF MULTIPLE APPOINTMENTS if the form should print only if the",!,"patient has multiple appointments. If so, it will print only for the",!,"earliest appointment.",!
 Q
 ;
HELP7 ;help for entering field .16 in the package interface file, type of 
 ;object that may point to a package interace
 ;
 W !,"This field only applies to input interfaces."
 W !,"It is used to determine what type of form objects may reference the interface."
 W !,"Enter any combination of S=selection list, M=multiple choice, H=hand print P=PANDAS"
 W !,"Example: You may enter 'SM'."
 Q
