GMRVPCE3 ;HIRMFO/RM,FT-V/M Data Validation for AICS ;07/26/05 8:26am
 ;;5.0;GEN. MED. REC. - VITALS;**13**;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; #10104 - ^XLFSTR calls          (supported)
 ;07/25/2005 BAY/KAM HD 0000000068371 changed lowest range height from 0 to 10
 ;
VALID(TYPE,X) ; This function returns 1 if rate (X) is valid for
 ; measurement type (TYPE).
 N FXN S FXN=0
 I TYPE="VU" S TYPE="VC"
 D @TYPE I $D(X) S FXN=1
 Q FXN
AG ; INPUT TRANSFORM FOR ABDOMINAL GIRTH
 N UNIT S UNIT=$$UP^XLFSTR($P(X,+X,2,10)) I UNIT="" K X Q
 S X=+X
 I $E(UNIT)="C"&("CM"[UNIT) S X=$$CMTOIN(+X,0),UNIT="IN"
 I $E(UNIT)="I"&("IN"[UNIT) K:+X'=X!(X>150)!(X<0)!(X?.E1"."1N.N) X
 E  K X
 Q
AUD ; INPUT TRANSFORM FOR AUDIOMETRY.
 N I,R,L
 K:X'?.N1"/".N1"/".N1"/".N1"/".N1"/".N1"/".N1"/".N1"/".N1"/".N1"/".N1"/".N1"/".N1"/".N1"/".N1"/".N1"/" X
 I $D(X) F I=1:1:8 S R=$P(X,"/",I) I R]"" K:+R'=R!(R>110)!(R<0) X
 I $D(X) F I=9:1:16 S L=$P(X,"/",I) I L]"" K:+L'=L!(L>110)!(L<0) X
 Q
BP ; INPUT TRANSFORM FOR BLOOD PRESSURE
 K:X'?2.3N1"/"2.3N1"/"2.3N&(X'?2.3N1"/"2.3N) X I $D(X) K:$P(X,"/",1)>300!($P(X,"/",2)>300)!(+$P(X,"/",3)>300) X
 I $D(X),$P(X,"/")'>$P(X,"/",$L(X,"/")) K X
 Q
FH ; INPUT TRANSFORM FOR FUNDAL HEIGHT
 N UNIT S UNIT=$$UP^XLFSTR($P(X,+X,2,10)) I UNIT="" K X Q
 S X=+X
 I $E(UNIT)="C"&("CM"[UNIT) S X=$$CMTOIN(+X,0),UNIT="IN"
 I $E(UNIT)="I"&("IN"[UNIT) K:+X'=X!(X>50)!(X<10)!(X?.E1"."1N.N) X
 E  K X
 Q
FT ; INPUT TRANSFORM FOR FETAL HEART TONES
 K:+X'=X!(X>250)!(X<50)!(X?.E1"."1N.N) X
 Q
HC ; INPUT TRANSFORM FOR HEAD CIRCUMFERENCE
 N UNIT S UNIT=$$UP^XLFSTR($P(X,+X,2,10)) I UNIT="" K X Q
 I $E(UNIT)="C"&("CM"[UNIT) D  Q
 .  K:+X>76!(+X<26)!(+X?.E1"."3N.N) X
 .  I $D(X) S X=$J(.3937*(+X),0,2)
 .  Q
 I $E(UNIT)="I" D  Q
 .  K:+X>30!(+X<10)!(+X?.E1"."4N.N) X
 .  I $D(X),+X?.E1"."1N.N D
 .  .  N F S F=$P(+X,".",2)
 .  .  K:"^125^25^375^5^625^75^875^"'[("^"_F_"^") X
 .  .  Q
 .  I $D(X) S X=+X
 .  Q
 K X
 Q
HE ; INPUT TRANSFORM FOR HEARING
 K:"^N^A^"'[("^"_$$UP^XLFSTR(X)_"^") X
 Q
HT ; INPUT TRANSFORM FOR HEIGHT
 D EN3^GMRVUT0 K:X=0!(X>100)!(X<10) X
 Q
PU ; INPUT TRANSFORM FOR PULSE
 K:+X'=X!(X>300)!(X<0)!(X?.E1"."1N.N) X
 Q
RS ; INPUT TRANSFORM FOR RESPIRATION
 K:+X'=X!(X>100)!(X<0)!(X?.E1"."1N.N) X
 Q
TON ; INPUT TRANSFORM FOR TONOMETRY
 N R,L
 K:X'?.N1"/"1N.N&(X'?1N.N1"/".N) X
 I $D(X) S R=$P(X,"/") I R]"" K:R'=+R!(R>80)!(R<0) X
 I $D(X) S L=$P(X,"/",2) I L]"" K:L'=+L!(L>80)!(L<0) X
 Q
TMP ; INPUT TRANSFORM FOR TEMPERATURE
 K:+X'=X!(X>120)!(X<0)!(X?.E1"."3N.N) X I $D(X) S:X<45 X=$J(+X*(9/5)+32,0,1)
 Q
VC ; INPUT TRANSFORM FOR VISION CORRECTED (AND VISION UNCORRECTED)
 N R,L
 K:X'=+X&(X'?.N1"/"1N.N) X
 I $D(X) S R=$P(X,"/") I R]"" K:R'=+R!(R>999)!(R<10) X
 I $D(X) S L=$P(X,"/",2) I L]"" K:L'=+L!(L>999)!(L<10) X
 Q
WT ; INPUT TRANSFORM FOR WEIGHT
 I $L(X)>10 K X Q
 S GMR=$E($P(X,+X,2)) S X=$S(GMR="":0,"Kk"[GMR:+$J(2.2*(+X),0,2),"Ll"[GMR:+X,1:0) K:X>1500!(X=0)!(X<0) X K GMR
 Q
PN ; INPUT TRANSFORM FOR PAIN
 K:"^0^1^2^3^4^5^6^7^8^9^10^99^"'[(U_X_U) X
 Q
UNITRATE(TYPE,RATE,UNIT) ; This function will add the unit of
 ; measurement to the rate so the input transforms will work properly.
 ;   Input variables:  TYPE = Measurement type
 ;                     RATE = Actual measurement (passed in by ref.)
 ;                     UNIT = Unit of measurement
 ;   Function value: Transormed rate with units on the end.
 N FXN S FXN=RATE,UNIT=$G(UNIT)
 I TYPE="AG"!(TYPE="FH")!(TYPE="HC")!(TYPE="HT") D
 .  I "^CM^IN^"'[("^"_UNIT_"^") S FXN=""
 .  E  S FXN=RATE_$E(UNIT)
 .  Q
 I TYPE="TMP" D
 .  I "^C^F^"'[("^"_UNIT_"^") S FXN=""
 .  I UNIT="F",RATE<45 S FXN=""
 .  I UNIT="C" S FXN=+$J(+RATE*(9/5)+32,0,1)
 .  Q
 I TYPE="WT" D
 .  I "^LB^KG^"'[("^"_UNIT_"^") S FXN=""
 .  E  S FXN=RATE_$E(UNIT)
 .  Q
 Q FXN
CMTOIN(X,PREC) ; Convert CM to IN, given CM value (X) this function will
 ; return IN value.  Optional input value of PREC for precision,
 ; if not set, 2 decimals will be returned.
 Q +$J(.3937*(+X),0,+$G(PREC,2))
