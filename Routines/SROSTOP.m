SROSTOP ;B'HAM ISC/ADM - CHECK TASKMAN TO STOP TASK ; 1 DEC 1992 11:32 AM
 ;;3.0; Surgery ;;24 Jun 93
 S SRHALT=0 Q:'$D(^%ZIS(14.7))
 S ZTSTOP=0 I $$S^%ZTLOAD S (SRHALT,ZTSTOP)=1 W !!!,?10,"** Task Being Stopped at User's Request **",!!! K ZTREQ
 Q
