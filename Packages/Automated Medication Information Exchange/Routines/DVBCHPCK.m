DVBCHPCK ;ALB/GTS-557/THM-HIP EXAM ; 5/19/91  1:02 PM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs",HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 1425 Worksheet" S HD7="HIP",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!!!,"Narrative:"
 W ?13,"Loss of range of motion of the hip will be recorded from",!?13,"the anatomical position (0 degrees) varying from 125 degrees",!
 W ?13,"in flexion to 30 degrees in extension, from 25 degrees in",!?13,"adduction to 45 degrees "
 W "in abduction, and from 60 degrees in",!?13,"external rotation to 40 degrees in internal rotation.  To gain",!?13,"a true picure of hip flexion, i.e. movement between the pelvis",!
 W ?13,"and femur in the hip joint, the opposide thigh should be",!,?13,"extended to minimize motion between the pelvis and spine.",!!
 I '$D(CMBN) W "A. Medical history:",!!!!!!!!!!,"B. Subjective complaints:",!!!!!!!!!! W "C. Objective findings:" D HD2
 W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!
 W ?5,"1. Describe movements of the thigh as it may rotate",!?8,"in a circular manner about the femoral head in the "
 W !?8,"acetabulum.  Discuss any pain, tenderness, weakness",!?8,"and fatigue on standing and any unusual motions on ",!?8,"walking -",!!!!!!!!!!!
 W $S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clinical test results:",!!!!!!!!!! D:$Y>50 HD2 W $S($D(CMBN):"C. ",1:"F. "),"Diagnosis:",!!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for ",HD7,!,"for "_NAME,!!!
 Q
 ;
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
