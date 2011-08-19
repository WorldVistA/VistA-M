DVBCESCK ;ALB/GTS-557/THM-ESOPHAGUS EXAM ; 2/6/91  7:31 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs"
 S HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 0310 Worksheet" S HD7="ESOPHAGUS (DIGESTIVE)",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",?14,HD7
 W !!!!,"Narrative:"
 W ?13,"This area of examination is limited to conditions",!?13,"from mouth to the esophagogastric sphincter.",!!
 I '$D(CMBN) W "A. Medical history :",!!!!!!!!!!,"B. Subjective complaints:",!!!!!!!!!!,"C. Objective findings:",!!!!!!!!!! D HD2
 W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!
 W ?8,"1. Current weight -",!!!!!!?8,"2. Maximum weight, past year -",!!!!!!?8,"3. Anemia -",!!!!!!
 W ?8,"4. Disturbance of motility -",!!!!!!?8,"5. Actual partial obstruction (indicate frequency of dilatation",!,?39,"if required) -",!!!!!
 W ?8,"6. Reflux disturbances -",!!!!!! D:$D(CMBN) HD2 W ?8,"7. Presence of pain -",!!!!!!
 D:'$D(CMBN) HD2 W $S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clinical test results:",!!!!!!!!!! W $S($D(CMBN):"C. ",1:"F. "),"Diagnosis:",!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for "_NAME,!
 W HD8,!!!
 Q
 ;
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
