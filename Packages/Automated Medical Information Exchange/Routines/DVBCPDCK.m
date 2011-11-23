DVBCPDCK ;ALB/GTS-557/THM-PULMONARY TB/OTHER MYCOBACTERIAL DISEASES ; 6/27/91  12:48 PM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs",HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 1515 Worksheet" S HD7="PULMONARY TUBERCULOSIS AND MYCOBACTERIAL DISEASES",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!!!,"Narrative:"
 W ?13,"Is pulmonary tuberculosis or other mycobacterial disease",!?13,"active?  If so, identify the organism.  In reactivated",!?13,"cases, it is necessary to know whether this is reactivation",!
 W ?13,"of the old disease or a separate and distinct new infection.",!!!
 I '$D(CMBN) W "A. Medical history:",!!!!!!!!!!,"B. Subjective complaints:",!!!!!!!!!!,"C. Objective findings:",! D HD2
 W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!
 W ?4,"1. IN ALL CASES:",!!?8,"a. Date of inactivity -",!!!!!?8,"b. Extent of structural damage to lungs -",!!!!!!?8,"c. Provide pulmonary function studies -",!!!!!?4,"2. In PENSION CASES ONLY:",!!!
 W ?8,"a. Disease condition after six months of treatment -",!!!!!?8,"b. Disease condition after twelve months of treatment -",!!!!!
 D:$D(CMBN) HD2 W "  Additional note to the physician:",!!!,"In all claims, if the disease is inactive and if the inactivity was confirmed",!
 W "at a non-VA facility, obtain the name and mailing address of the facility",!,"from the veteran so that the "
 W "Regional Office may request the report.",!
 D:'$D(CMBN) HD2 W $S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clinical test results:",!!!!!!!!!!!! W $S($D(CMBN):"C. ",1:"F. "),"Diagnosis:",!!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for ",!,HD7,!!,"for "_NAME,!!!
 Q
 ;
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
