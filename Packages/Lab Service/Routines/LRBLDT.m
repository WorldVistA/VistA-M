LRBLDT ;AVAMC/REG/CYM - DONOR UNIT TESTING ;7/5/96  08:35 ;
 ;;5.2;LAB SERVICE;**72,97,247,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 Q  D V^LRU S X="BLOOD BANK" D ^LRUTL G:Y=-1 END D D^LRBLU G:'$D(X) END
 I LRCAPA S X="DONOR ANTIBODY SCREEN" D X^LRUWK G:'$D(X) END S Y="DT" D S^LRBLWD D EN^LRBLW G:%<1 END W:%=2 ! I $D(LRK("LRK")) D DT^LRBLU S LRK("LRK")=LRK
 F A=12:1:20 D SC
SEL W !!,"Select test(s) by number: " R X:DTIME G:X=""!(X[U) END I X["?" W !,"Enter one or more of the above numbers",!,"For 2 or more selections separate each with a ',' (ex. 12,13,15)",!,"Enter 'ALL' for all tests." G SEL
 I X="ALL" D ALL G SHOW
 I X?.E1CA.E!($L(X)>200) W $C(7),!,"No CONTROL CHARACTERS, LETTERS or more than 200 characters allowed." G SEL
 I '+X W $C(7),!,"START with a NUMBER !!",! G SEL
 S Y=X F LRB=0:0 S LRV=+Y,Y=$E(Y,$L(LRV)+2,$L(Y)) S:$D(LRA(LRV)) LRF(LRV)=LRA(LRV) Q:'$L(Y)
SHOW I '$D(LRF) W $C(7),!,"None of the listed tests selected, try again " S %=1 D YN^LRU G LRBLDT:%=1,END
 W !!,"You have selected the following tests:" F A=0:0 S A=$O(LRF(A)) Q:'A  W !,$J(A,3),") ",LRF(A)
 W !,"OK " S %=1 D YN^LRU G:%'=1 LRBLDT S LRB="",LRC=1 W !!,"Enter TEST COMMENT(s) " S %=2 D YN^LRU G:%<1 END K:%=1 LRC
DNR W ! K DA,LRZ,LRR S DIC="^LRE(",DIC(0)="AFQM",D="C^B",DIC("B")=LRB,DIC("A")="Select DONOR ID: " D MIX^DIC1 K DIC G:X=""!(X[U) END
 I Y<1 W $C(7),!!,"Complete DONOR ID must be entered (ex. If ID=H12345 then H123 unacceptable)." G DNR
 I X["," D ASK G:Y<1 DNR D CKRL,REST G DNR
 S LRQ=+Y,LRI=$O(^LRE("C",X,LRQ,0)) I 'LRI W $C(7),"  ",X," does not exist, try again" G DNR
 L +^LRE(LRQ,5,LRI,0):5 I '$T W !!,$C(7),"Someone else is editing this record." G DNR
 S LRQ(1)=$P(^LRE(LRQ,5,LRI,0),"^",4) D CKRL,REST L -^LRE(LRQ,5,LRI,0) G DNR
 ;
REST S X(1)=$E(X,3,$L(X)),X(2)=X(1)+1,X(3)=$L(X(1))-$L(X(2)) I X(3) S X(2)=$E("00000",1,X(3))_X(2)
 S LRB=$E(X,1,2)_X(2),LRB=$S($D(^LRE("C",LRB)):LRB,1:"")
 S X=^LRE(LRQ,0),W(5)=$P(X,U,5),W(6)=$P(X,U,6)
 S Y=+^LRE(LRQ,5,LRI,0) D D^LRU W !!,"UNIT#:",LRQ(1),"  ABO:",W(5)," Rh:",W(6),"  Donation date:",Y I LRQ(1)="" W $C(7),!?35,"Must have UNIT # to proceed." Q
 W ! S LR(65.54,15)="",DR="[LRBLDT]",DIE="^LRE(",DA=LRQ D ^DIE K DIE,DR
 I $D(LRR) S B=3 F A=0:0 S A=$O(LRA(A)) Q:'A  I $D(^LRE(LRQ,5,LRI,A)),$P(^(A),"^") S LRZ=1,B=B+1,Y=^(A),X=+Y,X=$$EXTERNAL^DILFD(65.54,A,"",X),LR("TXT",B,0)=LRA(A)_":"_X_" "_$P(Y,"^",3)
 I $D(LRZ) D MSG K LRZ
 I $D(LRR),'$D(^XUSEC("LRBLSUPER",DUZ)) W !,"One or more components were released.  You may not edit existing test results."
 I LR(65.54,15)=0!(LR(65.54,15)) S Y="DT" D:LRCAPA SET^LRBLWD
 Q
S ;from LRBLDT input template only supervisor can edit data after release of components
 I $D(LRR),$P(LRM,U)!($P(LRM,U)=0),'$D(^XUSEC("LRBLSUPER",DUZ)) S Y=Z
 Q
ASK S LRQ=+Y,DIC="^LRE(LRQ,5,",DIC(0)="FAEQM",DIC("A")="Select DONATION DATE: " D ^DIC K DIC Q:Y<1
 S LRI=+Y,LRQ(1)=$P(^LRE(LRQ,5,LRI,0),U,4) Q
 ;
R W !,"Add ",LRF(A)," to donor testing worklist " S %=2 D YN^LRU Q:%'=1  S ^LRE("AT",LRQ(1),A,LRQ,LRI)="" Q
 ;
D K ^LRE("AT",LRQ(1),A,LRQ,LRI) Q
 ;
ALL F A=0:0 S A=$O(LRA(A)) Q:'A  S LRF(A)=LRA(A)
 Q
 ;
CKRL F A=0:0 S A=$O(^LRE(LRQ,5,LRI,66,A)) Q:'A  I $P(^(A,0),"^",8)=0 S LRR=1 Q
 Q
MSG S LR("TXT",2,0)="Component(s) released with one or more positive test results!",LR("TXT",1,0)="Blood donor unit ID: "_LRQ(1),LR("KEY")="LRBLSUPER",LR("SUB")="Release of donor unit with abnormal test results"
 N NAME,TYPE S X=$P(^LRE(LRQ,5,LRI,0),U,11) D FIELD^DID(65.54,1.1,"","LABEL","NAME") S NAME=NAME("LABEL")
 S TYPE=$$EXTERNAL^DILFD(65.54,1.1,"",X)
 S LR("TXT",3,0)=NAME_":  "_TYPE
 W $C(7),!!,LR("TXT",2,0) D ^LRUMSG Q
END D V^LRU Q
SC I A'=17&(A'=20) D W Q
 D:$G(LRH(A)) W Q
W D FIELD^DID(65.54,A,"","LABEL","LRA") S LRA(A)=LRA("LABEL") W !,$J(A,3),")  ",LRA(A) Q
