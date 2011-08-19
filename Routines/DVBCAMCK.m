DVBCAMCK ;ALB/GTS-557/THM-AMPUTATION STUMP EXAM ; 5/21/91  10:07 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs"
 S HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 1405 Worksheet" S HD7="AMPUTATION STUMPS",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,! I '$D(CMBN) W "Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!!!,"Narrative:"
 W ?13,"Amputations must be described in accordance with the following",!?13,"levels:",!!!!!!!?5,"1. ARM:",!!?8,"a. Disarticulation",!?8,"b. Amputation above insertion of deltoid muscle",!?8,"c. Amputation below insertion of deltoid muscle",!!
 W ?5,"2. FOREARM:",!!?8,"a. Above radial insertion of pronator teres (function is best indicator",!?11,"of disability)",!?8,"b. Below insertion of pronator teres",!!
 W ?5,"3. THIGH:",!!?8,"a. Disarticulation, with loss of extrinsic pelvic girdle muscles",!?8,"b. Amputation of upper, middle or lower third, always measured",!?11,"from perineum to the boney end of the stump with the claimant",!
 W ?11,"recumbent and stump lying parallel with the other lower limb",!?8,"c. State whether this level permits satisfactory prosthesis",!!
 W ?5,"4. LEG:",!!?8,"a. Give level of amputation and condition of stump",!?8,"b. State whether this level permits satisfactory prosthesis",!?8,"c. Describe any stump defects (e.g. painful neuroma or circulatory",!?11,"disturbance)",!!
 I '$D(CMBN) D HD2 W "A. Objective findings:",!!!!!!!!!!
 D:$D(CMBN) HD2 W $S($D(CMBN):"A. ",1:"B. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!!
 W ?8,"1. Scar -",!!!!!?8,"2. Circulation -",!!!!!?8,"3. Skin -",!!!!!?8,"4. Muscles -",!!!!!?8,"5. Joint -",!!!!!
 W ?8,"6. Bone -",!!!!!?8,"7. Length of stump (see Attachment A) -",!!!!! D:'$D(CMBN) HD2 W ?8,"8. Describe any limited motion or instability in",!?11,"the joint above the amputation site -",!!!!!!!!!!
 D:$D(CMBN) HD2 W $S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clinical test results:",!!!!!!!!!!,$S($D(CMBN):"C. ",1:"F. "),"Diagnosis:",!!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
ATTACH ;attachment A
 S DVBAX="Attachment A" W @IOF,!?(IOM-$L(DVBAX)\2),DVBAX,!?(IOM-$L(HD7)\2),HD8,!!!
 W "Length of stump",!!
 W " 1. The thigh.  The stump of an amputated thigh will be measured from the",!,"perineum, at the origin of the adductor tendons, to the bony end of the stump,",!,"with the claimant recumbent and the stump lying parallel with the other",!
 W "lower limb.  It is to be kept in mind that if the limb is abducted,",!,"flexed, rotated or adducted, its length will be altered.  The effective length",!,"of a thigh stump is governed by its inside dimension.  Measure length of",!
 W "normal thigh if present and indicate whether amputation is in upper,",!,"middle, or lower third.  When amputation is bilateral, estimate the same",!,"for a person of similar height.",!! D ^DVBCAMC1
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for ",HD7,!,"for ",NAME,!!!
 Q
 ;
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
