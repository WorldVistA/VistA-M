PSIVVW1 ;BIR/PR-PRINT ACTIVITY LOG ;06 APR 97 / 5:47 PM
 ;;5.0; INPATIENT MEDICATIONS ;**58,81**;16 DEC 97
 ;
 ; Reference to ^PS(55 is supported by DBIA# 2191
 ;
 ;Called at top from Patient Profile option
BEG ;Ask to view activity log
 K PSIVLOG,PSIVLAB F Q=0:0 W !,"View activity log" S %=1 D YN^DICN Q:%  S HELP="ACTLOG" D ^PSIVHLP
 G:%<1 Q S:%=1 PSIVLOG=1
 ;
BEG1 ;Ask to view label log
 F Q=0:0 W !!,"View label log" S %=1 D YN^DICN Q:%  S HELP="LABLOG" D ^PSIVHLP2
 G:%<1 Q S:%=1 PSIVLAB=1 G ENPR
 ;
EN ; Show activity, label, or history log.
 D FULL^VALM1
 S:'$D(ON55) ON55=ON
 K DIR S DIR(0)="SOA^A:Activity Log;L:Label Log;H:History Log",DIR("A")="(A)ctivity (L)abel (H)istory: " D ^DIR K DIR G:$D(DIRUT) Q I Y="H" D ENHIS^PSJHIS(DFN,ON55,"V") G EN
 K PSJHIS
 D @$S(Y="A":"EN1",1:"DATA^PSIVLTR1(DFN,+ON55)") I $D(PSIVSCR),'$G(PSJDNE) D PAUSE
 G EN
 ;
ENPR ;Entry from profile.
 D HOLDHDR^PSJOE
 K PSJDNE I $D(PSIVLOG) D EN1 I $D(PSIVSCR),'$D(PSJDNE) D PAUSE
 I '$D(PSJDNE),$D(PSIVLAB) D DATA^PSIVLTR1(DFN,+ON55) I $D(PSIVSCR),'$G(PSJDNE) D PAUSE
 I $D(PSIVSCR) K DIR S DIR(0)="E" D ^DIR K DIR
 ;
Q K %,COU,I,L,N,OG,P1,P17,PSIVX,USER
 Q
 ;
EN1 ;Entry for Inmed functionality and viewing the log from IV order entry
 K PSJDNE S PSIVSCR=$E(IOST)="C"
 I ON["P" D  Q
 . NEW AT,PN,PX,UD,OD
 . S AT="S",PN=1,PX="" F Q=0:0 S Q=$O(^PS(53.1,+ON,"A",Q)) Q:'Q  I $D(^(Q,0)) S AND=^(0)  D:'(PN#6) NPAGE^PSGVW0 Q:PX["^"  D AL1^PSGVW0
 . W !
 I '$O(^PS(55,DFN,"IV",+ON55,"A",0)) W !!,"No activity LOG to report." G Q
 D HDR F JJ=0:0 S JJ=$O(^PS(55,DFN,"IV",+ON55,"A",JJ)) Q:'JJ!$G(PSJDNE)  S P1=$G(^(JJ,0)),Y=+$P(P1,"^",5) D ACT
 Q
 ;
ACT ;This module is used for the screen profile
 X ^DD("DD") W !,JJ,?3,$P(Y,"@")," ",$P(Y,"@",2),?24 S X=$$CODES^PSIVUTL($P(P1,"^",2),55.04,.02) W X
 ;W ?50,$P(P1,"^",3),!?3,"Comment: ",$P(P1,"^",4) D PAUSE Q:$D(PSJDNE)
 D NAME^PSJBCMA1($P(P1,U,6),.X) W ?50,X
 W !?3,"Comment: ",$P(P1,"^",4) D PAUSE Q:$D(PSJDNE)
 F A1=0:0 S A1=$O(^PS(55,DFN,"IV",+ON55,"A",JJ,1,A1)) Q:'A1!$D(PSJDNE)  S P1=^(A1,0) D ACTW
 W !
 Q
 ;
ACTW ;
 W ! D PAUSE W !?10,"Field: '",$P(P1,"^"),"'" D PAUSE W !?3,"Changed from: '",$P(P1,"^",2),"'" D PAUSE W !?13,"To: '",$P(P1,"^",3),"'" D PAUSE
 Q
PAUSE ;
 I ($Y#IOSL)>18,PSIVSCR K DIR S DIR(0)="E" D ^DIR K DIR W !!! I $D(DUOUT)!$D(DTOUT) S (PSJS1,PSJS2,PSJS3,PSJS4)="~",(PSJDNE,PSJPR)=1
 Q
 ;
HDR W !!,"ACTIVITY LOG:",!,"#",?3,"DATE",?14,"TIME",?24,"REASON",?50,"USER",! F I=1:1:79 W "="
 Q
 ;
LOG1 ;This module is used for profile report. (hard printer copy usually)
 Q
 X ^DD("DD") W !,JJ,?3,$P(Y,"@")," ",$P(Y,"@",2),?24 S X=$$CODES^PSIVUTL($P(P1,"^",2),55.04,.02) W X
 W ?50,$P(P1,"^",3),!?3,"Comment: ",$P(P1,"^",4) I ($Y#IOSL)>22,PSIVSCR D PAUSE
 F PSIVX=0:0 S PSIVX=$O(^PS(55,DFN,"IV",+ON,"A",JJ,1,PSIVX)) Q:'PSIVX  S P1=^(PSIVX,0) W !!?10,"Field: '",$P(P1,"^"),"'",!?3,"Changed from: '",$P(P1,"^",2),"'",!?13,"To: '",$P(P1,"^",3),"'" I ($Y#IOSL)>18,PSIVSCR D PAUSE
 Q
ENLOG ;Entry for patient profile report OR patient purge report
 ;Called from routine PSIVPR
 S (ON,ON55)=PSJORD D HDR W:'$O(^PS(55,DFN,"IV",+ON,"A",0)) !!,"No activity LOG to report."
 ;
 K PSJDNE S PSIVSCR=$E(IOST)="C" F JJ=0:0 S JJ=$O(^PS(55,DFN,"IV",+ON,"A",JJ)) Q:'JJ!$D(PSJDNE)  S P1=$S($D(^(JJ,0)):^(0),1:""),Y=+$P(P1,"^",5) D ACT
 G Q
