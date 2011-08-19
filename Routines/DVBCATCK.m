DVBCATCK ;ALB/GTS-557/THM-HIGHER LEVEL A&A EXAM ; 1/3/91  9:37 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 K LINE S PG=1,HD91="Department of Veterans Affairs"
 S HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
 S $P(LINE,"-",75)="-"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 1720 Worksheet" S HD7="HIGHER LEVEL AID & ATTENDANCE",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________"
 W !!,"Type of Exam: ",HD7,!!!!,"Narrative:  "
 S TXT="TXT10" D PTXT W !!!!!!!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2,LINE
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam "_HD8,!,"for ",NAME,!!!
 Q
 ;
PTXT D PTXT^DVBCATC1
 Q
 ;
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
