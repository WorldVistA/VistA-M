DVBCHNCK ;ALB/GTS-557/THM-HAND,THUMB, FINGER ; 12/10/90  1:39 PM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs",HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 1420 Worksheet" S HD7="HAND, THUMB, AND FINGERS",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!!!,"Narrative:"
 W ?13,"The hand should be evaluated as a unit intricately adapted",!?13,"for grasping, pushing, pulling, twisting, probing, writing,",!?13,"touching, and expression.  Do not designate fingers numerically;",!?13,"use thumb, index, "
 W "middle, ring and little.  Specify which hand is",!?13,"involved and state whether the individual is right or left-handed."
 W !?13,"Designate the joints as wrist, MP (metacarpophalangeal), PIP,",!?13,"(proximal interphalangeal) or DIP (distal interphalangeal).",!?13,"Designate phalanges as proximal, middle or distal.",!!!
 I '$D(CMBN) W "A. Medical history:",!!!!!!!!!!,"B. Subjective complaints:",!!!!!!!!!!,"C. Objective findings:",! D HD2 W !!
 W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!?8,"1. Anatomical defects -",!!!!!!!
 W ?8,"2. Functional defects (motion of thumb and fingers should be described",!?11,"as to how near, in inches, the tip of thumb can approximate the",!?11,"fingers, or how near the tips of fingers can "
 W "approximate the median",!?11,"transverse fold of the palm.) -",!!!!!!!!!!?8,"3. Grasping objects (strength and dexterity) -",!!!!!!!!!!
 D:$D(CMBN) HD2 W $S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clinical test results:",!!!!!!!!!! D:'$D(CMBN) HD2
 W $S($D(CMBN):"C. ",1:"F. "),"Diagnosis:",!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for ",HD7,!,"for ",NAME,!!!
 Q
 ;
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
