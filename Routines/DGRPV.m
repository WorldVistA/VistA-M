DGRPV ;ALB/MRL,RTK,PJR,BRM,TMK,AMA,LBD - REGISTRATION DEFINE VARIABLES ON ENTRY ; 8/11/05 12:56pm
 ;;5.3;Registration;**109,114,247,190,327,365,343,397,415,489,546,545,451,624,677,672,689,716,688**;Aug 13, 1993;Build 29
 ;
 ;
 ;set up variables for registration screen processing
 ;
 ;DGRPVV   :string of 15 ones and zeros each character corresponding to
 ;          a particular screen (0 means allow edit, 1 means don't)
 ;
 ;DGRPVV(n):where n=screen number.  String of x ones and zeros where
 ;          x is the number of elements on screen n (0=edit, 1=don't)
 ;
 ;DGVI     :Turn on high intensity
 ;DGVO     :Turn off high intensity
 ;
EN D DT^DICRW I '$D(DVBGUI) D HOME^%ZIS
 S (DGVI,DGVO)="""""" I $S('$D(IOST(0)):1,'$D(^DG(43,1,0)):1,'$P(^DG(43,1,0),"^",36):1,$D(^DG(43,1,"TERM",IOST(0))):1,1:0) G M ;goto M if not high intensity
 I $D(^%ZIS(2,IOST(0),7)) S I=^(7),X=$S($P(I,"^",3)]"":3,1:2) I $L($P(I,"^",1)),$L($P(I,"^",X)) S DGVI=$P(I,"^",1),DGVO=$P(I,"^",X)
M I $L(DGVI_DGVO)>4 S X=132 X ^%ZOSF("RM")
 S DGRPW=1,DGRPCM=0,DGRPU="UNANSWERED",DGRPNA="NOT APPLICABLE",DGRPV=$S($D(DGRPV):DGRPV,1:1)
SC7 S X=$S('$D(^DPT(DFN,"TYPE")):0,1:+^("TYPE")) S:'$D(DGELVER) DGELVER=0
 S DGRPTYPE=$S($D(^DG(391,+X,0)):^(0),1:""),(DGRPSC,DGRPSCE,DGRPSCE1)="" S:'$D(DGELVER) DGELVER=0
 I DGRPTYPE'="" S DGRPSC=$G(^DG(391,+X,"S")),DGRPSCE=$G(^("E")),DGRPSCE1=$G(^("E10"))
 ;
 S DGPH=$P($G(^DPT(DFN,.53)),U)  ;Purple Heart Indicator
 I $G(DGPRFLG)=1 D
 . S DGRPVV="000001111111111"
 E  D
 . S DGRPVV="000000000000000"
 S X="5^3^5^2^3^8^4^2^3^2^4^5^5^2^1"
 F I=1:1:15 S J=+$P(X,"^",I),DGRPVV(I)=$S((I<12)!(I=15):$E("00000000000000000",1,J),1:$E("11111111111111111",1,J))
 S DGRPVV(1.1)="00"
 S DGRPVV(2)="00010"
 I $P($G(^DPT(DFN,.52)),U,9)'="" S $E(DGRPVV(6),4)=1  ;POW status verified, no editing (DG*5.3*688)
 I $G(DGPH)]"" S $E(DGRPVV(6),8)=1
 ;
 F I=3,6,8,9,10,11 S J=+$P(DGRPSC,"^",I) I 'J S DGRPVV=$E(DGRPVV,0,I-1)_1_$E(DGRPVV,I+1,99)
 ;
 ;-- if patient type is TRICARE then turn off screens 2,4
 ;
 ;-- modified 08/20/2003 for NOIS Calls MAC-0400-61574 & AMA-0700-71769 
 ;-- commented the line to allow screens 2 & 4 to display for Tricare
 ;I DGRPTYPE["TRICARE" F I=2,4 S J=+$P(DGRPSC,"^",I) I 'J S DGRPVV=$E(DGRPVV,0,I-1)_1_$E(DGRPVV,I+1,99)
 ;
 F I=31:0 S I=$O(^DD(391,I)) Q:I=""!(I>99)  I $D(^(I,0)),($E(^(0),1)'="*"),'+$P(DGRPSCE,"^",I) S X1=$E(I),X2=$E(I,2) I +X1 S DGRPVV(X1)=$E(DGRPVV(X1),0,X2-1)_1_$E(DGRPVV(X1),X2+1,99)
 I $G(^DPT(DFN,.35)),(^(.35)<+($E(DT,1,3)_"0000")) S DGRPVV=$E(DGRPVV,0,7)_11_$E(DGRPVV,10,99)
 K DIRUT,DUOUT,DTOUT
 ;
 ;Fields are numbered screen_item and put in that piece position.
 ;Because FM does not allow more than 100 pieces on a node, it was
 ;necessary to start a new node E10 for fields on screens 10 or higher.
 ;In these instances, the piece position will be screen_item-100 so,
 ;for example, screen 11, item 2 would be field 112, but piece 12.
 ;Items on screens <10 will be found on node E.
 ;
 F I=100:0 S I=$O(^DD(391,I)) Q:I=""!(I>150)  I $D(^(I,0)),($E(^(0),1)'="*"),'+$P(DGRPSCE1,"^",I-100) S X1=$E(I,1,2),X2=$E(I,3) I +X1 S DGRPVV(X1)=$E(DGRPVV(X1),0,X2-1)_1_$E(DGRPVV(X1),X2+1,99)
 ;
 I $S('($D(DUZ)#2):0,'$D(^XUSEC("DG ELIGIBILITY",DUZ)):0,1:1) G ELVER ;if user holds eligibility key, skip
 F I=.3,.32,.361 S DGRP(I)=$S($D(^DPT(DFN,I)):^(I),1:"")
 S DGRPVV(10)=11 I $P(DGRP(.361),"^",1)="V" S DGRPVV(7)=111,DGRPVV(1)=1_$E(DGRPVV(1),2,99) ;if elig verified, can't edit elig data, name, ssn, or dob
 I $P(DGRP(.3),"^",6)]"" S DGRPVV(8)=11 ;if monetary ben. verified, can't edit income screening data
 I $P(DGRP(.32),"^",2)]"" S DGRPVV(6)=111111111 ;if service data verified, can't edit service screen
 ;
ELVER ;set up variables for eligibility verification
 ;if elig ver option, only edit screens 1, 2, and 7 (and 6, 8, 9, 10,
 ;   and 11 if they're turned on).
 ;
 S DGRP(.361)=$G(^DPT(DFN,.361))
 I $P(DGRP(.361),U,3)="H" S DGRPVV(10)=10
 I $P($G(DGRP(.361)),U)="V",($P(DGRP(.361),U,3)="H") S DGRPVV(6)=$E(DGRPVV(6),1,5)_1_$E(DGRPVV(6),7,99),DGRPVV(11)=1000
 S:'DGELVER DGRPLAST=$S($G(DGPRFLG)=1:5,1:15)
 I DGELVER S DGRPVV="00111"_$E(DGRPVV,6,11)_"1111" F I=1:1:11 S J=$E(DGRPVV,I) I 'J S DGRPLAST=I
Q K DGRPSC,DGRPSCE
 Q
 ;
WW ;Write number on screens for display and/or edit (Z=number)
 W:DGRPW ! S Z=$S(DGRPCM:Z,DGRPV:"<"_Z_">",$E(DGRPVV(DGRPS),Z):"<"_Z_">",1:"["_Z_"]")
 I DGRPCM!($E(Z)="[") W @DGVI,Z,@DGVO
 I 'DGRPCM&($E(Z)'="[") W Z
 Q
 ;
WW1 ;spacing for screen display (Z=item to print)
 F Z2=1:1:(Z1-$L(Z)) S Z=Z_" "
 W Z K Z2
 Q
 ;
WW2 ; Write number on screen for fields always selectable
 W:DGRPW ! S Z="["_Z_"]"
 I DGRPCM!($E(Z)="[") W @DGVI,Z,@DGVO
 Q
