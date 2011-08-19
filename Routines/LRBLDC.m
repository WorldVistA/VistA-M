LRBLDC ;AVAMC/REG/CYM - DONOR COMPONENT PREP ;7/3/96  11:58 ;
 ;;5.2;LAB SERVICE;**72,247,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 Q  D V^LRU S X="BLOOD BANK" D ^LRUTL G:Y=-1 END W @IOF,?20,"Collection disposition/component preparation",!
 I LRCAPA S X="DONOR COMPONENT PREPARATION",X("NOCODES")=1 D X^LRUWK G:'$D(X) END
 D BAR^LRBLB
I R !!,"Select BLOOD DONOR: ",X:DTIME G:X=""!(X[U) END I X?7N.N,X'["?",LR,$E(X,1,$L(LR(2)))=LR(2) D EN^LRBLBU G:'$D(X) I
 S DIC="^LRE(",DIC(0)="EQM",D="B^C^"_$S("NAFARMY"[DUZ("AG")&(DUZ("AG")]""):"G4^G",1:"D") D MIX^DIC1 K DIC G I:Y<1 S LRQ=+Y D REST,^LRBLDC1 K LR("CK"),DIC,DIE,DR,DA,DQ G I
REST S LRI=$O(^LRE(LRQ,5,0)) I 'LRI W $C(7),!!,"No collection date for this patient",! Q
 I $P(^LRE(LRQ,5,LRI,0),U,4)="" W $C(7),!,"NO UNIT ID ENTERED !" Q
 I $P(^LRE(LRQ,5,LRI,0),U,14) W $C(7),!,"Not allowed, data entered via old blood donor records option." Q
 S X=^LRE(LRQ,0),LRP=$P(X,U),W(5)=$P(X,U,5),W(6)=$P(X,U,6)
 S Z=^LRE(LRQ,5,LRI,0),Y=$S($D(^(2)):$P(^(2),"^",2),1:+Z) D D^LRU W !!,"Donor: ",LRP,"  ABO: ",W(5)," Rh: ",W(6),!,"Donation date/time: ",Y,?50,"Unit ID: ",$P(Z,"^",4)
 S C=$P(Z,"^",2) I C=""!(C="N") W $C(7),!,"Sorry no collection indicated",! Q
 I $P(Z,"^",10)=2 W $C(7),!,"Collection discarded",! Q
 N LRDATA S LRDATA=^LRE(LRQ,5,LRI,2),LR(65.54)=$P(LRDATA,U,3)
 S DIE="^LRE(",DA=LRQ,DR="[LRBLDC]" D CK^LRU Q:$D(LR("CK"))  W ! D ^DIE D FRE^LRU
 Q:'$D(LRB)  K LRF,DIC,DIE,DR,DA F A=0:0 S A=$O(^LRE(LRQ,5,LRI,66,A)) Q:'A  W !?5,$P(^LAB(66,A,0),"^") S LRF(A)=""
 S:'$D(^LRE(LRQ,5,LRI,66,0)) ^(0)="^65.66PAI^^"
C S (DIC,DIE)="^LRE(LRQ,5,LRI,66,",LRZ=0 F X=0:0 S X=$O(^LRE(LRQ,5,LRI,66,X)) Q:'X  S LRZ=$P(^LAB(66,X,0),"^",19) Q:LRZ
 R !!,"Select BLOOD COMPONENT: ",X:DTIME G:X=""!(X[U) W I LR,$E(X,1,$L(LR(2)))=LR(2),$A(X)<58,$A(X)>47 D P^LRBLB G:'$D(X) C
 W ! S DA(2)=LRQ,DA(1)=LRI,LRB(4)=$P(^LRE(LRQ,5,LRI,66,0),"^",4),DIC(0)=$S(LRB(4)<LRB(1):"EQLM",1:"EQM") S:(LRB(4)<LRB(1)) DLAYGO=65 D ^DIC K DIC,DLAYGO G:Y<1 C S DA=+Y,LRA=^LAB(66,DA,0) I $P(Y,"^",3),LRZ,$P(LRA,"^",19) D KILL G C
 S X=^LRE(LRQ,5,LRI,66,DA,0),O=$P(X,U,3),M=$P(X,U,4),M(5)=$P(X,U,5),LRB(6)=9999999,LRB(5)="",LRB(7)=$P(LRA,"^",17),LRA=$P(LRA,"^",10)
 I LRB(7) S LRB(3)=$P(LRB(2),".",2),X1=$P(LRB(2),"."),X2=$P(LRB(7),".") D C^%DTC S (Y,LRB(6))=X D D^LRU S LRB(5)=Y I LRB(7)["." S Z=LRB(6)_"."_LRB(3),X="."_$P(LRB(7),".",2),Z(0)=$P(X*24*60,".") D EN
 S DR=".01;.03//^S X=LRB(9);I $L(O),O'=X S Z=.03 D S^LRBLDC;S:'X Y=.01;.04//^S X=LRB(5);D:X>LRB(6) X^LRBLDC;I $L(M),M'=X S O=M,Z=.04 D S^LRBLDC;.05//^S X=LRA;I $L(M(5)),M(5)'=X S O=M(5),Z=.05 D S^LRBLDC"
 D ^DIE G C
W F W=0:0 S W=$O(LRF(W)) Q:'W  I '$D(^LRE(LRQ,5,LRI,66,W)) S Z="65.66,.01",(O,DA)=W,DA(1)=LRI,DA(2)=LRQ,X="deleted" D EN^LRUD
 Q
KILL W !,$C(7),"Cannot select more than one red blood cell product.",!,"Selection ",$P(^LAB(66,DA,0),U)," canceled !",! L +^LRE(LRQ,5,LRI,66)
 K ^LRE(LRQ,5,LRI,66,DA),^LRE(LRQ,5,LRI,66,"B",DA) S X=^LRE(LRQ,5,LRI,66,0),X(1)=$O(^(0)),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_$S(X(1)="":"",1:($P(X,"^",4)-1)) L -^LRE(LRQ,5,LRI,66) Q
 ;
END D V^LRU Q
 ;
S S Z="65.66,"_Z D EN^LRUD Q
 ;
X W $C(7),!?4,"Expiration date exceeds allowable limit !",! S X=^LRE(LRQ,5,LRI,66,DA,0),^(0)=$P(X,"^",1,3)_"^^"_$P(X,"^",5,99),Y=.04 Q
EN ;from LRBLJLG1
 D H^LRUT S W(1)=Z(3)+Z(0) D C^LRUT S %H=$E(W,1,5),Z=$E(W,6,9),Z(1)=Z\60,Z(2)=Z#60 D YMD^%DTC S (LRB(6),Y)=X_"."_$E("00",1,2-$L(Z(1)))_Z(1)_$E("00",1,2-$L(Z(2)))_Z(2) D D^LRU S LRB(5)=$E(Y,1,12)_"@"_$E(Y,15,19) Q
