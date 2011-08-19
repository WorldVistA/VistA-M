DVBCBRCK ;ALB/GTS-557/THM-TRACHEA AND BRONCHI ; 6/27/91  7:33 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs"
 S HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 1525 Worksheet" S HD7="TRACHEA AND BRONCHI",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!!!,"Narrative:"
 W ?13,"Identify the disease present, describe clinical findings",!?13,"and provide current chest X-Ray results if no recent",!?13,"studies are available.  Report pulmonary function studies"
 W !?13,"unless medically contraindicated.",!!!
 I '$D(CMBN) W "A. Medical history:",!!!!!!!!!!,"B. Subjective complaints:",!!!!!!!!!!,"C. Objective findings:",!! D HD2
 W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!
 W ?8,"1. Presence of cor pulmonale -",!!!!!
 W ?8,"2. If veteran is asthmatic, report frequency of attacks",!?11,"and baseline functional status between attacks -",!!!!!!
 W ?8,"3. Report any indications of cyanosis/clubbing of extremities -",!!!!!!?8,"4. Productive cough/sputum -",!!!!!!?8,"5. Dyspnea on exertion/slight exertion/at rest -",!!!!!
 W ?8,"6. Indicate whether infectious disease is present -",!!!!!!!
 D:$D(CMBN) HD2 W $S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clincal test results:",!!!!!!!!!! D:'$D(CMBN) HD2
 W $S($D(CMBN):"C. ",1:"F. "),"Diagnosis:",!!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for ",HD7,!,"for ",NAME,!!!
 Q
 ;
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
