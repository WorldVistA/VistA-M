SROAPCA0 ;B'HAM ISC/MAM - PRINT CARDIAC ASSESSMENT ; 18 MAR 1992 2:00 pm
 ;;3.0; Surgery ;;24 Jun 93
PAGE I $E(IOST)'="P" W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 W @IOF,!,VADM(1)_" ("_VA("PID")_")",! F MOE=1:1:80 W "-"
 Q
