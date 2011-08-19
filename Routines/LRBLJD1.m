LRBLJD1 ;AVAMC/REG/CYM - POOL COMPONENTS ;10/9/97  07:24 ; 12/18/00 2:04pm
 ;;5.2;LAB SERVICE;**25,90,247,267**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 ;
 ; References to ^DD(65, supported by DBIA3261
 ;
 K LRT S:$G(LRCAPA) LRT=LRW("MO")
 S LR("%5")=1,C=$P(^LAB(66,LRE(4),0),"^") F A=0:0 S A=$O(^LAB(66,LRV,9,A)) Q:'A  S LRT(A)=""
 I LRCAPA,'$O(LRT(0)) W $C(7),!!,"Must enter WKLD CODES in BLOOD PRODUCT FILE (#66)",!,"for ",$P(^LAB(66,LRV,0),U)," to pool unit.",! S DA=LRX D K^LRBLJD Q
 W !?31,"Unit ID",?41,"ABO/Rh",!!,"Selection 1 (unit ID to pool): ",$P(LRE,"^"),?41,$J($P(LRE,"^",7),2),?44,$P(LRE,"^",8)
 S LRP(1)=LRX_"^"_$P(LRE,"^")_"^"_$P(LRE,"^",7)_" "_$P(LRE,"^",8)_"^"_$P(LRE,"^",6)_"^"_$P(LRE,"^",4) F N=2:1 D C Q:'$D(Y)
 I N=2 W !!,"No need to pool 1 unit",! S DA=LRX D K^LRBLJD Q
 W !!,"Pool will contain the following ",$P(^LAB(66,LRE(4),0),"^")," units:",!?3,"ID #",?30,"Expiration date"
 S A=0 F B=0:1 S A=$O(LRP(A)) Q:'A  W !,$J(A,2),?3,$P(LRP(A),"^",2),?20,$P(LRP(A),"^",3),?30 S Y=$P(LRP(A),"^",4) D D^LRU W Y
 S LRM=LRM*B W !!,"ALL OK " S %=1 D YN^LRU I %'=1 D K K LRP Q
ID W !! S X=$$READ^LRBLB("Select UNIT ID number for POOL: ") I X=""!(X[U) W !,$C(7),"UNITS selected were NOT pooled !",! D K Q
 F A=0:0 S A=$O(LRP(A)) Q:'A  I $P(LRP(A),"^",3)["POS" S $P(LRE,"^",8)="POS" Q
 I LR,$E(X,1,$L(LR(2)))=LR(2) D ^LRBLBU
 W:'LR $$STRIP^LRBLB(.X)  ; Strip off data identifiers just in case
 G:'$D(X) K X $P(^DD(65,.01,0),"^",5,99) I $D(X),X["?" K X
 I '$D(X) W !!,$C(7),$S($D(^DD(65,.01,3)):^(3),1:""),! X:$D(^(4)) ^(4) G ID
 I $O(^LRD(65,"B",X,0))!($O(^LRD(65,"C",X,0))) W !,$C(7),"SORRY THAT ALREADY EXISTS",! G ID
 S LRE(1)=X,(Y,LRE(6))=LRE(69) D D^LRU S LRE(3)=Y D ^LRBLJDA S:'$D(^LRD(65,DA,9,0)) ^(0)="^65.091PAI^^" I LRCAPA
 S Z=0 F LR("C")=1:1 S Z=$O(LRP(Z)) Q:'Z  S LRX=+LRP(Z),^LRD(65,DA,9,LR("C"),0)=$P(LRP(Z),"^",5)_"^"_$P(LRP(Z),"^",2)_"^"_1,^LRD(65,LRX,9,0)="^65.091PAI^1^1",^(1,0)=LRV_"^"_LRE(1)_"^"_2 D XR D:LRCAPA ^LRBLW
 S X=^LRD(65,DA,9,0),^(0)="^65.091PAI^"_(LR("C")-1)_"^"_(LR("C")-1)
 D S Q
C W ! S X=$$READ^LRBLB("Selection "_N_" (Unit ID to pool): ") I X=""!(X[U) K Y Q
 I LR,(($A(X)<58)&($A(X)>47))!($A(X)=61) D ^LRBLBU G:'$D(X) C
 W:'LR $$STRIP^LRBLB(.X)  ; Strip off the data identifiers just in case
 S DIC="^LRD(65,",DIC(0)="EFQMZ",DIC("S")="I $S('$D(^(4)):1,$P(^(4),U)']"""":1,1:0)&($P(^LAB(66,$P(^(0),U,4),0),U,26)=LRV(26))" D ^DIC K DIC G:Y<1 C I '$D(^LAB(66,+$P(Y(0),U,4),3,LRV,0)) W !,"Cannot pool this unit" G C
 S LRE("P")=Y,DA=+Y,LRL=Y(0) D EN^LRBLJDA I $D(LR("%")) K LR("%") G C
 S (LRE(6),LRE(9))=$P(LRL,"^",6) S:LRE(6)'["." LRE(6)=LRE(6)_".9999" I LRE(6)<LRF W $C(7),!!,"UNIT EXPIRED " S Y=LRE(9) D D^LRU W Y," STILL WANT TO INCLUDE IN POOL " S %=2 D YN^LRU S:%=1 LR("%4")=1 G:%'=1 C
 S:LRE(6)<LRE(69) LRE(69)=LRE(6)
 S LRV(10)=LRV(10)+$P(LRL,"^",10),Y=LRE("P"),LRP(N)=+Y_"^"_$P(LRL,"^")_"^"_$P(LRL,"^",7)_" "_$P(LRL,"^",8)_"^"_$P(LRL,"^",6)_"^"_$P(LRL,"^",4),^LRD(65,+Y,4)="MO^"_LRE(2)_"^"_DUZ
 D CMV S DA=+Y K ^LRD(65,"AE",$P(LRL,"^",4),$P(LRL,"^",6),DA) X:$D(^DD(65,4.1,1,2,1)) ^(1) X:$D(^DD(65,4.1,1,1,1)) ^(1) S X=LRE(2) X:$D(^DD(65,4.2,1,1,1)) ^(1) Q
 ;
K K X F E=0:0 S E=$O(LRP(E)) Q:'E  S DA=+LRP(E) X:$D(^DD(65,4.1,1,1,2)) ^(2) X:$D(^DD(65,4.1,1,2,2)) ^(2) X:$D(^DD(65,4.1,3,2)) ^(2) I $D(^LRD(65,DA,4)) S X=$P(^(4),"^",2) K:X ^LRD(65,"AB",X,DA) K ^LRD(65,DA,4),^(5)
 Q
XR F Z(1)=0:0 S Z(1)=$O(^LRD(65,LRX,2,Z(1))) Q:'Z(1)  K ^LRD(65,"AP",Z(1),LRX)
 Q
S W ! S X=0 F A=1:1 S X=$O(^TMP($J,X)) Q:'X  S Y=^(X),B(A)=X W !,$J(A,2),") ",$P(Y,U),?30,$P(Y,U,2)
 I A=2 S LRDFN=$O(^TMP($J,0)) G SET
 Q:A<3  S A=A-1 W !,"To assign pool Select from (1-",A,"): " R X:DTIME Q:X=""!(X[U)  I +X'=X!(X<1)!(X>A) W $C(7),!,"Select a number from 1 to ",A G S
 S Y=^TMP($J,B(X)),LRDFN=B(X)
SET W !,"Assign ",LRE(1)," to ",$P(Y,U)," ",$P(Y,U,2)," " S %=1 D YN^LRU Q:%'=1
 S ^LRD(65,DA,2,0)="^65.01IA^"_LRDFN_"^"_1,^(LRDFN,0)=LRDFN
 S DA(1)=DA,DA=LRDFN,DIE="^LRD(65,DA(1),2,",DR=.02 D ^DIE Q
CMV Q:LRV(15)  S X=$P(LRL,"^",15),LRV(15)=$S(X="":"",X=1:1,1:LRV(15)) Q
