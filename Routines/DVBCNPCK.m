DVBCNPCK ;ALB/GTS-557/THM-ALL FORMS OF NEPHRITIS ; 11/7/90  11:19 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs",HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 1105 Worksheet" S HD7="NEPHRITIS, EXCEPT CHRONIC PYELONEPHRITIS",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!!!,"Narrative:"
 W ?13,"Complications and/or medical side effects should always be",!?13,"reported, even when not specifically requested.",!!
 I '$D(CMBN) W "A. Medical history:",!!!!!!!!!!,"B. Subjective complaints:",!!!!!!!!!!,"C. Objective findings:",! D HD2
 W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!
 W ?8,"1. Blood pressure -",!!!!!?8,"2. Presence or absence of albumin casts -",!!!!!
 W ?8,"3. Edema -",!!!!!?8,"4. Red blood cells -",!!!!!
 W ?8,"5. Retention of non-protein nitrogen, creatinine or urea nitrogen -",!!!!!?8,"6. Describe overall impairment of kidney function -",!!!!!?8,"7. Report presence or absence of any cardiac complications -",!!!!!!!
 D HD2 W $S($D(CMBN):"B. ",1:"E. "),"Diagnosic/clinical test results:",!!!!!!!!!!!!,$S($D(CMBN):"C. ",1:"F. "),"Diagnosis:",!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for ",HD7,!," for "_NAME,!!!
 Q
 ;
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
