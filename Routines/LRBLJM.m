LRBLJM ;AVAMC/REG/CYM - EDIT POOLED UNIT ;9/26/97  13:01 ;
 ;;5.2;LAB SERVICE;**90,247,267,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 Q  D END S X="BLOOD BANK" D ^LRUTL G:Y=-1 END D BAR^LRBLB
ASK W !! S X=$$READ^LRBLB("Select POOLED UNIT: ") G:X=""!(X[U) END
 I X'["?",LR,$E(X,1,$L(LR(2)))=LR(2) D ^LRBLBU G:'$D(X) ASK
 W:'LR $$STRIP^LRBLB(.X)  ; Strip off the data identifiers just in case
 I '$O(^LRD(65,"B",X,0)) W $C(7),"  Must enter a specific unit" G ASK
 D REST,K^LRU
 I $D(LRLOCK) L -^LRD(65,LRLOCK)
 K ^TMP($J),LRV,LRP,DA,LRLOCK G ASK
REST S LR("Q")=0,DIC="^LRD(65,",DIC(0)="EFQMZ",DIC("S")="I $P($G(^LAB(66,+$P(^(0),U,4),0)),U,27)"
 D ^DIC K DIC Q:Y<1  S LRP=+Y,LRW=Y(0),LRA=$P(^LAB(66,$P(Y(0),U,4),0),U,26) D L Q:LRL
 I $P(^LRD(65,LRP,0),U,16)'=DUZ(2) W $C(7),!!,"You can only edit Pooled Units from your own division.",! G ASK
 I '$O(^LRD(65,LRP,9,0)) W $C(7),!,"No units in pool." Q
 W !?5,"Units in pool: " S E=0 F LRB=0:0 S LRB=$O(^LRD(65,LRP,9,LRB)) Q:'LRB!(LR("Q"))  S X=^(LRB,0),Y=$P(X,"^",2),LRZ=+X D:Y]"" W
 Q:'$D(^TMP($J))!(LR("Q"))
S S DIR(0)="S^A:Add unit to pool;R:Remove unit from pool;D:Delete the pool" D ^DIR
 G:$D(DIRUT) END
 D @(Y_"^LRBLJM1")
 Q
 ;
W S LRV=0 F B=0:0 S B=$O(^LRD(65,"B",Y,B)) Q:'B  S W=^LRD(65,B,0),W(4)=$P(^LAB(66,LRZ,0),U) I $P(W,U,4)=LRZ S LRV=1,E=E+1,^TMP($J,E)=LRB_U_B_U_$P(W,U)_U_W(4) W !?7,$P(W,U),?25,W(4) D:E#21=0 M^LRU Q:LR("Q")
 I 'LRV S LR("Q")=1 D F
 Q
F W $C(7),!!?7,Y,?25,$P(^LAB(66,LRZ,0),U)," not correct" S DIC="^LAB(66,",DIC(0)="AEQM",DIC("S")="I $P(^(0),U,26)=LRA",DIC("A")="Select CORRECT COMPONENT: " D ^DIC K DIC Q:Y<1  S $P(^LRD(65,LRP,9,LRB,0),U)=+Y
 S DA(1)=LRP,DA=LRB,X=+Y,O=LRZ,Z="65.091,.01" D EN^LRUD
 Q
L ;
 S LRL=0
 I $D(LRLOCK)#2 L -^LRD(65,LRLOCK)
 S LRLOCK=LRP L +^LRD(65,LRP):1
 I '$T W !,$C(7),"ANOTHER TERMINAL IS EDITING ",$P(^LRD(65,LRP,0),U) S LRL=1
 Q
 ;
END D V^LRU Q
