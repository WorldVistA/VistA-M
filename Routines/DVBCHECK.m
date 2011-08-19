DVBCHECK ;ALB/GTS-557/THM-HEMATOLOGICAL, NOT ELSEWHERE CLASSIFIED ; 5/8/90  11:12 AM
 ;;2.7;AMIE;;Apr 10, 1995
EN S DVBAX="For HEMATOLOGICAL, NOT ELSEWHERE CLASSIFIED"
 S PG=1 D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?22,"Compensation and Pension Examination",!?33,"# 0810 Worksheet",!,?(IOM-$L(DVBAX)\2),DVBAX,!!
 W "Name: ",NAME,?45,"SSN: ",SSN,!,?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: HEMATOLOGICAL, NOT ELSEWHERE CLASSIFIED",!!
 W "Physician's Guide Reference:  None",!!,"Narrative:",!!
 F I=0:1 S LY=$T(TXT+I) Q:LY["END"  W $P(LY,";;",2),! I $Y>55 D HD2
 K I,LY,DVBAX Q
 ;
TXT ;;This exam is to handle the balance of currently recognized hematological
 ;;disorders and to allow for new disorders not yet classified for V.A.
 ;;compensation evaluations.  The severity of a condition is based upon the
 ;;residual disability.  If there is a disease process that affects multiple
 ;;systems or extremeties, please evaluate each separately.
 ;;
 ;;
 ;;
 ;;
 ;;A. Medical history (W/P):
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;B. Subjective findings (W/P):
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;C. Objective findings (W/P):
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;D. Evaluation information for the rating board:
 ;;
 ;;
 ;;    1)  State how the residual disability affects the earning capacity of the
 ;;        Veteran in job performance.
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;    2)  State how the residual disability affects normal everyday activities.
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;    3)  State if the disability has constant activity or give any periods
 ;;        of remission during the year.
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;    4)  If there are acute exacerbations, state the effect on everyday
 ;;        life.
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;E. Diagnosis (W/P):
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;F. Diagnostic tests (Lab,X-Ray, etc) (W/P):
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;                         Signature: ______________________________
 ;;
 ;;                              Date: _________________________
 ;;END
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for "_NAME,!
 W "For HEMATOLOGICAL, NOT ELSEWHERE CLASSIFIED",!!!
 Q
 ;
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
