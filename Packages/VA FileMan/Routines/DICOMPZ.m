DICOMPZ ;SFISC/GFT-EVALUATE COMPUTED FLD EXPR ;2014-12-31  9:51 AM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**6,76,114,152,1039,1050**
 ;
 ;.
 ;
PRIOR ;from DICOMP -- PRIOR.. Functions get archived values
 N DIC,DICOMPSP,DICOMPXE,DICOPS
 S X=$E(X,6,99),DICOMPSP=$E("D",X="DATE"),DICOMPXE="D "_X_"^DIAUTL(",W=$F(I,")",M) S:X="USER"&$D(^VA(200)) DICO("PT")=200,DICOMPSP="p200" I 'W!'$D(DICMX)!'$D(J(0)) K Y Q
 S X=$E(I,M+1,W-2),M=W,W=$E(I,M) S:X?1"#"1.NP X=$E(X,2,999)
 S DIC="^DD("_J(DLV)_",",DIC(0)="",DIC("S")="I '$P(^(0),U,2),$P(^(0),U,2)'[""C""" D DICS^DICOMPY,^DIC K DIC I Y<0 K Y Q  ;Find Field that is the argument of PRIOR function
 S DICOMPXE=DICOMPXE_+J(DLV)_","_+Y_")"
 S DICOPS="><[]=",DIMW="m"
 G INSERT
 ;
BACKPNT ;from DICOMPV -- Backwards Pointer
 N DICOPS,D
 S DICOPS="><[]="
 G COLON
 ;
