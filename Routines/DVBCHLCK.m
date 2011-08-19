DVBCHLCK ;ALB/GTS-557/THM-HEMATOLOGIC DISORDERS-LYMPHATIC ; 2/6/91  7:53 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs",HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 0810 Worksheet" S HD7="HEMATOLOGIC DISORDERS-LYMPHATIC",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!!!,"Narrative:"
 W ?13,"As with other disorders, a careful history and complete",!?13,"physical examination are of first importance in hematologic",!?13,"disorders.  However, laboratory evaluation is often necessary",!?13,"for a definitive diagnosis.",!!!
 I '$D(CMBN) W "A. Medical history:",!!!!!!!!!!,"B. Subjective complaints:",!!!!!!!!!!,"C. Objective findings:",! D HD2
 W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!
 W ?8,"1. State whether the disease is currently active or in remission and",!?11,"if in remission, whether maintenance chemotherapy is required -",!!!!!?8,"2. Describe frequency and duration of acute attacks -",!!!!!
 W ?8,"3. Describe the state of general health between acute attacks -",!!!!!?8,"4. If the veteran is, or has been receiving chemotherapy, X-Ray or",!?11,"surgical treatment for Hodgkin's disease or other form of lymphoma,",!
 W ?11,"give date of last treatment -",!!!!!?8,"5. If veteran has been treated for any tuberculous adenitis (or",!
 W ?11,"adenitis due to any other mycobacterial infection) and the disease",!?11,"is currently inactive, give date the inactivity was first shown -",!!!!!
 D:$D(CMBN) HD2 W $S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clinical test results:",!!!!!!!!!! D:$Y>50 HD2 W $S($D(CMBN):"C. ",1:"F. "),"Diagnosis:",!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for "_HD7,!,"for ",NAME,!!!
 Q
 ;
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
