LRBLJDA ;AVAMC/REG/CYM - BB UNIT DISP NEW UNIT ;10/24/96  10:41 ;
 ;;5.2;LAB SERVICE;**25,72,90,247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 W !!,"New ID #: ",LRE(1)," ",LRV(1)
 S (DIC,DIE)=65,DIC(0)="FL",X=""""_LRE(1)_"""",DLAYGO=65 D ^DIC K DIC,DLAYGO S (LRR,DA)=+Y
 I LR=1 D
 . I $G(LR("CODE"))=0 D
 .. I LR(3)]"" S ^LRD(65,"C",LR(3),DA)=""
 . I $G(LR("CODE"))=1 D
 .. I LR(4)]"" S ^LRD(65,"C",LR(4),DA)=""
 S DR="[LRBLPOOL]" D ^DIE
Y I $D(Y)!(X="@") W:$S(X="@":1,Y'="NO":1,1:0) $C(7),!!,"YOU MUST ENTER DATES",! S DR=".05;S LRK=X;.06;S LRO(2)=X" D ^DIE G Y
 I LRO(2)>LRE(6) W $C(7),!,"Expiration date exceeds original unit expiration date",!?3,LRE(3)," OK " S %=2 D YN^LRU I %'=1 S Y="NO" G Y
 I '$D(LR("%5")),$D(^LRD(65,LRX,2)) S %X="^LRD(65,LRX,2,",%Y="^LRD(65,DA,2," D %XY^%RCR F E=0:0 S E=$O(^LRD(65,DA,2,E)) Q:'E  S X=^(E,0),Y=$P(X,"^",2),X=+$P(X,"^",3) I Y D A
 S X(1)=$G(^LRD(65,LRX,8)),X=$P(X(1),"^",3) I +X(1)&(X="A"!(X="D")) S ^LRD(65,DA,8)=X(1),^LRD(65,"AU",+X(1),DA)="" K ^LRD(65,"AU",+X(1),LRX)
 S LRE(9)=$S("DWFLRG"[LRV(6):0,LRV(2):0,1:9) I 'LRE(9),$D(^LRD(65,LRX,9,0)),$P(^(0),"^",4) S ^LRD(65,DA,9,0)="^65.091PAI^1^1",^(1,0)=LRV(4)_"^"_$P(LRE,"^")_"^"_1
 F W=LRE(9),60,70,80,90 I W,$D(^LRD(65,LRX,W,0)),$P(^(0),"^",4) S %X="^LRD(65,LRX,W,",%Y="^LRD(65,DA,W," D %XY^%RCR
 I LRD S LRX(1)=LRX,LRX=LRR D EN^LRBLDRR1 S LRX=LRX(1)
 I 'LRD F X=10,11 I $D(^LRD(65,LRX,X)) S X(1)=^(X),^LRD(65,DA,X)=X(1)
 K DLAYGO
 Q
A S ^LRD(65,"AP",E,DA)="",Z=$O(^LRD(65,DA,2,E,1,"B",X,0)) S:Z ^LRD(65,"AN",Y,DA,E,Z)="",$P(^LRD(65,DA,2,E,1,Z,0),"^",10)="" Q
EN1 ; from LRBLJD
 I $D(LR("%2")) F LRDFN=0:0 S LRDFN=$O(^LRD(65,LRX,2,LRDFN)) Q:'LRDFN  I $P(^LRD(65,LRX,2,LRDFN,0),"^",2) S X=$P(^(0),"^",3) D:X S
 Q
S S X=$O(^LRD(65,LRX,2,LRDFN,1,"B",X,0)) I X,$D(^LRD(65,LRX,2,LRDFN,1,X,0)) S Y=$S($D(^LRD(65,LRX,4)):$P(^(4),U)_":",1:""),A=$P(^DD(65,4.1,0),U,3),Y=$P($P(A,Y,2),";"),$P(^LRD(65,LRX,2,LRDFN,1,X,0),U,10)=Y_" while on x-match"
 Q
EN ;from LRBLJD
 F LRDFN=0:0 S LRDFN=$O(^LRD(65,DA,2,LRDFN)) Q:'LRDFN  I $D(^LRD(65,"AP",LRDFN,DA)) W $C(7),!,"Unit on x-match/assigned to " D W
 I $D(LR("%")) K LR("%") W !,"Do you still want to enter disposition " S %=2 D YN^LRU I %'=1 S LR("%")=1 K LR("%3")
 F X=0:0 S X=$O(LR("%3",X)) Q:'X  S ^TMP($J,X)=LR("%3",X)
 K LR("%3") Q
W S (LR("%"),LR("%2"))=1,X=^LR(LRDFN,0),Y=$P(X,"^",3),(LRDPF,X)=$P(X,"^",2),X=^DIC(X,0,"GL"),X=@(X_Y_",0)"),SSN=$P(X,"^",9),X=$P(X,"^") D SSN^LRU W X," ",SSN S LR("%3",LRDFN)=X_"^"_SSN Q
PV ;Enter new volume for units with plasma removed
 R !!,"Enter unit volume AFTER plasma removed: ",Z:DTIME I Z[U!(Z="") K Z Q
 I +Z'=Z!(Z>LRM)!('Z) W $C(7),!,"Enter a whole number less than ",LRM G PV
 I Z<(LRM\10) W "  Are you sure " S %=2 D YN^LRU G:%'=1 PV
 S LRM=Z Q
