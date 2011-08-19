FHORD71 ; HISC/REL - Diet Order Utilities (cont) ;10/1/96  10:00
 ;;5.5;DIETETICS;;Jan 28, 2005
GETD ; Get from/to dates
 S (D1,D2)=0 D NOW^%DTC S NOW=%,DT=NOW\1 K %,%H,%I
D1 R !!,"Effective Date/Time: NOW// ",X:DTIME Q:'$T!(X="^")  S:X="" X="NOW" D:$E($P(X,"@",2),1)?1U CNV S %DT="ETSX" D ^%DT Q:U[X  G:Y<1 D1
 I Y<NOW W *7,"  Cannot be effective before now!" G GETD
 S D1=+Y Q:'D3
D2 R !!,"Expiration Date/Time: ",X:DTIME G:'$T!(X["^") D3 Q:X=""  D:$P(X,"@",2)?1U CNV S %DT="ETSX" D ^%DT G D3:U[X,D2:Y<1
 I Y'>D1 W *7,"  Cannot end before effective date!" G GETD
 S D2=+Y Q
D3 S D1=0 Q
CNV S DP=$P($G(^FHPT(FHDFN,"A",ADM,0)),"^",8)
 I DP'="" S DP=$P($G(^FH(119.6,DP,0)),"^",8)
 S FHPAR=$G(^FH(119.73,+DP,2))
 S A1=$E($P(X,"@",2),1) I A1'="M" S A1=$S(A1="B":$P(FHPAR,"^",7),A1="N":$P(FHPAR,"^",8),A1="E":$P(FHPAR,"^",9),1:A1),$P(X,"@",2)=A1 Q
 S X=$P(X,"@",1),%DT="X" D ^%DT I Y<1 S X=X_"@2359" Q
 S X1=Y,X2=1 D C^%DTC K %H,%T Q:X<1  S X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_(1700+$E(X,1,3))_"@0001" Q
ACR ; Store AC diet sequence data
 G:Z6<1 A1 I '$D(^FHPT(FHDFN,"A",ADM,"AC",0)) S ^(0)="^115.14^^"
 S ^FHPT(FHDFN,"A",ADM,"AC",+Z6,0)=Z6,$P(^FHPT(FHDFN,"A",ADM,"AC",0),"^",3)=+Z6
 I Z6'>NOW S Z6=1 G A1
 N X,X1,FHORN K ZTSAVE
 S ZTIO="",ZTRTN="UPD^FHORD7",ZTREQ="@",ZTDESC="Diet Update",ZTDTH=+Z6
 S ZTSAVE("DFN")=DFN,ZTSAVE("FHDFN")=FHDFN,ZTSAVE("ADM")=ADM,ZTSAVE("Z6")=+Z6,ZTSAVE("ZTREQ")="" D ^%ZTLOAD K ZTSK
 S Z6=1
A1 S $P(^FHPT(FHDFN,"A",ADM,"AC",0),"^",4)=$P(^FHPT(FHDFN,"A",ADM,"AC",0),"^",4)+Z6 K Z6 Q
OE ; File OE/RR Diet Order
 Q:FHLD="X"!(FHLD="P")
 S FHO=FHOR,VAL="" D VAL^FHWORP(FHO,.VAL) Q:VAL=""
 S FHNEW=$S(FHLD'="":"N",1:"D")_";"_ADM_";"_FHORD_";"_D1_";"_D2_";"_FHLD_";"_COM_";"_TYP_";"_D4_";"_VAL
 S (FHSTS,FHDU)=$S(D1>NOW:8,1:6)
 I FHWF=1 D FILE S:FHDU $P(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0),"^",15)=FHDU Q
 I FHWF=2 S FHDU=+FHORN_"^"_FHDU D FHWF2
 S:+FHDU $P(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0),"^",14,15)=FHDU Q
OEU ; Update status of OE/RR orders
 N FHORN K A1 S A1=0
 F K=0:0 S K=$O(^FHPT(FHDFN,"A",ADM,"AC",K)) Q:K>NOW!(K<1)  S A1=K
 I A1 S X=$P(^FHPT(FHDFN,"A",ADM,"AC",A1,0),"^",2),A1(+X)=A1,A1=+X
 F K=NOW:0 S K=$O(^FHPT(FHDFN,"A",ADM,"AC",K)) Q:K<1  S X=$P(^(K,0),"^",2) I '$D(A1(+X)) S A1(+X)=K
 F K=0:0 S K=$O(^FHPT(FHDFN,"A",ADM,"DI",K)) Q:K=""  S FHORN=$P(^(K,0),"^",14) I FHORN S STS=$P(^(0),"^",15) D U1
 K A1,K,X,FHORN,FHL,FHO,FHMSG1,FHSAV,STS Q
