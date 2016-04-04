DICE1 ;SFISC/XAK-TRIGGER LOGIC ;10:24 AM  9 Jul 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**6**
 ;
FIELD S %=DI,%F=DL,DOLD=$P(^DD(DI,DL,0),U) W !!,"WHEN THE " D WR^DIDH
 R "IS CHANGED,",!,"WHAT FIELD SHOULD BE 'TRIGGERED': ",X:DTIME Q:U[X
 I X?1."?" S DIC="^DD("_DI_",",DIC(0)="QE",DIC("S")="S %=$P(^(0),U,2) I %'[""C""&(%'[""W"")",DIC("W")="W:$P(^(0),U,2) ""   (multiple)""" D ^DIC K DIC G FIELD
 F %=0:0 S %=$F(X," IN ") Q:'%  S X=$E(X,1,%-5)_":"_$E(X,%,999),%=$F(X," FILE") S:% X=$E(X,1,%-6)_$E(X,%,999)
 F %=99:0 S %=$O(I(%)) Q:%=""  K I(%),J(%)
 S %=-1,DCNEW=X,DICOMP="SW?",X="INTERNAL("_$P(X,":")_")"_$S($F(X,":"):":",1:"")_$P(X,":",2,99) D DA,DICOMP
 I '$D(X) S X=DCNEW,DICOMP="SW?" D DICOMP
 F %=9.2:.1 Q:'$D(X(%))  S ^UTILITY("DICE",$J,%+80)=X(%)
 I '$D(X)!'DICOMPX W !,"  ...",I,$C(7),!,"YOU MUST IDENTIFY SOME FIELD, EITHER WITHIN THE",!,"'",@("$P("_DIU_"0),U)"),"' FILE OR IN SOME OTHER" G FIELD
 S DFLD=X,DENEW=+$P(DICOMPX,U,2),DIN=+DICOMPX,DREF="",DLAY=Y["L"
 K X F X=Y\100*100:-100:0 F %=X:1 Q:'$D(J(%))  G CK:J(%)=DIN
 W $C(7),!,"SORRY, I AM CONFUSED" G FIELD
CK I DENEW=.001 W $C(7),!,"CAN'T UPDATE A 'NUMBER' FIELD!" G FIELD
 I DENEW=DL,DIN=DI W $C(7),!,"CAN'T HAVE A FIELD TRIGGERING ITSELF!!!" G FIELD
 S DIFILE=J(X),DIAC="DD" D ^DIAC I '% W $C(7),!,"YOU DON'T HAVE 'DATA DEFINITION' ACCESS TO",!,"  THE '",$O(^DD(J(X),0,"NM",0)),"' FILE!" G FIELD
 I $P($G(^DD(J(X),0,"DI")),U,2)["Y" W $C(7),!,"CAN'T TRIGGER A RESTRICTED"_$S($P(^("DI"),U)["Y":" (ARCHIVE)",1:"")_" FILE!" G FIELD
 F X=X:1 S %=X#100,DREF=DREF_I(X)_$E(",",1,%)_"DIV("_%_"),",A=X S:$S('$D(J(%)):1,1:J(%)-J(X))&'$D(DICOMPX(0,J(X))) ^UTILITY("DICE",$J,"DIC")="LOOKUP" Q:J(X)=+DICOMPX!'$D(I(X+1))
 S DLOC=$P(^DD(DIN,DENEW,0),U,4),DSUB=$P(DLOC,";"),DLOC=$P(DLOC,";",2),DNEW=$P(^(0),U) S:+DSUB'=DSUB DSUB=""""_DSUB_""""
 I $P(^(0),U,2)["C" W !,$C(7),"CAN'T TRIGGER A COMPUTED FIELD!" G FIELD
 W "  ...OK" K DIFILE,DIAC Q
 ;
DA S DA="^DD("_DI_","_DL_",1,"_DQ_","_8 Q
 ;
DICOMP ;
 S DICOMPX="",DICOMPX(0)="DIV(",DQI="Y(" G ^DICOMP
 ;
