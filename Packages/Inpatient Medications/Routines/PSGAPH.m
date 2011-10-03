PSGAPH ;BIR/CML3-HELP FOR ACTION PROFILES ;16 DEC 97 / 1:36 PM 
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
H1 ;
 W !!?2,"If a START date is entered, only orders that stop on or after the date entered",!,"will be shown.  If a start date is entered without a time, the beginning of the",!,"day is assumed." D M1,M2 Q
 ;
H2 ;
 W !!?2,"If a STOP date is entered, only orders that start on or before the stop date",!,"entered" W:PSGAPB ", and stop on or after ",$P(PSGAPB,"^",2),"," W " will be shown."
 W !,"If a stop date is entered without a time, the end of the day is assumed." D M1,M2 Q
 ;
M1 ;
 W !?2,"Neither the start date nor the stop date is required.  If neither is entered,",!,"all orders that are currently active are shown." Q
 ;
M2 ;
 W !!?2,"PLEASE NOTE that although you can enter a date range that is in the past,",!,"only those patients that are currently admitted can be shown, and that the",!,"orders will show their current information.",! Q
