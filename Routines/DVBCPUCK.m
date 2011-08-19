DVBCPUCK ;ALB/GTS-557/THM-PITUITARY TUMORS/AROMEGALY, PROLACTINOMA ; 12/26/90  12:40 PM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs",HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 0435 Worksheet" S HD7="PITUITARY TUMORS - ACROMEGALY, PROLACTINOMA",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!!!,"Narrative:"
 S LX="TXT" F I=1:1 S LY=$T(@LX+I) Q:LY["END"  W ?13,$P(LY,";;",2),!
 W !! I '$D(CMBN) W "A. Medical history:",!!!!!!!!!!,"B. Subjective complaints:",!!!!!!!!!!,"C. Objective findings:" D HD2
 W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!
 W ?5,"1.  Frequency of headaches -",!!!!!!?5,"2.  Changes in vision -",!!!!!!?5,"3.  Cardiac symptoms -",!!!!!!
 W ?5,"4.  Joint pain -",!!!!!!?5,"5.  Acromegaly -",!!!!!!
 W ?5,"6.  Kyphosis of cervicodorsal spine -",!!!!!! D:$D(CMBN) HD2 W ?5,"7.  Abnormal glucose tolerance -",!!!!!!?5,"8.  Genital atrophy -",!!!!!! D:'$D(CMBN) HD2
 W $S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clinical test results:",!!!!!!!!!!!!!!,$S($D(CMBN):"C. ",1:"F. "),"Diagnosis:",!!!!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for ",HD7,!,"for ",NAME,!!!
 Q
 ;
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
 ;
TXT ;
 ;;When symptoms interfere with normal daily activities or job
 ;;efficiency, it is essential that the extent of such handicaps
 ;;be described.
 ;;END
