GMVDCCHK ;HOIFO/DAD,FT-VITALS COMPONENT: CHECK DATA VALUE ;9/29/00  09:15
 ;;5.0;GEN. MED. REC. - VITALS;;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; #10104 - ^XLFSTR calls            (supported)
 ;
VALID(GMVALUE,GMVMSYS,GMVTYPE) ;
 ; *** Validate a vital measurement ***
 ; Input:
 ;  GMVALUE = The vital measurement to be validated
 ;  GMVMSYS = The measurement system the measurement is expressed in
 ;            (C - US Customary, M - Metric)
 ;  GMVTYPE = A vital type abbreviation
 ; Output:
 ;  0 - Invalid, 1 - Valid
 S GMVTYPE=$$UP^XLFSTR(GMVTYPE)
 I $T(@GMVTYPE)]"" D
 . N GMVCODE,GMVOK
 . S GMVCODE="S GMVOK=$$"_GMVTYPE_"(GMVALUE)"
 . X GMVCODE I 'GMVOK K GMVALUE
 . Q
 E  D
 . K GMVALUE
 . Q
 Q ''$D(GMVALUE)
 ;
AG(X) ; ABDOMINAL GIRTH
 S X=$$CNV^GMVDCCNV(X,GMVMSYS,"S",GMVTYPE)
 K:X'=+X!(X>150)!(X<0)!(X?.E1".".N) X
 Q ''$D(X)
 ;
AUD(X) ; AUDIOMETRY
 N I,Y
 K:X'?.N1"/".N1"/".N1"/".N1"/".N1"/".N1"/".N1"/".N1"/".N1"/".N1"/".N1"/".N1"/".N1"/".N1"/".N1"/".N1"/" X
 I $D(X) F I=1:1:16 S Y=$P(Y,"/",I) I Y]"" I Y'=+Y!(Y>110)!(Y<0) K X Q
 Q ''$D(X)
 ;
BP(X) ; BLOOD PRESSURE
 N I,Y
 K:(X'?1.3N1"/"1.3N1"/"1.3N)&(X'?1.3N1"/"1.3N)&(X'?1.3N) X
 I $D(X) F I=1:1:$L(X,"/") S Y=$P(X,"/",I) I Y]"" I Y<0!(Y>300) K X Q
 I $D(X),(X'?1.3N),$P(X,"/")'>$P(X,"/",$L(X,"/")) K X
 Q ''$D(X)
 ;
CG(X) ; CIRCUMFERENCE/GIRTH
 S X=$$CNV^GMVDCCNV(X,GMVMSYS,"S",GMVTYPE)
 K:X'=+X!(X>200)!(X<0)!(X?.E1"."3.N) X
 Q ''$D(X)
 ;
CVP(X) ; CENTRAL VENOUS PRESSURE
 S X=$$CNV^GMVDCCNV(X,GMVMSYS,"S",GMVTYPE)
 K:X<-13.6!(X>136)!(X?.E1"."2.N) X
 Q ''$D(X)
 ;
FH(X) ; FUNDAL HEIGHT
 S X=$$CNV^GMVDCCNV(X,GMVMSYS,"S",GMVTYPE)
 K:X'=+X!(X>50)!(X<10)!(X?.E1".".N) X
 Q ''$D(X)
 ;
FT(X) ; FETAL HEART TONES
 K:X'=+X!(X>250)!(X<50)!(X?.E1".".N) X
 Q ''$D(X)
 ;
HC(X) ; HEAD CIRCUMFERENCE
 I GMVMSYS="M" D
 . K:+X>76!(+X<26)!(X?.E1"."3.N) X
 . Q
 I GMVMSYS="C" D
 . K:+X>30!(+X<10)!(X?.E1"."4.N) X
 . I $D(X),X#1>0 K:"^.125^.25^.375^.5^.625^.75^.875^"'[(U_(X#1)_U) X
 . Q
 Q ''$D(X)
 ;
HE(X) ; HEARING
 K:"^A^N^"'[(U_X_U) X
 Q ''$D(X)
 ;
HT(X) ; HEIGHT
 S X=$$CNV^GMVDCCNV(X,GMVMSYS,"S",GMVTYPE)
 K:X'=+X!(X>100)!(X<1)!(X?.E1"."3.N) X
 Q ''$D(X)
 ;
P(X) ; PULSE
 K:+X'=X!(X>300)!(X<0)!(X?.E1".".N) X
 Q ''$D(X)
 ;
PN(X) ; PAIN
 K:"^0^1^2^3^4^5^6^7^8^9^10^99^"'[(U_X_U) X
 Q ''$D(X)
 ;
PO2(X) ; PULSE OXIMETRY
 K:X<0!(X>100)!(X?.E1".".N) X
 Q ''$D(X)
 ;
R(X) ; RESPIRATION
 K:X'=+X!(X>100)!(X<0)!(X?.E1".".N) X
 Q ''$D(X)
 ;
T(X) ; TEMPERATURE
 S X=$$CNV^GMVDCCNV(X,GMVMSYS,"S",GMVTYPE)
 K:X'=+X!(X>120)!(X<45)!(X?.E1"."3.N) X
 Q ''$D(X)
 ;
TON(X) ; TONOMETRY
 N I,Y
 K:(X'?1.2N1"/"1.2N)&(X'?1.2N1"/")&(X'?1"/"1.2N) X
 I $D(X) F I=1,2 S Y=$P(X,"/",I) I Y]"" I Y'=+Y!(Y>80)!(Y<0) K X Q
 Q ''$D(X)
 ;
VC(X) ; VISION CORRECTED
 N I,Y
 K:(X'?1.3N1"/"1.3N)&(X'?1.3N1"/")&(X'?1"/"1.3N) X
 I $D(X) F I=1,2 S Y=$P(X,"/",I) I Y]"" I Y'=+Y!(Y>999)!(Y<10) K X Q
 Q ''$D(X)
 ;
VU(X) ; VISION UNCORRECTED
 Q $$VC(X)
 ;
WT(X) ; WEIGHT
 S X=$$CNV^GMVDCCNV(X,GMVMSYS,"S",GMVTYPE)
 K:X'=+X!(X>1500)!(X'>0)!(X?.E1"."3.N) X
 Q ''$D(X)
