LRBLJD ;AVAMC/REG/CYM - BB UNIT DISPOSITION ;7/25/96  11:53 ; 12/18/00 2:06pm
 ;;5.2;LAB SERVICE;**25,72,78,247,267,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 ;
 ; References to ^DD(65, supported by DBIA3261
 ;
 Q  D END S LR("M")=1,LRN="",X="BLOOD BANK" D ^LRUTL G:Y=-1 END S X=$P(^DD(65,4.1,0),U,3),LR(3)="" F Y=1:1 S Z=$P($P(X,";",Y),":",2) Q:Z=""  I $A(Z)'=84 S LRB(Y)=Z
 W !?15,"Division: ",LRAA(4)
 I LRCAPA S X="UNIT MODIFICATION",X("NOCODES")=1 D X^LRUWK G:'$D(X) END K X S LRW("MO")=LRT S X="UNIT LOG-IN/SEND-OUT" D X^LRUWK G:'$D(X) END S LRW("S")=LRT F A=0:0 S A=$O(LRT(A)) Q:'A  S LRW("S",A)=""
 K LRT D BAR^LRBLB
ASK S X="N",%DT="T" D ^%DT S LRF=Y K %DT W !! S X=$$READ^LRBLB("Select UNIT ID FOR DISPOSITION: ") G:X=""!(X[U) END
 I LR,$E(X,1,$L(LR(2)))=LR(2) D
 .D ^LRBLBU
 E  W $$STRIP^LRBLB(.X)  ; Strip off data identifiers just in case
 G:'$D(X) ASK
 D REST,K^LRU K ^TMP($J),DA,LR("CK"),LR("C"),LR("%5"),LR("%4"),LR("%3"),LR("%2"),LR("%"),LRO,LRM,LRV,LRE,LRP,LRJ,LRT G ASK
REST S (DIC,DIE)="^LRD(65,",DIC(0)="EFQMZ",DIC("S")="I $P(^(0),U,16)=DUZ(2),$S('$D(^(4)):1,$P(^(4),U,2):0,$P(^(4),U)="""":1,1:0)" D ^DIC K DIC Q:Y<1
 S DA=+Y,LRV(10)=$P(Y(0),"^",10),LRV(4)=+$P(Y(0),"^",4),LRV(26)=$P(^LAB(66,LRV(4),0),U,26),LRV(15)=$P(Y(0),"^",15) D EN^LRBLJDA Q:$D(LR("%"))
 D CK^LRU Q:$D(LR("CK"))  S DR="[LRBLID]" D ^DIE D FRE^LRU  S LRX=DA K DIC,DIE,DR,DA,D S DA=LRX I $D(Y) D K Q
 F A=0:0 S A=$O(^LRD(65,DA,2,A)) Q:'A  I $D(^LR(A,1.8,LRV(4),1,DA,0)) K ^(0) L +^LR(A,1.8,LRV(4),1,0) S X=^LR(A,1.8,LRV(4),1,0),X(1)=$O(^(0)),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_($P(X,"^",4)-1) L -^LR(A,1.8,LRV(4),1,0)
 D:$D(LR("%2")) EN1^LRBLJDA Q:'$D(LRE(1))  D:"RS"[LRE(1)&LRCAPA RS^LRBLW Q:LRE(1)'="MO"  S LRJ=$P($G(^LRD(65,LRX,8)),"^",2) S:LRCAPA LRT=LRW("MO")
 S LRV(3)=$P(^LAB(66,LRE(4),0),"^",10),DIE="^LRD(65,",DA=LRX,DR=".11//^S X=LRV(3);S LRM=X" D ^DIE I $D(Y) D K Q
M S DIC="^LAB(66,LRE(4),3,",DIC(0)="AEQMZ" D ^DIC K DIC I Y<1 W !!,"Nothing selected " D K Q
 S LRV=+Y,LRV(2)=$P(Y(0),"^",2),X=^LAB(66,LRV,0),LRN=$P(X,"^",28),LRV(1)=$P(X,"^"),LRV(6)=$P(X,"^",6),LRV(6)=$S("DP"[LRV(6):LRV(6),1:""),LRD=$P(X,"^",18),LRJ(1)=$P(X,"^",25)
 I LRV(1)["PLASMA REMOVED" D PV^LRBLJDA I '$D(Z) D K Q
 I LRJ,LRJ(1)'=1 W $C(7),!!,"Unit has positive screening tests and component selected is not autologous.",! G M
 S (LRO(9),LRO(1))=$P(X,"^",11),LRV(11)="" D:LRO(1) F^LRBLJDM
 S LRE=^LRD(65,LRX,0),(LRE(6),Y)=$P(LRE,"^",6) S:LRE(6)'["." LRE(6)=LRE(6)_".9999" D D^LRU S LRE(3)=Y,LRE(69)=LRE(6)
 I LRE(6)<LRF W $C(7),!!,"UNIT EXPIRED " S Y=$P(LRE,U,6) D D^LRU W Y," STILL WANT TO MODIFY " S %=2 D YN^LRU I %'=1 D K Q
 I LRO(1)="" S Y=$P(LRE,"^",6) D DA^LRU S LRO(1)=Y
 D @$S(LRV(6)="D":"D^LRBLJDM",LRV(2):"^LRBLJDM",LRV(6)="P":"^LRBLJD1",1:"S^LRBLJDM") Q
K ;from LRBLJD1, LRBLJDM, [LRBLID] edit template file #65
 W $C(7),!,"Answer all prompts (no NULL responses) DISPOSITION DELETED",!!
 X:$D(^DD(65,4.1,1,1,2)) ^(2) X:$D(^DD(65,4.1,1,2,2)) ^(2) X:$D(^DD(65,4.1,1,3,2)) ^(2) S X=$S($D(^LRD(65,DA,4)):$P(^(4),"^",2),1:"") K:X ^LRD(65,"AB",X,DA) K ^LRD(65,DA,4),^(5) Q
 ;
END D V^LRU Q
 ;
R R !,"DISPOSITION: ",LRE(1):DTIME S:LRE(1)="" LRE(1)=U Q:LRE(1)[U
 F X=0:0 S X=$O(LRB(X)) Q:'X  I $E(LRB(X),1,$L(LRE(1)))=LRE(1) W $E(LRB(X),$L(LRE(1))+1,$L(LRB(X))) S LRE(1)=LRB(X) G OUT
 W !!,"Select from:"
 F X=0:0 S X=$O(LRB(X)) Q:'X  W !?3,LRB(X)
 W ! G R
OUT I $D(^LRD(65,DA,8)),$P(^(8),"^",2)'=0,LRE(1)="SEND ELSEWHERE"!(LRE(1)="SALVAGED") S X=$P(^(8),"^",2) D C
 Q
C W $C(7),!,$S(X:"POSITIVE",1:"INCOMPLETE")," SCREENING TESTS." I LRE(1)="SEND ELSEWHERE" W " WANT TO CONTINUE " S %=2 D YN^LRU S:%'=1 LRE(1)=U Q
 W " SALVAGE NOT ALLOWED." S LRE(1)=U Q
