DVBCXSCK ;ALB/GTS-557/THM-DISEASES/INJURIES OF THE SPINAL CORD ; 12/27/90  1:26 PM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs",HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 1215 Worksheet" S HD7="DISEASES/INJURIES OF THE SPINAL CORD",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!!!,"Narrative:  None",!!
 W !! I '$D(CMBN) W "A. Medical history:",!!!!!!!!!!,"B. Subjective complaints:",!!!!!!!!!!,"C. Objective findings:" D HD2
 W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!
 W ?5,"1.  State whether a tumor is present.  If so, note type and whether",!?9,"malignant -",!!!!!!!!
 W ?5,"2.  If a malignancy is present but is now cured or in remission,",!?9,"report the date of last surgery, radiation therapy, chemotherapy",!?9,"or other treatment -",!!!!!!!!
 W ?5,"3.  Identify the level of the lesion -",!!!!!!!!
 D:$D(CMBN) HD2 W ?5,"4.  State if the impairment is total or partial -",!!!!!!!!
 W ?5,"5.  State if the veteran is incontinent of bladder and/or bowels -",!!!!!!!! D:'$D(CMBN) HD2 W ?5,"6.  If the lesion is partial, describe the impairment of function at",!?9,"the level of each affected radicular group -",!!!!!!!!!
 W $S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clinical test results:",!!!!!!! W:$D(CMBN) !!!!! W:'$D(CMBN) !!!!!!!!!! ;D:$D(CMBN) HD2
 W $S($D(CMBN):"C. ",1:"F. "),"Diagnosis:",!!!!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for ",HD7,!,"for ",NAME,!!!
 Q
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
