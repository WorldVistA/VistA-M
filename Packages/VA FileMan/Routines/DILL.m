DILL ;SFISC/GFT-TURN PRINT FLDS INTO CODE ;2015-01-03  1:08 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**25,76,127,1004,1005**
 ;
EN(DILLFILE,DILLFLD,DXSET) ; Entry Point
 S:$G(DXSET) DXS=1
V ;
 S V=$P(X,U,2),DRJ=$F(V,"P") I V["O",$D(^DD(DILLFILE,DILLFLD,2)) S Y=Y_" "_^(2),DIO=1,D1="",DLN=30,DRJ=0 D SY G J
 G CLC:V["C",D:'DRJ S V=+$E(V,DRJ,99),D1=$P(X,U,3) I 'V S DRJ=0,@("V=$D(^"_D1_"0))") G D:'V S V=+$P(^(0),U,2)
POINTR D Y S Y=Y_" S Y=$S(Y="""":Y,$D(^"_D1_"Y,0))#2:$P(^(0),U),1:Y)" I $D(^DD(V,.01,0)) S X=$P(X,U)_U_$P(^(0),U,2,9) G V
D I V["V" D Y S Y=$P(Y," S Y=$S(Y="""":Y,$D(^")_" S C=$P(^DD("_DP_","_+W_",0),U,2) D Y^DIQ:Y S C="","""
 I V["D" S DLN=$P($P(X,"%DT=""",2),"""",1),DLN=$S(DLN["S":21,DLN["T":18,1:11) D W S D1=" D DT" S:DLN>11&DRJ D1=" W ?("_DLN_"-$S(Y#1:18,1:11)+$X)"_D1 S:W[";W" Y=Y_" X ^DD(""DD"") S:Y[""@"" Y=$P(Y,""@"")_""  ""_$P(Y,""@"",2)" G SY
 I $P(X,"X>",2) S DLN=$L(+$P(X,"X>",2))+3,DRJ=1 G J
 S DLN=+$P(X,"$L(X)>",2) I 'DLN S D1=$P($P(X,U,4),";",2) I D1?1"E"1N.N1","1N.N S DLN=$P(D1,",",2)-D1+1
FJ I V'["S" S I=+$P(V,"J",2) S:V["F"&I DLN=I S:'DLN DLN=30 G J
 D W N D1,D2,D3 S D1=$P(X,U,3)
S I D1]"",W[";W"!'$D(DNP) S D2=$P(D1,";"),D1=$P(D1,";",2,99),D3=$P(D2,":"),D2=$P(D2,":",2) S:$L(D2)>DLN&'$P(W,";L",2)&'$P(W,";R",2) DLN=$L(D2) G S
SET S D1="$$SET^DIQ("_DILLFILE_","_DILLFLD_",Y)" S D1=$S(DRJ:"$J("_D1_","_DLN_")",DLN:"$E("_D1_",1,"_DLN_")",1:D1) S:W[";W" Y=Y_" S:Y]"""" Y="_D1 S:W'[";W" D1=" W:Y]"""" "_D1
SY D Y S Y=Y_$S($D(DNP):"",1:D1) K D1 Q
 ;
Y I DXS S Y=" S Y="_Y,DXS="Y"
Q Q
 ;
W ;
 F I=";W",";L" I W[I S DRJ=0 S:$P(W,I,2)?1N.E DLN=+$P(W,I,2),I="" G Q
 I $P(X,U,2)["J",$P(X,U,2)'["F" S I=$P($P(X,U,2),"J",2),W=W_";R"_$P(I+1,U,I>0) I $P(X,U,2)'["O",I["," S W=W_";D"_+$P(I,",",2)
 I W[";R" S DRJ=1 S:$P(W,";R",2) DLN=+$P(W,";R",2)
 S I=$P($P(W,";D",2),";",1) S:I]"" DRJ=1,I=","_+I Q
 ;
CLC ;
 S Y=" "_$P(X,U,5,99),DXS="X" I V["D" S Y=Y_" S Y=X" G D
 I V["p" S V=$P(V,"p",2),D1=$P($G(^DIC(+V,0,"GL")),U,2) I D1]"" S Y=Y_" S Y=X",DXS="Y" G POINTR ;computed pointer
 I V?.E1"J"1N.E,W'[";X",W'[";R",V'["," S W=W_";L"_+$P(V,"J",2)
J D W Q:V["m"!$D(DNP)  I '$D(DLN) S Y=Y_" W X" Q
 I 'DLN S DLN=$S(V["B":1,W[";L0":0,1:8)
 S D2="" I 'DRJ S V="E(",D3="1,"_DLN
 E  S V="J(",D3=DLN_I I I]"" D Y S D2=":Y]""""" I DXS="X" S D2=":X'?.""*"""
 S Y=$S(DXS:",$"_V_Y,1:Y_" W"_D2_" $"_V_DXS)_","_D3_")" I $P(X,U,2)["C",$L(Y)<225 S Y=Y_" K Y("_DP_","_+W_")"
 I $G(DDXP)=4 S Y=$$DJTOPY^DDXP4(Y)
K K D2,D3 Q
