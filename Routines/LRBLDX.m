LRBLDX ;AVAMC/REG - DONOR ABO/RH TESTING ;3/25/92  22:42 ;
 ;;5.2;LAB SERVICE;**247,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 Q  D END S X="BLOOD BANK" D ^LRUTL G:Y=-1 END
 I LRCAPA S X="DONOR ABO/RH TESTING" D X^LRUWK G:'$D(X) END S Y="DX" D S^LRBLWD D EN^LRBLW G:%<1 END I $D(LRK("LRK")) D DT^LRBLU S LRK("LRK")=LRK
 S LRB="",LRC=1 W !!,"Enter TEST COMMENT(s) " S %=2 D YN^LRU G:%<1 END K:%=1 LRC
DNR W ! K DA,LR,LRR S DIC="^LRE(",DIC(0)="AFQM",D="C^B",DIC("B")=LRB,DIC("A")="Select DONOR ID: " D MIX^DIC1 K DIC G:X=""!(X[U) END
 I Y<1 W $C(7),!!,"Complete DONOR ID must be entered (ex. If ID=H12345 then H123 unacceptable)." G DNR
 I X[","!($L(X)=5) D ASK G:Y<1 DNR D CKRL,REST G DNR
 S LRQ=+Y,LRI=$O(^LRE("C",X,LRQ,0)) G:'LRI DNR S LRQ(1)=$P(^LRE(LRQ,5,LRI,0),"^",4) D CKRL,REST G DNR
 ;
REST S X(1)=$E(X,3,$L(X)),X(2)=X(1)+1,X(3)=$L(X(1))-$L(X(2)) I X(3) S X(2)=$E("00000",1,X(3))_X(2)
 S LRB=$E(X,1,2)_X(2),LRB=$S($D(^LRE("C",LRB)):LRB,1:"")
 S X=^LRE(LRQ,0),W(5)=$P(X,U,5),W(6)=$P(X,U,6)
 S Y=+^LRE(LRQ,5,LRI,0) D D^LRU W !!,"UNIT#:",LRQ(1),"  Donation date:",Y I LRQ(1)="" W $C(7),!?35,"Must have UNIT # to proceed." Q
 W ! S DR="[LRBLDABRH]",DIE="^LRE(",DA=LRQ D ^DIE K DIE,DR
 I $D(LRR) F A=0:0 S A=$O(LRA(A)) Q:'A  I $D(^LRE(LRQ,5,LRI,A)),$P(^(A),"^") S LR=1
 I $D(LRR),'$D(^XUSEC("LRBLSUPER",DUZ)) W !,"One or more components were released.  You may not edit existing test results."
 S Y="DX" D:LRCAPA SET^LRBLWD Q
S ;from LRBLDX input template only supervisor can edit data after release of components
 I $D(LRR),$P(LRM,U,4)]"",'$D(^XUSEC("LRBLSUPER",DUZ)) S Y=Z
 Q
ASK S LRQ=+Y,DIC="^LRE(LRQ,5,",DIC(0)="FAEQM",DIC("A")="Select DONATION DATE: " D ^DIC K DIC Q:Y<1
 S LRI=+Y,LRQ(1)=$P(^LRE(LRQ,5,LRI,0),U,4) Q
 ;
CKRL F A=0:0 S A=$O(^LRE(LRQ,5,LRI,66,A)) Q:'A  I $P(^(A,0),"^",8)=0 S LRR=1 Q
 Q
END D V^LRU Q
