DGMTO ;ALB/CAW - AGREE TO PAY DEDUCTABLE PRINT ; 8/12/92
 ;;5.3;Registration;;Aug 13, 1993
 ;
EN I '$$RANGE(.DGYRAGO,.DGTODAY) G ENQ
 S %ZIS="PMQ" D ^%ZIS I POP G ENQ
 I '$D(IO("Q")) D START^DGMTO1 G ENQ
 S Y=$$QUE
ENQ D:'$D(ZTQUEUED) ^%ZISC
 K DGCAT,DGLINE,DGP,DGPAGE,DGSTOP,DGTODAY,DGYRAGO,DGX,VAERR Q
 ;
RANGE(DGYRAGO,DGTODAY) ; select date range
 ;  input: none
 ; output: DGYRAGO := begin date
 ;         DGTODAY := end date
 ; return: was selection made [ 1|yes   0|no]
DATE S (DGYRAGO,DGTODAY)=0
 S %DT="PAEX",%DT("A")="Select Beginning Date: "
 W ! D ^%DT K %DT G RANGEQ:Y'>0 S DGYRAGO=Y
 I DGYRAGO>(DT_.9999) W !,"   Future dates are not allowed.",*7 K DGBEG G DATE
 S %DT="PAEX",%DT("A")="Select    Ending Date: "
 D ^%DT K %DT G RANGEQ:Y'>0 S DGTODAY=Y_".2359"
 I DGTODAY>(DT_.9999) W !,"   Future dates are not allowed.",*7 K DGBEG G DATE
 I DGTODAY<DGYRAGO W !!,"Beginning Date must be prior to Ending Date" G DATE
RANGEQ Q DGTODAY
 ;
QUE() ; -- que job
 ; return: did job que [ 1|yes   0|no ]
 ;
 K ZTSK,IO("Q")
 S ZTDESC="Agreed to Pay Deductible Listing",ZTRTN="START^DGMTO1"
 F X="DGYRAGO","DGTODAY" S ZTSAVE(X)=""
 D ^%ZTLOAD W:$D(ZTSK) "   (Task: ",ZTSK,")"
 Q $D(ZTSK)
