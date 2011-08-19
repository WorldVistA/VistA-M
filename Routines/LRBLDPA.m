LRBLDPA ;AVAMC/REG/CYM - BLOOD DONOR PRINT ;6/26/96  08:57 ;
 ;;5.2;LAB SERVICE;**72,247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D END S (LRN,LR("Q"))=0,DIC="^LRE(",DIC(0)="AEQMZ",DIC("A")="Select DONOR: " D ^DIC K DIC G:X=""!(X[U) END S LR=+Y
 I $O(^LRE(LR,5,0)) W !!,"Select a single donation date " S %=2 D YN^LRU G:%<1 END I %=1 K ^TMP($J) S (A,C)=0 D L G:'$D(LRI) END W !!,"Include workload information " S %=2 D YN^LRU Q:%<1  S:%=1 LRN=1
 K DIC,DIE,DR S ZTRTN="QUE^LRBLDPA" W ! D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE N NAME U IO D L^LRU,S^LRU F X=6.1,6.2,6.3,6.4 D FIELD^DID(65.5,X,"","LABEL","NAME") S Y=NAME("LABEL")
 S DIWL=5,DIWR=IOM-5,DIWF="W"
 D ^LRBLDPA1,END^LRUTL,END Q
L F B=1:1 S A=$O(^LRE(LR,5,A)) Q:'A!(LR("Q"))  S W=^(A,0) D:B#21=0 M^LRU Q:LR("Q")  S Y=+W,W(2)=$P(W,"^",2),C=C+1,^TMP($J,C)=A D D^LRU D W
ASK Q:'$D(^TMP($J))  W !!,"CHOOSE FROM 1-",C," : " R X:DTIME Q:X=""!(X[U)  I X'=+X!(X<1)!(X>C) W $C(7)," Numbers only from 1 to ",C G ASK
 S LRI=^TMP($J,X),Y=+^LRE(LR,5,LRI,0) D D^LRU W " ",Y K ^TMP($J) Q
W W:B=1 !!?5,"Donation Date",?30,"Unit ID" W !,$J(C,2),?5,Y,?30,$P(W,"^",4) W:W(2)="N" "NO DONATION"
 Q
END D V^LRU Q
