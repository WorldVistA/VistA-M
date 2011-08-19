YSEMSG ;SLC/AFE-ERROR MESSAGES ;8/3/89  14:49 ;
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
MSG1 ; Called by routine YSPPJ
 W !!,"  YOU SHOULD SELECT ONE OF THE FOLLOWING OR (^) TO EXIT:"
 W !,"    Select section numbers (1) thru (10) corresponding to the "
 W !,"        'PATIENT PROFILE' section items listed above."
 W !,"    Select (P) for section number selection process, e.g. 1,3,5,7."
 W !,"    Select (Q) for a single section 'PATIENT STATUS' or 'Quick Look'.",! H 5
 Q
 ;
MSG2 ; Called by routine YSPROBR
 W !!,"  NO PROBLEM LIST ENTRIES EXIST FOR:  ",YSNM
 W !!,"   ",! H 5
 Q
 ;
MSG3 ; Called by routine YSPROBR
 W !!,"  FOR PROBLEM NUMBER:  ",YSNP
 W !,"    NO STATUS RECORDS EXIST",! H 5
 Q
MSG4 ; Called by routine YSPROBR
 W !!,"  FOR PROBLEM NUMBER:  ",YSNP
 W !,"    STATUS RECORD NUMBER:  ",YSLP
 W !,"      DOES NOT EXIST",! H 5
 Q
