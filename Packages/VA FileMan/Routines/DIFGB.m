DIFGB ;SFISC/XAK-STORE FILEGRAM TEMPLATE ;5/23/96  11:16
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
PUT ;
 W !,"STORE ",$S($D(DIAR):"ARCHIVE",$D(DIAX):"EXTRACT",1:"FILEGRAM")_" LOGIC IN TEMPLATE: "
 R X:DTIME S:'$T DTOUT=1,X="" G Q:U[X
 S DIC="^DIPT(",D="F"_DK
 S DIC("S")="S %=^(0) I $P(%,U,8)="_$S($D(DIAX):2,1:1)_",$P(%,U,4)=DK!'$L($P(%,U,4))"_$P(" F DW=1:1:$L($P(%,U,3)) I DUZ(0)[$E($P(%,U,3),DW) Q",U,DUZ(0)'="@"&L)
 S DIC(0)="ELZSQI",DIC("S")="I Y'<1 "_DIC("S"),Y=-1,DLAYGO=0 D IX^DIC:X]"" K DIC,DLAYGO G:Y<0 PUT:X'[U,Q
 S S=$O(^DIPT(+Y,0))]""
 I S W $C(7),!,"TEMPLATE ALREADY STORED THERE...." D W:DUZ(0)'="@" G PUT:'$T W " OK TO REPLACE" S %=0 D YN^DICN W ! G PUT:%-1 D PURGE
 S ^DIPT(+Y,0)=$P(Y,U,2)_U_DT_U_DUZ(0)_U_DK_U_DUZ_U_DUZ(0)_U_DT,^DIPT("F"_DK,$P(Y,U,2),+Y)=1
 I '$D(DIAX) S ^DIPT("FG",$P(Y,U,2),+Y)="",$P(^DIPT(+Y,0),U,8)=1
 E  S $P(^DIPT(+Y,0),U,8,9)=2_U_DIAXFNO
 S Y=+Y,%X=""
 F %=1:1 S %X=$O(^UTILITY("DIFG",$J,%X)) Q:%X=""  S ^DIPT(Y,1,%,0)=^(%X) D FLD
 S:%-1 ^DIPT(Y,1,0)="^.41^"_(%-1)_U_(%-1)
 I '$D(DIAX) S ^DIPT(Y,"F",2)="S DIFGT="""_$P(^DIPT(+Y,0),U)_""",DIFGBFN="_DK_" D FG^DIFGB;X"
Q K ^UTILITY("DIFG",$J),DIFG Q
 ;
PURGE L +^DIPT(+Y)
 S %Y=0 F %X=0:0 S %Y=$O(^DIPT(+Y,%Y)) Q:%Y=""  K:%Y'="%D" ^DIPT(+Y,%Y)
 L -^DIPT(+Y)
 Q
 ;
W S %=$P(^DIPT(+Y,0),U,6) F X=1:1:$L(%) I DUZ(0)[$E(%,X) Q
 Q
 ;
FLD S %Y=""
 F S=1:1 S %Y=$O(^UTILITY("DIFG",$J,%X,%Y)) Q:%Y=""  S ^DIPT(Y,1,%,"F",S,0)=^(%Y)
 S:S-1 ^DIPT(Y,1,%,"F",0)="^.411^"_(S-1)_U_(S-1) Q
 ;
TEM ;
 S X=$E(X,2,99),DIC="^DIPT(",DIC(0)="SQEM",D="FG" I X["?"!($D(DIAX)) S D="F"_DK
 S DIC("S")="I $P(^(0),U,4)="_DK_",$P(^(0),U,8)="_$S($D(DIAX):2,1:1)_$S($D(DIAX):",$P(^(0),U,9)=DIAXFNO",1:"")
 D IX^DIC S X="" Q:Y<0
EN ;
 K DIR S DA=+Y
 S DIR(0)="Y",DIR("A")="WANT TO EDIT '"_$P(Y,U,2)_"' TEMPLATE"
 D ^DIR K DIR S:'Y!$D(DTOUT) X=U Q:'Y  D DIE I '$D(DA) S DC=0 Q
 S DC(1)=0,DC(0)=DA K DA D GET
 S DJ=0,X="" ;D EN^DIFGA,PUT:X'=U
 Q
GET S DC(1)=$O(^DIPT(DC(0),1,+DC(1))),DC=0 Q:+DC(1)'=DC(1)
 S %=^(DC(1),0),X=+% Q:'X  S DC=1
 I DL>1,$P(%,U,2)'>DL F J=$P(%,U,2):1:DL S DC=DC+1,DC(DC)=""
 I $D(DIAX),$P(%,U,4)>2 S $P(DC(1),U,3)=$O(^DD(+$P(%,U,9),0,"NM",""))
 I $P(%,U,5)]"" S DC=DC+1,DC(DC)=$P(%,U,5)
 F J=0:0 S J=$O(^DIPT(DC(0),1,+DC(1),"F",J)) Q:+J'=J  S %=^(J,0),DIAXZ=$P(%,U,2,9),%=+%,%=$S($D(^DD(X,%,0)):$P(^(0),U),1:%) S:'% DC=DC+1,DC(DC)=%_U_DIAXZ
 S DC=$S($D(DC(2)):2,1:0)
 Q
DIE N DL,DK,DI
 S DIE="^DIPT(",DR=".01;3;6" D ^DIE K DIE,DR S X=""
 Q
FG ;Entry from Print template
 K ^UTILITY($J,"W")
 S DIFG("FE")=D0,DIFG("FUNC")="L",DIFG("FGR")="^UTILITY(""DIFG"",$J,"
 I 'DIFGT S DIC="^DIPT(",D="FG",DIC("S")="I $P(^(0),U,4)="_DIFGBFN,DIC(0)="O",X=DIFGT K DIFGBFN D IX^DIC S:+Y DIFGT=+Y I Y'>0 K DIFG,DIFGT G Q
 I $G(DIAR)=4 S DIFG("FGR")="^DIAR(1.11,DIARC,""D""," I DIARF=DIARF2,$D(^DIC(+DIARF,0,"GL")) S D1=^("GL"),@(D1_"D0,-9)")=DIARC
 I $G(DIARP)]"",+DIARP'=+DIFGT S DIFGT=DIARP,^DIPT(DIARP,"F",2)="S DIFGT="_DIARP_" D FG^DIFGB;X"
 N DI,D0 D START^DIFGG
 I $D(DIARD) S DIARD=DIARD+1 W:(DIARD#50=0) !,DIARD," RECORDS PROCESSED"
 I $G(DIAR)=4 S ^DIAR(1.11,DIARC,"D",0)="^1.113^"_DILC_U_DILC Q
 S DIWL=1,DIWR=IOM-1,DIWF="NW"
 F D1=0:0 S D1=$O(^UTILITY("DIFG",$J,D1)) Q:D1'>0  S X=^(D1,0) D ^DIWP Q:'DN
 D:DN ^DIWW G Q
WR F D1=0:0 S D1=$O(^DIAR(1.11,DIARC,"D",D1)) Q:D1'>0  S X=^(D1,0) W X
 G Q
