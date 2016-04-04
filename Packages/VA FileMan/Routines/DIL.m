DIL ;SFISC/GFT/XAK-TURN PRINT FLDS INTO CODE ;31DEC2003
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**25,102,119,1003**
 ;
LOOP F DD=1:1 S W=$P(R,$C(126),DD) G Q:W="" S:DIWL DIWL=9 D DM I DIO D  S DIO=0
 .S DN=-8 Q:DIO=1
 .I DIO=3 D UN
 .S DIWR(DM)=DX,Y=" D 0^DIWW" D PX
 ;
DM I DM G UP:$P(W,F)]"" S W=$P(W,F,2,999)
 I W[";Y" S DE="" D W:DG S I=+$P(W,";Y",2),DG=0,Y=DE_" F Y=0:0 Q:$Y>"_$S(I>0:I-2,1:"(IOSL"_(I-2)_")")_"  W !" S:I>0 M(DP)=I D PX S O=999
 G ^DIL1:'W,^DIL11:W?.NP1",".E,^DIL1:$P(W,";",1)'=+W K DPQ(DP,+W)
 D DE,^DIL0 G T:DU=DN I $P(X,U,2)["C" S DN=-2 G PX
 S DN=DU,Y=" S X=$G("_DI_C_DN_"))"_Y
PX ;
 I DHT G PX^DIPZ1:DHT<0 S ^UTILITY($J,DV)=$E(Y,2,999),Y="",DV=DV+1 Q
 S DX=DX+1 G PX:$D(^UTILITY($J,99,DX)) S ^(DX)=$E(Y,2,999)
 D DX(DX)
 S O=0
Q Q
 ;
DE S DE="" I W[";S" D W:DG S I=+$P(W,";S",2),DG=0 S:'I I=1 S M(DP)=M(DP)+I,DE=DE_" D T Q:'DN " F I=I:-1:1 S DE=DE_" D N"
 I $P(W,";C",2) S DIC=$P(W,";C",2) S:DIC<0 DIC=IOM+DIC+1 D W:DIC<DG S DG=DIC-1 I 1
 I DN=-4!$T S DE=DE_" D N:$X>"_DG_" Q:'DN "
 S DE=DE_" W ?"_DG Q
W ;
 D DIWR^DIL0:$D(DIWR)
A ;FROM DIP5 AND DIPZ & above
 S M(DP)=M(DP)+1 I DHD D COLHEADS(.DHD)
 I $D(DIOSUBHD) S:DIOSUBHD<2 DIOSUBHD=2 D COLHEADS(.DIOSUBHD)
 Q
 ;
 ;
COLHEADS(DHD) ;TAKE COLUMN HEADERS AND STORE THEM AS WRITE STATEMENTS, STARTING AT ^UTILITY($J,DHD)
 N V,I,Z,%
 S I=99,V="" F  S V=$O(^UTILITY("DIL",$J,V)) Q:V=""  S Z=$O(^(V,0)) I I>Z S I=Z
 F I=I:1:99 S Z="W !" D  I Z'="W !" D U
 .S V="" F  S V=$O(^UTILITY("DIL",$J,V)) Q:V=""  I $D(^(V,I)) S %=$G(^($O(^(0))-I+99)) D
 ..F  Q:%'?1" ".E  S V=V+1,%=$E(%,2,999)
 ..I $L(Z)+$L(%)>245 D U
 ..S Z=Z_",?"_V_","""_%_""""
 K ^UTILITY("DIL",$J)
 Q
U S ^UTILITY($J,DHD)=Z,DHD=DHD+1,Z="W """"" Q
 ;
 ;
SUBHEADS ;
 N X
 S X=$$EZBLD^DIALOG(7095) ;"PAGE"
 W:$X+30>IOM !
 W ?IOM-30,$$NOW^DIUTL,"  "
 I $G(DC) W ?IOM-$L(X)-4,X," ",DC
 F X=1.5:0 S X=$O(^UTILITY($J,X)) Q:X>50!'X  X ^(X)
 Q
 ;
D ;
 D PX:DHT<1 S F(DM)=DX,R(DX)=DP(DM),R(DX,1)=M(DP(DM)),F=F_W_",",DM=DM+1,DIL=DIL+1,DD=DD-1 I DHT+1 S DX=$S('DHT:900,1:DX) D:DHT PX Q
 G DE^DIPZ1
 ;
UP D UN G DM
 ;
UNSTACK ;
 D UN Q:'DM  G UNSTACK
 ;
UN ;
 D DIWR^DIL0:$D(DIWR(DM))
 D:DHT<0 UP^DIPZ1 S O=999,DN=-8,DM=DM-1,DIL=DIL-1,DP=DP(DM),DX=+$S(DM:F(DM),1:0),F=$P(F,",",1,DM)_$E(",",DM>0),DY=DY(DM),DI=DI(DM)
 I $D(DIL(DM)) S Y=" K J("_DIL0_"),I("_DIL0_")",DIL=DIL(DM),DIL0=DIL(DM,0) K DIL(DM) F X=DIL0:1 S %=X#100,V="I("_X_",0)",Y=Y_" S:$D("_V_") D"_%_"="_V I X=DIL G PX
 Q
 ;
O ;
 D DE,DN^DIL0
T ;
 G PX:'$D(^UTILITY($J,99,DX))!DIO,PX:$L(^(DX))+$L(Y)+O>240 S ^(DX)=^(DX)_Y Q
 ;
DX(DX) ;If we're in sub-fields, another UTILITY node needs to invoke node DX
 Q:'DM
 N Y
 S Y=F(DM-1) D IF S ^(Y)=^UTILITY($J,99,Y)_$S($T:",^UTILITY($J,99,",1:" X ^UTILITY($J,99,")_DX_")"
 I $T,$L(^UTILITY($J,99,Y))>99 F O=500:1 I '$D(^(O)) S ^(Y)=$E(^(Y),1,$L(^(Y))-1-$L(DX))_O_")",F(DM-1)=O,^(O)="X ^UTILITY($J,99,"_DX_")" Q
 Q
IF I ^UTILITY($J,99,Y)?.E1"^UTILITY($J,99,".N1")"
 Q
