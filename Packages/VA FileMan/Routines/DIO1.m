DIO1 ;SFISC/GFT,TKW-BUILD P-ARRAY (OR LINES IN COMPILED SORT) WHICH CREATES SORTED DATA ;20MAR2005
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**2,97,113,144**
 ;
 F DJ=0:1:7 F DX=-1:0 S DX=$O(Y(DJ,DX)) Q:DX=""  F DPR=-1:0 S DPR=$O(Y(DJ,DX,DPR)) D  Q:DPR=""
 .I DPR="" D:$D(DIBTPGM) SETU("Q") Q
 .S X=0
A .F  S X=$O(Y(DJ,DX,DPR,X)) Q:X=""  D
B ..N DL,DIF,W,DICOND,Z,%,BACKWARD
 ..S DL=Y(DJ,DX,DPR,X),W="DISX("_DL_")",DICOND="=""""",D2="" I $P(DPP(DL),U,4)["-" S BACKWARD="-"
 ..I 'X,DL>$G(DPP(0)) S:'$D(DPP(DL,"CM")) W=$G(BACKWARD)_"D"_V(DX),DICOND="<0"
 ..I X S Z=$P($P(^DD(DX,+X,0),U,4),";",2) S:$E(Z)="E" DICOND="?."" """
 ..S Z="" S:$C(63,122)=$P($G(DPP(DL,"F")),U) Z=1 S:$P($G(DPP(DL,"T")),U)="@" Z=Z+2 ;From NULL:Z=1  To NULL:Z=2   Both:Z=3
 ..S DIF=$S($D(BACKWARD):BACKWARD,$P(DPP(DL),U,10)=2:"+",1:"")_$S($D(DE(DL)):"$E("_W_",1,"_DE(DL)_")",1:W) ;DE array was set in ^DIOS
 ..I Z S DIF="$S("_W_"'"_DICOND_":"_DIF_",1:""  EMPTY"")"
 ..S J(DL)=W
 ..I Z=3 S J(DL)=""" """ K DIF ;if just looking for NULLs
 ..I $P(DPP(DL),U,4)["'" S J(DL)=1 K DIF ;if Sort Value doesn't matter
 ..S P(DX)=$S($D(P(DX)):P(DX)_" ",1:"")
 ..S Y=$S(W?1"DISX(".E:"S "_W_"="""" ",1:"")_DPP(DL,"GET")
 ..S DICOND=$G(DPP(DL,"QCON")) I DL=DJK&$D(DPP(DL,"IX"))!(DICOND="") S DICOND="I "_W_"]"""""
SORTVAL ..I $D(DIF),DIF'=W S DICOND=DICOND_" S DISX("_DL_")="_DIF
 ..S Y=Y_" ",DIF="" D  S Y=DICOND,DIF="I  " D
 ...I $D(DIBTPGM) D SETU(Y) D:DIF]"" SETU("Q:'$T") Q
 ...I DPP>2!($L(P(DX))+$L(Y)>125) S Z=$O(P(DX,""),-1)+1,P(DX,Z)=Y,P(DX)=P(DX)_"X P("_DX_","_Z_") "_DIF Q
 ...S P(DX)=P(DX)_Y
BX ..S Y=DX Q
UTILITY K W S W="",Z=" S:$T ^UTILITY($J,0" F X=1:1:DPP S Z=Z_","_$G(J(X),1)
SUB F V=1:1:DPP I V=DPP&(W="")!(DPP(V)-DP) S F=",",Y=DP,%=1,X=0 D  S W=W_Z_F_")="""""
U .S:$D(D(Y)) X=X_D(Y) S %=%+1,Y=$P(Z(V),",",%),D=Y="",F=$S(F'=",":F_",D"_X,D:",D"_X,1:",D"_X_","_V) I 'D S X=V(Y) G U
 .I $L(W)+$L(Z)+$L(F)+$L(DX(DPQ))+$S(V(DPQ):38,1:0)>237 D
 ..I '$D(DIBTPGM) S DIOVFL(V)=$E(W,2,999),W=" X DIOVFL("_V_")" Q
 ..S %=W,(%(1),%(2))="OV",W=" D OV"_DICOV D SETU^DIOS
DX F X=-1:0 S X=$O(DX(X)),DX=X Q:X=""  D
 .N A,B S A=""
 .I $D(DIBTPGM) S B=+$O(^TMP("DIBTC",$J,X,0)),A=$G(^(B))
 .S:A="" A=DX(X)
 .S:X=DPQ A=A_W_$P(",DJ=DJ+1",U,$D(DIS)>9)
 .I V(X) S F="",%(0)=DX,%=DCC S:$D(DXIX(DX)) F=DXIX(DX) D:F="" GREF^DIOU(.V,.%,.F) S A=A_" "_"S D"_V(X)_"=$O("_F_")) Q:D"_V(X)_"'>0"
 .S DX(X)=A Q:'$D(DIBTPGM)
 .S:B ^TMP("DIBTC",$J,X,B)=A S DX(X)="D "_$P(A," ")
0 S DX(0)=DX(DP),DX=0,DPQ=0 K:DP DX(DP)
 ;
2 K D,%,I D 2^DIO D  I $G(DIERR) G IXK^DIO
 .I $G(DIERR),$D(^UTILITY($J,0))>0 D CLEAN^DILF
 K DIOVFL,P,V,Y,D0,D1,D2,D3 K:'$D(DIB) DIS S:$D(DIBTPGM) DIBTPGM=""
DIOO1 S V="I $D(^UTILITY($J,0" K DPP(0,"F"),DPP(0,"T") F X=1:1:DPP K DPP(X,"F"),DPP(X,"T") S V=V_",DIOO"_(DPP-X+1)
 F X=-1:0 S X=$O(DX(X)) Q:X=""  I $D(DX(X,U)) S DSC(X)=V_DX(X,U)_$S($D(DSC(X)):" "_DSC(X),1:"")
 K DX S DX=^UTILITY($J,"DX"),DJ=^("F"),%=$O(^("DX",-1)) S:%="" %=-1 F %=%:0 S DX(%)=^(%),%=$O(^(%)) I %="" G GO^DIO
 ;
SETU(%) Q:%=""  N A
 S A=$G(DICP(DX)) I A S A="P"_A
 S ^TMP("DIBTC",$J,"P",DICNT)=A_" "_%
 K DICP(DX) S DICNT=DICNT+1
 Q
