OR1 ; slc/dcm - OE/RR
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
ADD ;Old 2.5 entry point for adding orders
 S OREND=1 Q:$D(ZTQUEUED)  Q:$D(DGQUIET)
 W !!,"This path is currently disabled.",!,"Please select items from a menu." D READ^ORUTL
AFT ;Old 2.5 exit point for adding orders
 Q
