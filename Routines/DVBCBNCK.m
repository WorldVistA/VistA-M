DVBCBNCK ;ALB/GTS-557/THM-BONE EXAM ; 12/10/90  1:35 PM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs"
 S HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 1410 Worksheet" S HD7="BONES (FRACTURES/BONE DISEASE)",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,! I '$D(CMBN) W "Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam:",HD7
 W !!!!,"Narrative:",?13,"Evaluate the effect of functional impairment on gait, posture",!?13,"and specific functions of adjacent joints, muscles and nerves.",!!!
 I '$D(CMBN) W "A. Medical history:",!!!!!!!!!!,"B. Subjective complaints:",!!!!!!!!!!,"C. Objective findings:",!! D HD2
 W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!?8,"1. Swelling -",!!!!!?8,"2. Deformity -",!!!!!
 W ?12,"a. Angulation -",!!!!!?12,"b. False motion -",!!!!!?12,"c. Shortening -",!!!!!!!!?8,"3. Intra-articular involvement",!!!!!!!! D:$D(CMBN) HD2
 W $S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clinical test results:",!!!!!!!!!! D:'$D(CMBN) HD2 W !!,$S($D(CMBN):"C. ",1:"F. "),"Diagnosis:",!!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for ",HD7,!,"for "_NAME,!!!
 Q
 ;
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
