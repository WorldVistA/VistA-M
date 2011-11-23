DVBCMDCK ;ALB/GTS-557/THM-MISCELLANEOUS NEUROLOGICAL DISORDERS EXAM ; 12/10/90  8:36 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs",HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 1225 Worksheet" S HD7="MISCELLANEOUS NEUROLOGICAL DISORDERS",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!!!,"Narrative:"
 S LX="TXT" F I=1:1 S LY=$T(@LX+I) Q:LY["END"  W ?13,$P(LY,";;",2),!
 W !! I '$D(CMBN) W "A. Medical history:",!!!!!!!!!!,"B. Subjective complaints:",!!!!!!!!!!,"C. Objective findings:" D HD2
 W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!
 S LX="TXT1" F I=1:1 S LY=$T(@LX+I) Q:LY["END"  W $P(LY,";;",2),!
 W !!!!!!! S LX="TXT2" F I=1:1 S LY=$T(@LX+I) Q:LY["END"  W $P(LY,";;",2),!
 W !!!!!!!!!!!! D:$D(CMBN) HD2 S LX="TXT3" F I=1:1 S LY=$T(@LX+I) Q:LY["END"  W $P(LY,";;",2),!
 W !!!!!!!!!!!! D:'$D(CMBN) HD2 W $S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clinical test results:",!!!!!!!!!!!!!!
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
 ;;If the diagnosis is NOT established or is questioned at some later
 ;;date, schedule necessary special studies, including admission
 ;;for a period of examination and observation, as appropriate to
 ;;provide a definitive diagnosis.
 ;;END
 ;
TXT1 ;
 ;;   1.  Migraine:  Obtain the best possible history of frequency and duration
 ;;   of attacks and description of level of activity the veteran can maintain
 ;;   during the attacks.  For example, state if the attacks are prostrating in
 ;;   nature or if ordinary activity is possible -
 ;;END
TXT2 ;
 ;;   2.  Tics and paramyoclonus complex:  Ascertain the muscle group(s)
 ;;   involved and obtain the best possible history of frequency and severity
 ;;   of attacks -
 ;;END
TXT3 ;
 ;;   3.  Chorea, choreiform disorders, etc:  Describe manifestations by
 ;;   impairment of strength, coordination, tremor, etc., with particular
 ;;   attention to the effects of the performance of ordinary activities
 ;;   of daily living -
 ;;END
