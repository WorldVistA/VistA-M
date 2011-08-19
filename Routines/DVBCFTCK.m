DVBCFTCK ;ALB/GTS-557/THM-FEET EXAM ; 2/4/91  7:40 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs"
 S HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 1415 Worksheet" S HD7="FEET (ORTHOPEDIC)",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!!!,"Narrative:"
 W ?13,"The findings in each foot will be separately and carefully",!?13,"described, as this will affect the evaluation.  The nomenclature",!?13,"of toes for examination purposes will be the great toe, the second,",!
 W ?13,"third, fourth and fifth toes, named from the medial or inner side",!?13,"and which foot is being examined.  The functional loss should",!?13,"be related to the anatomical condition.",!!
 I '$D(CMBN) W "A. Medical history:",!!!!!!!!!!,"B. Subjective complaints:",!!!!!!!!!!,"C. Objective findings:",!!!!!!!!!! D HD2
 W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!
 W ?8,"1. Posture (standing, squatting, supination, pronation and",!?22,"rising on toes and heels) -",!!!!!
 W ?8,"2. Appearance -",!!!!!?8,"3. Function -",!!!!!?8,"4. Deformity -",!!!!!?8,"5. Gait -",!!!!!?8,"6. Secondary skin and vascular changes -" D HD2
 W $S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clinical test results:",!!!!!!!!!!!! D:$Y>50 HD2 W $S($D(CMBN):"C. ",1:"F. "),"Diagnosis:",!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for ",HD7,!,NAME,!!!
 Q
 ;
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
