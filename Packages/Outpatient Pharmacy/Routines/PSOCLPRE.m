PSOCLPRE ;BHAM ISC/RTR-Environment check routine for Patch 15
 ;;7.0;OUTPATIENT PHARMACY;**15**;DEC 1997
 ;
 N X
 S X=$T(REF^ORMBLDPS) I $G(X)'["CLINIC" W !,"The latest version of Patch OR*3.0*38 must be installed first!",! S XPDQUIT=2
 Q
