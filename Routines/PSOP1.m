PSOP1 ;BHAM ISC/SAB - prints short medication profile ;02/25/94
 ;;7.0;OUTPATIENT PHARMACY;**15,46,103,132,148,233,326,251**;DEC 1997;Build 202
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External reference to ^PS(50.605 supported by DBIA 696
 K RX,DTOUT,DIRUT,DIROUT,DUOUT
 D HD S DRUG="" F I=0:0 S DRUG=$O(^TMP($J,DRUG)) Q:DRUG=""!($G(PQT))  D  G:$D(DTOUT)!($D(DUOUT))!($D(DIROUT)) Q
 .F J=0:0 S J=$O(^TMP($J,DRUG,J)) Q:'J!($G(PQT))  S RX0=^(J),RX2=$G(^PSRX(J,2)),$P(RX0,"^",15)=$G(^("STA")),CP=$S(+$G(^PSRX(J,"IB")):"$",1:" ") S:$P(RX2,"^",15)&($P(RX2,"^",2)) RST($P(RX2,"^",2))=1 S:$P(RX0,"^",15)="" $P(RX0,"^",15)=-1 D W
 D:'$G(PQT) PEND^PSOP2,NVA^PSOP2
Q D ^%ZISC K ^TMP($J),PQT,PSODTCT,ST,D0,DIC,DIR,DIRUT,DUOUT,G,II,K,RXD,RXF,ZX,DRUG,X,DFN,PHYS,PSRT,CT,AL,I1,PLS,REF
 K LMI,PI,FN,Y,I,J,RX,DRX,ST,RX0,RX2,DA,PPPSTAT,PPP,EEEE,PPPCNT,PENDREX,PSOPEND,PPDIS,PPOI,PCOUNT,PP,FSIG,ZZZZ
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
W I $Y+6>IOSL,$E(IOST)="C" D DIR W @IOF Q:$D(PQT)  D HD
 N PSOBADR
 U IO I IO'=IO(0),$Y+6>IOSL W @IOF D HD
 I $E(IOST)'="C",$Y+6>IOSL W @IOF D HD
 D STAT^PSOFUNC S STA="A^N^R^H^N^S^^^^^^E^DC^^DP^DE^PH",ST=$P(STA,"^",(ST0+1)) K STA
 S PSOBADR=$O(^PSRX(J,"L",9999),-1)
 I PSOBADR'="" S PSOBADR=$G(^PSRX(J,"L",PSOBADR,0)) I PSOBADR["(BAD ADDRESS)" S PSOBADR="B"
 I PSOBADR'="B" S PSOBADR=""
 S ST=ST_PSOBADR
 W !,CP_$P(RX0,"^"),$$ECME^PSOBPSUT(J),?13,$S($D(^PSDRUG(+$P(RX0,"^",6),0)):$P(^(0),"^"),1:"NOT ON FILE"),?54,$S($L(ST)=1:" "_ST,1:ST)
 S RXD=$P($G(^PSRX(J,3)),"^"),RXF=$P(RX0,"^",9) F II=0:0 S II=$O(^PSRX(J,1,II)) Q:'II  S RXF=RXF-1 S:$P(^PSRX(J,1,II,0),"^",16) RST($P(^(0),"^"))=1
 W ?58,$S($L(RXF)=1:" "_RXF,1:RXF)
 W ?61,$E($P(RX0,"^",13),4,5)_"-"_$E($P(RX0,"^",13),6,7)_"-"_$E($P(RX0,"^",13),2,3) W:RXD ?70,$E(RXD,4,5)_"-"_$E(RXD,6,7)_"-"_$E(RXD,2,3)_$S($G(RST(RXD)):"R",1:"")
 S PSOPRSIG=$P($G(^PSRX(J,"SIG")),"^",2) K FSIG,BSIG D
 .I PSOPRSIG D FSIG^PSOUTLA("R",J,50) Q
 .D EN2^PSOUTLA1(J,50) F GGGG=0:0 S GGGG=$O(BSIG(GGGG)) Q:'GGGG  S FSIG(GGGG)=BSIG(GGGG)
 K PSOPRSIG,GGGG,BSIG
 W !?5,"QTY: ",$P(RX0,"^",7),?24,"SIG: ",$G(FSIG(1)) D:$O(FSIG(1))
 .F GGGG=1:0 S GGGG=$O(FSIG(GGGG)) Q:'GGGG!($G(PQT))  W !,?29,$G(FSIG(GGGG)) D:$Y+5>IOSL&($E(IOST)="C") DIR Q:$G(PQT)  I '$G(PQT),($Y+5>IOSL) W @IOF D HD
 K GGGG,FSIG Q:$G(PQT)
 ;D SIG
 K RST Q
HD D:PAGE>1
 .W !,"Patient: "_$P(^DPT(DFN,0),"^")_" ("_$E($P(^DPT(DFN,0),"^",9),6,9)_")",?70,"Page: "_PAGE
 .W !?(80-$L("Medication Profile Sorted by "_HDR))/2,"Medication Profile Sorted by "_HDR W:$G(FR)]"" !?(80-$L(FR_" to "_TO))/2,FR_" to "_TO
 W !?57,"REF",!?1,"Rx#",?13,"Drug",?54,"ST",?57,"REM",?62,"Issued",?70,"Last Fill",!,PSOPLINE S PAGE=PAGE+1
 Q
