LRBLPCS ;AVAMC/REG - COMPONENT SELECTION FOR PATIENTS ;8/4/95  06:32 ;
 ;;5.2;LAB SERVICE;**1,72,247,267,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 Q  D V^LRU,CK^LRBLPUS
 G:Y=-1 END
 I LRSS'="BB" W $C(7),!!,"MUST BE BLOOD BANK" G END
 W !?20,LRAA(4),!!?15,"Selection of blood components for a patient"
 S LRJ=1
 W !,"Display instructions for component selected "
 S %=2 D YN^LRU G:%<1 END S:%=1 LRO=1
P W ! K DIC D ^LRDPA
 K DIC,DIE,DR
 W ! G:LRDFN=-1 END D EN1 G P
 ;
EN1 Q:'$D(LRP)
 D ^LRBLPA Q:$D(Q("Q"))!(LRLLOC["DIED")
 W LRP," ",SSN(1),?42,$J(LRPABO,2),?45,LRPRH
 D EN^LRBLPUS
 S A=0 F B=1:1 S A=$O(^LRD(65,"AP",LRDFN,A)) Q:'A  D N
 I $D(LRQ),B=1 W !,"No units currently assigned/xmatched"
 W ! S A=0 F B=0:1 S A=$O(^LR(LRDFN,1.8,A)) Q:'A  S X=^(A,0) W:'B !,"Component(s) requested",?24,"Units",?30,"Request date/time",?48,"Wanted date/time",?65,"Requestor",?77,"By" D L
OP K LRR
 S LRCPT=0
 W !!,"Is patient Pre-op " S %="" D YN^LRU I %<1 W $C(7),!,"You must answer 'YES' or 'NO' to enter component request.",!,"Do you want to enter component request at this time " S %=1 D YN^LRU G:%=1 OP Q
 S LRV=$S(%=2:0,1:1),LRV(1)=$S(LRV=1:8,1:6)
 D:LRV ^LRBLPCSS
 S DIE=63,DA=LRDFN,DR="[LRBLPCS]"
 W ! D ^DIE K DIE,DR
 D:$D(LRK) EN^LRBLPCS1
 K LRK,S,C Q
 ;
EN3 F A=0:0 S A=$O(^LAB(66,C,LRV(1),A)) Q:'A  S X=^(A,0),E=$P(X,"^",2),F=+X,C(C,F,E)=$P(X,"^",3) I '$D(S(F,E)) D G
 K I(0) F A=0:0 S A=$O(C(C,A)) Q:'A  F B=0:0 S B=$O(C(C,A,B)) Q:'B  D A
 K:$D(I(0)) Q
 I $D(Q) K Q W !?5,$C(7)," Request still OK " S %=2 D YN^LRU S:%=1 LRR=1 I %'=1 S Y=0 D DEL
 S:$D(LRR) LRK(C)="" Q
G S X=$S($D(^LAB(60,F,0)):^(0),1:F)
 I $P(X,"^",5)'["CH" W $C(7),!,"No DATA NAME in file 60 for ",$P(X,"^") Q
 S G=$P(X,";",2),H=+$P(X,";",3),Z=$S($D(^LAB(60,F,1,E,0)):$P(^(0),"^",7),1:""),I(0)=$P(X,"^")
 F B=0:0 S B=$O(^LR(LRDFN,"CH",B)) Q:'B  S W=^(B,0),S=$P(W,"^",5) I S=E,$D(^(G)),$L(^(G)) S X=^(G) D H Q
 S:'$D(S(F,E)) S(F,E)="^"_I(0) Q
H N LRDATE S LRDATE=$$FMTE^XLFDT(+W,"5F")
 S LRDATE=$TR(LRDATE," ",0)
 S LRDATE=$TR(LRDATE,"@"," ")
 S S(F,E)=$P(X,"^",H)_"^"_I(0)_"^"_LRDATE_"^"_Z_"^"_$P(^LAB(61,E,0),"^")
 Q
A Q:'$D(S(A,B))
 I $P(S(A,B),"^")="" W !?10,"No ",$P(S(A,B),"^",2)," results " S Q=1 Q
 I +S(A,B),@(+$P(S(A,B),"^")_C(C,A,B)) W !?10,$P(S(A,B),"^",3)," Last ",$P(S(A,B),"^",2),": ",$P(S(A,B),"^")," ",$P(S(A,B),"^",4)," ",$P(S(A,B),"^",5) S Q=1 Q
 S I(0)=1 Q
EN2 K ^UTILITY($J)
 S DIWR=IOM-5,DIWL=5,DIWF="W"
 S A=0 F K=0:1 S A=$O(^LAB(66,C,7,A)) Q:'A  S X=^(A,0) D ^DIWP
 D:K ^DIWW Q
 ;
L S Y=+X
 I '$D(^LAB(66,Y,0)) K ^LR(LRDFN,1.8,Y) S Y=^LR(LRDFN,1.8,0),^(0)=$P(Y,"^",1,2)_"^^"_($P(Y,"^",4)-1) Q
 W !,$E($P(^LAB(66,+X,0),"^"),1,23),?24,$J($P(X,"^",4),3),?30 S Y=$P(X,"^",3) D M W Y,?48 S Y=$P(X,"^",5) D M W Y,?65,$P(X,"^",9) S Y=$P(X,"^",8) W ?77,$S(Y="":Y,$D(^VA(200,Y,0)):$P(^(0),"^",2),1:Y) Q
M Q:'Y  D DD^LRX
 Q
 ;
N W:B=1 !,"Unit assigned/xmatched:",?49,"Exp date",?67,"Location"
 I '$D(^LRD(65,A,0)) K ^LRD(65,"AP",LRDFN,A) Q
 S X=^LRD(65,A,0),L=$O(^(3,0)) S:'L L="Blood Bank" I L S L=$P(^(L,0),"^",4)
 S M=^LAB(66,$P(X,"^",4),0)
 W !,$J(B,2),")",?5,$P(X,"^"),?20,$E($P(M,"^"),1,21),?42,$J($P(X,"^",7),2),?45,$P(X,"^",8),?49 S Y=$P(X,"^",6) D DD^LRX S:L<0 L="Blood bank" W Y,?67,L Q
 ;
DEL I $O(^LR(LRDFN,1.8,C,1,0)) S ^LR(LRDFN,1.8,C,0)=$P(^LR(LRDFN,1.8,C,0),"^") K ^LR(LRDFN,1.8,C,2) Q
 K ^LR(LRDFN,1.8,C) S X=^LR(LRDFN,1.8,0),X(2)=$O(^(0)),X(1)=$P(X,"^",4),^(0)="^63.084PA^"_X(2)_"^"_$S(X(1)<2:"",1:X(1)-1) Q
END D V^LRU Q
EN K LRO S IOM=$S('$D(IOM):80,IOM:IOM,1:80)
 W !,"FOR TRANSFUSION REQUESTS: Display instructions for components " S %=2 D YN^LRU Q:%<1  S:%=1 LRO=1 Q
