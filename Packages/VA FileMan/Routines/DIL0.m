DIL0 ;SFISC/GFT-TURN PRINT FLDS INTO CODE ;24JAN2013
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**91,102,999,1005,1012**
 ;
 D XDUY S %=$P(X,U,2) S:%["Cm"&(W[";W") %="w"_% G WP:%["W",M:%["m",STATS^DIL1:$D(DCL(DP_U_+W)),N:W[";N"
 I W[";W" D  S D1=$S(%["C":Y,1:$P(" S Y=",U,Y'?1" ".E)_Y_" S X=Y") D W S Y=Y_D1_" D ^DIWP" Q
 .N %,DNP S DNP=1 D EN^DILL(DP,+W,1)
 D EN^DILL(DP,+W,1)
DN ;
 I W[";X" D  Q
 .S DE=$S(W[";C"!(W[";S"):DE,$A(Y)-32:" W ?0",1:"")
 .I $L(DE)+$L(Y)>250 D
 ..S %=Y,Y=DE,DE=% D PX^DIL S Y=DE
 .E  S Y=DE_Y
 .I $D(DIWR(DM)) D DIWR
DNW D H:DHD!$G(DIOSUBHD) I DG+DLN>IOM,DG K ^UTILITY("DIL",$J,DG) S DG='%*DM*2+2,DE=$P(W,";C",2),DG=$S(DE>0:DE-1,DE<0:IOM+DE,DG+DLN'>IOM!(W[";W"):DG,DLN>IOM:0,1:IOM-DLN),DE=" D T Q:'DN  W ?"_DG D W^DIL,H:DHD!$G(DIOSUBHD)
 S DG=2+DLN+DG Q:$D(DNP)  I $L(DE)+$L(Y)>250 S %=Y,Y=DE,DE=% D PX^DIL S Y=DE Q
 S Y=DE_Y Q
 ;
H S V=$P(X,U),Z=99,I=$P(W,";""",2) I I]"" S V=$$CONVQQ^DILIBF($P(I,"""",1,$L(I,"""")-1))
HEAD Q:V=""  S I=$P(V," ") I $L(I)>DLN S DLN=$L(I) ;Column width may have to be increased for a long word
XD S V=$P(V," ",2,99),D=$P(V," ") I D]"",$L(I)+$L(D)<DLN S I=I_" "_D G XD
 S ^UTILITY("DIL",$J,DG,Z)=$J(I,DRJ*DLN),V(Z)="",Z=Z-1 G HEAD
 ;
XDUY ;
 I '$D(^DD(DP,+W,0)) S X="",DU=0,Y=0 Q
 S X=^(0),DU=$P(X,U,4),Y=$P(DU,";",2),DU=$P(DU,";") I W[";T",$D(^(.1)) S X=^(.1)_U_$P(X,U,2,99)
EGP E  S $P(X,U)=$$LABEL^DIALOGZ(DP,+W) ;**FIELD LABEL FOR OUTPUT HEADING
 S:+DU'=DU DU=""""_DU_""""
 I Y S Y="$P(X,U,"_Y_")" Q
 I Y="" S Y="D"_DM Q
 S Y=$E(Y,2,9) S:$P(Y,",",2)=+Y Y=+Y S Y="$E(X,"_Y_")" Q
 ;
WR ;
 K DLN D W^DILL
W S DRJ=0,DIWL=DIWL+1 I '$D(DLN) S %=IOM-DG,DLN=$S(%>20:%,1:IOM)-2
 S:W[";X" $P(X,U)="" D DNW S %=$P(DE,"W ?",2)+1,Y=DLN+%-1,DIO=2,%=" S DIWL="_%_",DIWR="_$S(IOM<Y:IOM,1:Y),Y=$P(DE," W ?")_% Q
 ;
WP S DN=%["L"_U D WR ;COME HERE FOR A W-P TYPE FIELD
 S DIO=3,Y=%_" D ^DIWP",X=F(DM-1) I DHT<0 S I=$E(^UTILITY("DIPZ",$J,X),2,999) D WPX S ^UTILITY("DIPZ",$J,X)=" "_I Q
 I $D(^UTILITY($J,99,X)) S I=^(X) D WPX S ^UTILITY($J,99,X)=I Q
WPX ;from DIPZ1
 S:DN I=^DD("FUNC",38,1)_" "_I ;'NOWRAP' FUNCTION
 I DE]"" S I=DE_" "_I ;GFT
 Q
 ;
M S D1=" S DICMX=""D "_$E("L",%'["w")_"^DIWP"" "_$P(X,U,5,99) D WR S Y=Y_D1 Q
 ;
N ;
 S DCL=DCL+1,DXS="Y",D=",Y=$$DITTO^DIO2("_DCL_",Y)",DITTO(DCL)="",I=""
 I %["C" S X=X_" S Y=X"_D_" S X=Y" G Z
 S Y=" S Y="_Y_D
Z D EN^DILL(DP,+W) G DN
 ;
DIWR ;
 G DIWR^DIPZ1:DHT I $D(DIWR(DM)),DX=DIWR(DM) S ^UTILITY($J,99,DX)="D A^DIWW" G K
 I $D(DIWR(DM)) F DX=DX+1:1 I '$D(^UTILITY($J,99,DX)) S ^(DX)="D ^DIWW" D DX^DIL(DX) G K
 D  S ^(I)="D ^DIWW "_^UTILITY($J,99,I)
 .F I=DM-1:-1:0 I $D(DIWR(I)) K DIWR(I) Q
 .I I S I=F(I)
 .E  F I=1:1 Q:'$D(^UTILITY($J,99,I+1))
K K DIWR(DM) Q
