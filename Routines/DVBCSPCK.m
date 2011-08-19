DVBCSPCK ;ALB/GTS-557/THM-SPINAL EXAM ; 5/17/91  9:08 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs",HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 1450 Worksheet" S HD7="SPINE (ORTHOPEDIC)",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!!!,"Narrative:"
 W ?13,"Complete description of spinal orthosis, its impact on",!?13,"motion before and after application, and whether the ",!?13,"usage is constant or intermittent should be part of the",!?13,"findings.",!!?13,"To give uniformity in "
 W "describing limitation of motion or",!?13,"ankylosis, THE USE OF A GONIOMETER IS REQUIRED.  Report",!?13,"each spinal segment separately.",!!!
 I '$D(CMBN) W "A. Medical history:",!!!!!!!!!!,"B. Subjective complaints:",!!!!!!!!!!,"C. Objective findings:",! D HD2
 W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!
 W ?8,"1. Postural abnormalities -",!!!!!?8,"2. Fixed deformity -",!!!!!?8,"3. Musculature of back -",!!!!!
 W ?8,"4. Range of motion:",!!?10,"a. Forward flexion -",!!!!?10,"b. Backward extension -",!!!!?10,"c. Left lateral flexion -",!!!! D:$D(CMBN) HD2
 W ?10,"d. Right lateral flexion -",!!!!?10,"e. Rotation to left -",!!!!!?10,"f. Rotation to right -",!!!!!
 W ?8,"5. Objective evidence of pain on motion -",!!!!! D:'$D(CMBN) HD2 W ?8,"6. Identify and describe any evidence of neurological involvement -",!!!!!
 W $S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clinical test results:",!!!!!!!!!!,$S($D(CMBN):"C. ",1:"F. "),"Diagnosis:",!!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for ",HD7," for "_NAME,!!!
 Q
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
