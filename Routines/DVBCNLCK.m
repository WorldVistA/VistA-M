DVBCNLCK ;ALB/GTS-557/THM-NOT ELSEWHERE CLASSIFIED EXAM ; 11/9/90  1:16 PM
 ;;2.7;AMIE;;Apr 10, 1995
 ;Note:  This is a generic exam format for the
 ;       'Not Elsewhere Classified' exams.
 ;
XX S MX="EXM" F I=1:1 S MY=$T(@MX+I) Q:MY["$END"!(MY="")  S TNAM=$P(TNAM,"(NEC)",1) S X=$L(TNAM) S:$E(TNAM,X,X)=" " TNAM=$E(TNAM,1,X-1) Q:MY[TNAM
 Q:MY=""  S MY=$P(MY,";;",2),NARR=$P(MY,U,2),PREF=$P(MY,U,3),WKSNUM=$P(MY,U,4),DXCMT=$P(MY,U,5)
 S PG=1,HD91="Department of Veterans Affairs",HD9=$S($D(CMBN):"Abbreviated",1:"Full")_" Exam Worksheet"
EN D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?25,HD91,!?22,"Compensation and Pension Examination",! W ?33,"# "_WKSNUM_" Worksheet" S HD7=TNAM_", NOT ELSEWHERE CLASSIFIED",HD8="For "_HD7 W !?(40-($L(HD9)\2)),HD9,!?(40-($L(HD8)\2)),HD8,!!
 W !,"Name: ",NAME,?45,"SSN: ",SSN,!?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: ",HD7
 W !!!!,"Narrative:"
 S LX="TXT" F I=1:1 S LY=$T(@LX+I) Q:LY["$END"  D:LY["{}" FMT W ?13,$P(LY,";;",2),!
 W !! I '$D(CMBN) W "A. Medical history:",!!!!!!!!!!,"B. Subjective complaints:",!!!!!!!!!!,"C. Objective findings:" D HD2
 W $S($D(CMBN):"A. ",1:"D. "),"Specific evaluation information required by the rating board",!?4,"(if the information requested is included elsewhere, do not",!?4,"repeat here):",!!!
 W ?5,"1)  How does the residual disability affect the earning capacity",!?9,"of the veteran in job performance?",!!!!!!?5,"2)  How does the residual disability affect normal everyday activities?",!!!!!!
 W ?5,"3)  If the disability has constant activity, are there",!?9,"any periods of remission during the year?",!!!!!!
 W ?5,"4)  If there are acute exacerbations, what effects are there on",!?9,"everyday life?",!!!!!!
 D:$D(CMBN) HD2 W $S($D(CMBN):"B. ",1:"E. "),"Diagnostic/clinical test results:" W:DXCMT]"" !!?5,DXCMT W !!!!!!!!!!!!!!
 D:'$D(CMBN) HD2 W $S($D(CMBN):"C. ",1:"F. "),"Diagnosis:",!!!!!!!!!!!!?25,"Signature: ______________________________",!!?30,"Date: _________________________",!
 K LN,LN1,LN2
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for",!,HD7,!!,"for ",NAME,!!!
 Q
 ;
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
 ;
TXT ;
 ;;This exam is to handle the balance of currently recognized
 ;;{} disorders and to allow for new disorders not yet
 ;;classified for V. A. compensation evaluations.  The severity
 ;;of a condition is based upon the residual disability.  If
 ;;there is a disease process that affects multiple systems or
 ;;extremeties, please evaluate each separately.
 ;;$END
 ;
FMT S LZ=$P(LY,"{}",1),LY=$P(LY,"{}",2),LY=LZ_NARR_LY
 Q
 ;
EXM ;;$EXAMS
 ;;MENTAL^mental^None^0905^(Including psychological testing if deemed necessary)
 ;;CARDIOVASCULAR^cardiovascular^None^0105
 ;;DIGESTIVE^digestive^None^0310
 ;;ENDOCRINE DISORDERS^endocrine^None^0415
 ;;GENITOURINARY^genitourinary^None^0610
 ;;GYNECOLOGICAL^gynecological^None^0710
 ;;NEPHROLOGICAL^nephrological^None^1115
 ;;NEUROLOGICAL^neurological^Chapter 13^1230
 ;;ORGANS OF SENSE^organs of sense^None^1320
 ;;MUSCULOSKELETAL^musculoskeletal^None^1455
 ;;PULMONARY^pulmonary^None^1515
 ;;SKIN^skin^None^1610
