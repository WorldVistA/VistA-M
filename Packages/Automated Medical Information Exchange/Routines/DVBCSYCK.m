DVBCSYCK ;ALB/GTS-557/THM-SYSTEMIC CONDITIONS ; 12/28/90  10:08 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs",HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 1805 Worksheet" S HD7="SYSTEMIC CONDITIONS",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !!,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!!!,"Narrative:"
 W ?13,"Many systemic conditions have stormy acute phases during",!?13,"onset and recurrences but leave little or no residual",!?13,"disability after they are cured or arrested.  Others have slow",!?13,"progression with disabling "
 W "residuals, after relatively mild",!?13,"or transient earlier phases.  The examiner must search for and",!?13,"describe the residual disabilities upon which adjudication",!?13,"of the claim can be determined.",!!!
 I '$D(CMBN) W "A. Medical history:",!!!!!!!!!!,"B. Subjective complaints:",!!!!!!!!!!,"C. Objective findings:",! D HD2
 W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!
 W ?8,"1. Renal impairment -",!!!?8,"2. Mental changes -",!!!?8,"3. Anemia -",!!!?8,"4. Neurological -",!!!?8,"5. Musculoskeletal -",!!!?8,"6. Skin -",!!!?8,"7. Cardiac -",!!!!!
 D:$D(CMBN) HD2 W $S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clinical test results:",!!!!!!!!!
 W $S($D(CMBN):"C. ",1:"F. "),"Diagnosis (if malaria, tuberculosis, or other mycobacterial",!,?14,"disease, specify organism):"
 W !!!!!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for ",HD7,!,"for ",NAME,!!!
 Q
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
