DGPTFM71 ;ALB/MJK - Display Phys. MPCR mvts ; 12/12/06 11:49am
 ;;5.3;Registration;**729**;Aug 13, 1993;Build 59
 ;
EN ; -- entry point for MPCR display option
 W ! S DIC="^DGPT(",DIC(0)="AEMZQ",DIC("S")="I '$P(^(0),U,4),$P(^(0),U,11)=1" D ^DIC K DIC
 G ENQ:+Y<0 S DGPTF0=Y(0),PTF=+Y,DFN=+Y(0) D UPDT^DGPTUTL:'$P(Y(0),U,6)
 S Y=$S($D(^DGPT(PTF,70)):+^(70),1:"") D FMT^DGPTUTL
 S DGPR="",DGBRCH="OPT^DGPTFM71" K DGBLK S $P(DGBLK," ",80)=""
 S X=$S($D(^DPT(DFN,0)):^(0),1:""),HEAD=$E($P(X,U)_" ("_$E($P(X,U,9),6,10)_")"_DGBLK,1,30)_"Adm: ",Y=$P(DGPTF0,U,2) X ^DD("DD") S HEAD=HEAD_Y_" to " S Y=$S($D(^DGPT(PTF,70)):+^(70),1:"") S:'Y Y="Present" X:Y ^DD("DD") S HEAD=HEAD_Y_" "
 ;S X="IORVON;IORVOFF" D ENDR^%ZISS S DGVI=IORVON,DGVO=IORVOFF K IORVON,IORVOFF
 S (DGVI,DGVO)=""""""
 D EN^DGPTFM7 G EN
ENQ K DGPR,HEAD,DFN,DGPTFMT,DGVI,DGVO,DGBRCH,PTF,DIC,DGPTF0,DGBLK Q
 ;
OPT I DGC'<DGTOT W !,"Enter <RET> to stop"
 I DGC<DGTOT W !,"Enter <RET> to display more MPCR information"
 I DGC>DGMAX W:$X>40 !?2 W " or  'B'  to display from beginning"
 W ":  <RET>// " R X:DTIME
 I '$T!(X="^") G OPTQ
 I X="" G LOOP^DGPTFM7:DGC<DGTOT,OPTQ
 I DGC>DGMAX,X="B" S (DGC,DGLDT)=0 G LOOP^DGPTFM7
 W !
 I DGC<DGTOT W !,"Press return to see more MPCR information"
 I DGC'<DGTOT W !,"Press return to stop the display"
 I DGC>DGMAX W !,"Enter 'B'    to display table from beginning again"
 W !,"      '^'    to stop the display",!
 G OPT
OPTQ D KILL^DGPTFM7 Q
 ;
