PRS8SU ;HISC/MRL-DECOMPOSITION, SET-UP ;02/20/08
 ;;4.0;PAID;**112,116**;Sep 21, 1995;Build 23
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;This routine sets up various data elements required to process
 ;a decomp.  The ^TMP array is built for each day of the
 ;pay period (1-14) and includes tour information, exceptions,
 ;holiday information, etc.  All times are converted to 15-minute
 ;increments in this routine (the number of 15-minute increments
 ;into the day).  Additionally, the credit tour for WG
 ;employees is determined in this routine.
 ;
 ;Called by Routines:  PRS8DR
 ;
 K ^TMP($J,"PRS8")
 K D,DAY F DAY=0:1:15 D
 .I 'CYA,DAY>1,DAY<15,$E($P(PPD,"^",DAY),4,7)="0101" S CYA=DAY
 .S P=0 I 'DAY S P=+PPD(0),D=14 ;last day of previous pp
 .I DAY=15 S P=+PPD(15),D=1 ;first day of next pp
 .I P S ZZ=$S(D=14:0,1:15)
 .I 'P S P=+PY,(ZZ,D)=+DAY
 .S W=$S(D<8:1,1:2) K DADRFM S DADRFM=1
 .S TWO=0 F N=0,1,4,2,10 S Z=$G(^PRST(458,+P,"E",+DFN,"D",+D,N)) D
 ..S (N14,NDAY,LAST,QT)=0,D(N)=Z,N1=$S(N=2:4,1:3)
 ..I N=0,$S(ZZ<15:1,1:0) F J=2,13 I +$P(D(0),"^",J) D
 ...S X=+$P(D(0),"^",$S(J=2:8,1:14)) Q:'X  ;normal hours
 ...I DAY'=0 S X=X\.25 S NH(W)=NH(W)+X ;increment NH
 ...S Z1=Z,Z=X,D1=D,X="DH"_$S(J=2:1,1:2) D SET S Z=Z1 ;save NH
 ...S X=+$P(D(0),"^",J)
 ...S X=+$P($G(^PRST(457.1,+X,0)),"^",3) Q:'X  ;mltime
 ...S X=X\15,MT($S(J=2:1,1:2))=X ;save mltime
 ...I X S X1=Z,Z=X,D1=D,X="MT"_$S(J=2:1,1:2) D SET S Z=X1
 ..I "^1^2^4^"[("^"_N_"^") F K=1:N1 S V=$P(Z,"^",K,K+1) Q:QT  D
 ...S X=$P(Z,U,K,999) S:X?1"^"."^"!(X="")!(N14=1) QT=1 I QT!($P(Z,U,K)="") Q
 ...S:K=1 (NDAY,LAST)=0 F K1=1,2 S X=$P(V,"^",K1),(Y,Y1)=K1-1 I X'="" D
 ....S FLAG=1 I N=2&(K1=1)&("^HW^"[("^"_$P(Z,"^",K+2)_"^")) S FLAG=$S(NDAY=1!(LAST>96)&("^HW^"[("^"_$P(Z,"^",K+2)_"^"))&((X["A")!(X["MID")):0,1:1),NDAY=0
 ....S:$P(D(0),"^",14)'=""&(X="MID")&(LAST=96)&(N=2)&(K1=1) FLAG=0 S:N=2&(K1=1)&(FLAG=1) (NDAY,LAST)=0 S Y=K1-1 D 15
 ....I N=2,"^RG^OT^CT^ON^SB^"'[("^"_$P(Z,"^",K+2)_"^") D
 .....S Y=+$O(DADRFM("S",(-X-.01))),Y1=+$O(DADRFM("F",(X-.01)))
 .....I $G(DADRFM("S",Y))'=$G(DADRFM("F",Y1)) S X=X+96
 .....Q
 ....S $P(Z,"^",K+(K1-1))=X ;15-minute conversion
 ....I K1=1,N=1!(N=4) S DADRFM("S",-X)=DADRFM
 ....I K1=2,N=1!(N=4) S DADRFM("F",X)=DADRFM,DADRFM=DADRFM+1
 ....I K1=2,X>96,N'=2 S Y=$P(Z,"^",(K+K1)) I Y=""!("12345"'[Y) S X=X-96 D
 .....I "^0^7^14^"'[("^"_+ZZ_"^") Q
 .....I $G(^TMP($J,"PRS8",DAY,"MT1"))>1 S X=X-$G(^TMP($J,"PRS8",DAY,"MT1"))
 .....I ZZ=0!(ZZ=7) S NH($S('ZZ:1,1:2))=NH($S('ZZ:1,1:2))+X
 .....Q:'ZZ  ;already moved previous time to this pp
 .....S NH($S(D=7:1,1:2))=NH($S(D=7:1,1:2))-X
 .....Q
 ....Q
 ...I N=4,Z?1AN.E!(Z?1"^".AN) D  ;2-tour day
 ....I +D(1)'>+Z S TWO=1_"^"_+Z ;early tour first
 ....E  S TWO=2_"^"_+D(1) ;late tour first
 ....Q:+TWO=1  ;we're gonna switch 1&4 nodes if necessary now
 ....S X1=^TMP($J,"PRS8",DAY,1),D1=D,X=1,D(1)=Z D SET ;move 4 node to 1
 ....S Z=X1,N14=1 K X,X1 ;this will move 1 node to 4
 ..S D(N)=Z,D1=D,X=N D SET
 .K DADRFM,MT1,MT2
 .S Z=TWO,D1=D,X="TWO" D SET
 .S Z="",$P(Z,"0",97)="",D1=D,X="W" D SET ;activity string
 .S X="HOL" D SET ;save holiday string
 .S X="P" D SET ;premium node
 .S X="r" D SET ;Recess node
 .S X=D(0),OFF=0 I $P(X,"^",2)=1 S OFF=1 ;day off
 .S Z=OFF,X="OFF" D SET
 .I +TWO=2 S MT2=$G(^TMP($J,"PRS8",D1,"MT2")),MT1=$G(^TMP($J,"PRS8",D1,"MT1")),^TMP($J,"PRS8",D1,"MT2")=MT1,^TMP($J,"PRS8",D1,"MT1")=MT2
 .I TYP["W" D  ; -- compute credit tour for WG
 ..S X=D(0) I DAY=0 S (L,T)=0
 ..I $P(X,"^",3) S X=$G(^PRST(457.1,+$P(X,"^",4),1)) ;temp tour
 ..E  S X=D(1) ;not temporary
 ..S S=0 F J=1,4 Q:D(J)=""  F I=3:3:28 Q:S!($P(D(J),"^",(I-2))="")  D
 ...I "^6^7^"[("^"_+$P(D(J),"^",I)_"^") S S=+$P(D(J),"^",I)-4
 ..I 'OFF S:'S S=1 S:(DAY>0)&(DAY<15) L=S ;credit tour
 ..I DAY>0,DAY<15 D
 ...I 'T S T=+S
 ...I S S T=S ;T=credit tour on days off
 ..S Z=S S:TYP'["W"&(Z>1) Z=1 S D1=DAY,X="TOUR" D SET
 ..I DAY=7!(DAY=14) S TOUR((DAY\7))=$S(T:T,1:1),T=0 ;save tour
 I TYP["B" S NH=320,(NH(1),NH(2))=160,TH=192,(TH(1),TH(2))=96 ; Baylor NH=40 hrs to mimic full time, TH = 24 hrs for reality
 E  S TH=NH,TH(1)=NH(1),TH(2)=NH(2) ;total hrs for pp
 ; 
 ; Update NH for the nurses on the 36/40 AWS
 I "KM"[$E(AC,1),$E(AC,2)=1,NH=288 S NH=320,(NH(1),NH(2))=160,TH=320,(TH(1),TH(2))=160
 ;
 I TYP["W",L>1 S $P(WK(3),"^",3)=L ;last tour (IN) in misc for WG
 S VALOLD=$G(^PRST(458,+PY,"E",+DFN,5)) ;existing decomp
 K D,D1,DAY,NDAY,FLAG,J,K,K1,L,LAST,MT,N,N1,N14,P,QT,T,V,W,X,Y,Y1,Z
 G ^PRS8ST ;start decomp
 ;
15 ; --- convert time to 15-minute increments
 ;
 ; Need to conditionally set Y $S(Y=0 mid=00:00, y=1: mid=24:00)
 ; based on whether exception is within or outside the tour.
 D MIL^PRSATIM ;convert to military (24hr) time
 I +Y<1000 S Y=$E("0000",0,4-$L(Y))_Y
 S X=(+$E(Y,1,2)*4)+($E(Y,3,4)\15)
 I 'Y1 S X=X+1 ; Add 15 minutes to start time
 I X<LAST S X=X+96,NDAY=1 ;new day
 S LAST=X Q
 ;
SET ; --- save value (Z) in ^TMP($J,"PRS8",DAY,X)
 ;
 S D1=+ZZ
 S ^TMP($J,"PRS8",D1,X)=Z Q
 ;
TAL ; --- T&L Unit (whole zeroth node)
 ;
 S X=$O(^PRST(455.5,"B",X,0))
 S X=$G(^PRST(455.5,+X,0)) I $E(X)="" S X=""
