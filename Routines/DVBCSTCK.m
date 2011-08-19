DVBCSTCK ;ALB/GTS-557/THM-STOMACH EXAM ; 12/6/90  11:45 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs",HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 0325 Worksheet" S HD7="STOMACH (DIGESTIVE)",HD8="for "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",?14,HD7
 W !!!!,"Narrative:"
 W ?13,"The term ""peptic ulcer"" should not be used in examination",!?13,"reports.  Ulcer site should be localized as ""gastric"",",!
 W ?13,"""duodenal"", or ""marginal"" so as to conform to rating",!?13,"schedule terminology.",!!
 I '$D(CMBN) W "A. Medical history:",!!!!!!!!!!,"B. Subjective complaints:",!!!!!!!!!!,"C. Objective findings:",! D HD2
 W:$D(CMBN) !! W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!
 W ?8,"1. Current weight -",!!!!!!?8,"2. Maximum weight, past year -",!!!!!!?8,"3. Is the veteran anemic? -",!!!!!!
 W ?8,"4. Periodic vomiting -",!!!!!!?8,"5. Recurrent hematemesis or melena -",!!!!!! D:$D(CMBN) HD2 W ?8,"6. Area of pain -",!!!!!! D:'$D(CMBN) HD2
 W ?8,"7. Number of days of duration per episode -",!!!!!!?8,"8. Frequency of episodes per year -",!!!!!!
 W $S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clinical test results:",!!!!!!!!!!,$S($D(CMBN):"C. ",1:"F. "),"Diagnosis:",!!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for "_NAME,!
 W HD8,!!!
 Q
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
