DGPTF41 ;ALB/JDS - PTF ENTRY/EDIT-4 ; 11/15/06 8:37am
 ;;5.3;Registration;**64,635,729**;Aug 13, 1993;Build 59
 ;
ACT ; -- 701 actions
 G ACT1:DGST
 S DGCFL=0 I $D(DGCST),DGCST<2,'DGCST!$G(DGREL) S DGCFL=1
 W !,"   PTF ",$J("#"_PTF,7),?15,"actions: 1=Edit   C=Close       ^N=Another Screen",!
 I DGCFL W "CENSUS ",$S(DGCI:$J("#"_DGCI,7),1:" record"),?15,"actions: ",$S(DGCST=1:"P=Open   E=Release",1:"         L=Close")
 S Z="^CLOSE^1 Edit"
 I DGCFL S Z=Z_"^"_$S(DGCST=1:"P Open Census^E Release Census",1:"L Close for Census")
 W !?15,"         ^=Abort   <RET> to Continue: "
 D READ
 ;
 I X="^"!(X="") G Q^DGPTF
 I DGCFL,DGCST=1,$E(X)="P"!($E(X)="E") G ACT^DGPTC1
 I DGCFL,'DGCST,$E(X)="L" G ACT^DGPTC1
 I X?1"^".E S DGPTSCRN=701 G ^DGPTFJ
 I X?1"C".E,'DGN G CLS^DGPTF4
 I X="O" G O^DGPTF4
 I X="R",DGN G REL
 I X'=1 D HELP G EN1^DGPTF4
 S DR="[DG701]",DIE="^DGPT(",(DGPTF,DA)=PTF D ^DIE
 F I=0,70 S B(I)="" S:$D(^DGPT(PTF,I)) B(I)=^(I)
 K DGPTF,DR
 G EN1^DGPTF4
 ;
READ ; -- read X
 R X:DTIME S:'$T X="^",DGPTOUT="" D IN^DGHELP
 Q
 ;
HELP ;
 W !,"Enter  '1'  to edit Principal & Admit Diagnosis"
 W !,"       'C'  to close out PTF record"
 I DGCFL W:DGCST=1 !,"       'P'  to re-open a Census record",!,"       'E'  to release a Census record" W:'DGCST !,"       'L'  to close for Census"
 W !,"       '^'  to stop the display"
 W !,"       '^N' to jump to screen #N (appears in upper right of screen '<N>')"
 W !,"      <RET> to continue on to the next screen"
 R !!,"Enter <RET> to continue: ",XS:DTIME
 Q
 ;
ACT1 ;
 W !,"   PTF ",$J("#"_PTF,7),?15,"actions: O=Open   R=Release   ^N=Another Screen",!
 I $D(DGCST),DGCST=1 W "CENSUS ",$J("#"_DGCI,7),?15,"action :          E=Release"
 W !?15,"         ^=Abort    <RET> to continue: "
 S Z="^OPEN^RELEASE PTF^E RELEASE CENSUS"
 D READ
 I $D(DGCST),DGCST=1,$E(X)="E" G ACT^DGPTC1
 I X=""!(X=U) G Q^DGPTF
 I X?1"^".E S DGPTSCRN=701 G ^DGPTFJ
 I X="O" G O^DGPTF4
 I X="R" G REL
 ;
 W !,"Enter  'O'  to re-open a PTF record"
 W !,"       'R'  to release a PTF record"
 I $D(DGCST),DGCST=1 W !,"       'E'  to release a Census record"
 W !,"       '^'  to stop the display"
 W !,"       '^N' to jump to screen #N (appears in upper right of screen '<N>')"
 W !,"      <RET> to continue on to the next screen"
 R !!,"Enter <RET> to continue: ",XS:DTIME
 G EN1^DGPTF4
 ;
REL ;
 S Y=1 D RTY^DGPTUTL S DGPTFLE=1,DGPTIFN=PTF D EN^DGPTFREL G ^DGPTF
 ;
