DVBCSMCK ;ALB/GTS-557/THM-SENSE OF SMELL ; 12/27/90  1:40 PM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs",HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 1320 Worksheet" S HD7="SENSE OF SMELL",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!!!,"Narrative:"
 W ?13,"Report whether loss is partial or complete and whether it",!?13,"is on an organic or psychiatric basis.  If a psychiatric",!?13,"basis is suspected, a special psychiatric examination should",!?13,"be ordered.",!!!
 I '$D(CMBN) W "A. Medical history:",!!!!!!!!!!,"B. Subjective complaints:",!!!!!!!!!!,"C. Objective findings:",! D HD2
 W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!
 W ?4,"Substances used for testing olfaction and results (each side of nose",!?8,"should be tested separately):"
 W !!?8,"1. Coffee -",!!!?8,"2. Benzaldehyde -",!!!?8,"3. Tar -",!!!
 W ?8,"4. Oil of lemon -",!!!?8,"5. Other (state substance) -",!!!
 W $S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clinical test results:",!!!!!!!!!! D:$Y>50 HD2 W $S($D(CMBN):"C. ",1:"F. "),"Diagnosis:",!!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for ",HD7,!,"for ",NAME,!!!
 Q
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
