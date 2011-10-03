DGDEPU ;ALB/CAW/AMA - Dependent Utilities - Generic ;11/3/94
 ;;5.3;Registration;**45,733**;Aug 13, 1993;Build 15
 ;
SEL ; -- select processing
 ;DG*5.3*733 -- added DIR to the list a vars to be NEW'ed
 N BG,LST,Y,DIR
 S BG=+$O(@VALMAR@("IDX",$S($G(BEG):BEG,1:1),0))
 S LST=+$O(@VALMAR@("IDX",$S($G(END):END,1:DGCNT),0))
 I 'BG W !!,*7,"There are no '",VALM("ENTITY"),"s' to select.",! S DIR(0)="E" D ^DIR K DIR D OUT G SELQ
 S Y=+$P($P(XQORNOD(0),U,4),"=",2)
 I 'Y S DIR(0)="N^"_BG_":"_LST,DIR("A")="Select "_VALM("ENTITY")_"(s)" D ^DIR K DIR I $D(DIRUT) D OUT G SELQ
 ;
 ; -- check was valid entries
 S DGERR=0,DGW=Y
 I DGW<BG!(DGW>LST) D
 . W !,*7,"Selection '",DGW,"' is not a valid choice."
 . D OUT,PAUSE^VALM1
 ;
SELQ K DIRUT,DTOUT,DUOUT,DIROUT Q
 ;
OUT ;
 S DGERR=1
 Q
 ;
LOOKUP ; Look up the tests that can be added to
 ;
 S DIC("S")="I $P(^(0),U,2)=DFN"
 W ! S DIC="^DGMT(408.31,",DIC(0)="EQZ",X=DFN,D="C" D IX^DIC K DIC G LOOKUPQ:$D(DTOUT)!($D(DUOUT))!(+Y<0)
 I ('$P($G(^DG(408.34,+$P(Y(0),"^",23),0)),U,2))!('$P($G(^DGMT(408.31,+Y,"PRIM")),"^")) W !?5,*7,"This means test is uneditable and cannot be added to." G LOOKUP
 S DGMTI=+Y,DGMT0=Y(0) K DIC,Y
LOOKUPQ ;
 Q
