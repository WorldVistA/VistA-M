DVBCRACK ;ALB/GTS-557/THM RECTAL/ANAL EXAM ; 12/6/90  11:43 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs",HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 0320 Worksheet" S HD7="RECTUM AND ANUS (DIGESTIVE)",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",?14,HD7
 W !!!!,"Narrative:"
 W ?13,"Diseases of the rectum, anal canal or perineum must be",!?13,"differentiated as to type.",!!
 I '$D(CMBN) W "A. Medical history:",!!!!!!!!!!,"B. Subjective complaints:",!!!!!!!!!!,"C. Objective findings:",! D HD2
 W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!
 W ?8,"1. Bleeding -",!!!!!!?8,"2. Soiling -",!!!!!!?8,"3. Incontinence/diarrhea -",!!!!!!
 W ?8,"4. Tenesmus -",!!!!!!?8,"5. Dehydration -",!!!!!!?8,"6. Malnutrition -",! D HD2
 W ?8,"7. Anemia -",!!!!!!?8,"8. Fecal leakage -",!!!!!!?8,"9. Frequency of episodes -",!!!!!!!!!!
 W $S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clinical test results:",!!!!!!!!!! D:$Y>50 HD2 W $S($D(CMBN):"C. ",1:"F. "),"Diagnosis:",!!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for "_NAME,!
 W HD8,!!!
 Q
 ;
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
