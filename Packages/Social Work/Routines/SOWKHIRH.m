SOWKHIRH ;B'HAM ISC/SAB-Routine to print patients by RCH, all homes or a single home  ; 17 Mar 94 / 9:45 AM
 ;;3.0; Social Work ;**27**;27 Apr 93
 K ^TMP($J),ZTSK
ASK W !!,"1. ALL HOMES",!,"2. A SINGLE HOME ?",!! R "ENTER 1 or 2  1// ",SWA:DTIME,! S:SWA="" SWA=1 G:"^"[$E(SWA)!('$T) CLO I "12"'[$E(SWA) D HP G ASK
 I SWA=1 G LP Q
SEA W ! S DIC="^SOWK(652,",DIC(0)="AQEM",DIC("A")="ENTER RCH: " D ^DIC G:"^"[X CLO G SEA:Y<0 S DA=+Y,A=^SOWK(652,DA,0) K DIC D DEV I $D(ZTSK)!($D(OUT))!(POP) K ZTSK G CLO
ENQ U IO W:$Y @IOF W !?25,"RESIDENTIAL CARE HOME REPORT" D SW
CLO W ! W:$E(IOST)'["C" @IOF D ^%ZISC K SWXX,SWX,H,^TMP($J),B,DA,I,POP,S,STA,SWA,SWN,SWW,X,Y,A,C,G,DA,DIC,HM,WRK,J,OUT D:$D(ZTSK) KILL^%ZTLOAD
 Q
LP D DEV I $D(ZTSK)!($D(OUT))!(POP) K ZTSK G CLO
ENQ1 U IO W:$Y @IOF W !?25,"RESIDENTIAL CARE HOME REPORT" S HM="" F B=0:0 S HM=$O(^SOWK(652,"B",HM)) Q:HM=""  F DA=0:0 S DA=$O(^SOWK(652,"B",HM,DA)) Q:'DA  S A=^SOWK(652,DA,0) D SW I $G(SWXX) Q
 G CLO Q
PRI S I="" F J=0:0 S I=$O(^TMP($J,I)) Q:I=""  S H=^TMP($J,I) D PR1 I $G(SWXX) Q
 Q
DEV K OUT,%ZIS,IOP,ZTSK S SOWKION=ION,%ZIS="QM" D ^%ZIS K %ZIS I POP S IOP=SOWKION D ^%ZIS K IOP,SOWKION S POP=1 Q
 K SOWKION I $D(IO("Q")) S ZTDESC="RESIDENTIAL CARE HOME REPORT",ZTRTN=$S(SWA=2:"ENQ^SOWKHIRH",1:"ENQ1^SOWKHIRH") F G="DA","A" S:$D(@G) ZTSAVE(G)=""
 I  K IO("Q") D ^%ZTLOAD I '$D(ZTSK) S OUT=1 K G,SWA,DIC,B,A,DA Q
 I $D(ZTSK) W !!,"Task Queued to Print",! W:$E(IOST)'["C" @IOF D ^%ZISC K G,SWA,DIC,B,A,DA
 Q
SW S SWN=$P(A,"^"),SWW=$P(^VA(200,$P(A,"^",4),0),"^"),STA=$P(^DIC(5,$P(A,"^",7),0),"^") I $G(SWXX) Q
 U IO I $E(IOST)["C",$Y+5>IOSL R !!,"PRESS RETURN TO CONTINUE or '^' TO EXIT: ",SWX:DTIME I SWX["^"!'$T S SWXX=1 Q
 U IO W:$Y+5>IOSL @IOF W !!!!,"SOCIAL WORKER: ",SWW,!,"HOME: ",SWN,!,"ADDRESS: ",$P(A,"^",5) W:$P(A,"^",14)]"" !,"ADDRESS 2: "_$P(A,"^",14)
 W !,$P(A,"^",6)_", "_STA_" "_$P(A,"^",8),?$X+5,"PHONE: "_$P(A,"^",9),!!!
 F S=0:0 S S=$O(^SOWK(655,S)) Q:'S  I $P(^SOWK(655,S,0),"^",2) F C=0:0 S C=$O(^SOWK(655,S,4,C)) Q:'C  D
 .I $P(^SOWK(655,S,4,C,0),"^")=DA,$P(^(0),"^",5),$P(^(0),"^",3)'=1,'$P(^(0),"^",6) S WRK=$P(^SOWK(650,$P(^SOWK(655,S,4,C,0),"^",5),0),"^",3),DFN=S D PID^VADPT6,SETUP
 D PRI K ^TMP($J) I $G(SWXX) Q
 Q
SETUP S ^TMP($J,$P(^DPT(S,0),"^"))=$P(^DPT(S,0),"^")_"^"_VA("PID")_"^"_$P(^VA(200,WRK,0),"^")
 Q
HP W !!,"Enter the number one (1) if all homes are to print, else enter the number",!,"two (2) for an individual home.",! Q
PR1 U IO I $E(IOST)["C",$Y+5>IOSL R !!,"PRESS RETURN TO CONTINUE or '^' TO EXIT: ",SWX:DTIME I SWX["^"!'$T S SWXX=1 Q
 W:$Y+5>IOSL @IOF W !,$P(H,"^"),?30,$P(H,"^",2),?45,$P(H,"^",3)
 Q
