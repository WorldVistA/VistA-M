DVBCSKCK ;ALB/GTS-557/THM-SKIN, OTHER THAN SCARS ; 12/11/90  7:31 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs",HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 1610 Worksheet" S HD7="SKIN, OTHER THAN SCARS",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!!!,"Narrative:"
 W ?13,"When furnishing the history of the present skin disease",!?13,"include a description of the skin changes, when the disorder",!?13,"first appeared, and the progression of the illness since that",!?13,"time.  Note whether"
 W " remissions or exacerbations occurred",!?13,"and whether they were related to the occupation or treatment.",!?13,"Include the duration of remissions and factors that",!?13,"may have influenced the course of the disorder.",!!!
 I '$D(CMBN) W "A. Medical history:",!!!!!!!!!!,"B. Subjective complaints:  "
 I '$D(CMBN) W ?24,"(List the types of complaints such as itching",!,"burning, pain and anesthesia.  Note whether environmental factors such as",!,"temperature or seasonal change affect the severity of the symptoms.)",! D HD2
 I '$D(CMBN) W "C. Objective findings:",!!!!!!!!!!!!!
 W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!
 W ?8,"1. Description of skin disorder -",!!!!!?8,"2. Distribution of skin disorder -",!!!!!?8,"3. Configuration and characteristics of lesions -",!!!!!!?8,"4. Nervous manifestations -",!!
 W !!!?8,"5. Attach color photograph if condition is disfiguring.",!
 D HD2 W $S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clinical test results:",!!!!!!!!!!!!!!!!,$S($D(CMBN):"C. ",1:"F. "),"Diagnosis:",!!
 W "(Note:  If current diagnosis differs from the skin condition",!,"for which the examination was ordered, then review prior records and",!,"express opinion whether current disease is a new problem or original ",!,"diagnosis was in error.)"
 W !!!!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for ",HD7,!,"for ",!,NAME,!!!
 Q
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
