LRBLJLG1 ;AVAMC/REG/CYM - REVIEW UNIT LOG-IN ;11/12/96  07:41 ;
 ;;5.2;LAB SERVICE;**72,139,247,267**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 ;References to ^DIC(4 in this routine are covered by DBIA 2508
 Q:'$D(LRL)
 W @IOF,P," Source: ",LRW," Invoice: ",LRI,!,"Review:",?9,"Unit",?25,"ABO/Rh",?33,"Expiration date (*=Expired or expires today)"
 S X=0 F A=0:1 S X=$O(LRL(X)) Q:'X  W !,X,")",?9,$P(LRL(X),"^",2),?25,$P(LRL(X),"^",3),?28,$P(LRL(X),"^",4),?34 S Y=$P(LRL(X),"^",5) D D^LRU W Y,$P(LRL(X),"^",6)
 Q:'A  W !!,"All OK " S %=1 D YN^LRU G:%=1&LRCAPA WRK Q:%'=2  I %=1 L -^LRD(65)
ASK W !!,"Select (1-",A,") to Edit: " R LRE:DTIME G:LRE=""!(LRE["^") ^LRBLJLG1 I LRE'?1N.N!(LRE<1!(LRE>A)) W $C(7),! D H G ASK
DIE S DA=+LRL(LRE),DIE="^LRD(65,",LR(65,.01)=$P(^LRD(65,DA,0),U)
 S LRA=""
 S DR=".01;I X["" "" W $C(7),"" No spaces.  Enter '@' to delete."" S Y=.01;D CK^LRBLJLG1;S:LRF Y=.01;S LRP=X;.07;S LRABO=X;.08;S LRRH=X;.06;S LRH=X;I LRS,LRH>LRS D A^LRBLJLG1 S Y=.06"
 D ^DIE I $D(Y) W $C(7),!,"No entering '^' during this edit !!" G DIE
 I '$D(DA) D FIX G LRBLJLG1
 S X=$P(^LRD(65,DA,0),U) D:X'=LR(65,.01) KK^LRBLU
 S LRL(LRE)=DA_"^"_LRP_"^"_LRABO_"^"_LRRH_"^"_LRH_"^"_LRA_"^"_LRC
 S:$D(^LRO(69.2,LRAA,6,DA,0)) ^(0)=LRP_"^"_LRABO_"^"_LRRH
 K DIE,DR,DA
 G LRBLJLG1
 ;
WRK F LRL=0:0 S LRL=$O(LRL(LRL)) Q:'LRL  S LRX=+LRL(LRL) D ^LRBLW
 Q
FIX S X=+LRL(LRE) K LRL(LRE)
 I $D(^LRO(69.2,LRAA,6,X,0)) K ^(0) S X=^LRO(69.2,LRAA,6,0),^(0)=$P(X,"^",1,2)_"^^"_($P(X,"^",4)-1)
 K B S X=0 F A=1:1 S X=$O(LRL(X)) Q:'X  S B(A)=LRL(X)
 K LRL F A=0:0 S A=$O(B(A)) Q:'A  S LRL(A)=B(A) K B(A)
 Q
H W " Enter a number from 1 to ",A Q
EN ;from LRBLJLG
 S LRB(7)=$P(^LAB(66,LRC,0),"^",17),LRB(6)="" G:'LRB(7) END
 S LRB(3)=$P(LRK,".",2),X1=LRK,X2=$P(LRB(7),".")
 D C^%DTC S LRB(6)=X I LRB(7)["." S Z=LRB(6)_"."_LRB(3),X="."_$P(LRB(7),".",2),Z(0)=$P(X*24*60,".") D EN^LRBLDC
END S LRS=LRB(6) K LRB Q
 ;
CK S LRF=0,LRO=$P(LRL(LRE),"^",2)
 F C=0:0 S C=$O(^LRD(65,"B",X,C)) Q:'C  I C'=DA,$D(^LRD(65,C,0)),$P(^(0),"^",4)=$P(LRL(LRE),"^",7) S $P(^LRD(65,DA,0),"^")=LRO,LRF=1 W $C(7)," Sorry, that unit exists in inventory." Q
 Q:'LRF
 K ^LRD(65,"B",$E(X,1,30),DA)
 S Y=^LRD(65,DA,0) I $P(Y,U,4),$P(Y,U,6) K ^LRD(65,"AI",$P(Y,U,4),X,$P(Y,U,6),DA)
 K ^LRD(65,"AT",X) F Z=0:0 S Z=$O(^LRD(65,DA,2,Z)) Q:Z<1  K ^LRD(65,"AP",Z,DA)
 D K^LRBLU
 S X=LRO
 S ^LRD(65,"B",$E(X,1,30),DA)=""
 S Y=^LRD(65,DA,0) I $P(Y,U,4),$P(Y,U,6),$P($G(^LRD(65,DA,4)),U)="" S ^LRD(65,"AI",$P(Y,U,4),X,$P(Y,U,6),DA)=""
 S:'$D(^LRD(65,DA,10)) (^LRD(65,"AT",X,10,DA),^LRD(65,"AT",X,11,DA))="" I '$D(^LRD(65,DA,4)) F Z=0:0 S Z=$O(^LRD(65,DA,2,Z)) Q:Z<1  S:$P(^(Z,0),U,2) ^LRD(65,"AP",Z,DA)=""
 D S^LRBLU
 S Y=.01 Q
EN1 ;
 S X=$P($G(^DIC(4,+$P(Y(0),"^",16),0)),"^") W:X]"" !,"Institution: ",X
 I $D(^LRD(65,C,4)) S W=^(4),LRP=$P(W,"^") I LRP="R"!(LRP="S") W !!,"DISPOSITION: ",$S(LRP="S":"SENT ELSEWHERE",1:"RETURNED TO SENDER"),".  Re-enter unit in inventory " S %=2 D YN^LRU Q:%'=1  S ^(4)="^^^"_$P(W,"^",4)_"^^"_$P(W,"^",6,99) G Z
 Q
A W $C(7),!!?4,"Expiration date exceeds allowable limit !",! Q
 ;
Z S:'$D(^LRD(65,C,15,0)) ^(0)="^65.15DA^^" S A=^(0),X=$P(A,"^",4),X=X+1,^(0)=$P(A,"^",1,2)_"^"_X_"^"_X
 S Z=^LRD(65,C,0),W(5)=$P(Z,U,5),Z(4)=$P(Z,U,4),Z(6)=$P(Z,U,6),^LRD(65,C,15,X,0)=LRK_U_$P(W,U,1,3)_U_$P(Z,U,13)_U_$P(Z,U,3)_U_$P(Z,U,9)_U_$P(Z,U,5)_U_$P(W,U,5),W(11)=$P(W,U,2)
 K:W(11) ^LRD(65,"AB",W(11),C)
 S $P(Z,"^",5)=LRK,$P(Z,"^",9)=DUZ,$P(Z,"^",10)=$P($P(Z,"^",14),"-",2),$P(Z,"^",14)="",$P(Z,"^",3)=LRI,$P(Z,"^",13)="",^LRD(65,C,0)=Z,^LRD(65,"A",W(5),C)=""
 I Z(4),Z(6) S ^LRD(65,"AE",Z(4),Z(6),C)="",^LRD(65,"AI",Z(4),$P(Z,"^"),Z(6),C)=""
 Q
