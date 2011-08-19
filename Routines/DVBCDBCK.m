DVBCDBCK ;ALB/GTS-557/THM-DISEASES/INJURIES OF THE BRAIN ; 12/28/90  9:26 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs"
 S HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 1210 Worksheet" S HD7="DISEASES/INJURIES OF THE BRAIN",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!!!,"Narrative:"
 S LX="TXT" F I=1:1 S LY=$T(@LX+I) Q:LY["END"  W ?13,$P(LY,";;",2),!
 W !! I '$D(CMBN) W "A. Medical history:",!!!!!!!!!!,"B. Subjective complaints:",!!!!!!!!!!,"C. Objective findings:" D HD2
 W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!
 W ?5,"1.  State if a tumor is present.  If so, note type and whether ",!?9,"malignant -",!!!!!!!!
 W ?5,"2.  If a malignancy is present but is now cured or in remission,",!?9,"report the date of last surgery, radiation therapy, chemotherapy",!?9,"or other treatment -",!!!!!!!!
 W ?5,"3.  Describe in detail the motor and sensory impairment of the affected",!?9,"cranial nerves -",!!!!!!!!
 D:$D(CMBN) HD2 W ?5,"4.  Describe in detail any functional impairment of the peripheral",!?9,"and autonomic systems -",!!!!!!!!
 D:'$D(CMBN) HD2 W ?5,"5.  Describe any psychiatric manifestations in detail -",!!!!!!?5,"6.  "
 S LX="TXT1" F I=1:1 S LY=$T(@LX+I) Q:LY["END"  W:$X'=5 ?5,$P(LY,";;",2),!
 W !!!!!!!!!,$S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clinical test results:",!!!!!!!!!!!!!! D:$D(CMBN) HD2
 W $S($D(CMBN):"C. ",1:"F. "),"Diagnosis:",!!!!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for ",HD7,!,"for ",NAME,!!!
 Q
 ;
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
 ;
TXT ;
 ;;Since disorders of the brain are likely to produce psychiatric
 ;;manifestations as well as neurological, special psychiatric
 ;;examinations will often be necessary.  If special senses are
 ;;impaired, the examiner should order additional testing as
 ;;appropriate.
 ;;END
TXT1 ;
 ;;State if the veteran is capable of managing his/her benefit payments
 ;;    in the individual's own best interest without restriction (a physical
 ;;    disability which prevents the veteran from attending to financial
 ;;    matters in person is not a proper basis for a finding of incompetency
 ;;    unless the veteran is, by reason of that disability, incapable of
 ;;    directing someone else in handling the individual's financial
 ;;    affairs) -
 ;;END
