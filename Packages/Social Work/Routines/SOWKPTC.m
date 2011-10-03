SOWKPTC ;B'HAM ISC/SAB,DLR-Routine to print RCH Patient Registry for all open cases ; 08 Apr 93 / 8:59 AM
 ;;3.0; Social Work ;;27 Apr 93
 K ^TMP($J)
 K %ZIS,IOP,ZTSK S SOWKION=ION,%ZIS="QM" D ^%ZIS K %ZIS I POP S IOP=SOWKION D ^%ZIS K IOP,SOWKION G CLO
 K SOWKION I $D(IO("Q")) S ZTDESC="RCH PATIENT REGISTRY FOR ALL OPEN CASES",ZTRTN=$S($G(COM):"ENQ^SOWKPTC",1:"SUM^SOWKPTC") S G="COM" S:$D(@G) ZTSAVE(G)=""
 I  K IO("Q") D ^%ZTLOAD W:$D(ZTSK) !!,"Task Queued to Print",! K ZTSK,G G CLO Q
 I '$G(COM) G SUM
ENQ U IO W:$Y @IOF W "RCH PATIENT REGISTRY",!,"COMPLETE: OPEN CASES",!
SEA F S=0:0 S S=$O(^SOWK(650,S)) Q:'S  S A=^SOWK(650,S,0) I $P(^SOWK(651,$P(A,"^",13),0),"^",6)["R",'$P(A,"^",18) S ^TMP($J,$P(^DPT($P(A,"^",8),0),"^"),$P(A,"^"))=$P(A,"^")
 D PRI
CLO W ! W:$E(IOST)'["C" @IOF D ^%ZISC K ^TMP($J),SWX,SWXX,A,I,IOP,POP,LP,LP1,MS,P,S,X,Y,J,Q,E,HM,PL,R,Z,COM D KVA^VADPT D:$D(ZTSK) KILL^%ZTLOAD Q
PRI S I="" F J=0:0 S I=$O(^TMP($J,I)) Q:I=""  D PR1 I $G(SWXX) Q
 Q
PR1 F E=0:0 S E=$O(^TMP($J,I,E)) Q:'E  S A=^SOWK(650,E,0),P=$P(A,"^",8) S DFN=P D PID^VADPT6 D @$S($G(COM):"OUT",1:"OUT1") I $G(SWXX) Q
 Q
OUT U IO F Z=0:0 S Z=$O(^SOWK(655,P,4,Z)) Q:'Z  I $P(^SOWK(655,P,4,Z,0),"^",5)=E S HM=$P(^(0),"^"),PL=$P(^(0),"^",2),R=Z
 I $E(IOST)["C",$Y+10>IOSL R !!,"PRESS RETURN TO CONTINUE or '^' TO EXIT: ",SWX:DTIME I SWX["^"!'$T S SWXX=1 Q
 W:$Y+10>IOSL @IOF W !!,"NAME: ",$E($P(^DPT(P,0),"^"),1,20),?$X+5,"HOME: "_$E($P(^SOWK(652,HM,0),"^"),1,20) S Y=PL X ^DD("DD") W "  PLACED: "_Y,!,"ID#: ",VA("PID"),!,"DOB: " S Y=$P(^DPT(P,0),"^",3) X ^DD("DD") W Y,?$X+5
 W "WORKER: "_$P(^VA(200,$P(A,"^",3),0),"^") S X=$P(A,"^",7),MS=$S(X="1":"MEDICAL/SURGICAL",X="2":"PSYCHOSIS",X="3":"ORGANIC & SENILE",X="4":"SUBSTANCE ABUSE",X="5":"ALL OTHER",1:"")
 W !,"MS: ",MS,?$X+5,"PRIOR LIVING: " S LP1=$P(^DD(650,10,0),"^",3),LP=$P(A,"^",11),LP=$P(LP1,";",LP) W $P(LP,":",2)
 W !,"LEVEL OF CARE: "_$S($P(A,"^",23)=1:"LIGHT",$P(A,"^",23)=2:"MODERATE",1:"HEAVY")
 W !,"RATE: " F Q=0:0 S Q=$O(^SOWK(655,P,4,R,1,Q)) Q:'Q  S Y=$P(^SOWK(655,P,4,R,1,Q,0),"^",2) X ^DD("DD") W $P(^SOWK(655,P,4,R,1,Q,0),"^"),?$X+5,"DATE: "_Y,!,?$X+6
 Q
SUM U IO W:$Y @IOF W "RCH PATIENT REGISTRY",!,"SUMMARY: OPEN CASES",!!!!!
 W "PATIENT NAME",?20,"ID#",?37,"HOME NAME",?59,"SOCIAL WORKER",!
 D SEA
 Q
OUT1 U IO F Z=0:0 S Z=$O(^SOWK(655,P,4,Z)) Q:'Z  I $P(^SOWK(655,P,4,Z,0),"^",5)=E S HM=$P(^(0),"^")
 I $E(IOST)["C",$Y+5>IOSL R !!,"PRESS RETURN TO CONTINUE or '^' TO EXIT: ",SWX:DTIME I SWX["^"!'$T S SWXX=1 Q
 W:$Y+5>IOSL @IOF W !,$E($P(^DPT(P,0),"^"),1,15),?20,VA("PID"),?37,$E($P(^SOWK(652,HM,0),"^"),1,20),?59,$P(^VA(200,$P(A,"^",3),0),"^")
 Q
