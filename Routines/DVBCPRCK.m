DVBCPRCK ;ALB/GTS-557/THM-THE PERIPHERAL NERVES EXAM ; 12/27/90  1:32 PM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 S PG=1,HD91="Department of Veterans Affairs",HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# 1230 Worksheet" S HD7="THE PERIPHERAL NERVES",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!!!,"Narrative:  None",!!
 W !! I '$D(CMBN) W "A. Medical history:",!!!!!!!!!!,"B. Subjective complaints:",!!!!!!!!!!,"C. Objective findings:" D HD2
 W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!
 S LX="TXT1" F I=1:1 S LY=$T(@LX+I) Q:LY["END"  W $P(LY,";;",2),!
 D:$D(CMBN) HD2 S LX="TXT2" F I=1:1 S LY=$T(@LX+I) Q:LY["END"  W $P(LY,";;",2),!
 D:'$D(CMBN) HD2 W $S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clinical test results:",!!!!!!!!!!!!!!
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
TXT1 ;
 ;;   1.  Where disability is the result of brain disease or injury, spinal cord
 ;;       disease or injury, cervical disc disease, or trauma to the nerve roots
 ;;       themselves, report sensory and motor impairment by reference to the
 ;;       distribution of the affected groups as paralysis, neuritis or
 ;;       neuralgia.  Report each affected extremity separately -
 ;;
 ;;
 ;;       a.  In the upper extremities -
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;       b.  In the lower extremities -
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;END
TXT2 ;
 ;;   2.  Where disability is NOT from the above, identify the specific major
 ;;       nerve involved, localize the lesion and describe specific impairment
 ;;       of motor and sensory function, fine motor control, etc..  Again
 ;;       characterization as paralysis, neuritis or neuralgia is necessary
 ;;       Indicate whether any muscle wasting or atrophy represents direct
 ;;       effect of nerve damage or merely disuse.  Report each affected
 ;;       extremity separately -
 ;;
 ;;
 ;;       a.  In the upper extremities -
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;       b.  In the lower extremities -
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;END
