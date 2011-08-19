DGMTREM ;ALB/CAW - Comments for Means Test ; 04/28/2003 2:00 pm
 ;;5.3;Registration;**45,182,513**;Aug 13, 1993
 ;
EN ;Entry point to place comments concerning a means test
 I DGMTYPT=1 S DIC("S")="I $P(^(0),U,14)"
 I DGMTYPT=2 S DIC("S")="I $D(^DGMT(408.31,""AID"",DGMTYPT,+Y))"
 S DIC="^DPT(",DIC(0)="AEMQ" W ! D ^DIC K DIC G Q:Y<0 S DFN=+Y
 ;
DT S DIC("A")="Select DATE OF TEST: "
 I $D(^DGMT(408.31,+$$LST^DGMTU(DFN,"",DGMTYPT),0)) S DIC("B")=$P(^(0),"^")
 S DIC("S")="I $P(^(0),U,2)=DFN,$P(^(0),U,19)=DGMTYPT S MTDT=X,MTIEN=Y I $$PRIM^DGMTREM(MTDT,MTIEN)"
 S DIC="^DGMT(408.31,",DIC(0)="EQZ" W ! D EN^DGMTLK K DIC G Q:Y<0
 S DGMTI=+Y,DGMTDT=$P(Y,"^",2),DGMT0=Y(0)
 ;
 ;
 I '$P($G(^DG(408.34,+$P(Y(0),U,23),0)),U,2) D  G:$G(DGERR) Q
 .W !!?3,*7,"Warning: Uneditable "_$S(DGMTYPT=1:"means",1:"copay")_" test.  The source of this test is "_$S($$SR^DGMTAUD1(Y(0))]"":$$SR^DGMTAUD1(Y(0)),1:"UNKNOWN")
 .W !?12,"which has been flagged as an uneditable source.",! S DGERR=1
 D DISPLAY^DGMTU23(DGMTI,DGMTYPT),PAUSE I $D(DTOUT)!($D(DUOUT)) K DTOUT,DUOUT G EN
 ; Comment enter/edit
 S DA=DGMTI,DR="[DGMT COMMENTS]",DIE="^DGMT(408.31," D ^DIE
 ;
Q K DFN,DGMTACT,DGMTDT,DGMTERR,DGMT0,DGMTI,DGMTROU,DGMTYPT,DGMTX,DTOUT,DUOUT,X,Y
 Q
 ;
PAUSE S DIR(0)="E" D ^DIR
 Q
 ;
PRIM(DGMTDT,DGMTIEN) ;
 ; Find Primary Test for Income Year, and allow for a Future Dated Test
 ;
 I ^DGMT(408.31,DGMTIEN,"PRIM")=1 Q 1
 I DGMTDT>DT,$O(^DGMT(408.31,"AD",1,DFN,DGMTDT,""),-1)=DGMTIEN Q 1
 ;
 Q 0
