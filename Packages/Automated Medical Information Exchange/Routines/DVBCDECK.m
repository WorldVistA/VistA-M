DVBCDECK ;ALB/GTS-557/THM-DIGESTIVE, NOT ELSEWHERE CLASSIFIED ; 6/6/90  8:18 AM
 ;;2.7;AMIE;;Apr 10, 1995
EN S DVBAX="For DIGESTIVE, NOT ELSEWHERE CLASSIFIED"
 S PG=1 D:'$D(IOF) SETIOF W:(IOST?1"C-".E) @IOF
 W !?22,"Compensation and Pension Examination",!?33,"# 0310 Worksheet",!,?(IOM-$L(DVBAX)\2),DVBAX,!!
 W "Name: ",NAME,?45,"SSN: ",SSN,!,?45,"C-number: ",CNUM,!,"Date of exam: ____________________",!!,"Place of exam: ___________________",!!,"Type of Exam: DIGESTIVE, NOT ELSEWHERE CLASSIFIED",!!
 W "Physician's Guide Reference:  None",!!,"Narrative:",!!
 F I=0:1 S LY=$T(TXT+I) D:LY["TOF" HD2 Q:LY["END"  W:LY'["TOF" $P(LY,";;",2),! I $Y>55 D HD2
 K I,LY,DVBAX Q
 ;
TXT ;;This exam is to handle the balance of currently recognized digestive
 ;;disorders and to allow for new disorders not yet classified for V.A.
 ;;compensation evaluations.  The severity of a condition is based upon the
 ;;residual disability.  If there is a disease process that affects multiple
 ;;systems or extremeties, please evaluate each separately.
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
 ;;TOF
 ;;
 ;;
 ;;D. Evaluation Information for the Rating Board:
 ;;
 ;;
 ;;  Residual disability effect on:
 ;;
 ;;
 ;;    1) earning capacity/job performance (F/T):
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;    2)  everyday activities (F/T):
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;    3)  Is disability constant? (YES/NO):
 ;;          
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;    4)  If NO, give frequency, length of remissions (F/T):
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;
 ;;    5)  Acute exacerbations effect on everyday life. (F/T)
 ;;TOF
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
 ;;                         Signature: ______________________________
 ;;
 ;;                              Date: _________________________
 ;;END
 Q
 ;
HD2 S PG=PG+1 W @IOF,!,"Page: ",PG,!!,"Compensation and Pension Exam for "_NAME,!
 W "For DIGESTIVE, NOT ELSEWHERE CLASSIFIED",!!!
 Q
 ;
SETIOF ;  ** Set device control var's
 D HOME^%ZIS
 Q
