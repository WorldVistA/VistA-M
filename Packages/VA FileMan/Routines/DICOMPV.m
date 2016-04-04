DICOMPV ;SFISC/GFT  BACKWARD-POINTERS IN COMPUTED FIELDS ;13APR2007
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1,6,76,114,144,999,1005,1012,1027**
 ;
 N DIX,DICOTRY,DICOLEV
 D DRW^DICOMPX
TRY F DICOTRY=1,2 S Y=$$BACK I Y[U Q:Y=U  D:$G(D)-.001 Y^DICOMPX G END
 S D=0 ;'D' is a flag to the calling routine, DICOMP0, saying we've found nothing here in DICOMPV
END Q
 ;
BACK() N DICOB,DICODD
 S DICOB=DLV0,DICODD=0
DD S DICODD=$O(^DD(J(DICOB),0,"PT",DICODD)) I DICODD'>0 S DICOB=DICOB-100,DICODD=0 G DD:DICOB'<0 Q ""
ARCH S Y=DICODD I DICOMP["W",$P($G(^DD(Y,0,"DI")),U,2)["Y" G DD ;No editing RESTRICTED or ARCHIVE file!
 F DICOLEV=0:-1 G DD:'$D(^DD(Y,0)) Q:'$D(^(0,"UP"))  S Y=^("UP")
 I $D(^DIC(Y,0)),$P(^(0),X)="" X DIC("S") I $T,$D(^DIC(Y,0,"GL")) S V=^("GL"),D=0 F  S D=$O(^DD(J(DICOB),0,"PT",DICODD,D)) Q:'D  D  G Y:Y[U
DINUM .I DICODD=Y,D=.01&(DICOTRY=1)&($P($G(^DD(Y,.01,0)),U,5,99)["DINUM=X")!(D=.001&(DICOTRY=2)) D YN("") I %=1 S %Y=V,X="D0" S:$D(DIFG) DIFG=1 D X(Y,D),P^DICOMPX S D=.001,Y=Y_U Q
 .Q:'$D(DICMX)  ;Stop if expression can't be multiple-valued
 .N DICOUT F DIX=0:0 S DIX=$O(^DD(DICODD,D,1,DIX)) Q:DIX'>0  S J=$G(^(DIX,0)) I +J=Y S %=$P(J,U,3,9) I $S(DICOTRY=1:%="",1:%]""&("MUMPS"[%)) D  G:$G(DICOUT) Q
 ..D YN("Cross-reference") I %<1 S Y=U,DICOUT=1 Q
 ..I %=1 D MP S DICOUT=1
 .Q:DICOTRY=1
INDEXES .F DIX=0:0 S DIX=$O(^DD("IX","F",DICODD,D,DIX)) Q:'DIX  I $P($G(^DD("IX",DIX,0)),U,4)="R",$P(^(0),U,9)=DICODD S J=$P(^(0),U,1,3) I +J=Y,$P($G(^(11.1,1,0)),U,2,4)=("F^"_DICODD_U_D) D YN("Index") G Q:%<1 I %=1 D MP G Q
Q .Q
 G DD
 ;
Y Q Y
 ;
 ;
MP S DICN=$S(DA:DQI_(80+DICOB),1:"I("_DICOB_",0")_")",J=""""_$P(J,U,2)_"""",T=D S:$D(DIFG) DIFG=$P(J,"""",2)
 I DICOMP'["W" D  G POP:$D(Y) S (Y,D)=0 Q
 .N DICOMPIX S DICOMPIX=J
 .S D=Y,I(DLV0+100)=V,J(DLV0+100)=D
RCR .D BACKPNT^DICOMPZ Q:'$D(Y)
 .S Y=D,X=$P(^DD(D,.01,0),U,2) D X^DICOMPZ
 .S D="S (D,D0)=$QS(DIMQ,$QL(DIMQ)" I DICOLEV S D=D_DICOLEV
 .D DIMP^DICOMPZ(D_") I D,$D("_V_"D,0)) "_X_" "_DICMX)
 .D DIMP^DICOMPZ("N DIMQ,DIMSTRT,DIMSCNT S (DIMQ,DIMSTRT)=$NA("_V_DICOMPIX_","_DICN_")),DIMSCNT=$QL(DIMQ) F  S DIMQ=$Q(@DIMQ) Q:DIMQ=""""  Q:$NA(@DIMQ,DIMSCNT)'=DIMSTRT  "_X_" Q:'$D(D)  S D=D0")
 .S X=X_" S X="""""
ASK D ASKE^DICOMPW I 'D,T-.01&'DS!(DICODD-Y) S D=0
 E  S DZ=0 D ASK^DICOMPW:'D I D<0 K T Q
 S %=D,D="N DIADD,DIC S DIC="_Y_$S(%=2:",DIADD=1",1:"")_",DIC(0)="""_$P("EQ",U,DS)_$E("L",D>0)_$E("W",$D(DICO(3)))
CROSS I T-.01 S D=D_$P("AM",U,DS)_""",DIC(""S"")=""I $D("_V_""""_J_""","""_"_"_DICN_"_"_""",Y))"" D ^DIC S D0=+Y,DIC("_T_")="_DICN_",DIH="_Y_" D DICL^DICR:$P(Y,U,3)"
 E  S D=D_"U"",X="_DICN_" D ^DIC S D0=+Y"
DIM D DIMP^DICOMPZ(D) I '% S %=":$O(^(D0))>0",X=" S D0=$O("_V_J_","_DICN_",0))"_$S(DS:X_%,1:" S"_%_" D0=0")
 S X=X_" S X=$S(D0>0:D0,1:"""")" S:$D(DICOMPX(0)) X=X_","_DICOMPX(0)_"0)=X"
POP S Y=Y_U,D=1,DICO("PT")=+Y
 D X(+Y,.01) Q
 ;
X(Y,D) S DICN=Y ;Remember that we have used this field
 I $D(DICOMPX)#2 S DICOMPX=Y_U_D_$E(";",1,$L(DICOMPX))_DICOMPX
 Q
 ;
YN(SHOW) N X
 S X=$P(^DIC(Y,0),U)
 S %=1 I DICOMP["?" D
YOU .N N ;**CCO/NI (+ next 2  lines) 'BY SO&SO, DO YOU MEAN THE SUCH&SUCH FILE, POINTING...?'
 .S N(1)=DICN,N(2)=X,N(3)=$P(^DD(DICODD,D,0),U),DICV=$P(^(0),U,2)
 .W !,$$EZBLD^DIALOG(8202,.N)
 .I SHOW]"" W !,"    (""",$P(J,U,2),""" ",SHOW,")"
 .D YN^DICN
 I %=1 F M=M:1:$L(I)+1 Q:$F(X,$E(I,1,M))-1-M  S W=$E(I,M+1)
 Q
