PRSATP1 ; HISC/REL,WOIFO/PLT - Daily Post verification ;11/28/2006
 ;;4.0;PAID;**34,57,112**;Sep 21, 1995;Build 54
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;routine is called to validate data entered during the 
 ;screenman posting of an employees pay period
 ;
 K T S ZS="",TWO=$P($G(^PRST(457.1,+TC,0)),"^",5),DY2=TWO="Y" I TC2,'DY2 S TWO=$P($G(^PRST(457.1,+TC2,0)),"^",5),DY2=TWO="Y"
 F K=1:4:25 I $P(Z,"^",K)'="" D
 .S X=$P(Z,"^",K)_"^"_$P(Z,"^",K+1) I $P(Z,"^",K+1)="" D E8 Q
 .D CNV^PRSATIM S Z1=$P(Y,"^",1),Z2=$P(Y,"^",2) D V0
 .I Z2>1440,TWO'="Y","OT CT SB ON UA"'[$P(Z,"^",K+2) D E4 Q
 .I Z2>2880 D E5 Q
 .I $P(Z,"^",K+2)="" D E9 Q
 .;check duplicate start time if no rs-type of time in exception string z for node 2
 .I Z'["^RS",'(Z["HX"&("ON HW"[$P(Z,"^",K+2))),'(Z["^ON"&(Z["OT")),'(Z["^ON"&(Z["CT")),$D(T(Z1)) D E3 Q
 .I $P(Z,"^",K+2)="HW",Z'["HX",'$P($G(^PRST(458,PPI,"E",DFN,"D",DAY,0)),"^",12) D E7 Q
 .I $P(Z,"^",K+2)'="" S T(Z1)=$G(T(Z1))_$P(Z,U,K+2)_U,T(Z1,K)=Z2_"^"_$P(Z,"^",K,K+3)
 .Q
 I '$D(T) Q
 ;check duplicate start time if rs in exception string z for node 2.
 S Z1="" I Z["^RS",'(Z["^ON"&(Z["OT")),'(Z["^ON"&(Z["CT")) F  S Z1=$O(T(Z1)) QUIT:Z1=""  QUIT:Z["HX"&("^ON^HW^"[T(Z1))  I $L(T(Z1),U)>2 D  QUIT:Z1="*"
 . N A
 . S A=T(Z1),A=U_A
 . I $L(A,U)>4 S Z1="*" QUIT
 . I A'["^RS^" S A=$P(A,"^ON")_$P(A,"^ON",2) S:A="" A="^ON" I "^CT^"'[A,"^OT^"'[A,Z'["^HX"!("^HW^"'[A) S Z1="*" QUIT
 . I A["^RS^" S A=$P(A,"^RS")_$P(A,"^RS",2) S:A="" A="^RS" I "^CT^OT^RG^ON^HW^"'[A S Z1="*" QUIT
 . QUIT
 G:Z1="*" E3
 ;exclude rs with ct, ot, rg, on, hw for error e2 check
 I Z'["HX",'(Z["^ON"&(Z["OT")),'(Z["^ON"&(Z["CT")) S Z1="" F  S Z1=$O(T(Z1)) Q:Z1=""  G:Z1'<T(Z1,$O(T(Z1,0))) E1 S Y=$O(T(Z1)) I Y,T(Z1,$O(T(Z1,0)))>Y G E2:'(T(Z1)["RS^"&("^CT^OT^RG^ON^HW^"[T(Y)))&'("^CT^OT^RG^ON^HW^"[T(Z1)&(T(Y)["RS^"))
 S Z1="",LL=1 F  S Z1=$O(T(Z1)) Q:Z1=""  F K=0:0 S K=$O(T(Z1,K)) Q:K<1  D
 .S $P(ZS,"^",LL)=$P(T(Z1,K),"^",2),$P(ZS,"^",LL+1)=$P(T(Z1,K),"^",3),$P(ZS,"^",LL+2)=$P(T(Z1,K),"^",4) S:$P(T(Z1,K),"^",5)'="" $P(ZS,"^",LL+3)=$P(T(Z1,K),"^",5)
 .S LL=LL+4 Q
 S Z1=$$GET^DDSVAL(DIE,.DA,70)
 I Z1="" F K=1:4:25 G:$P(Z,"^",K+2)="AA" E6 I $P(Z,"^",K+2)="WP",$P(Z,"^",K+3)=3 G E10
 ;loop thru posting checking for comptime w/out remarks code.
 F K=1:4:25 G:($P(Z,"^",K+2)="CT")&($P(Z,"^",K+3)="") E11
 F K=1:4:25 G:($P(Z,"^",K+2)="CU")&($P(Z,"^",K+3)="") E12
 ;Now loop again checking to make sure compressed tours aren't
 ;trying to post credit hours remarks.
 I $$COMPR(PPI,DFN) F K=1:4:25 G:$$CTCH(Z,K) E13
 Q
 ;-------------------------------------------------
COMPR(P,D) ;return true if employee has a compressed tour indicator 
 ;        this pay period
 ;        INPUT:  P--pay period ien; D--Day number
 ;
 Q $P($G(^PRST(458,+P,"E",D,0)),"^",6)="C"
 ;-------------------------------------------------
CTCH(Z,K) ;return true if comp/credit earned (CT) posted and
 ;        the remarks code is credit hours.
 ;        INPUT: Z--Posting node from file 458
 ;               K--segment of posting node
 Q $P(Z,"^",K+2)="CT"&($P(Z,"^",K+3)="16")
 ;-------------------------------------------------
 ;
V0 I Z2>Z1 S:DY2=1&($O(T(0))>Z1) DY2=2 I DY2=2 S Z1=Z1+1440,Z2=Z2+1440
 S:Z2'>Z1 Z2=Z2+1440,DY2=2 Q
E1 S STR="A start time is not less than a stop time." G E20
E2 S STR="End of one segment must not be greater than start of next." G E20
E3 S STR="Duplicate start times encountered." G E20
E4 S STR="Segment of second day encountered; no two-day tour specified." G E20
E5 S STR="Segment of third day encountered." G E20
E6 S STR="Remarks must be entered when AA is posted." G E20
E7 S STR="HW can only be posted with HX or on a Holiday." G E20
E8 S STR="Stop Time not entered for a segment." G E20
E9 S STR="Type of Time not entered for a segment." G E20
E10 S STR="Remarks must be entered for WP due to AWOL." G E20
E11 S STR="REMARKS CODE must be entered when CT is posted." G E20
E12 S STR="REMARKS CODE must be entered when CU is posted." G E20
E13 S STR="REMARKS CODE:  Compressed tours can't earn credit hours." G E20
E20 K ZS,T S DDSERROR=1,TIM=0 D HLP^DDSUTL(.STR) Q
