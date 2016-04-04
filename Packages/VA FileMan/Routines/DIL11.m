DIL11 ;SFISC/GFT-TURN PRINT FLDS INTO CODE ;16OCT2009
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**152,1037**
 ;
DOWN ;INTO A MULTIPLE
 I W>0,'$D(^DD(DP,+W,0)) Q  ;IN CASE FIELD IS NOW GONE FOR SOME REASON!
 S DN=-6,DY(DM)=DY,DP(DM)=DP,DI(DM)=DI I W>0 D M G D^DIL
F ;
 S DP=-W,X=$P(W,U,2),DD=DD+1,M(DP)=1,DIL(DM)=DIL,DIL(DM,0)=DIL0,Y=0,DIL0=DIL0+100,%=X["(" I % S (X,DI)=U_X,DIL=DIL0
 E  S DI=DI(DM)_","""_X_""",",DIL=DIL+101
QT S Y=$F(X,"""",Y) I Y S X=$E(X,1,Y-1)_$E(X,Y-1,999),Y=Y+1 G QT
 S Y=" S I("_DIL_")="""_X_""",J("_DIL_")="_DP
 S X=" "_$P($P(W,U,4,99),";")
 S DY="D"_(DIL-DIL0),DI=DI_DY,DIL=DIL-1 I $P(W,U,3)="" S W=+W,Y=Y_X_" S D0=D(0) I D0>0" G D^DIL
 S %="I("_(DIL0-100)_",0)=D0" I X'[% S X=","_%_X
 I DHT=-1 D DREL^DIPZ1 G END ;WE'RE COMPILING A PRINT TEMPLATE
 F %=900:1 I '$D(^UTILITY($J,99,%)) S ^(%)="I 1 X:$D(DSC("_DP_")) DSC("_DP_") I  D T:$X>"_DG_" Q:'DN "_Y,Y=" S (DIXX,DIXX("_(DM+1)_"))="_%_X,W=+W D D^DIL K R(DX) Q
END S (F(DM-1),DX)=%,R(%)=DP(DM-1),R(%,1)=M(DP(DM-1))
 Q
 ;
 ;
M N %,DILEVEL,DIB1,DIBO,D,DY,X ;BUILD A "Y" STRING
 S DILEVEL=DIL-DIL0+1
 S X=^DD(DP,+W,0),DU=$P($P(X,U,4),";") S:+DU'=DU DU=""""_DU_""""
 S DI=DI_","_DU_",",DY="D"_DILEVEL
B I W'[";B" S %=":0 Q:$O("_DI_DY_"))'>0 ",DIB1=""
 E  S DIB1="DIB"_DIL,DIBO="$O("_DI_"""B"","_DIB1,DIB1=" N "_DIB1_" S "_DIB1_"="""" F  S "_DIB1_"="_DIBO_")) Q:"_DIB1_"=""""  Q:'DN  ",%=":0 Q:"_DIBO_","_DY_"))'>0 "
 S DI=DI_DY
 S DP=+$P(X,U,2),M(DP)=1,D=$P("""""",U,+DU'=DU),D=" S I("_(DIL+1)_")="_D_DU_D_",J("_(DIL+1)_")="_DP_DIB1,Y=" S "_DY_"=$O(^("_DY_"))"
 ;
W S W=$P(W,",") I $P(^DD(DP,.01,0),U,2)["W" D:$P(^(0),U,2)["x"!($P(^(0),U,2)["X")  G P ;**DI*22*152**
 .S D=D_",D"_(DIL+1)_"=$G(DIWF) N DIWF S DIWF=D"_(DIL+1)_"_""X"""
 I DHT+1 F X=1:1 G P:X>DPP,DPP:+DPP(X)=DP!$D(DPP(X,DP))
DPP S Y=Y_" Q:"_DY_"'>0 "
 I DIB1="" S Y=" X $G(DSC("_DP_")) "_Y ;DSC will switch the naked reference, so we can get thru the subentries faster!
 I DIB1]"" S Y=Y_" I 1 X $G(DSC("_DP_")) I " ;DSC will do an IF
 I DHT+1,"@"[$P(DPP(X),U,4),$P(DPP(X),U,2)=0 S DPP(X,U)="" G R:$D(DPP(X,"F"))
 S Y=Y_" "
P S Y=D_" F "_DY_"=0"_%_Y_$S($D(DIARP(DP)):" X DIARP("_DP_") I $T",1:"")
 G S
R S V=$P(DPP(X,"T"),U),Y=D_" F "_DY_"="_$P(DPP(X,"F"),U)_%_Y_$S(V:"!("_DY_">"_V_") ",1:" ") ;RANGE FROM AND TO SORTING BY SUB-IEN
S S:($G(DDXP)'=4) %=" D:$X>"_DG,Y=Y_%_$S($D(DIWR):" NX^DIWW",1:" T Q:'DN ") ;ADD A LINE FEED UNLESS WE ARE 'EXPORTING'
 I DHT>0 S ^UTILITY($J,DV)="I "_DY_"'>0 S "_DY_"=0 "_$P(Y,"  ",2,99),DV=DV+1 ;HEADER TEMPLATE
 Q
