LRBLJU ;AVAMC/REG - FIND UNITS NO DISPOSITION ;10/6/95  10:10 ;
 ;;5.2;LAB SERVICE;**72,247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 S %DT="T",X="N" D ^%DT S N=Y,E(1)=$S($D(E(1)):E(1),1:DT-.0001) S:'$D(LROPT) LROPT=""
 S IOP="HOME" D ^%ZIS W !!?20,$S($D(A)#2:A,1:""),!!
ASK R !,"Select: (A)ll blood components or (S)pecific component: ",S:DTIME G:S=""!(S[U) END G:S?1"A".E T I S'?1"S" W !!,"Enter A to list all components or S for a specific component",! G ASK
 S DIC=66,DIC(0)="AEQMZ",DIC("A")="Select BLOOD COMPONENT: ",DIC("S")="I $P(^(0),U,4)=""BB""" D ^DIC K DIC G:X=""!(X[U) END S C=+Y,C(1)=$P(Y(0),"^",3)
T R !,"Select: (A)ll units or (S)pecific ABO/Rh: ",X:DTIME G:X=""!(X[U) END G DEV:X?1"A".E I X'?1"S".E W !!,"Select A for all units or S for specific T & Rh",! G T
AB R !,"ABO GROUP: ",X:DTIME G:X=""!(X[U) END S T=$S(X="A":"A",X="O":"O",X="B":"B",X="AB":"AB",1:"") I T="" W $C(7),!!,"Enter A, O, B, or AB",! G AB
R R !,"Rh TYPE: ",X:DTIME G:X=""!(X[U) END S R=$S(X?1"P".E:"POS",X?1"N".E:"NEG",1:"") I R="" W $C(7),!!,"Enter P or N",! G R
DEV S ZTRTN="QUE^LRBLJU" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) D L^LRU,S^LRU
 G:S?1"A".E ALL
L S E=E(1) F E=E:0 S E=$O(^LRD(65,"AE",C,E)) Q:'E  D I
 Q:S?1"A".E
OUT D ^LRBLJU1 W:IOST'?1"C".E @IOF K ^TMP($J) D END^LRUTL,END Q
I I LROPT="" Q:E<N&(E[".")  I E'[".",E<$P(N,".") Q
 F I=0:0 S I=$O(^LRD(65,"AE",C,E,I)) Q:'I  D S
 Q
S Q:'$D(^LRD(65,I,0))  I $D(^(4)),$P(^(4),"^")]"" K ^LRD(65,"AE",C,E,I) Q
 S W=^LRD(65,I,0) Q:$P(W,"^",16)'=DUZ(2)
 S LRB=$P(W,"^",7),R(1)=$S($P(W,"^",8)]"":$P(W,"^",8),1:"?"),LRLLOC=$O(^LRD(65,I,3,0)),LRLLOC=$S(LRLLOC="":"Bld Bank",1:$P(^(LRLLOC,0),"^",4))
 I $D(T)#2,$D(R) Q:T'=LRB!(R'=R(1))
 S ^TMP($J,C,LRB,R(1),$P(W,"^",6),$P(W,"^"))=I_"^"_LRLLOC Q
ALL F C=0:0 S C=$O(^LRD(65,"AE",C)) Q:'C  D L
 G OUT
EN D END,SET G:Y=-1 END S LROPT="" G LRBLJU
EN1 D END,SET G:Y=-1 END S E(1)=0,LROPT="EN1" G LRBLJU
 ;
SET S X="BLOOD BANK" D ^LRUTL Q
 ;
END D V^LRU Q