U1 I '$D(A1(K)) Q:STS<3  S $P(^FHPT(FHDFN,"A",ADM,"DI",K,0),"^",15)=1,FHSTS=1,FHSAV=$G(^FHPT(FHDFN,"A",ADM,"DI",K,0)) Q:'$D(^OR(100,FHORN))  G U3
 N FHMSG1,FHO,FHSAV S FHSAV=$G(^FHPT(FHDFN,"A",ADM,"DI",K,0))
 S FHO=$P(FHSAV,"^",2,6),VAL="" D VAL^FHWORP(FHO,.VAL) Q:VAL=""
 S FHMSG1=$S($P(FHSAV,"^",7)="N":"N",1:"D")_";"_ADM_";"_K_";"_$P(FHSAV,"^",9)_";"_$P(FHSAV,"^",10)_";"_$P(FHSAV,"^",7)_";"_$G(^FHPT(FHDFN,"A",ADM,"DI",K,1))_";"_$P(FHSAV,"^",8)_";;"_VAL
 S FHDAT="",FHSTRT=$P(^FHPT(FHDFN,"A",ADM,"DI",K,0),"^",9) I FHSTRT'=A1(K) S FHDAT=A1(K)
 S FHDAT=FHDAT_"^"_$P(^FHPT(FHDFN,"A",ADM,"DI",K,0),"^",10)
 S FHSTS=$S(K=A1:6,1:8) I FHSTS'=STS S $P(^FHPT(FHDFN,"A",ADM,"DI",K,0),"^",15)=FHSTS
 I '$D(^OR(100,FHORN)) K FHDAT,FHSTRT,FHSTS Q
 I $D(FHORN1),FHORN1=FHORN S FHORR=1
 I $P(FHSAV,"^",7)="N" D CODE^FHWOR4 D:$D(MSG) MSG^XQOR("FH EVSEND OR",.MSG) K MSG,FHDAT,FHSTRT,FHSTS Q
 I $P(FHSAV,"^",7)="" D CODE^FHWOR2 D:$D(MSG) MSG^XQOR("FH EVSEND OR",.MSG) K MSG
 K FHDAT,FHSTRT,FHSTS Q
U3 S FHO=$P(FHSAV,"^",2,6),VAL="" D VAL^FHWORP(FHO,.VAL) Q:VAL=""
 S FHMSG1=$S($P(FHSAV,"^",7)="N":"N",1:"D")_";"_ADM_";"_K_";"_$P(FHSAV,"^",9)_";"_$P(FHSAV,"^",10)_";"_$P(FHSAV,"^",7)_";"_$G(^FHPT(FHDFN,"A",ADM,"DI",K,1))_";"_$P(FHSAV,"^",8)_";;"_VAL
 I $D(FHORN1),FHORN1=FHORN S FHORR=1
 S FHDAT=""
 I $P(FHSAV,"^",7)="N" D CODE^FHWOR4 D:$D(MSG) MSG^XQOR("FH EVSEND OR",.MSG) K MSG Q
 I $P(FHSAV,"^",7)="" D CODE^FHWOR2 D:$D(MSG) MSG^XQOR("FH EVSEND OR",.MSG) K MSG
 Q
FILE ; File Orders from Dietetics
 I FHLD="N" D NPO^FHWOR4 D:$D(MSG) MSG^XQOR("FH EVSEND OR",.MSG) K MSG Q
 I FHLD="" D DO^FHWOR2 D:$D(MSG) MSG^XQOR("FH EVSEND OR",.MSG) K MSG
 Q
FHWF2 ; Perform if orders comes from OE/RR
 S $P(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0),"^",14)=$S(+FHORN:+FHORN,1:0)
 Q:FHLD="X"!(FHLD="P")
 Q:'FHORN  S VAL="" D VAL^FHWORP(FHOR,.VAL) Q:VAL=""
 S FILL=$S(FHLD="N":"N;",1:"D;")_ADM_";"_FHORD_";"_D1_";"_D2_";"_FHLD_";"_COM_";"_TYP_";"_D4_";"_VAL
 I FHLD="N" D SEND^FHWOR D:$D(MSG) MSG^XQOR("FH EVSEND OR",.MSG) K MSG Q
 I FHLD="" D SEND^FHWOR D:$D(MSG) MSG^XQOR("FH EVSEND OR",.MSG) K MSG
 Q
WAIT ; Hold screen for OE/RR
 Q:$E(IOST,1)'="C"  R !!?5,"Press return to continue ",X:DTIME Q
