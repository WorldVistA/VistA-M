DIL1 ;SFISC/GFT-STATS, NUMBER FIELD, ON-THE-FLY ;24JAN2013
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**2,999,1003,1004,1012**
 ;
 I $A(W)=34 D  Q
 .N A9
 .S Y="" F A9=0:0 S Y=Y_""""_$P(W,"""",2)_"""",W=$P(W,"""",3,99) Q:$A(W)'=34&($A(W)'=95)  S:$A(W)=95 Y=Y_$C(95),W=$P(W,"_",2,99)
 .S Y=" W "_Y,DLN=0,X="",DRJ=0 D DE^DIL,W^DILL:W[";" I W[";W" D WR Q
 .S %=$L(Y)-5 S:'DLN DLN=% S:DRJ Y=" W ?"_(DG+DLN-%)_Y D DN^DIL0,T^DIL
NUMB S:DN<0 O=999 S X="",DRJ=0 I W?1"0".E D  D T^DIL Q
 .K DPQ(DP,0)
 .S Y="D"_(DIL-DIL0),X=$$LABEL^DIALOGZ(DP,.001)_U_$P($G(^DD(DP,.001,0)),U,2,99) S:X?.P X=$$EZBLD^DIALOG(7099)_"^^^^$L(X)>12" ;**CCO/NI
 .I $D(DCL(DP_U_0)) D DE^DIL,STATS Q
 .D EN^DILL(DP,.001,1),DE^DIL,DN^DIL0
 S DN=$E(W,$L(W)),X=$P(W,";") K DLN I DM,$A(X)=94 S W=F_W G UP^DIL
COMP D  D T^DIL Q
 .N V,DILDATE,DILCUT
 .S DILCUT=0
 .I W[";d" S DILDATE="D"
 .I X?.E1" W X K Y" S DILCUT=8
 .I X?.E1" W X K DIP" S DILCUT=10
 .I X?.E1" D DT K DIP" S DILCUT=11,DILDATE="D"
 .I X?.E1" D DT K Y" S DILCUT=9,DILDATE="D"
 .S X=$E(X,1,$L(X)-DILCUT)_" K DIP K:DN Y"
DITTO .I W[";N" S DCL=DCL+1,X=X_" S X=$$DITTO^DIO2("_DCL_",X)",DITTO(DCL)=""
 .S Y=" "_X,X="^^^^"_X,%=DN,DN=-3
 .I W[";m" D W D  Q
 ..S X="D "_$E("L",W'[";w"&(W'[";W"))_"^DIWP",V=$F(Y,"D ^DIWP")
 ..I V S Y=$E(Y,1,V-8)_X_$E(Y,V,999)
 ..E  S Y=" S DICMX="""_X_""""_Y
 .I DILCUT S V=$G(DILDATE) D CLC^DILL
 .I 'DILCUT D W^DILL
 .S:'$D(DLN) DLN=9
 .I W[";W" D W S Y=Y_" D ^DIWP" Q
 .I "+#&!*"'[% D DE^DIL,DN^DIL0 Q
 .S X="^C"_$G(DILDATE)_"^^^"_$E(Y,2,999),W=-1_";"_$P(W,";",2,9),DCL(DP_U_-1)=%
 .D DE^DIL,STATS
 ;
W D DE^DIL,WR^DIL0 S Y=Y_" "_$E(X,5,999) Q
 ;
WR S D1=" S Y="_$P(Y,"W ",2,999),Y="" D W^DIL0
 F D1=D1," S X=Y D ^DIWP" S:$L(Y)+$L(D1)'>250 Y=Y_D1 I $F(Y,D1)-1'=$L(Y) D PX^DIL S Y=D1
 D T^DIL Q
 ;
STATS ;
 N TYPE
 I DG<10!(DG>900),'$G(DIONOSUB) S DG=10 D DE^DIL I DE'["!" S DE=" W:$X>8 !"_DE ;LEAVE FIRST 8 CHARS ON OUTPUT LINE FOR "SUBTOTAL"
 S TYPE=$P(X,U,2),V=DP_U_+W,I=DCL(V),D=+I I D S DSUM="" G E
 S (D,DCL)=DCL+1,DCL(V)=D_I
 S DXS=$S(I["*":"C",I["#":"S",I["&":"A",I["+":"P",1:1),V=TYPE,%=":Y"_$S(TYPE["C":"'?.""*""",Y["$E":"'?."" """,1:"]""""")
 I DXS S DSUM=" S"_%_" N("_D_")=N("_D_")+1",N(D)=0 G E
 G @DXS
 ;
C S CP(D)=""
S S Q(D)=0,L(D)=9999999999,H(D)=-L(D) I $P(TYPE,"I",2) S DLN=+$P(TYPE,"I",2)
P S N(D)=0
A S (S(D),DRJ)=0
 S DSUM=",C="_D_" D "_DXS_%
E I TYPE["C" D
 .D EN^DILL(DP,+W) S Y=Y_" S Y=X"_DSUM,DXS=$S($D(^DD(DP,+W,9.02)):^(9.02),1:0)
 E  S DXS=DSUM,Y=" S Y="_Y_DXS,I="",DXS="Y" D EN^DILL(DP,+W)
UTIL K DSUM S ^UTILITY($J,"T",DG)=DLN_U_D_U_DRJ_U_$P(X,U,2)_U_I
 D  D DN^DIL0 Q
 .I DXS?1E Q
 .S ^(DG)=^UTILITY($J,"T",DG)_U_DXS,DN=^DD(DP,+W,9.01)
 .I '$D(DNP) S V=$L(Y)+$L(DE) S:V<250 Y=DE_Y I V>249 S V=Y,Y=DE D PX^DIL S Y=V
 .S DE=X,V=DLN N X,DLN,DNP S X=DE,DLN=V,DNP="" ;'Do Not Print' hidden fields
LOOP .F  S DE="",V=$P(DN,";"),W=$P(V,U,2),DN=$P(DN,";",2,99) Q:V=""  D:'$D(DCL(V))
 ..D PX^DIL,XDUY^DIL0,EN^DILL(DP,W,1)
 ..I $P(X,U,2)'["C" S Y=",X=$G("_DI_C_DU_"))"_$P(",Y=",U,Y'[" S Y=")_Y
 ..E  S Y=Y_" S Y=X"
 ..S (D,DCL)=DCL+1,S(D)=0,DCL(DP_U_+W)=D,Y=" S C="_D_Y_" D A"
