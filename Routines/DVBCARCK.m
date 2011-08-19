DVBCARCK ;ALB/GTS-557/THM-REGULAR A&A/HOUSEBOUND EXAM ; 1/3/91  8:25 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 K LINE S PG=1,HD91="Department of Veterans Affairs",HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet",$P(LINE,"-",75)="-"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 1715 Worksheet" S HD7="REGULAR AID AND ATTENDANCE/HOUSEBOUND STATUS",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________"
 W !!,"Type of Exam: ",HD7,!!!!,"Narrative:  "
 S TXT="TXT10" D PTXT S TXT="TXT2" D PTXT W !!!
 D HD2 W "D. Present complaints (symptoms only, NOT diagnosis):",!!!!!!!!!!!!,"E. Examination data:",!!!!,"Height:",?25,"Weight:",?45,"Max wgt past year:",!!!
 W "Build and state of nutrition:",!!!,"Posture:",?23,"Gait:",!!!,"General appearance:",!!!
 W "Pulse:",?20,"Blood pressure:",?51,"Respiration:",!
 S TXT="TXT3" D PTXT,HD2 W !!!,"K. Diagnosis:",!!!!!!!!!!!
 W "L. Additional remarks as examiner deems necessary in individual case:",!!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2,LINE
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam "_HD8,!,"for ",NAME,!!!
 Q
 ;
PTXT D PTXT^DVBCARC1
 Q
 ;
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
