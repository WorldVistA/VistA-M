LRBLU ;AVAMC/REG/CYM - BB UTIL ;1/22/97  15:32 ;
 ;;5.2;LAB SERVICE;**97,90,247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 ;
 K:$L(X)<6!($L(X)>11)!(X'?.UN) X ;input trans ^DD(65.54,4,
 I $D(X),$D(^LRE("C",X)) S W=X(1)+50000 F Y=0:0 Q:'$D(X)  S Y=$O(^LRE("C",X,Y)) Q:'Y  K:'$D(^LRE(Y,0)) ^LRE("C",X,Y) I $D(^LRE("C",X,Y)) D I
 Q:'$D(X)  I $D(^LRD(65,"B",X))!($D(^LRD(65,"C",X))) W $C(7),!?15,"INVENTORY FILE HAS AN ENTRY WITH SAME ID ! " D O
 Q
I F Z=0:0 S Z=$O(^LRE("C",X,Y,Z)) Q:'Z  I Z<W W !,$C(7),X," assigned to ",$P(^LRE(Y,0),U) K X Q
 Q
 ;
F Q:X=""  S X=$P($P(B,X_":",2),";") Q
S ;sets C-xref in FILE 65
 S Y=^LRD(65,DA,0),S=$P(Y,U,2),C=$P(Y,U,4),A=$P(Y,U) I C,S]"" S Y=$O(^LAB(66,C,"SU","B",S,0)) S:Y Y=$L($P(^LAB(66,C,"SU",Y,0),U,10)) S:Y ^LRD(65,"C",$E(A,Y+1,$L(A)),DA)=""
 Q
K ;Kill C-xref in FILE 65
 S LR("DEAD")=0
 S A="" F  S A=$O(^LRD(65,"C",A)) Q:A=""!(LR("DEAD"))  I $D(^LRD(65,"C",A,DA)) K ^LRD(65,"C",A,DA) S LR("DEAD")=1
 K LR("DEAD")
 Q
KK S Y=^LRD(65,DA,0),S=$P(Y,U,2),C=$P(Y,U,4),A=LR(65,.01)
 I C,S]"" D
 . S Y=$O(^LAB(66,C,"SU","B",S,0))
 . S:Y Y=$L($P(^LAB(66,C,"SU",Y,0),U,10))
 I Y K ^LRD(65,"C",$E(A,Y+1,$L(A)),DA) Q
 Q
S1 I 1
 Q
