SOWKPNTF ;B'HAM ISC/SAB-PATIENT STATUS REPORT ; 25 Feb 93 / 9:20 AM [ 09/22/94  1:46 PM ]
 ;;3.0; Social Work ;**34**;27 Apr 93
 W !!,"WARNING !!!",!?5,"This report is formatted for 132 columns and will be",!?5,"difficult to read if printed to the screen.",!
 K SOWKION,^TMP($J),%ZIS,IOP,IO("Q"),ZTSK S SOWKION=ION,%ZIS="QM",%ZIS("B")="" D ^%ZIS I POP S IOP=SOWKION D ^%ZIS K IOP,SOWKION G CLOSE
 K SOWKION I $D(IO("Q")) S ZTDESC="PATIENT STATUS REPORT",ZTRTN="ENQ^SOWKPNTF"
 I  K IO("Q") D ^%ZTLOAD W:$D(ZTSK) !!,"Task Queued to Print",! K ZTSK G CLOSE Q
ENQ S SWPG=0,Y=DT X ^DD("DD") S SWDATE=Y
 ;BUILD UTL
BUILD F DFN=0:0 S DFN=$O(^SOWK(650,"P",DFN)) Q:'DFN  F M=0:0 S M=$O(^SOWK(650,"P",DFN,M)) Q:'M  S ^TMP($J,"SWP",$P(^DPT(DFN,0),"^"),M)=DFN
GET S NAM="" F N=0:0 S NAM=$O(^TMP($J,"SWP",NAM)) G:NAM="" CLOSE F M=0:0 S M=$O(^TMP($J,"SWP",NAM,M)) Q:'M  S N=$P(^TMP($J,"SWP",NAM,M),"^"),SWREC=^SOWK(650,M,0) D:'SWPG HDR D:($Y+7>IOSL) CHK Q:$G(OUT)=1  S DFN=N D PID^VADPT6,OUT K SWN,SWU
 Q
OUT W !,$E($P(^DPT(N,0),"^"),1,$F($P(^DPT(N,0),"^"),",")),?21,VA("BID"),?27,$S($P(SWREC,"^",13):$P(^SOWK(651,$P(SWREC,"^",13),0),"^",4),1:"N/A")
 W ?38,$E($P(SWREC,"^",2),4,5)_"/"_$E($P(SWREC,"^",2),6,7)_"/"_$E($P(SWREC,"^",2),2,3)
 I $P(SWREC,"^",18) W ?50,$E($P(SWREC,"^",18),4,5)_"/"_$E($P(SWREC,"^",18),6,7)_"/"_$E($P(SWREC,"^",18),2,3)
 I $O(^SOWK(650,M,2,0)) S C=0 F I=0:0 S C=C+1,I=$O(^SOWK(650,M,2,I)) Q:'I!(C>8)  W ?62,$P(^SOWK(650,M,2,I,0),"^")_","
 I $O(^SOWK(650,M,2,0)) S C=0 F I=0:0 S C=C+1,I=$O(^SOWK(650,M,2,I)) Q:'I!(C>8)  W ?85,$P(^SOWK(650,M,2,I,0),"^",2)
 I $O(^SOWK(650,M,1,0)) S C=0,SWU="" F I=0:0 S C=C+1,I=$O(^SOWK(650,M,1,I)) Q:'I!(C>4)  I $P(^SOWK(650,M,1,I,0),"^",3) S SWU=SWU_$P(^(0),"^")_","
 I $O(^SOWK(650,M,1,0)) S C=0,SWN="" F I=0:0 S C=C+1,I=$O(^SOWK(650,M,1,I)) Q:'I!(C>4)  I '$P(^SOWK(650,M,1,I,0),"^",3) S SWN=SWN_$P(^(0),"^")_","
 W ?95,$G(SWU),?110,$G(SWN)
 W ?126,$J($P(^VA(200,$P(SWREC,"^",3),654),"^",3),3,0)
 Q
HDR W:$Y&(SWPG=0) @IOF S SWPG=SWPG+1
 U IO W !,"PATIENT STATUS REPORT",?80,SWDATE,?123,"PAGE",?128,SWPG,!?38,"OPEN",?50,"CLOSE",?97,"RESOURCES/REFERRALS",!?1,"PATIENT",?21,"ID#",?29,"CDC",?38,"DATE",?50,"DATE",?62,"PROBLEMS",?85,"OUTCOME"
 W ?95,"USED",?110,"NEEDED",?124,"WORKER" W ! F I=1:1:130 W "_"
 W ! Q
CLOSE W ! W:$E(IOST)'["C" @IOF D ^%ZISC
 K C,Y,X,I,DFN,SWPG,SWDATE,N,M,NAM,^TMP($J),SWREC D KVA^VADPT D:$D(ZTSK) KILL^%ZTLOAD
 Q
CHK ;
 N SWXX
 I $E(IOST)["C" R !,"Press <RETURN> to continue: ",SWXX:DTIME I SWXX["^" S OUT=1
 W @IOF
 D:$G(OUT)'=1 HDR
 Q
