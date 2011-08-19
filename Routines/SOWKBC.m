SOWKBC ;DLR/B'HAM ISC - Correct incomplete cases ; 10-10-95 [ 07/29/96  1:45 PM ]
 ;;3.0; Social Work ;**39**;27 Apr 93
 W !!,"This report will identify any incomplete Social Work cases.",!
DEV K %ZIS,IOP,ZTSK S SOWKION=ION,%ZIS="QM",%ZIS("B")="" D ^%ZIS K %ZIS I POP S IOP=SOWKION D ^%ZIS K IOP,SOWKION G END
 K SOWKION I $D(IO("Q")) S ZTDESC="SOCIAL WORK CASE CORRECTION",ZTRTN="BEGIN^SOWKBC" K IO("Q") D ^%ZTLOAD W:$D(ZTSK) !!,"Task Queued to Print",! K ZTSK G END
BEGIN ;entry point to correct incomplete cases 
 N SOW,SW
 W:$Y @IOF,!," Searching for incomplete cases "
 S SW=0 F  S SW=$O(^SOWK(650,SW)) Q:'SW  W:$Y "." I $P(^SOWK(650,SW,0),U,13)="" S SOW(SW)=^(0)
 I '$D(SOW) U IO W !!,"There were no incomplete cases found in your Social Work Case file."
 I $D(SOW) D DISPLAY
END ;end of routine
 W:$E(IOST)'["C" @IOF D ^%ZISC
 Q
DISPLAY ;
 N HDR
 S HDR="Incomplete Case Information Report"
 W:$Y @IOF W ?((IOM-$L(HDR))/2),HDR,!!
 W !,"Case #",?15,"Social Work",?47,"CDC",! F X=1:1:75 W "-"
 S SW=0 F  S SW=$O(SOW(SW)) Q:'SW  U IO W !,SW,?15,$S($D(^VA(200,$P(SOW(SW),U,3),0)):$E($P(^VA(200,$P(SOW(SW),U,3),0),U),1,20),1:"UNKNOWN"),?47,$S($P(SOW(SW),U,13)'="":$P(^SOWK(651,$P(SOW(SW),U,13),0),U),1:"UNKNOWN")
 Q
KIDS ;entry point to correct incomplete cases 
 N SOW,SW
 W:$Y @IOF,!," Searching for incomplete cases "
 S SW=0 F  S SW=$O(^SOWK(650,SW)) Q:'SW  W:$Y "." I $P(^SOWK(650,SW,0),U,13)="" S SOW(SW)=^(0)
 I '$D(SOW) U IO W !!,"There were no incomplete cases found in your Social Work Case file."
 I $D(SOW) D DISPLAY2
 Q
DISPLAY2 ;
 N HDR,MSG
 D BMES^XPDUTL("Incomplete Case Information Report....")
 S SW=0 F  S SW=$O(SOW(SW)) Q:'SW  U IO S MSG="Case #"_SW_" for "_$S($D(^VA(200,$P(SOW(SW),U,3),0)):$E($P(^VA(200,$P(SOW(SW),U,3),0),U),1,20),1:"UNKNOWN")_" is incomplete." D MES^XPDUTL(MSG)
 Q
