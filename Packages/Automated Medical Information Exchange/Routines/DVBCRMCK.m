DVBCRMCK ;ALB/GTS-557/THM-RESPIRATORY MANIF. DISEASES OTH SYS ; 6/27/91  7:31 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs",HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 1520 Worksheet" S HD7="RESPIRATORY MANIFESTATIONS OF DISEASES OF OTHER SYSTEMS",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!!!,"Narrative:"
 W ?13,"An example of this type of exam is extremely unfavorable",!?13,"ankylosis of the thoracic spine that so severely",!?13,"restricts chest excursion that the veteran is dyspneic",!
 W ?13,"on minimal exertion OR abdominal tumor interferes with",!?13,"excursion of the diaphragm to such an extent that chronic",!?13,"passive congestion of one lung results.",!!!
 I '$D(CMBN) W "A. Medical history:",!!!!!!!!!!,"B. Subjective complaints:",!!!!!!!!!!,"C. Objective findings :",! D HD2
 W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!
 W ?8,"1. Clinical findings -",!!!!!!!?8,"2. Pulmonary function studies -",!!!!!!!
 D:$D(CMBN) HD2 W $S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clinical test results:",!!!!!!!!!!,$S($D(CMBN):"C. ",1:"F. "),"Diagnosis:",!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for ",!,HD7,!!,"for ",NAME,!!!
 Q
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
