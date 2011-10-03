MCPSOP ;WISC/DMA-PHARMACY PATIENT PROFILE (MEDICINE VERS) ;7/30/96  10:39
 ;;2.3;Medicine;;09/13/1996
 ;modified from pharmacy to quit after displaying for one pt.
 Q:'$D(MCRH)  ;quit if not entered from rheumatology module
DOIT S (FN,DFN,D0,DA)=+Y I '$D(^PS(55,+Y,"P")),'$D(^("ARC")) W !?20,*7,"NO PHARMACY INFORMATION" Q
 I '$O(^PS(55,+Y,"P",0)),$D(^PS(55,+Y,"ARC")) D ^PSODEM W !!,"PATIENT HAS ARCHIVED PRESCRIPTIONS",! Q
 S DIR("?")="Enter 'L' for a long profile or 'S' for a short profile",DIR("A")="LONG or SHORT: ",DIR(0)="SA^L:LONG;S:SHORT",DIR("B")="SHORT" D ^DIR G:$D(DUOUT)!$D(DIRUT) Q S PLS=Y K DIR
S S DIR(0)="SA^D:DATE;M:MEDICATION;C:CLASS",DIR("A")="Sort by DATE, CLASS or MEDICATION: ",DIR("B")=$S($P($G(PSOPAR),"^",14)=2:"MEDICATION",$P($G(PSOPAR),"^",14)=1:"CLASS",1:"DATE")
 S DIR("?",1)="Enter 'DATE', 'CLASS' or 'MEDICATION' to determine the order in which",DIR("?")="prescriptions will appear on the profile." D ^DIR G:$D(DUOUT)!$D(DIRUT) Q S PSRT=$S(Y="D":"DATE",Y="M":"DRUG",1:"CLSS") K DIR
 K DIR G:PSRT="DATE" DEV S DIR("A")="PROFILE EXP/CANCEL CUTOFF",DIR("B")=45,DIR(0)="N^1:9999:0",DIR("?",1)="Enter the number of days which will cut canceled and expired Rx's from",DIR("?")="the profile."
 D ^DIR G:$D(DTOUT)!($D(DUOUT)) Q K DIR S X1=DT,X2=-X D C^%DTC S PSODTCT=X
DEV K %ZIS,IOP,ZTSK S PSOION=ION,%ZIS="MQ" D ^%ZIS K %ZIS I POP S IOP=PSOION D ^%ZIS K IOP,PSOION G Q
 K PSOION I $D(IO("Q")) S ZTDESC="PATIENT MEDICATION PROFILE",ZTRTN="P^MCPSOP" F G="PSODTCT","FN","DFN","DA","D0","PLS","PSRT","PSOPAR" S:$D(@G) ZTSAVE(G)=""
 I  K IO("Q") D ^%ZTLOAD W:$D(ZTSK) !,"Task Queued to Print",! K Q,ZTSK D Q G Q
 D P,Q G Q
P K ^TMP($J) D LOOP Q:'$D(^TMP($J))  D ^PSODEM W:$O(^PS(55,DA,"ARC",0)) !!,"PATIENT HAS ARCHIVED PRESCRIPTIONS",!
 I $Y+8>IOSL,$E(IOST,1,2)="C-" W "ENTER '^' TO HALT:" R X:DTIME S:'$T X="^" G Q:X="^" W @IOF
 I $P($G(^PS(59.7,1,40.1)),"^") W !,"Outpatient prescriptions are cancelled 72 hours after admission",!
 I PLS="S" D ^PSOP1 G Q
 W ! S DRUG="" F II=0:0 S DRUG=$O(^TMP($J,DRUG)) Q:DRUG=""!($D(DTOUT))!($D(DUOUT))  F J=0:0 S J=$O(^TMP($J,DRUG,J)) Q:'J  D O I $Y+8>IOSL,$E(IOST,1,2)="C-" D DIR W @IOF Q:$D(DUOUT)!($D(DTOUT))
