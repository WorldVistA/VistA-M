DVBCTTCK ;ALB/GTS-557/THM-TESTES, TRAUMA, OR DISEASE ; 12/7/90  8:41 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs",HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 0625 Worksheet" S HD7="TESTIS, TRAUMA, OR DISEASE (GU)",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!!!,"Narrative:"
 W ?13,"Loss of use of a testis when based upon its small size or soft",!?13,"consistency must be described by a board of at least three",!?13,"physicians including at least one urologist.  The board of",!
 W ?13,"physicians should review the physician's guide for special",!?13,"instructions.",!!
 I '$D(CMBN) W "A. Medical history:",!!!!!!!!!!,"B. Subjective complaints:",!!!!!!!!!!,"C. Objective findings:",!
 D:'$D(CMBN) HD2 W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!
 W ?8,"1. Atrophy or absence of one or both testis -",!!!!!?8,"2. Measurements -",!!!!!?8,"3. Consistency -",!!!!!
 W ?8,"4. Comparison -",!!!!!,$S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clinical test results:",!!!!!!!!!!
 I $Y>50 D HD2
 W $S($D(CMBN):"C. ",1:"F. "),"Diagnosis:",!!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for "_NAME,!,HD8,!!!
 Q
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
