LRBLJCK ;AVAMC/REG - INVENTORY ABO/RH CK ;7/30/95  15:38 ; 12/18/00 2:03pm
 ;;5.2;LAB SERVICE;**72,247,267,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 ; 
 ; References to ^DD(65, supported by DBIA3261
 ;
SD S Y(1)=Y+.99,Y=Y-.0001 F T=Y:0 S T=$O(^LRD(65,"A",T)) Q:'T!(T>Y(1))  F A=0:0 S A=$O(^LRD(65,"A",T,A)) Q:'A  S X=^LRD(65,A,0) I $P(X,"^",3)=LRA,$P(^LAB(66,$P(X,"^",4),0),"^",19) S ^TMP($J,$P(X,"^"),A)=""
 Q
ST F A=0:0 S A=$O(^LRD(65,"A",Y,A)) Q:'A  S X=^LRD(65,A,0) I $P(X,"^",3)=LRA,$P(^LAB(66,$P(X,"^",4),0),"^",19) S ^TMP($J,$P(X,"^"),A)=""
 Q
E S (LRW(10),LRW(11))="" W !! S X=$$READ^LRBLB("UNIT ID: ") G:X=""!(X["^") END
 I LR,$E(X,1,$L(LR(2)))=LR(2) D ^LRBLBU G:'$D(X) E
 W:'LR $$STRIP^LRBLB(.X)  ; Strip off data identifiers just in case
 X $P(^DD(65,.01,0),"^",5,99) I $D(X),X["?" K X
 I '$D(X) W !!,$C(7),$S($D(^DD(65,.01,3)):^(3),1:""),! X:$D(^(4)) ^(4) G E
 S DIC=65,DIC(0)="EFMXZ",DIC("S")="I $P(^(0),U,16)=DUZ(2)" D ^DIC K DIC I Y<1 W $C(7),"  (NOT IN INVENTORY FILE)" G E
 S (DA,LRX)=+Y,DIE="^LRD(65,",DR="[LRBLIABRH]" D ^DIE D DT^LRBLU I LRCAPA D:LRW(10)]""&(LRW(10)'="ND") ABO D:LRW(11)]""&(LRW(11)'="ND") RH
 G E
 ;
ABO K LRT S LRT=LRW("ABO") Q:$D(^LRD(65,LRX,99,LRT))  F A=0:0 S A=$O(LRW("ABO",A)) Q:'A  S LRT(A)=""
 D:LRCAPA ^LRBLW Q
RH K LRT S LRT=LRW("RH") Q:$D(^LRD(65,LRX,99,LRT))  F A=0:0 S A=$O(LRW("RH",A)) Q:'A  S LRT(A)=""
 D:LRCAPA ^LRBLW Q
EN ;
 Q  D V^LRU,S^LRBLW S LR("M")=1,X="BLOOD BANK" D ^LRUTL G:Y=-1 END W !!?28,"Inventory ABO/Rh check",!!?15,"Division: ",LRAA(4) K LRE Q:'$D(DUZ)#2
 I LRCAPA F Y="ABO","RH" K LRT S X="UNIT "_Y_" RECHECK" D X^LRUWK G:'$D(X) END S LRW(Y)=LRT F A=0:0 S A=$O(LRT(A)) Q:'A  S LRW(Y,A)=""
 K LRT D BAR^LRBLB W !!,"Enter TEST COMMENT(s) " S %=2 D YN^LRU G:%<1 END S:%=1 LRQ=1
ASK W !!?14,"1) Enter by invoice# (batch)",!?14,"2) Entry by unit ID",!,"Select 1 or 2:" R X:DTIME G:X=""!(X[U) END
 I X<1!(X>2) W $C(7),!,"Enter a '1' to automatically request data entry for all units in a given invoice",!,"Enter a '2' to specify unit ID" G ASK
 S DIE=("NO")="OUTOK",LR(3)="" G:X=2 E
I W !!,"Select ",$P(^DD(65,.03,0),"^"),": " R X:DTIME G:X=""!(X[U) END S:X["?" X="?" X $P(^(0),"^",5,99) I '$D(X) W:$D(^(3)) !,^(3) X:$D(^(4)) ^(4) G I
 S LRA=X
 S %DT="AETX",%DT("A")="Enter date received: ",%DT(0)="-N" D ^%DT K %DT G:Y<1 END S LRB=Y
 D WAIT^LRU D @($S(Y[".":"ST",1:"SD")) I '$D(^TMP($J)) W $C(7),!!,"There are no units in inventory for invoice# ",LRA," for " S Y=LRB D D^LRU W Y G ASK
 D DT^LRBLU S LRD(1)=0 F LRA=0:0 S LRD(1)=$O(^TMP($J,LRD(1))) Q:LRD(1)=""!($D(LRE))  F LRD=0:0 S LRD=$O(^TMP($J,LRD(1),LRD)) Q:'LRD!($D(LRE))  D A
 G:$D(LRE) E Q
A S (LRW(10),LRW(11))="" W !!,LRD(1) S (DA,LRX)=LRD,DIE="^LRD(65,",DR="[LRBLIABRH]" D ^DIE I $D(Y) W !!,"WANT TO STOP LOOPING " S %=1 D YN^LRU S:%=1 LRE=1
 I LRCAPA D:LRW(10)]""&(LRW(10)'="ND") ABO D:LRW(11)]""&(LRW(11)'="ND") RH
 Q
 ;
END D V^LRU Q
