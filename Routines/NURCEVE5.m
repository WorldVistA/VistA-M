NURCEVE5 ;HIRMFO/RTK,RM-HIGHLIGHT EDITED CARE PLANS ;8/29/96
 ;;4.0;NURSING SERVICE;;Apr 25, 1997
EN1 K NURACPL
 S Z=0,GMRGOUT=0
 F RVDT=0:0 S RVDT=$O(^GMR(124.3,"AA",DFN,+GMRGRT,RVDT)) Q:RVDT'>0  F NURCPDA=0:0 S NURCPDA=$O(^GMR(124.3,"AA",DFN,+GMRGRT,RVDT,NURCPDA)) Q:NURCPDA'>0  D:'+$G(^GMR(124.3,NURCPDA,5))
 .   S Z=Z+1,NURACPL(Z)=RVDT_"^"_NURCPDA
 .   Q
 W @IOF,!!,"The following is a list of previous Patient Plans of Care",!
 S IOP="HOME" D ^%ZIS S X="IORVON;IORVOFF" D ENDR^%ZISS S GMRGIO("RVOF")=IORVOFF,GMRGIO("RVON")=IORVON,GMRGIO("S")=$L(GMRGIO("RVOF"))&$L(GMRGIO("RVON")) K IORVOFF,IORVON
 F J=0:0 S J=$O(NURACPL(J)) Q:J'>0  D  Q:GMRGOUT
 .   W !,$S($D(GMRGPDAA($P(NURACPL(J),"^",2))):"**",1:"  "),?5,J,". ",?8
 .   S Y=9999999-$P(NURACPL(J),"^") D DD^%DT
 .   D:GMRGIO("S")&$D(GMRGPDAA($P(NURACPL(J),"^",2))) HI(GMRGIO("RVON"))
 .   S USN=$P($G(^GMR(124.3,$P(NURACPL(J),"^",2),0)),"^",5) W Y,"  ",$P(^VA(200,USN,0),"^")
 .   D:GMRGIO("S")&$D(GMRGPDAA($P(NURACPL(J),"^",2))) HI(GMRGIO("RVOF"))
 .   I $Y>(IOSL-3) W !,"""^"" TO STOP: " R X:DTIME S:X="^" GMRGOUT=1 Q:GMRGOUT  W @IOF,!
 .   Q
 S:GMRGOUT GMRGOUT=0
 K DIR S DIR(0)="L^1:"_Z,DIR("A")="Enter Selection",DIR("?")="ENTER THE NUMBER (1-"_Z_") OF THE SELECTION TO BE CHOSEN" D ^DIR S GMRGUR=Y
 I $D(DIRUT) S GMRGOUT=1 Q
 E  K GMRGXPRT D
Q1 .   S NURSOUT=0 W !!,"Enter a  C  for a current listing, or an  A  for a complete listing: " R NURSPLN:DTIME S:NURSPLN="^"!(NURSPLN="^^")!'$T NURSOUT=1 Q:NURSOUT  G:NURSPLN="" Q1
 .   S:NURSPLN?1L NURSPLN=$C($A(NURSPLN)-32) I NURSPLN'="C",NURSPLN'="A" W !?3,$C(7),"Enter a C to get a current listing which will give only the latest date,",!?3,"or an A to get a complete listing with all of the dates" G Q1
 .   W !!,"This Report may be Queued to print on another device,",!,"Freeing your terminal for other use",!
 .   S ZTRTN="QUEUED^NURCEVE5",ZTDESC="Nursing CP Print from Eval DT Option" D EN7^NURSUT0 I POP K POP Q
 .   I '$D(ZTSK) D QUEUED
 .   Q
 Q
HI(ONOFF) ; WILL TURN HIGHLIGHTING ON OR OFF (ONOFF).
 S DX=$X,DY=$Y W ONOFF I $X'=DX X:$D(^%ZOSF("XY")) ^("XY")
 K DX,DY
 Q
QUEUED ;
 S NURSOUT=0 F N=1:1:($L(GMRGUR,",")-1) D  Q:NURSOUT
 .   S GMRGPDA=$P(NURACPL($P(GMRGUR,",",N)),"^",2)
 .   S NURSGMRG=0,NUREDB="P"
 .   D PRINT2^NURCPPS1
 .   K NURSGMRG,NUREDB
 .   Q
 Q
