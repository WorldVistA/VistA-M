DIS2 ;SFISC/GFT-SEARCH, TEMPLATES & COMPUTED FIELDS;4JUN2005
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**6,144**
 ;
 K DISV G G:'DUZ
0 D  K DIRUT,DIROUT I $D(DTOUT)!($D(DUOUT)) G Q
 . N DIS,DIS0,DA,DC,DE,DJ,DL D S3^DIBT1 Q
 I X="" G G:'$D(DIAR)
 I Y<0 G Q:X=U,0
 I $D(DIARU),DIARU-Y=0 W $C(7),!,"Archivers must not store results in the default template" G 0
 S (DIARI,DISV)=+Y,A=$D(^DIBT(DISV,"DL")) S:$D(DIS0)#2 ^("DL")=DIS0 S:$D(DA)#2 ^("DA")=DA S:$D(DJ)#2 ^("DJ")=DJ
 I $D(DIAR),'$D(DIARU) S $P(^DIAR(1.11,DIARC,0),U,3)=DISV
 S Z=-1,DIS0="^DIBT(+Y," F P="DIS","DA","DC","DE","DJ","DL" S %Y=DIS0_""""_P_""",",%X=P_"(" D %XY^%RCR
 S %X="^UTILITY($J,",%Y="^DIBT(DISV,""O"",",@(%X_"0)=U") D %XY^%RCR
G N DISTXT S %X="^UTILITY($J,",%Y="DISTXT(" D %XY^%RCR
 W ! S Y=DI D Q S DIC=Y G EN1^DIP:$D(SF)!$D(L)&'$D(DIAR),EN^DIP
 ;
TEM ;
 K DIC S X=$P($E(X,2,99),"]",1),DIC="^DIBT(",DIC(0)="EQ",DIC("S")="I "_$S($D(DIAR):"$P(^(0),U,8)",1:"'$P(^(0),U,8)")_",$P(^(0),U,4)=DK,$P(^(0),U,5)=DUZ!'$P(^(0),U,5),$D(^(""DIS""))"
 S DIC("W")="X ""F %=1:1 Q:'$D(^DIBT(Y,""""O"""",%,0))  W !?9 S I=^(0) W:$L(I)+$X>79 !?9 W I"""
 D ^DIC K DIC G F^DIS:Y<0
 S P="DIS",Z=-1,%X="^DIBT(+Y,P,",%Y="DIS(" D %XY^%RCR
 S %Y="^UTILITY($J,",P="O" D %XY^%RCR
 G DIS2
 ;
COMP ;
 S E=X,DICMX="X DIS(DIXX)",DICOMP=N_"?",DQI="Y(",DA="DIS("""_$C(DC+64)_DL_"""," I $D(O(DC))[0 S O(DC)=X
 G COLON:X?.E1":"
 I X?.E1":.01",$D(O(DC))[0 S O(DC)=$E(X,1,$L(X)-4)
 D EN^DICOMP,XA G X:'$D(X),X:Y["m" ;I Y["m" S X=E_":" G COMP
 S DA(DC)=X,DU=-DC,E=$E("B",Y["B")_$E("D",Y["D") I Y["p" S E="p"_+$P(Y,"p",2)
 G G^DIS
 ;
XA S %=0 F  S %=$O(X(%)) Q:%=""  S @(DA_%_")")=X(%)
 S %=-1 Q
 ;
COLON D ^DICOMPW,XA G X:'$D(X)
 S R(DL)=R,N(DL)=N,N=+Y,DY=DY+1,DV(DL)=DV,DL(DL)=DK,DL=DL+1,DV=DV_-DY_C,DY(DY)=DP_U_$S(Y["m":DC_"."_DL,1:"")_U_X,R=U_$P(DP,U,2)
 K X G R^DIS
 ;
Q ;
 K DIC,DA,DX,O,D,DC,DI,DK,DL,DQ,DU,DV,E,DE,DJ,N,P,Z,R,DY,DTOUT,DIRUT,DUOUT,DIROUT,^UTILITY($J)
 Q
 ;
X K O(DC) G X^DIS
 ;
DIS ;PUT SET LOGIC INTO DIS FOR SUBFILE
 S %X="" F %Y=1:1 S %X=$O(DIS(%X)) Q:'%X  S %=$S($D(DIAR(DIARF,%X)):DIAR(DIARF,%X),1:DIS(%X)) S:%["X DIS(" %=$P(%,"X DIS(")_"X DIFG("_DIARF_","_$P(%,"X DIS(",2) S ^DIAR(1.11,DIARC,"S",%Y,0)=%X,^(1)=%
 S:%Y>1 %Y=%Y-1,^DIAR(1.11,DIARC,"S",0)="^1.1132^"_%Y_U_%Y G DIS2
