DITR ;SFISC/GFT-FIND FLDS TO XRF ;8SEP2011
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**41,168**
 ;
 N DITRCNT
LOOP S (DFL,DTL)=DFL-1 Q:'$D(DFN(DFL))
N S @("DFN(DFL)=$O("_DFR(DFL)_"DFN(DFL)))")
 I DFN(DFL)]"",$D(^(DFN(DFL)))#2 S Z=^(DFN(DFL)),A="" D:$G(DIFRFRV) SFRV1 G NS
 G LOOP:DFN(DFL)="",1:DFL#2,LOOP:$D(^(DFN(DFL),0))-1 S Z=^(0),X="D"_(DFL\2),@X=DFN(DFL) I DTO,$D(DSC(DDF(DFL+1))) X DSC(DDF(DFL+1)) E  G N
 I $P(^DD(DDT(DTL),.01,0),U,2)["W" D ^DITR1 G N
 D ^DITR1 I A D:$G(DIFRSA)]"" ERR G N
 I $G(DIFRSA)]"",'DKP,@("$D("_DTO(DTL)_"Y))") D KILLIDX
 D D,SFRV1:$G(DIFRFRV)
NS S A=$O(^DD(DDF(DFL),"GL",DFN(DFL),A)) G N:A=""
 S W=$O(^(A,0)) S:W="" W=-1 G:$G(DIFRDKP) NS:$D(@DIFRSA@("^DD",DIFRFILE,DDF(DFL),W)) I A S Y=$P(Z,U,A) G NS:Y=""
 E  S Y=$E(Z,+$E(A,2,9),$P(A,",",2)) F %=$L(Y):-1 Q:" "'[$E(Y,%)  G NS:'% S Y=$E(Y,1,%-1)
 I DTO G NS:'$D(^UTILITY("DITR",$J,DDF(DFL),W)) S B=^(W),DTN(DTL)=$P(B,U,2)
 E  S B=A,DTN(DTL)=DFN(DFL)
 S X="" I @("$D("_DTO(DTL)_"DTN(DTL)))#2") S X=^(DTN(DTL))
 I 'B D  G NS
 .S W=$E(B,2,9),B=$P(B,",",2)
 .I $E(X,+W,B)'?." "&DKP D:$G(DIFRFRV) KFRV1 Q
 .S %=$E(X,B+1,999),V=W-$L(X)-1,^(DTN(DTL))=$E(X,0,W-1)_$J("",$S(V>0:V,1:0))_Y S:%'?." " ^(DTN(DTL))=^(DTN(DTL))_$J("",B+1-W-$L(Y))_%
 .I $G(DIFRFRV) D SFRVL
 .Q
 I DKP,$P(X,U,B)]"" D:$G(DIFRFRV) KFRV1 G NS
P S $P(^(DTN(DTL)),U,B)=Y D:$G(DIFRFRV) SFRVL G NS
 ;
1 G N:$O(^(DFN(DFL),0))'>0 S Z=$O(^DD(DDF(DFL),"GL",DFN(DFL),0,0)) G N:Z'>0 I DTO G N:'$D(^UTILITY("DITR",$J,DDF(DFL),Z)) S B=^(Z)
 D D S Y=$P(^DD(DDF(DFL-1),Z,0),U,2),DDF(DFL+1)=+Y I DTO S Y=$P(B,U,3),X=""""_$P(B,U,2)_""","
 S DDT(DTL)=+Y,DTO(DTL)=DTO(DTL-1)_X S:$G(DIFRDKP) DIFRX=$D(@DIFRSA@("^DD",DIFRFILE,+Y)) I @("'$D("_DTO(DTL)_"0))") G:$G(DIFRDKP) LOOP:DIFRX S ^(0)=U_Y
 G N
 ;
SFRV1 S DIFRFRV1=$P($NA(@("DIFRFRV(D0,"_$P(DFR(DFL),DFR(1),2,255)_""""_DFN(DFL)_""")")),"DIFRFRV(",2,255),$E(DIFRFRV1,$L(DIFRFRV1))=""
 Q
SFRVL Q:'$D(@DIFRSA@("FRV1",DIFRFILE,DIFRFRV1))
 S @DIFRSA@("FRVL",DIFRFILE,DIFRFRV1)=$NA(@(DTO(DTL)_""""_DFN(DFL)_""")"))
 Q
KFRV1 K @DIFRSA@("FRV1",DIFRFILE,DIFRFRV1,B)
 Q
 ;
D S DTL=DFL+1
 S X=""""_DFN(DFL)_""",",DFR(DFL+1)=DFR(DFL)_X,DFL=DFL+1,DFN(DFL)=0 Q
 ;
F ;
 S A=1,@("Z="_DIK_"D0,0)") W !,$P(^(0),U,1) G I:'DTO!'$D(DITF)
 S Z=$P(DITF,";",1) I Z=" " S Z=D0 G I
 Q:'$D(^(Z))  S X=$P(DITF,";",2) I X S Z=$P(^(Z),U,X) G I
 S Z=$E(^(Z),+$E(X,2,9),+$P(X,",",2))
I ;
 S DFL=0,DTL=0,DA=D0 D ^DITR1
 I A D:$G(DIFRSA)]"" ERR Q
 I $G(DIFRSA)]"" S DIFRND0=Y I 'DKP,@("$D("_DTO(DTL)_"Y))") D KILLIDX
GO ;
 S DFL=1,DTL=1,DFN(1)=-1 D N
 Q
 ;
KILLIDX ; Kill the old index for single entry (overwrite mode only).
 N DIK,DA,%,A,B S DA=Y,DIK=DTO(DTL),DIK(0)="ABs"
 S A=$$CREF^DILF(DIK),A=$NA(@A),B=$QL(A)-1 F %=1:1:DFL\2 S DA(%)=$QS(A,B),B=B-2 ;GET SUBSCRIPTED VALUES OF DA  --GFT
 N D0,DDF,DDT,DFL,DFR,DINUM,DTL,DTN,DTO,I,W,X,Y,Z
 D IX2^DIK Q
 ;
ERR N DIPAR S DIPAR(.01)=X,DIPAR("IEN")=Y,DIPAR("FILE")=DDT(DFL)
 D BLD^DIALOG(9513.1,.DIPAR) Q
 ;