K1 ;Kill AG x-ref DD(65,4.1,1,
 S A=^LRD(65,DA,6),Z=$P(A,U,4),A=+A
 I A,Z D
 . S B=+$P($G(^LR(A,1.6,Z,0)),U,11)
 . K ^LRD(65,"AB",$E(X,1,30),DA)
 . K ^LRD(65,DA,4),^(5),^(6),^(7),^LR(A,1.6,Z),^LR("AB",A,B,Z)
 . I $D(^LR(A,1.6,0)) S A=^(0),Z=$O(^(0)),^(0)=$P(A,U,1,2)_U_Z_U_$S('Z:Z,1:($P(A,U,4)-1))
 Q
A ;Makes change to ^LRD(65,"AP" & date unit assigned if necessary
 I X'="C",X'="IG" K ^LRD(65,"AP",DA(1),DA(2)) S $P(^LRD(65,DA(2),2,DA(1),0),U,2)="" Q
 S ^LRD(65,"AP",DA(1),DA(2))="",X(1)=$P(^LRD(65,DA(2),2,DA(1),0),U,2) I 'X(1) S LR=X,X="N",%DT="T" D ^%DT S X=LR,$P(^LRD(65,DA(2),2,DA(1),0),U,2)=Y
 Q
EN ;
 F A=0:0 S A=$O(^LRD(65,"B",X,A)) Q:'A  I $D(LR)#2,$D(^LRD(65,A,0)),$P(^(0),U,4)=LR W $C(7),!,"UNIT IN INVENTORY - EDIT TRANSFUSION DATA THERE !" K X Q
 Q  ;input transform ^DD(63.017,.03,0)
EN1 ;
 S (DIC,DIE)="^LAB(61.3,"
 S X=0 F X(1)=0:0 S X=$O(^LAB(61.3,"B","D",X)) Q:'X  I X,^(X)="" Q
 I X S (LRB,DA)=X,DR="2///50710" D ^DIE G END
 S X="D",DIC(0)="ML",DLAYGO=61 D ^DIC K DIC
 S DA=+Y,DR="2///50710" D ^DIE S LRB=$O(^LAB(61.3,"C",50710,0))
 K DLAYGO
 ;
EN2 ;called by TRANSFUSION entry in EXECUTE CODE file
 S X="N",%DT="T" D ^%DT S X1=Y,X2=-3 D C^%DTC S X=9999999-X
 S A=0 F B=1:1 S A=$O(^LR(LRDFN,"BB",A)) Q:'A!(A>X)  W:B=1 $C(7),!,"Specimen(s) received within past 72 hrs:" S Z=^(A,0),Y=+Z D DT^LRU W !,Y,?18,$P(Z,U,6)
 Q
EN3 ;delete user print list for transfusion & hematology data
 D OUT
 S X="BLOOD BANK" D ^LRUTL
 G:'LRAA OUT
 I '$D(^LRO(69.2,LRAA,7,0)) W $C(7),!!,"There are no user lists." G OUT
 S (DIC,DIE)="^LRO(69.2,LRAA,7,",DIC(0)="AEQM" D ^DIC K DIC G:Y<1 OUT
 S DA=+Y,DA(1)=LRAA,DR=.01 D ^DIE G EN3
D S X=$O(^LAB(69.9,1,8,"B","DONOR",0)) I 'X W $C(7),"Must define blood bank site parameters using option:",!?3,"Edit blood bank site parameters [LRBLSSP] under the Supervisor menu" K X Q
 S X=^LAB(69.9,1,8,X,0),LRH(2)=$P(X,U,3),LRH(3)=$P(X,U,4) I LRH(2)=""!(LRH(3)="") W $C(7),!!,"Must enter second and third defaults for DONOR using:",!?3,"Edit blood bank site parameters [LRBLSSP] under the Supervisor menu" K X Q
 S LRH(17)=+$P(X,U,6),LRH(20)=+$P(X,U,7) Q
OUT D V^LRU Q
O ;enter old donor unit (CAUTION: This unit is in inventory)
 I '$D(LRD("U")) K X Q
 W !!,"Do you still want to enter this unit in the donor file " S %=2 D YN^LRU I %=1 W !,"Ok, done." Q
 K X Q
P ;from DD(63.01, input transforms for fields 6.1 to 6.4
 Q:'$D(^LR(LRDFN,"BB",LRI,A,X))&('$D(^LR(LRDFN,B,X)))
 W !!,$P(^LAB(61.3,X,0),U)," antigen cannot be present & absent.",! K ^LR(LRDFN,"BB",LRI,C,X) S X=^LR(LRDFN,"BB",LRI,C,0),X(1)=$O(^(0)),^(0)=$P(X,U,1,2)_U_X(1)_U_$S('X(1):"",1:($P(X,U,4)-1)) K X Q
B ;
 S X="T",%DT="" D ^%DT,D^LRU S LRH=Y
 S %DT="AETX",%DT(0)="-N",%DT("A")="Start with Date TODAY// " D ^%DT K %DT I X="" S Y=DT W LRH
 Q:Y<1  S LRSDT=Y
 S %DT="AETX",%DT("A")="Go    to   Date TODAY// " D ^%DT K %DT I X="" S Y=DT W LRH
 Q:Y<1  S LRLDT=Y I LRSDT>LRLDT S X=LRSDT,LRSDT=LRLDT,LRLDT=X
 S Y=LRSDT D D^LRU S LRSTR=Y,Y=LRLDT D D^LRU S LRLST=Y K LRH Q
DT W ! S %DT("A")="Date/time work completed: NOW// ",%DT="AEQTX",%DT(0)="-N" D ^%DT K %DT I X[U!(Y>1&(Y'[".")) W $C(7),!?35,"Not allowed, enter date and time.",!?35,"Future times not allowed." G DT
 I Y<1 S X="N",%DT="EQTX" D ^%DT K %DT
 S LRK=Y W ! Q
 ;
END K DIC,DIE,DR,DA Q
