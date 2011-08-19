DVBCDACK ;ALB/GTS-557/THM-DISEASES OF THE ARTERIES/VEINS ; 12/26/90  12:23 PM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs"
 S HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 0105 Worksheet" S HD7="DISEASES OF THE ARTERIES AND VEINS (CARDIOVASCULAR)",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",?14,HD7
 W !!!!,"Narrative:"
 W ?13,"Once a diagnosis is established, details about the",!?13,"permanent medical residuals and how they affect the",!
 W ?13,"veteran's industrial capabilities are very important as",!?13,"the degree of impairment is used by the rating board to",!
 W ?13,"determine the percentage of disability and payments therefore.",!!
 I '$D(CMBN) W "A. Medical history  (if a disability is already service connected, then",!?22,"provide data since last VA rating examination):",!!!!!!!!!!,"B. Subjective complaints:",!!!!!!!!!!,"C. Objective findings:",!!!!!!!!!!! D HD2
 W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!?8,"1. Blood pressure -",!!!!!!
 W ?8,"2. Pulsation -",!!!!!!?8,"3. Skin appearance -",!!!!!!
 W ?8,"4. Skin temperature (to the touch) -",!!!!!!?8,"5. Paresthesias -",!!!!!!
 W ?8,"6. Cardiac involvement -",!!!!!! D:$D(CMBN) HD2
 W $S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clinical test results:",!!!!!!!!! D:'$D(CMBN) HD2 W $S($D(CMBN):"C. ",1:"F. "),"Diagnosis:",!!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
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
