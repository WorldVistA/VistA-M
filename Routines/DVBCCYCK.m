DVBCCYCK ;ALB/GTS-557/THM-CYSTITIS,BLADDER CALCULUS,ETC ; 2/6/91  7:59 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs"
 S HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 0605 Worksheet" S HD5="CYSTITIS, BLADDER CALCULUS, RESIDUALS OF BLADDER INJURY,",HD6="ALL DISORDERS OF THE PROSTATE, URETHRA AND SURGICAL RESIDUALS (GU)"
 S HD7="For "_HD5
 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD7)\2)),HD7,!?(40-($L(HD6)\2)),HD6,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,! I '$D(CMBN) W "Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD5,!?14,HD6
 W !!!!,"Narrative:"
 W ?13,"Complications and/or medical side effects should always be",!?13,"reported, even when not specifically requested.",!!
 I '$D(CMBN) W "A. Medical history:",!!!!!!!!!!,"B. Subjective complaints:",!!!!!!!!!!,"C. Objective findings:",!!!!!!!!!!! D HD2
 W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!
 W ?8,"1. Frequency of urination -",!!!!!?8,"2. Presence or absence of pyuria -",!!!!!
 W ?8,"3. Pain or tenesmus -",!!!!!?8,"4. Incontinence requiring pads or appliance -",!!!!!
 W $S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clinical test results:",!!!!!!!!!! D:$Y>50 HD2 W $S($D(CMBN):"C. ",1:"F. "),"Diagnosis:",!!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for "_NAME,!!,HD5,!,HD6,!!!
 Q
 ;
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
