DVBCGOCK ;ALB/GTS-557/THM-OTHER GENITOURINARY EXAM ; 12/7/90  8:43 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs",HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 0625 Worksheet" S HD7="OTHER GENITOURINARY",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!!!,"Narrative:"
 W ?13,"In original claims, particularly pension cases, and in",!?13,"reopened claims in which the evidence on hand at the time",!?13,"the examination request is prepared does not establish the",!
 W ?13,"exact diagnosis, the nature of the disability will generally",!?13,"be expressed in the most general terms, usually in the veteran's",!?13,"own words (e.g. ""kidney condition"", ""bladder problem"",",!
 W ?13,"""can't hold water"", ""stones"", etc).  In such cases it is",!?13,"the responsibility of the general medical examiner to conduct",!?13,"or order to be conducted such special examinations as may be",!
 W ?13,"necessary, both to diagnose the underlying disorder, and",!?13,"to provide the information that the rating board must have to",!?13,"apply the examiner's findings to the rating schedule.  Once",!
 W ?13,"a definitive diagnosis is established, the examiner need only to",!?13,"report history, clinical findings, and laboratory tests for",!?13,"evaluation purposes.  Complications and/or medical side effects",!
 W ?13,"should always be reported, even when not specifically requested.",!!!!!!
 W "A. Medical History:  No medical history for this exam",!!!,"B. Subjective complaints:",! D HD2
 W "C. Objective findings:",!!!!!!!!!!!!!!!
 W "D. Diagnosis:",!!!!!!!!!!!!!!! D:$Y>50 HD2 W "E. Diagnostic/clinical test results:",!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for ",HD7,!,"for "_NAME,!!!
 Q
 ;
SETIOF ;  ** Set device control variables **
 D HOME^%ZIS
 Q