Q D ^%ZISC K RX3,^TMP($J),ST0,PSODTCT,ST,D0,DIC,DIR,DIRUT,DUOUT,G,II,K,RXD,RXF,ZX,DRUG,X,DFN,PHYS,PSRT,CT,AL,I1,PLS,REF,LMI,PI,FN,Y,I,J,RX,DRX,ST,RX0,RX2,DA S:$D(ZTQUEUED) ZTREQ="@" Q
O S RX0=^(J),RX2=$S($D(^PSRX(J,2)):^(2),1:""),RX3=$S($D(^PSRX(J,3)):^(3),1:""),DRX="NOT ON FILE"
 I $D(^PSDRUG(+$P(RX0,"^",6),0)) S DRX=$P(^(0),"^")
 I $Y+10>IOSL,$E(IOST,1,2)="C-" D DIR W @IOF Q:$D(DUOUT)!($D(DTOUT))
 W:$Y+10>IOSL&($E(IOST,1,2)'="C-") @IOF W !,"RX #: ",$P(RX0,"^"),!,DRX,?45,"SIG: ",$P(RX0,"^",10)
 W !?2,"QTY: ",$P(RX0,"^",7),?23,"# OF REFILLS: ",$P(RX0,"^",9),?45,"ISSUE/EXPR : " S Y=$P(RX0,"^",13) W $E(Y,4,5),"-",$E(Y,6,7),"-",$E(Y,2,3),"/" S Y=$P(RX2,"^",6) W:Y $E(Y,4,5),"-",$E(Y,6,7),"-",$E(Y,2,3)
 S PHYS=$S($D(^VA(200,+$P(RX0,"^",4),0)):$P(^(0),"^"),1:"UNKNOWN")
 W !?2,"PHYS: ",PHYS,?30,"CLERK: ",$P(RX0,"^",16),?45,"FILLED: " S Y=$P(RX2,"^",2) W:Y $E(Y,4,5),"-",$E(Y,6,7),"-",$E(Y,2,3) W " (",$P(RX0,"^",11),")"
 W !?2,"LAST FILLED: " S Y=$P(RX3,"^") W:Y $E(Y,4,5),"-",$E(Y,6,7),"-",$E(Y,2,3),?45,$S($P(RX2,"^",15):"Original Fill Returned to Stock",1:"")
 S CT=0,REF=$P(RX0,"^",9) W !?2,"REFILLED:" F K=0:0 S K=$O(^PSRX(J,1,K)) Q:'K  D
 .W:CT=5!(CT=10) !?11 W " "_$E(^PSRX(J,1,K,0),4,5)_"-"_$E(^(0),6,7)_"-"_$E(^(0),2,3)_" ("_$P(^(0),"^",2)_")"_$S($P(^(0),"^",16):"(R)",1:"") S REF=REF-1,CT=CT+1 W:CT#5 ","
 I $O(^PSRX(J,"P",0)) W !?2,"PARTIALS: " F K=0:0 S K=$O(^PSRX(J,"P",K)) Q:'K  W $E(^(K,0),4,5),"-",$E(^(0),6,7),"-",$E(^(0),2,3)," (",$P(^(0),"^",2),") QTY:",$P(^(0),"^",4)_$S($P(^(0),"^",16):" (R)",1:"")_", "
 W:$P(RX3,"^",7)]"" !?2,"REMARKS: ",$P(RX3,"^",7) D STAT^PSOFUNC
 S PSDIV=$S($D(^PS(59,+$P(RX2,"^",9),0)):$P(^(0),"^")_" ("_$P(^(0),"^",6)_")",1:"UNKNOWN")
 W !?2,"DIVISION: ",$E(PSDIV,1,25),?40,ST,?60,REF," REFILL",$S(REF'=1:"S",1:"")," LEFT",!
 Q
LOOP F I=0:0 S I=$O(^PS(55,DFN,"P",I)) Q:'I  S J=+^(I,0) I $D(^PSRX(J,0)),$P($G(^PSRX(J,0)),"^",15)'=13 D @PSRT
 Q
DATE S X=$P(^PSRX(J,0),"^",13),X=999999999-X,^TMP($J,X,J)=^(0)
 Q
DRUG I $P($G(^PSRX(J,2)),"^",6)'<PSODTCT,$D(^PSDRUG(+$P(^(0),"^",6),0)) S ^TMP($J,$E($P(^(0),"^"),1,31),J)=^PSRX(J,0)
 Q
CLSS I $P($G(^PSRX(J,2)),"^",6)'<PSODTCT,$D(^PSDRUG(+$P(^(0),"^",6),0)) S ^TMP($J,$S($P(^(0),"^",2)]"":$E($P(^(0),"^",2),1,31),1:"UNKNOWN"),J)=^PSRX(J,0)
 Q
DIR K DTOUT,DUOUT,DIR S DIR("?")="Enter '^' to Halt or Press Return to Continue",DIR(0)="FO",DIR("A")="Enter ""^"" to Halt" D ^DIR Q
