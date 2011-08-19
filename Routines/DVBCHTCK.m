DVBCHTCK ;ALB/GTS-557/THM-HYPERTENSION EXAM ; 12/5/90  2:14 PM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs",HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 0115 Worksheet" S HD7="HYPERTENSION",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",?14,HD7
 W !!!!,"Narrative:"
 W ?13,"There should be at least three blood pressure readings",!?13,"in the sitting position spaced throughout the examination.",!
 W ?13,"At times it may be necessary to recall the veteran on",!?13,"subsequent days to obtain readings which are most",!
 W ?13,"representative of the true blood pressure.",!!
 I '$D(CMBN) W "A. Medical history:",!!!!!!!!!!,"B. Subjective complaints:",!!!!!!!!!!,"C. Objective findings:",! D HD2
 W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!
 W ?8,"1. Blood pressure readings:",!!!?13,"sitting -",!!?13,"lying -",!!?13,"standing -",!!!!!!?8,"2. Medication -",!!!!!!?8,"3. Enlarged heart confirmation -",!!!!!!
 W ?8,"4. Apex beat beyond midclavicular line -",!
 D HD2 W $S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clinical test results:",!!!!!!!!!!,$S($D(CMBN):"C. ",1:"F. ") D:$Y>50 HD2
 W "Diagnosis:",!!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
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
