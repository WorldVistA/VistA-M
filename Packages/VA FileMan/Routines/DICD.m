DICD ;SFISC/XAK-DISP,SELECT,DELETE,EDIT XREF ;11:26 AM  18 Aug 2000
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**58**
 ;
 K DICD S (DA,DL)=+Y D CHIX I 'DQ D ^DICE G Q
 D RD G:$D(DIRUT) Q I Y["C" D ^DICE G Q
 I Y["E" D EDT^DICE G Q
 D DEL G Q
 ;
DEL I DH(DQ,4) D R Q:'$D(DICD)  S DQ=DICD
 I $D(DH(DQ,3)) W !?5,$C(7),"This cross-reference cannot be deleted.",! Q
ASK S %=2 W !,"Are you sure that you want to delete the CROSS-REFERENCE " D YN^DICN Q:(%<0)!(%=2)
 I %=0 W !?7,"Answer YES if you want to delete the Cross-Reference." G ASK
 W !,"  ...OK",! K:I["SOUNDEX" ^DD(DI,0,"LOOK"),^("QUES")
 S ^DD(J(N),DL,1,0)="^.1",X=^(DQ,2),Y=$P(I,U,2) I Y?1A.E,+I=J(0),I'["MNEM",I'["MUM" K @(I(0)_"Y)") G DDD
 G DDD:X="Q"!$F(I,"BUL") I $P(I,U,3)]"",I'["MUM",I'["TRIG" D DD G DDD
 S %=1 W "DO YOU WANT THE INDIVIDUAL CROSS-REFERENCE VALUES DELETED" D YN^DICN Q:%<1
 D DD:%=1
DDD I $D(DDA) S DDA="D" D XA^DICATTA
 S DIK="^DD(J(N),DL,1,",DA(1)=DL,DA(2)=J(N),DA=DQ D ^DIK K DIK,DA
 S DA=DL D DIEZ^DIU0
D I $D(^DD(J(0),0,"DIK")) S X=^("DIK"),Y=J(0),DMAX=^DD("ROU") D EN^DIKZ
 Q
 ;
CHIX ;
 K DH S DQ=0,X="CURRENT CROSS-REFERENCE"
 F Y=0:1 S DQ=$O(^DD(DI,DA,1,DQ)) Q:DQ'>0  S DH(DQ)=^(DQ,0),DH(DQ,4)=Y S:$D(^(3)) DH(DQ,3)=^(3)
 W !! I 'Y S DQ=0 W "NO ",X Q
 I Y=1 W X_" IS " S DQ=$O(DH(0)) D L Q:'$D(DICD)  S %=2 W !,"WANT TO "_DICD_" IT" D YN^DICN S:%=-1 DICDF=1 S:%=1 DICD=DQ Q
 D M Q:'$D(DICD)  S %=2 W !,"WANT TO "_DICD_" ONE OF THEM" D YN^DICN Q:%-1
R R !,"WHICH NUMBER: ",X:DTIME Q:U[X  I X\1'=X!'$D(DH(X)) D M G R
 S DICD=X,I=DH(X) Q
M W !,"CURRENT CROSS-REFERENCES:" F J=0:0 S J=$O(DH(J)) Q:J'>0  W !?8,J,?14 S DQ=J D L
 Q
 ;
L S I=DH(DQ),X=$P(I,U,3) S:X="" X="REGULAR" W X
 G E:X["BULL" I X["TRIGGER" S %=+$P(I,U,4),(%F,Y)=+$P(I,U,5) W " OF " D WR^DIDH:$D(^DD(%,Y,0)),N Q
 W " '",$P(I,U,2),"' INDEX OF " I +I=J(0) W "FILE"
 W:'$T $P(^DD(+I,0),U)
N W:$D(DH(DQ,3)) !?14,"("_DH(DQ,3)_")" Q
 ;
E F %="CREA","DELE" S %=%_"TE VALUE" I $D(^DD(DI,DA,1,DQ,%)),^(%)'="NO EFFECT" W "  ("_^(%)_")"
 D N Q
 ;
DD ;
 N DIKJ,DA,DV,DH,Y,DCNT,DIK S DIKJ=$J
 K ^UTILITY("DIK",$J) S J=J(N),^($J)=$H,^($J,J,DL,1)=X,Y=$P(^DD(DI,DL,0),U,4),^UTILITY("DIK",$J,J,DL)=$P(Y,";",1),Y=$P(Y,";",2),^(DL,0)="S X=$"_$S(Y:"P(^(X),U,"_Y_")",1:"E(^(X),"_+$E(Y,2,9)_","_$P(Y,",",2)_")")
 I $D(^DD(J,DL,1,DQ,"DIK")) S ^UTILITY("DIK",$J,J,DL,1)="D RCR",^(1,0)=X
 K Y,DA,DV,DH S DH(1)=J(0) F Y=1:1:N S DV(J(Y-1),1)=I(Y),DV(J(Y-1),1,0)=J(Y)
 D WAIT S DIK=DIU,DA=0,DCNT=0 G CNT^DIK1
 ;
KOLD K DIR S DIR(0)="Y",DIR("A")="DO YOU WANT TO EXECUTE THE OLD KILL LOGIC NOW",DIR("?",1)="Enter 'YES' to execute the original kill logic now.",DIR("?")="Otherwise, enter 'NO'."
 D ^DIR K DIR I 'Y!$D(DIRUT) K DTOUT,DUOUT,DIRUT,DIROUT Q
 N DA W !!,"Executing old kill logic...",! S X=A1(2) D DD Q
WAIT ;
 W !,"..."
 W $P("HMMM^EXCUSE ME^SORRY","^",$R(3)+1),", ",$P("THIS MAY TAKE A FEW MOMENTS^LET ME PUT YOU ON 'HOLD' FOR A SECOND^HOLD ON^JUST A MOMENT PLEASE^I'M WORKING AS FAST AS I CAN^LET ME THINK ABOUT THAT A MOMENT","^",$R(6)+1)_"..."
 Q
 ;
RD ;
 N DQ,DH W ! S DIR(0)="SAO^E:EDIT;D:DELETE;C:CREATE",DIR("A")="Choose E (Edit)/D (Delete)/C (Create): "
 S DIR("?",1)="Enter 'E' to edit an existing X-reference",DIR("?",2)="      'D' to delete it",DIR("?")="      'C' to create a new X-reference."
 D ^DIR K DIR Q
 ;
Q D Q^DICE K DICD,DDA Q
