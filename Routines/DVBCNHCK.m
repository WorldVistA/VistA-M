DVBCNHCK ;ALB/GTS-557/THM-NEPHROLOGICAL EXAM ; 12/27/90  1:07 PM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs",HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 1110 Worksheet" S HD7="NEPHROLOGICAL",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam:  NEPHROLOGICAL"
 W !!!!,"Narrative:"
 W ?13,"Complications and/or medical side effects should always be",!?13,"reported, even when not specifically requested.",!!
 I '$D(CMBN) W "A. Medical history:",!!!!!!!!!!,"B. Subjective complaints:",!!!!!!!!!!,"C. Objective findings:",! D HD2
 W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!
 W !!?8,"1. Report presence or absence of calculi -",!!!!!?8,"2. If stone, presence and size if retained -",!!!!!?8,"3. Frequency of attacks of colic -",!!!!!?8,"4. Catheter drainage requirments, including frequency -",!!!!!
 W ?8,"5. Presence or absence of infection -",!!!!!?8,"6. Involvement of other kidney -",!!!!!
 D:$D(CMBN) HD2 W $S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clinical test results:",!!!!!!!!!! D:'$D(CMBN) HD2 W $S($D(CMBN):"C. ",1:"F. "),"Diagnosis:",!!!!!!!!!!
 W ?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for "_NAME,!,HD8,!!!
 Q
 ;
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
