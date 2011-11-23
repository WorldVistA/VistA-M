DVBCJNCK ;ALB/GTS-557/THM-JOINT EXAM ; 5/17/91  8:47 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs",HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 1430 Worksheet" S HD7="JOINTS (ORTHOPEDIC)",HD8="FOR "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!!!,"Narrative:"
 W ?13,"Do not use negative values to indicate inability to achieve",!?13,"full extension.  The anatomical position is the reference",!?13,"position EXCEPT with the regard to rotation of the shoulder",!?13,"and pronation/supination "
 W "of the forearm (see fig. 2.1 and 2.2",!?13,"of the Physician's Guide).  To give uniformity in describing",!?13,"limitation of motion or ankylosis of a joint, THE USE OF A",!?13,"GONIOMETER IS REQUIRED.",!!!
 I '$D(CMBN) W "A. Medical history:",!!!!!!!!!! W "B. Subjective complaints:",!!!!!!!!!!,"C. Objective findings:",! D HD2
 W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!
 W ?8,"1. Swelling -",!!!!!?8,"2. Deformity -",!!!!!
 W ?8,"3. Other impairment of knee: subluxation or lateral instability;",!?11,"non-union, with loose motion; malunion -",!!!!!
 D:$D(CMBN) HD2 W ?8,"4. Range of motion (complete chart below)-",!!?11,"Note: Enter joint names in blanks under numbers below.  If more",!
 W ?11,"than four joints are involved, please extend your dictation in the",!?11,"same format.",!!
 S LN="|============|============|============|============|",LN1="|            |            |            |            |",LN2="|------------|------------|------------|------------|"
 W ?19,"------------------ JOINT EXAMINED -------------------",!!?25,"1",?32,"|",?38,"2",?45,"|",?51,"3",?58,"|",?65,"4",?71,"|",!?19,LN,!,"Range of:",?19,LN1,!,"----- --",?19,LN,!
 F JX="Flexion","Extension","Rotation","Abduction","Adduction","Pronation","Supination","Deviation (radial)","Deviation (ulnar)","Plantar Flexion","Dorsiflexion" W JX,?19,LN1,!?19,LN2,!
 D HD2 W $S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clinical test results:",!!!!!!!!!!!!
 W $S($D(CMBN):"C. ",1:"F. "),"Diagnosis:",!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for JOINTS for "_NAME,!!!
 Q
 ;
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
