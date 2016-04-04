DIEQ ;SFISC/XAK,YJK-HELP DURING INPUT ;24AUG2006
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**4,3,59,999,1004,1024**
 ;
BN S D=$P(DQ(DQ),U,4) S:DP+1 D=DIFLD
 S DZ=X D EN1 G B^DIED
QQ ;
 I DV,DV["*",$D(^DD(+DV,.01,0)) S DQ(DQ)=$P(DQ(DQ),U,1,4)_U_$P(^(0),U,5,99)
EN1 N DDH,DST,A1 S DDH=0 G M:DV I DP<0 D HP G P
HELP I X="?"!(X["BAD") S X=$$HELP^DIALOGZ(DP,D),A1="T" D N:X]"" I '$G(DISORT),$D(^DD(DP,D,12)) S X=^(12) D N ;***CCO/NI HELP MESSAGE
 D H G:'$D(DZ) Q
 ;
P I DV["P" K DO S DIC=U_DU,D="B",DIC(0)="M"_$E("L",DV'["'") G AST:DV["*"&('$G(DISORT)) D DQ^DICQ D %
VP I DV["V" S DU=DP S:DV DU=+DO(2),D=.01 D V G Q
D I DV["D" S %(0)=0 D DT^DIEH1($P($P($P(DQ(DQ),U,5,9),"%DT=""",2),""""),1) ;**CCO/NI REPLACES CALL TO HELP^%DTC
S I DV["S" D:'$G(DISORT) SETSCR^DIR(DP,D) S A1="T",DST=$$EZBLD^DIALOG(8068)_" " D DS D  K DIC("S")
 .N A,A1,A2
 .S A=$P(DQ(DQ),U,3)
 .I $G(DUZ("LANG"))>1,A=$P(^DD(DP,D,0),U,3) S A=$$SETIN^DIALOGZ_";" ;NAKED
 .F DG=1:1 S Y=$P(A,";",DG) Q:Y=""  S D=$P(Y,":",2),Y=$P(Y,":") I 1 X:$D(DIC("S")) DIC("S") I  S A2="",$P(A2," ",15-($L(Y)+7))=" ",DST="  "_Y_A2_" "_D D DS
Q K DST,A1 S:$D(DIE) DIC=DIE S D=0 I $D(DDH)>10 D LIST^DDSU
 D:DV UDA
 Q
 ;
 ;
 ;
N F  Q:X=""  F %=$L(X," "):-1:1 I $L($P(X," ",1,%))<75 S DST=$P(X," ",1,%) D DS D:X'="" N1 Q
 S X=DZ
 Q
 ;
N1 S X=$P(X," ",%+1,$L(X," ")) Q
 ;
DS S:'$D(A1) A1="T" S DDH=$G(DDH)+1,DDH(DDH,A1)=$S(A1="X":"",1:"     ")_DST K A1,DST Q
 ;
HP I $D(DQ(DQ,3)) S A1="T",DST=DQ(DQ,3) D DS
 I $D(DQ(DQ,4)) S A1="X",DST=DQ(DQ,4) D DS
 Q
 ;
% S %=$G(DIC("V")) K DIC S:%]"" DIC("V")=% Q
 ;
AST S:$D(X)[0 X="?" X $P(DQ(DQ),U,5,99) K DIC G Q
 D ^DIC K DIC,DICS,DICW G Q
 ;
M K DO S DZ=X,DIC=DIE_DA_","_$S(+$P(DC,U,3)=$P(DC,U,3):$P(DC,U,3),1:$C(34)_$P(DC,U,3)_$C(34))_",",D="B",DIC(0)="LM",DZ(1)=0
 I '$D(@(DIC_"0)")) S DO=U_$P(DC,U,2) D DO2^DIC1
 D:'$D(DO) DO^DIC1
 D DDA,DQ^DICQ D % G Q:'$D(DZ)!(DV["S") S X=DZ G P
 ;
H I '$G(DISORT),$D(^DD(DP,D,4)) S A1="X",DST=^(4) D DS,LIST^DDSU Q:'$D(DZ)!$D(DDSQ)
 I $G(X)?1"??".E,X'["BAD" D
 . N DIDG,DG,DDD,DD,DIY,DIZ,DUOUT
 . S DIDG=$P($G(^DD(DP,D,21,0)),U,3)
 . K DDSQ
 . I '$D(DDS) S DDD=5,DD="",DIY=99,DIZ=21 I $G(DIPGM)'="DICQ1" N DIPGM S DIPGM="DIEQ" D Z^DDSU
 . F DG=1:1 Q:'$D(^DD(DP,D,21,DG,0))  Q:+DIDG&(DG>DIDG)  D  Q:$D(DDSQ)
 . . I '($G(DDH)#15) D LIST^DDSU I $G(DTOUT)!($G(DUOUT)) S DDSQ=1
 . . Q:$D(DDSQ)
 . . S DST=^DD(DP,D,21,DG,0) D DS Q
 . I '$D(DDSQ) Q:$D(DDH)'>10  D LIST^DDSU
 . I $D(DDSQ) K DDSQ,DDH
 . Q
 Q
 ;
BK S DDH=$G(DDH)+1,DDH(DDH,"T")=" " Q
 ;
V S DDH=+$G(DDH),A1="T",DST=$$EZBLD^DIALOG(8071) D DS
EGP F Y=0:0 S Y=$O(^DD(DU,D,"V",Y)) Q:Y'>0  I $D(^(Y,0)) S Y(0)=^(0) X:$D(DIC("V")) DIC("V") I  I $D(^DIC(+Y(0),0)) S Y(1)=$P(Y(0),U,4),Y(2)=$$FILENAME^DIALOGZ(+Y(0)),DST=$$EZBLD^DIALOG(8072,.Y) K Y(1),Y(2) D DS ;**CCO/NI V-P FILE NAMES
 D BK S DST=$$EZBLD^DIALOG(8073) D DS S DU="" D BK I DZ'?1"??".E K X,DZ Q
 D T^DIEQ1 K X,DZ Q
 ;
DDA N T,%
 S T=$T
 F %=+$O(DA(" "),-1):-1:1 K DA(%+1) S:$D(DA(%))#2 DA(%+1)=DA(%)
 K DA(1) S:$D(DA)#2 DA(1)=DA
 I T
 Q
 ;
UDA N T,%
 S T=$T
 S DA=$G(DA(1)) ;K DA(1)
 F %=2:1:+$O(DA(" "),-1) I $D(DA(%))#2 S DA(%-1)=DA(%) K DA(%)
 I T
 Q
 ;
 ;#8071  Enter one of the following
 ;#8072  |Prefix|.EntryName to select a |filename|
 ;#8073  To see the entries in any particular file type <Prefix.?>
