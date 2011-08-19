LRBLPT1 ;AVAMC/REG - TRANSFUSION RESULTS (COND'T) ;12/11/92  07:38 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 W !! S LRJ=^TMP($J,LRV),(X,LRI)=+LRJ,F=$P(LRJ,"^",7),X=^LRD(65,X,0),LRC=$P(X,"^",11),M=^LAB(66,$P(X,"^",4),0),M(1)=$P(M,"^",24),M=$P(M,"^"),LRW=$P(X,"^",5),LR(65,.04)=+$P(X,"^",4)
 D U W !,"Is this the unit " S %=1 D YN^LRU Q:%'=1
DT S %DT="AEXT",%DT("A")="DATE/TIME TRANSFUSION COMPLETED: ",%DT(0)="-N" D ^%DT K %DT Q:Y<1  S LRR=Y,LRQ(1)="" I Y'["." W $C(7),"  Enter date & TIME" G DT
 I Y<LRW W $C(7),!!,"DATE/TIME MUST BE AFTER DATE UNIT RECEIVED IN INVENTORY",! G DT
 I M(1) S R=$O(^LRD(65,LRI,3,0)) I R S W(3)=^(R,0),R=+W(3),Z=Y D H^LRUT S J=%H,J(0)=Z(3),Z=R D H^LRUT S X=J-%H*1440,Y=J(0)-Z(3),J=X+Y I J>M(1) W $C(7),!!,"Prolonged transfusion time (",J," min) OK " S %=2 D YN^LRU Q:%'=1  G T
 S Y=LRR W !!,"DATE/TIME TRANSFUSION COMPLETED: " D D^LRU W Y," " S %=1 D YN^LRU G:%'=1 DT
T W !!,"TRANSFUSION REACTION " S %=2 D YN^LRU Q:%<1  S LRR(3)=$S(%=2:0,%=1:1,1:""),LRR(8)=""
 I LRR(3)=1 S DIC="^LAB(65.4,",DIC(0)="AEQM",DIC("S")="I $P(^(0),U,2)=""T""",DIC("A")="Select TRANSFUSION REACTION TYPE: " D ^DIC K DIC S:Y>0 LRR(8)=+Y
 S DIE="^LRD(65,",DA=LRI,DR="4.1///T;4.2///^S X=LRR;4.3////^S X=DUZ;7" D ^DIE I $D(^LRD(65,LRI,9,0)) S LRQ(1)=$P(^(0),"^",4) S:LRQ(1)>0 $P(^LRD(65,LRI,4),"^",4)="("_LRQ(1)_")"
 S X=$P(LRJ,"^",6) I X S X=$O(^LRD(65,LRI,2,LRDFN,1,"B",X,0)) S:X $P(^LRD(65,LRI,2,LRDFN,1,X,0),"^",10)="TRANSFUSED"
 F A=0:0 S A=$O(^LRD(65,DA,2,A)) Q:'A  I $D(^LR(A,1.8,LR(65,.04),1,DA,0)) K ^(0) L +^LR(A,1.8,LR(65,.04),1,0) S X=^LR(A,1.8,LR(65,.04),1,0),X(1)=$O(^(0)),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_($P(X,"^",4)-1) L -^LR(A,1.8,LR(65,.04),1,0)
 S LRR(1)=9999999-LRR S:'$D(^LR(LRDFN,1.6,0)) ^(0)="^63.017DAI^^" L +^LR(LRDFN,1.6)
F I $D(^LR(LRDFN,1.6,LRR(1))) S LRR(1)=LRR(1)-.00001 G F
 S ^LR(LRDFN,1.6,LRR(1),0)=LRR_"^"_$P(LRJ,"^",2)_"^"_$P(LRJ,"^",3)_"^"_DUZ_"^"_$P(LRJ,"^",4)_"^"_$P(LRJ,"^",5)_"^"_LRQ(1)_"^"_LRR(3)_"^^"_LRC_"^"_LRR(8)
 S:LRR(8) ^LR("AB",LRDFN,LRR(8),LRR(1))=""
 S ^LR(LRDFN,1.6,0)="^63.017DAI^"_LRR(1)_"^"_($P(^LR(LRDFN,1.6,0),"^",4)+1) L -^LR(LRDFN,1.6)
 S ^LRD(65,LRI,6)=LRDFN_"^"_LRMD_"^"_LRS_"^"_LRR(1)_"^"_LRR(3)_"^"_LRMD(1)_"^"_LRS(1)_"^"_LRR(8) S E=0 F E(1)=1:1 S E=$O(^LRD(65,LRI,7,E)) Q:'E  S E(2)=^(E,0),^LR(LRDFN,1.6,LRR(1),1,E(1),0)=E(2)
 S:E(1)>1 ^LR(LRDFN,1.6,LRR(1),1,0)="^63.186A^"_(E(1)-1)_"^"_(E(1)-1)
 S E(3)=$O(^LRD(65,LRI,2,LRDFN,1,0)) I E(3) S E=0 F E(1)=1:1 S E=$O(^LRD(65,LRI,2,LRDFN,1,E(3),3,E)) Q:'E  S E(2)=^(E,0),^LR(LRDFN,1.6,LRR(1),2,E(1),0)=E(2)
 S:E(1)>1 ^LR(LRDFN,1.6,LRR(1),2,0)="^63.027A^"_(E(1)-1)_"^"_(E(1)-1) Q
U W $P(X,"^"),?17,$E(M,1,22),?40,$J($P(X,"^",7),2),?43,$P(X,"^",8),?48 S Y=$P(X,"^",6) D DT^LRU W Y,?64,F Q
