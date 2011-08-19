DIL11 ;SFISC/GFT-TURN PRINT FLDS INTO CODE ;5APR2007
 ;;22.0;VA FileMan;**152**;Mar 30, 1999;Build 10
 ;Per VHA Directive 2004-038, this routine should not be modified.
DOWN ;
 I W>0,'$D(^DD(DP,+W,0)) Q  ;IN CASE FIELD IS GONE FOR SOME REASON!
 S DN=-6,DY(DM)=DY,DP(DM)=DP,DI(DM)=DI G F:W'>0 S X=^DD(DP,+W,0),DU=$P($P(X,U,4),";") S:+DU'=DU DU=""""_DU_""""
 S W=$P(W,","),DY="D"_(DIL-DIL0+1),DI=DI_","_DU_","_DY,%=":0 Q:$O("_DI_"))'>0 ",DP=+$P(X,U,2),M(DP)=1,D=$P("""""",U,+DU'=DU),D=" S I("_(DIL+1)_")="_D_DU_D_",J("_(DIL+1)_")="_DP,Y=" S "_DY_"=$O(^("_DY_"))"
W I $P(^DD(DP,.01,0),U,2)["W" D:$P(^(0),U,2)["x"!($P(^(0),U,2)["X")  G P ;**DI*22*152**
 .S D=D_",D"_(DIL+1)_"=$G(DIWF) N DIWF S DIWF=D"_(DIL+1)_"_""X"""
 I DHT+1 F X=1:1 G P:X>DPP,DPP:+DPP(X)=DP!$D(DPP(X,DP))
DPP S %=%_" X:$D(DSC("_DP_")) DSC("_DP_")",Y=Y_" Q:"_DY_"'>0" I $T,"@"[$P(DPP(X),U,4),$P(DPP(X),U,2)=0 S DPP(X,U)="" G R:$D(DPP(X,"F"))
 S Y=Y_" "
P S Y=D_" F "_DY_"=0"_%_Y_$S($D(DIARP(DP)):" X DIARP("_DP_") I $T",1:"")
 G S
R S V=$P(DPP(X,"T"),U),Y=D_" F "_DY_"="_$P(DPP(X,"F"),U)_%_Y_$S(V:"!("_DY_">"_V_") ",1:" ")
S S:($G(DDXP)'=4) %=" D:$X>"_DG,Y=Y_%_$S($D(DIWR):" NX^DIWW",1:" T Q:'DN ") I DHT>0 S ^UTILITY($J,DV)="I "_DY_"'>0 S "_DY_"=0 "_$P(Y,"  ",2,9),DV=DV+1
 G D^DIL
 ;
F ;
 S DP=-W,X=$P(W,U,2),DD=DD+1,M(DP)=1,DIL(DM)=DIL,DIL(DM,0)=DIL0,Y=0,DIL0=DIL0+100,%=X["(" I % S (X,DI)=U_X,DIL=DIL0
 E  S DI=DI(DM)_","""_X_""",",DIL=DIL+101
QT S Y=$F(X,"""",Y) I Y S X=$E(X,1,Y-1)_$E(X,Y-1,999),Y=Y+1 G QT
 S Y=" S I("_DIL_")="""_X_""",J("_DIL_")="_DP
 S X=" "_$P($P(W,U,4,99),";")
 S DY="D"_(DIL-DIL0),DI=DI_DY,DIL=DIL-1 I $P(W,U,3)="" S W=+W,Y=Y_X_" S D0=D(0) I D0>0" G D^DIL
 S %="I("_(DIL0-100)_",0)=D0" I X'[% S X=","_%_X
 I DHT=-1 D DREL^DIPZ1 G END
 F %=900:1 I '$D(^UTILITY($J,99,%)) S ^(%)="I 1 X:$D(DSC("_DP_")) DSC("_DP_") I  D T:$X>"_DG_" Q:'DN "_Y,Y=" S (DIXX,DIXX("_(DM+1)_"))="_%_X,W=+W D D^DIL K R(DX) Q
END S (F(DM-1),DX)=%,R(%)=DP(DM-1),R(%,1)=M(DP(DM-1))
 Q
