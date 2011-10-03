LRBLDUC ;AVAMC/REG/CYM - DONOR ABO/RH RECHECK ;7/5/96  22:39 ;
 ;;5.2;LAB SERVICE;**72,247,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 Q  D V^LRU S X="BLOOD BANK" D ^LRUTL G:Y=-1 END
 W !!?30,"Donor ABO/Rh Recheck",! I LRCAPA S X="DONOR ABO/RH RECHECK" D X^LRUWK G:'$D(X) END S Y="UC" D S^LRBLWD
 S LRB="",LRC=1 W !!,"Enter TEST COMMENT(s) " S %=2 D YN^LRU K:%=1 LRC
DNR W ! K DA,LR,LRR S DIC="^LRE(",DIC(0)="AFQM",D="C^B",DIC("B")=LRB,DIC("A")="Select DONOR ID: " D MIX^DIC1 K DIC G:X=""!(X[U) END
 I Y<1 W $C(7),!!,"Complete DONOR ID must be entered (ex. If ID=H12345 then H123 unacceptable)." G DNR
 I X["," D ASK G:Y<1 DNR D CKRL,REST G DNR
 S LRQ=+Y,LRI=$O(^LRE("C",X,LRQ,0)) I 'LRI W $C(7),"  ",X," does not exist.  Try again" G DNR
 L +^LRE(LRQ,5,LRI,0):5 I '$T W !!,$C(7),"Sorry, someone else is editing this record" G DNR
 S LRQ(1)=$P(^LRE(LRQ,5,LRI,0),"^",4) D CKRL,REST L -^LRE(LRQ,5,LRI,0) G DNR
 ;
REST S X(1)=$E(X,3,$L(X)),X(2)=X(1)+1,X(3)=$L(X(1))-$L(X(2)) I X(3) S X(2)=$E("00000",1,X(3))_X(2)
 S LRB=$E(X,1,2)_X(2),LRB=$S($D(^LRE("C",LRB)):LRB,1:"")
 S X=^LRE(LRQ,0),W(5)=$P(X,U,5),W(6)=$P(X,U,6)
 S Y=+^LRE(LRQ,5,LRI,0) D D^LRU W !!,"UNIT#:",LRQ(1),"  Donation date:",Y I LRQ(1)="" W $C(7),!?35,"Must have UNIT # to proceed." Q
 W ! S DR="[LRBLDUC]",DIE="^LRE(",DA=LRQ D ^DIE K DIE,DR
 I $D(LRR) F A=0:0 S A=$O(LRA(A)) Q:'A  I $D(^LRE(LRQ,5,LRI,A)),$P(^(A),"^") S LR=1
 I $D(LRR),'$D(^XUSEC("LRBLSUPER",DUZ)) W !,"One or more components were released.  You may not edit existing test results."
 S Y="UC" D:LRCAPA SET^LRBLWD Q
S ;from LRBLDUC input template only supervisor can edit data after release of components
 I $D(LRR),$P(LRM,U,4)]"",'$D(^XUSEC("LRBLSUPER",DUZ)) S Y=Z
 I $P(LRM,U)="" W $C(7),!,"ABO/Rh testing not completed." S Y=0
 Q
ASK S LRQ=+Y,DIC="^LRE(LRQ,5,",DIC(0)="FAEQM",DIC("A")="Select DONATION DATE: " D ^DIC K DIC Q:Y<1
 S LRI=+Y,LRQ(1)=$P(^LRE(LRQ,5,LRI,0),U,4) Q
 ;
CKRL F A=0:0 S A=$O(^LRE(LRQ,5,LRI,66,A)) Q:'A  I $P(^(A,0),"^",8)=0 S LRR=1 Q
 Q
END D V^LRU Q