SORT K DIR,DUOUT,DTOUT
 S DIR("B")="All",DIR("A",1)=" ",DIR("A")="All Medications or Selection (A/S): ",DIR(0)="SAM^A:All;S:Select Range",DIR("?",1)="Enter 'A' to Print Entire Medication Profile",DIR("?")="   or 'S' for Selection Range" D ^DIR
 K DIR Q:$D(DIRUT)!(Y="A")!(Y="E")  D @PSRT
 Q
DATE ;asks date range
 W ! K %DT S %DT="AEX",%DT("A")="Starting Date: " D ^%DT  I "^"[X S DUOUT=1 Q
 G:Y<0 DATE S SDT=+Y,%DT(0)=SDT,FR=$E(SDT,4,5)_"/"_$E(SDT,6,7)_"/"_$E(SDT,2,3)
EDT S %DT("A")="Ending Date: " D ^%DT  I "^"[X S DUOUT=1 Q
 G:Y<0 EDT S EDT=+Y,DTS=1,TO=$E(EDT,4,5)_"/"_$E(EDT,6,7)_"/"_$E(EDT,2,3)
 K %DT Q
DRUG ;asks drug list
 W ! S DIC("A")="Start with Drug: ",DIC(0)="AEMQ",DIC=50
 S DIC("S")="I $S('$D(^PSDRUG(Y,""I"")):1,'^(""I""):1,DT'>^(""I""):1,1:0),$S('$D(^PSDRUG(Y,2)):1,$P(^(2),""^"",3)'[""O"":0,1:1)"
 D ^DIC I "^"[X S DUOUT=1 K DIC Q
 G:Y<0 DRUG S FR=$P(Y,"^",2)
 F %=$L($E(FR,1,30)):-1:1 S M=$A(FR,%) I M>32 S Y1=$E(FR,1,%-1)_$C(M-1)_$C(122) Q
 S PSFR=Y1 K Y1,Y,X
TO S DIC("A")="To Drug: " D ^DIC I "^"[X S DUOUT=1 K DIC Q
 G:Y<0 TO I FR]$P(Y,"^",2) W !,$C(7),"Less Than 'Start' Value" K X,Y G TO
 S TO=$P(Y,"^",2),DRS=1
 F %=$L($E(TO,1,30)):-1:1 S M=$A(TO,%) I M>32 S Y1=$E(TO,1,%-1)_$C(M+1)_$C(122) Q
 S PSTO=Y1 K Y1,Y,X,DIC
 Q
CLSS ;asks drug class list
 W ! S DIC("A")="Start with Drug Class: ",DIC(0)="AEQ",DIC=50.605 D ^DIC I "^"[X S DUOUT=1 Q
 G:Y<0 CLSS S FR=$P(Y,"^",2)
 F %=$L($E(FR,1,30)):-1:1 S M=$A(FR,%) I M>32 S Y1=$E(FR,1,%-1)_$C(M-1)_$C(122) Q
 S PSFR=Y1 K Y1,Y,X
TO1 S DIC("A")="To Drug Class: " D ^DIC I "^"[X S DUOUT=1 Q
 G:Y<0 TO1 I FR]$P(Y,"^",2) W !,$C(7),"Less Than 'Start' Value" K X,Y G TO1
 S TO=$P(Y,"^",2)
 F %=$L($E(TO,1,30)):-1:1 S M=$A(TO,%) I M>32 S Y1=$E(TO,1,%-1)_$C(M+1)_$C(122) Q
 S PSTO=Y1,CLS=1 K Y,Y1,X
 Q
DIR K PQT,DTOUT,DUOUT,DIR,DIRUT S DIR(0)="E" D ^DIR S:$D(DUOUT)!($D(DTOUT)) PQT=1 Q
SIG I '$P(^PSRX(J,"SIG"),"^",2) D  Q
 .S X=$P(^PSRX(J,"SIG"),"^") D SIGONE^PSOHELP S SIG=$E($G(INS1),2,250)
 .F SG=1:1:$L(SIG) W:($X+$L($P(SIG," ",SG)_" "))>$S(IOST["C-":IOM,1:70) !?6 W:$P(SIG," ",SG)]"" $P(SIG," ",SG)_" "
 S MIG=$P(^PSRX(J,"SIG"),"^"),SIGOK=1 D
 .F SG=1:1:$L(MIG) Q:$P(MIG," ",SG)=""  W:($X+$L($P(MIG," ",SG)_" "))>$S(IOST["C-":IOM,1:70) !?6 W $P(MIG," ",SG)_" "
 F I=0:0 S I=$O(^PSRX(RXN,"SIG1",I)) Q:'I  S MIG=$P(^PSRX(RXN,"SIG1",I,0),"^") D
 .F SG=1:1:$L(MIG) Q:$P(MIG," ",SG)=""  W:($X+$L($P(MIG," ",SG)_" "))>$S(IOST["C-":IOM,1:70) !?6 W $P(MIG," ",SG)_" "
 Q
