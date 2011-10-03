LRBLWD ;AVAMC/REG - STUFF WORKLOAD IN 65.5 ;2/7/91  18:45
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
N S Y="ND" G SET ;no donation
HW S Y="HW" G SET ;homologous whole blood donation
TW S Y="TW" G SET ;therapeutic phlebotomy
DW S Y="DW" G SET ;directed whole blood
HP S Y="HP" G SET ;homologous plasmapheresis
AP ;autologous plasmapheresis
 D CK S Y=$S('Z:"APF",1:"APN") G SET ;APF=1st APN=not 1st
TP S Y="TP" G SET ;therapeutic plasmapheresis
DP S Y="DP" G SET ;directed plasmapheresis
HC S Y="HC" G SET ;homologous cytapheresis
AC ;autologous cytapheresis
 D CK S Y=$S('Z:"ACF",1:"ACN") G SET ;ACF=1st ACN=not 1st donation
TC S Y="TC" G SET ;therapeutic cytapheresis
DC S Y="DC" G SET ;directed cytapheresis
AW ;autologous whole blood donation
 D CK S Y=$S('Z:"AWF",1:"AWN") G SET ;AWF=1st AWN=not 1st donation
 ;
C S X=$D(^LRE(LRQ,5,LRI,99,LRT,0)) Q
CK S X1=9999999-LRI,X2=-60 D C^%DTC S Z(1)=9999999-X
 S Z=0 F X=LRI:0 S X=$O(^LRE(LRQ,5,X)) Q:'X!(X>Z(1))  S Y=$P(^(X,0),"^",11) I Y="A" S Z=1 Q
 Q
SET K LRT S LRT=+LRW(Y),LR(60,320)=$P(LRW(Y),"^",2) D C Q:X  F A=0:0 S A=$O(LRW(Y,A)) Q:'A  S LRT(A)=""
 S LRK=$S($D(LRK("LRK")):LRK("LRK"),$D(LR("LRBLDLG")):$P(^LRE(LRQ,5,LRI,0),"^",13),1:"") D:'LRK DT^LRBLU D ^LRBLWDS K LRT Q
 ;
X K LRT S LRT=$O(^LAB(60,"B",X,0)) G:'LRT OUT Q:$D(X("NOCODES"))
 F B=0:0 S B=$O(^LAB(60,LRT,9,B)) Q:'B  S LRT(B)=""
 Q:$D(LRT)=11
OUT W $C(7),!!,"Must have test in LAB TEST file (#60) called",!,"'",X,"'" W:'$D(X("NOCODES")) " with WKLD CODES." K X S LRX=1 Q
S S LRW(Y)=LRT_"^"_$P(^LAB(60,LRT,0),"^",19) F A=0:0 S A=$O(LRT(A)) Q:'A  S LRW(Y,A)=""
 Q
Z ;from LRBLDLG
 K LRX S X="DONOR DEFERRAL" D X I $D(X) S Y="ND" D S
 S X="HOMOLOGOUS WB DONATION" D X I $D(X) S Y="HW" D S
 S X="HOMOLOGOUS PLASMAPHERESIS" D X I $D(X) S Y="HP" D S
 S X="HOMOLOGOUS CYTAPHERESIS" D X I $D(X) S Y="HC" D S
 S X="AUTOLOGOUS WHOLE BLOOD 1ST" D X I $D(X) S Y="AWF" D S
 S X="AUTOLOGOUS WHOLE BLOOD NOT 1ST" D X I $D(X) S Y="AWN" D S
 S X="AUTOLOGOUS PLASMAPHERESIS 1ST" D X I $D(X) S Y="APF" D S
 S X="AUTOLOGOUS PLASMAPH NOT 1ST" D X I $D(X) S Y="APN" D S
 S X="AUTOLOGOUS CYTAPHERESIS 1ST" D X I $D(X) S Y="ACF" D S
 S X="AUTOLOGOUS CYTAPH NOT 1ST" D X I $D(X) S Y="ACN" D S
 S X="THERAPEUTIC PHLEBOTOMY" D X I $D(X) S Y="TW" D S
 S X="THERAPEUTIC PLASMAPHERESIS" D X I $D(X) S Y="TP" D S
 S X="THERAPEUTIC CYTAPHERESIS" D X I $D(X) S Y="TC" D S
 S X="DIRECTED WB DONATION" D X I $D(X) S Y="DW" D S
 S X="DIRECTED PLASMAPHERESIS" D X I $D(X) S Y="DP" D S
 S X="DIRECTED CYTAPHERESIS" D X I $D(X) S Y="DC" D S
 K LRT Q
