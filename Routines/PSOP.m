PSOP ;BIR/SAB - Medication profile long or short ;02/25/94
 ;;7.0;OUTPATIENT PHARMACY;**2,15,98,132,148,326**;DEC 1997;Build 11
 ;External reference to PS(55 supported by DBIA 2228
 ;External reference to PS(59.7 supported by DBIA 694
 ;External reference to PSDRUG supported by DBIA 221
 W !! K ^TMP($J),ZTSK,CLS S DIC(0)="QEAM" D EN^PSOPATLK S Y=PSOPTLK G Q:+Y<1  S PSOLOUD=1,DFN=+Y D:$P($G(^PS(55,+Y,0)),"^",6)'=2 EN^PSOHLUP(+Y) K PSOLOUD S Y=DFN
DOIT S (FN,DFN,D0,DA)=+Y I '$D(^PS(55,+Y,"P")),'$D(^("ARC")),'$D(^("NVA")),'$D(^PS(52.41,"AOR",+Y)) W !?20,$C(7),"NO PHARMACY INFORMATION" H 5 D ^PSODEM G PSOP
 I '$O(^PS(55,+Y,"P",0)),$D(^PS(55,+Y,"ARC")) D ^PSODEM W !!,"PATIENT HAS ARCHIVED PRESCRIPTIONS",! G PSOP
 S DIR("?")="Enter 'L' for a long profile or 'S' for a short profile",DIR("A")="LONG or SHORT: ",DIR(0)="SA^L:LONG;S:SHORT",DIR("B")="SHORT" D ^DIR G:$D(DUOUT)!$D(DIRUT) Q S PLS=Y K DIR
S S DIR(0)="SA^D:DATE;M:MEDICATION;C:CLASS",DIR("A")="Sort by DATE, CLASS or MEDICATION: ",DIR("B")=$S($P($G(PSOPAR),"^",14)=2:"MEDICATION",$P($G(PSOPAR),"^",14)=1:"CLASS",1:"DATE")
 S DIR("?",1)="Enter 'DATE', 'CLASS' or 'MEDICATION' to determine the order in which",DIR("?")="prescriptions will appear on the profile." D ^DIR G:$D(DUOUT)!$D(DIRUT) Q S PSRT=$S(Y="D":"DATE",Y="M":"DRUG",1:"CLSS")
 S HDR=$S(Y="D":"ISSUE DATE",Y="M":"DRUG NAME",1:"DRUG CLASS") K DIR
 K DIR G:PSRT="DATE" DEV S DIR("A")="Profile Expiration/Discontinued cutoff",DIR("B")=120,DIR(0)="N^1:9999:0",DIR("?",1)="Enter the number of days which will cut discontinued and expired Rx's from",DIR("?")="the profile."
 D ^DIR G:$D(DTOUT)!($D(DUOUT)) Q K DIR S X1=DT,X2=-X D C^%DTC S PSODTCT=X
DEV D SORT^PSOP1 G:$D(DUOUT)!($D(DTOUT)) Q
 K %ZIS,IOP,ZTSK S PSOION=ION,%ZIS="MQ" D ^%ZIS K %ZIS I POP S IOP=PSOION D ^%ZIS K IOP,PSOION G Q
 K PSOION I $D(IO("Q")) S ZTDESC="Patient Medication Profile",ZTRTN="P^PSOP" D  G PSOP
 .F G="HDR","TO","FR","SDT","PSFR","PSTO","DTS","CLS","EDT","DRS","PSODTCT","FN","DFN","DA","D0","PLS","PSRT","PSOPAR" S:$D(@G) ZTSAVE(G)=""
 .K IO("Q") D ^%ZTLOAD W:$D(ZTSK) !,"Task Queued to Print",! K Q,ZTSK D Q
 D P,Q G PSOP
P U IO S PAGE=1,$P(PSOPLINE,"-",80)="" K ^TMP($J) D LOOP D ^PSODEM W:$O(^PS(55,DA,"ARC",0)) !!,"Patient Has Archived Prescriptions",!
 I $Y+10>IOSL,$E(IOST)="C" D DIR^PSOP1 Q:$D(PQT)  W @IOF
 W:$P($G(^PS(59.7,1,40.1)),"^") !,"Outpatient prescriptions are discontinued 72 hours after admission"
 W !!?(80-$L("Medication Profile Sorted by "_HDR))/2,"Medication Profile Sorted by "_HDR W:$G(FR)]"" !?(80-$L(FR_" to "_TO))/2,FR_" to "_TO
 I PLS="S" D ^PSOP1 G Q
 W ! S DRUG="" F II=0:0 S DRUG=$O(^TMP($J,DRUG)) Q:DRUG=""!($D(PQT))  F J=0:0 S J=$O(^TMP($J,DRUG,J)) Q:'J  D O W:$G(PQT) @IOF Q:$G(PQT)  I $Y+8>IOSL,$E(IOST)="C" D DIR^PSOP1 W @IOF Q:$D(PQT)
 D PEND^PSOP2,NVA^PSOP2
Q D ^%ZISC K CP,HDR,X1,X2,RX3,^TMP($J),ST0,PSODTCT,ST,D0,DIC,DIR,DIRUT,DUOUT,G,II,K,RXD,RXF,ZX,DRUG,X,DFN,PHYS,PSRT,CT,AL,I1,PLS,REF,LMI,PI,FN,Y,I,J,RX,DRX,ST,RX0,RX2,DA,PSOPLINE,PAGE,PRLBL,PSOPATOK,PSOPTLK
 K PSOLR,PSDIV,PQT,TO,FR,CLS,DRG,DRS,DTS,DTOUT,PSFR,PSTO,SDT,EDT,PPP,FSIG,IIII,STAT,PP,EEEE,PPPCNT,PENDREX,PSOPEND,PPDIS,PPOI,PCOUNT,PPCOUNT,PPP S:$D(ZTQUEUED) ZTREQ="@" Q
 ;
O S RX0=^PSRX(J,0),RX2=$G(^(2)),RX3=$G(^(3)),$P(RX0,"^",15)=$G(^("STA")),DRX="NOT ON FILE",CP=$S(+$G(^PSRX(J,"IB")):"$",1:" ") S:$P(RX0,"^",15)="" $P(RX0,"^",15)=-1
 ;
 I $D(^PSDRUG(+$P(RX0,"^",6),0)) S DRX=$P(^(0),"^")
 I $Y+10>IOSL,IOSL["C-" D DIR^PSOP1 W @IOF Q:$D(PQT)
 I $Y+10>IOSL,$E(IOST)'="C" S PAGE=PAGE+1 D
 .W @IOF,!,$P(^DPT(DFN,0),"^"),?70,"Page: "_PAGE
 .W !?(80-$L("Medication Profile Sorted by "_HDR))/2,"Medication Profile Sorted by "_HDR W:$G(FR)]"" !?(80-$L(FR_" to "_TO))/2,FR_" to "_TO
 .W !,PSOPLINE
 W !!,"Rx #: "_CP_$P(RX0,"^"),$$ECME^PSOBPSUT(J),?32,"Drug: ",$G(DRX)
 S PSOBRSIG=$P($G(^PSRX(J,"SIG")),"^",2) K FSIG,BSIG D
 .I PSOBRSIG D FSIG^PSOUTLA("R",J,70) Q
 .D EN2^PSOUTLA1(J,70) F IIII=0:0 S IIII=$O(BSIG(IIII)) Q:'IIII  S FSIG(IIII)=BSIG(IIII)
 K PSOBRSIG,IIII,BSIG
 W !?2,"SIG: "_$G(FSIG(1)) D:$O(FSIG(1))
 .F IIII=1:0 S IIII=$O(FSIG(IIII)) Q:'IIII!($G(PQT))  W !?7,$G(FSIG(IIII))  D:($Y+5>IOSL)&($E(IOST)["C") DIR^PSOP1 Q:$G(PQT)  D:$Y+5>IOSL
 ..S PAGE=PAGE+1
 ..W @IOF,!,$P(^DPT(DFN,0),"^"),?70,"Page: "_PAGE
 ..W !?(80-$L("Medication Profile Sorted by "_HDR))/2,"Medication Profile Sorted by "_HDR W:$G(FR)]"" !?(80-$L(FR_" to "_TO))/2,FR_" to "_TO
 ..W !,PSOPLINE
 Q:$G(PQT)
 W !?2,"QTY: ",$P(RX0,"^",7),?23,"# of Refills: ",$P(RX0,"^",9),?45,"Issue/Expr: " S Y=$P(RX0,"^",13) W $E(Y,4,5),"-",$E(Y,6,7),"-",$E(Y,2,3),"/" S Y=$P(RX2,"^",6) W:Y $E(Y,4,5),"-",$E(Y,6,7),"-",$E(Y,2,3)
 K DIC,X,Y S DIC="^VA(200,",DIC(0)="M",X="`"_+$P(RX0,"^",4) D ^DIC S PHYS=$S(+Y:$P(Y,"^",2),1:"Unknown") K DIC,X,Y
 W !?2,"Prov: "_PHYS,?30,"Entry By: "_$P(RX0,"^",16),?45,"Filled: " S Y=$P(RX2,"^",2) W:Y $E(Y,4,5),"-",$E(Y,6,7),"-",$E(Y,2,3) W " (",$P(RX0,"^",11),")"
 I $P(RX3,"^",3) D
 .K DIC,X,Y S DIC="^VA(200,",DIC(0)="M",X="`"_+$P(RX3,"^",3) D ^DIC S PHYS=$S(+Y:$P(Y,"^",2),1:"Unknown") K DIC,X,Y W !?2,"Cosigner: "_PHYS K PHYS
 S PSOLR=$S($P(RX2,"^",13):$P(RX2,"^",13),1:"") F PSOX=0:0 S PSOX=$O(^PSRX(J,1,PSOX)) Q:'PSOX  S:$P(^PSRX(J,1,PSOX,0),"^",18) PSOLR=$P(^(0),"^",18)
 W !?2,"Last Released: " W:PSOLR $E(PSOLR,4,5)_"-"_$E(PSOLR,6,7)_"-"_$E(PSOLR,2,3)
 W ?45,$S($P(RX2,"^",15):"Original Fill Returned to Stock",1:"Original Release: "_$S($P(RX2,"^",13):$E($P(RX2,"^",13),4,5)_"-"_$E($P(RX2,"^",13),6,7)_"-"_$E($P(RX2,"^",13),2,3),1:""))
 S CT=0,REF=$P(RX0,"^",9) F K=0:0 S K=$O(^PSRX(J,1,K)) Q:'K  S RX1=^PSRX(J,1,K,0) D
 .I $Y+5>IOSL,IOSL["C-" D DIR^PSOP1 W @IOF Q:$D(PQT)
 .I $Y+5>IOSL,$E(IOST)'="C" S PAGE=PAGE+1 D
 ..W @IOF,!,$P(^DPT(DFN,0),"^"),?70,"Page: "_PAGE
 ..W !?(80-$L("Medication Profile Sorted by "_HDR))/2,"Medication Profile Sorted by "_HDR W:$G(FR)]"" !?(80-$L(FR_" to "_TO))/2,FR_" to "_TO
 ..W !,PSOPLINE
 .W !?2,"Refilled: "_$E($P(RX1,"^"),4,5)_"-"_$E($P(RX1,"^"),6,7)_"-"_$E($P(RX1,"^"),2,3)_" ("_$P(RX1,"^",2)_")"_$S($P(RX1,"^",16):"(R)",1:"")
 .W ?30,"Released: "_$S($P(RX1,"^",18):$E($P(RX1,"^",18),4,5)_"-"_$E($P(RX1,"^",18),6,7)_"-"_$E($P(RX1,"^",18),2,3),1:"")
 .S REF=REF-1
 I $Y+2>IOSL,IOSL["C-" D DIR^PSOP1 W @IOF Q:$D(PQT)
 I $Y+2>IOSL,$E(IOST)'="C" S PAGE=PAGE+1 W @IOF,!,$P(^DPT(DFN,0),"^"),?70,"Page: "_PAGE
 I $O(^PSRX(J,"P",0)) W !?2,"Partials: " F K=0:0 S K=$O(^PSRX(J,"P",K)) Q:'K  W $E(^(K,0),4,5),"-",$E(^(0),6,7),"-",$E(^(0),2,3)," (",$P(^(0),"^",2),") QTY:",$P(^(0),"^",4)_$S($P(^(0),"^",16):" (R)",1:"")_", "
 W:$P(RX3,"^",7)]"" !?2,"Remarks: ",$P(RX3,"^",7) D STAT^PSOFUNC
 S PSDIV=$S($D(^PS(59,+$P(RX2,"^",9),0)):$P(^(0),"^")_" ("_$P(^(0),"^",6)_")",1:"Unknown")
 W !?2,"Division: "_$E(PSDIV,1,25),?40,ST,?60,REF," Refill"_$S(REF'=1:"s",1:"")," Left"
 Q
LOOP F I=0:0 S I=$O(^PS(55,DFN,"P",I)) Q:'I  S J=+^(I,0) D  I $G(PSOPATOK),$D(^PSRX(J,0)),$P($G(^PSRX(J,"STA")),"^")'=13 S PRLBL=PSRT_"^PSOP2" D @PRLBL
 .S PSOPATOK=1 I $P($G(^PSRX(+$G(J),0)),"^",2),DFN'=$P($G(^(0)),"^",2) K ^PS(55,DFN,"P",I,0) S:$P($G(^PS(55,DFN,"P",0)),"^",4) $P(^PS(55,DFN,"P",0),"^",4)=$P($G(^(0)),"^",4)-1 S PSOPATOK=0
 Q
