DVBCREQM ;ALB ISC/THM-DIAGNOSTIC TEST ORDER SHEET, GENERIC ; 6/28/91  7:08 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
EN K DVBCXX,DVBCDASH,DVBCBX,DVBCULN
 S DVBCXX="C&P Diagnostic Test Order Record",$P(DVBCDASH,"-",79)="-",$P(DVBCULIN,"_",70)="_",DVBCBX="        |          |            |         |       "
 S DVBCXHD="S DVBCCNTR=1 W !?35,""Order"",!?8,""Test"",?22,""Order #"",?35,""Date"",?45,""Initials"",?64,""Remarks"",!,DVBCDASH,! F DVBC=1:1:6 W ?($S(DVBCCNTR>9:0,1:1)),DVBCCNTR,""."",?12,DVBCBX,!,DVBCDASH,! S DVBCCNTR=DVBCCNTR+1"
 W @IOF,!,?(80-$L(DVBCXX)\2),DVBCXX,!!,"Name: ",PNAM,?40,RQ,!," SSN: ",SSN F DVBCYX="Laboratory:","Radiology:","Other:" W !!,DVBCYX,! X DVBCXHD
 K DVBCXX,DVBCDASH,DVBCBX,DVBCULN,DVBCCNTR
 Q