MUL(DICOMPSP) ;DICOMPSP is the SPECIFIER of the Field we have encountered
 N DICOXR,DICOMPXE,DICOPS S DICOPS="><][="
 I DICOMPSP S X=$P(^DD(+DICOMPSP,.01,0),U,2) G WP:X["W" D  S DLV=DLV+1,I(DLV)=""""_$P($P(Y(0),U,4),";")_"""",J(DLV)=+DICOMPSP D X G FOR
 .I T<DLV S DLV0=DLV0+100,%=DLV0-(T\100*100) F DLV=DLV0:1 S I(DLV)=I(DLV-%),J(DLV)=J(DLV-%),DG(DLV-%,DLV0-%)=DLV#100 I DLV-%=T S K(K+1,1)=DLV0,(T,DG(DLV0))=DLV Q
 S Y=+$P(DICOMPSP,"p",2),DIMW="m"_$E("w",DICOMPSP["w"),DICOMPXE=$P(Y(0),U,5,99)
 I Y S (%,DLV,DLV0)=DLV0+100,I(%)=^DIC(Y,0,"GL"),J(%)=Y D X^DICOMPV(Y,.01)
INSERT N DICOMX S D=DICOMPXE,DICOMX=DICMX D CONTAINS Q:'$D(Y)  I DICOMX=DICMX D
 .I DICOMPSP["D" S DICMX="S Y=X X ^DD(""DD"") S X=Y "_DICMX
 .I DICOMPSP["p" S DICMX="S X=$$CP^DIQ1("""_DICOMPSP_""",X) "_DICMX
 N F,Z,I S Z=""
 S F=$F(DICMX,"X DICMX") I F D
 .S Z="N DICOMPM S DICOMPM=$G(DICMX,""Q"") "
 .S DICMX=$E(DICMX,1,F-6)_"DICOMPM"_$E(DICMX,F,999)
 D DIMP(DICMX) S Z=Z_"N DICMX S DICMX="_$$DA_$$DIMC_")"
 D DIMP(D),DICOXR S Z=Z_X
 D DIMP(Z) S X=X_" S X=X" Q
 ;
WP S DIMW="m"_$E("w",X'["L"),DICOPS="["
M S X="S X=^(0)"
FOR N DICOR,DICOT ;These lines build the code for a typical Computed Multiple
 S DICOMPXE=X,DICOT=Y(0) D CONTAINS Q:'$D(Y)
 S Y=T#100+1,D=$P($P(DICOT,U,4),";") I +D'=D S D=""""_D_""""
 S DICOMPXE="D,0))#2 "_DICOMPXE_" "_DICMX_" Q:'$D(D)  S D=D"_Y
 S DICOR=$$REF(T)_","_D_",",D="F D=0:0 S (D,D"_Y_")=$O("_DICOR
 I W=")",$D(DPS(DPS,"INTERNAL")) S D="S D=$G(DIWF) N DIWF S DIWF=D_""XL"" "_D ;**DI*22*152
 S %=+$P(DICOT,U,2)
 I $P($G(^DD(%,.01,0)),U,2)["W"!'$D(^DD(%,0,"IX","B",%,.01))
 E  I '$D(^DD(%,.01,1,1,0))
 E  I $P(^(0),U,3)]""
 I  S D=D_"D)) Q:D'>0  I $D(^("_DICOMPXE ;We will go thru the muliple by ien
 E  D DIMP(D_"""B"",DICOB,D)) Q:D'>0  I $D("_DICOR_DICOMPXE) S D="N DICOB S DICOB="""" F  S DICOB=$O("_DICOR_"""B"",DICOB)) Q:DICOB=""""  "_X_" Q:'$D(D)" ;We will go thru the multiple using the B X-ref
 D DIMP($$I(Y)_D)
 I DICOPS'?1P S K(K+1,2)=1 ;If it is just a multiple, it can't be followed by an operator (see BINOP^DICOMP)
 S (T,DG(DLV0))=DG(DLV0)+1,K(K+2,1)=DLV0,DG(DLV0,T)=Y,M(Y,DLV0+Y)=T
 S X=X_":D"_(Y-1)_">0"
DICOXR S X=X_" S X="_$S(DIMW["m"!'$D(DICOXR):"""""",1:DICOXR)
 Q
 ;
CONTAINS N DICON
 S DICON=W="'",%=$E(I,M+DICON) I %=""!(W=")") S Y=0 Q
 I DICOPS[% S DICOPS=% D R($E(I,M+DICON+1,999)) Q:'$D(Y)  D  Q
 .S DICOXR=$$DGI^DICOMP
 .D DIMP("S Y=X "_X_" I Y"_DICOPS_"X S "_DICOXR_"="_'DICON_" K D") S DICMX=X
 .S K(K+1)=" S "_DICOXR_"="_DICON,K=K+1
 .S DBOOL=1,DIMW=""
COLON I W'=":" Q:W=""  S DICOMPX("X")="X",I="X"_$E(I,M,999),M=0 I DICOPS="[" K Y Q
 N DQI D R($E(I,M+1,999)) Q:'$D(Y)  I '$D(DICO("RCR")) S DICO("RCR")=Y
 I Y#100=0 S W=$G(J(+Y)) I W S DICO("PT")=W
 S DICMX=X_" "_$G(DICMX) Q  ;The 'X" code that we got back from RCR becomes what we eXecute for every multiple!
 ;
R(DICORM) N DICOLEFT,DICOX S DICOLEFT="",DICOX=0 F %=1:1 S W=$E(DICORM,%) Q:W=""  S:W="(" DICOX=DICOX+1 I W=")" S DICOX=DICOX-1 I DICOX<0 S DICOLEFT=$E(DICORM,%,999),DICORM=$E(DICORM,1,%-1)
 S DICOX=$G(X) D RCR(DICORM)
 S W="",M=0,I=DICOLEFT S:'$D(Y) I=DICORM,X=DICOX Q
 ;
RCR(W) ;Tricky and important!  What we get from this recursion will be inserted into the larger expression.
 N D
 S:+W=W W=""""_W_"""" S D="ZXM"_$$DIMC_" S"_DICOMP D  ;Don't allow MUMPS. Remember where to start more nodes in X array.  Allow simple numeric.
 .N X,DICOMP,DLV,DICMXSV,K
 .S X=W,DICOMP=D I $D(DICMX) S DICMXSV=DICMX
DQI .S %=$G(DQI,"Y(") N DQI S DQI=%_$$DIMC_","
 .D EN1^DICOMP ;Here is the recursion!  I & J, the context, will be preserved by this entry point
 .I '$D(X) K Y Q
 .K W M W=X
 .I Y["m" K DICMXSV
 .I $D(DICMXSV) S DICMX=DICMXSV
 I $D(Y) M X=W D DIMP(X),DATE^DICOMP0:Y["D" ;Remember if it's a DATE
 Q
 ;
DIMP(D) ;
 N DIM
 S DIM=$$DIMC,DIM=DIM+$S(DIM<9.8:.1,1:.01)
 S X(DIM)=D,X=" X "_$$DA_DIM_")" Q
 ;
DA() Q $S(DA:"^DD("_A_","_DA_",",1:DA)
 ;
DIMC() N DIM
 S DIM=$O(X(99),-1) I 'DIM S DIM=+$P(DICOMP,"M",2) I 'DIM S DIM=9.1
 Q DIM
 ;
X ;
 S X="S X=$P(^(0),U)"_$S(X["D"&'$D(DPS($$NEST^DICOMP,"INTERNAL")):",Y=X X ^DD(""DD"") S X=Y",X["P":" S:$D(^"_$P(^(0),U,3)_"+X,0)) X=$P(^(0),U)",X["S":",Y=$F(^DD("_+D_",.01,0),X_$C(58)) S:Y X=$P($E(^(0),Y,999),$C(59),1)",1:""),DIMW="m" Q
 ;
I(LEV) N S
 S S=DLV0+LEV I DICOMP'["I"!'$D(I(S)) Q ""
 Q "S I("_S_")="""_$$CONVQQ^DILIBF(I(S))_""",J("_S_")="_J(S)_" "
 ;
REF(T) ;
 N L,D,X,V
 F L=T\100*100:1:T S D=I(L) S X=$G(X)_D_$E(",",$D(X))_$S(L<DLV0:"I("_L_",0)",1:"D"_(L#100))_","
 Q $E(X,1,$L(X)-1)
