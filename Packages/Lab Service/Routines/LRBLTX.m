LRBLTX ;AVAMC/REG - TESTS FOR TX RELATED DISORDERS ; 2/17/88  20:59 ;
 ;;5.2;LAB SERVICE;**247,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 Q  D OUT S X="BLOOD BANK" D ^LRUTL G:Y=-1 OUT
 I '$D(^LRO(69.2,LRAA,0)) L +^LRO(69.2) S ^LRO(69.2,LRAA,0)=LRAA_"^"_LRAA(2),X=^LRO(69.2,0),^(0)=$P(X,"^",1,2)_"^"_LRAA_"^"_($P(X,"^",4)+1),^LRO(69.2,"B",LRAA,LRAA)="",^LRO(69.2,"C",LRAA(2),LRAA)="" L -^LRO(69.2)
 I '$D(^LRO(69.2,LRAA,60,0)) S ^(0)="^69.33A^^"
 D F G:'C T D Z
ASK W !,"(E)nter/edit a test  (D)elete a test list  (R)emove all test lists",! R "Enter E, D, R or <CR> to accept lists: ",X:DTIME Q:X=""!(X[U)
 G R:$A(X)=82,D:$A(X)=68,E:$A(X)=69 W $C(7) G ASK
 ;
L W !?6,"Test order#:",?21,1,?29,2,?37,3,?45,4,?53,5,?61,6,?69,7 D Z Q
 ;
Z W !,"-----------------|-------|-------|-------|-------|-------|-------|-------|" Q
 ;
R W !!,"SURE YOU WANT TO DELETE ALL THE LISTS " S %=2 D YN^LRU Q:%'=1  K ^LRO(69.2,LRAA,60) S ^(60,0)="^69.33A^0^0" Q
 ;
D R !,"Select list number to delete: ",X:DTIME G:X=""!(X[U) LRBLTX I '$D(N(X)) W $C(7),!,"Enter the test list number",! G D
 K ^LRO(69.2,LRAA,60,X) S X(1)=$O(^LRO(69.2,LRAA,60,0)) S:'X(1) X(1)=0 S X=^LRO(69.2,LRAA,60,0),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_$S(X(1)=0:0,1:($P(X,"^",4)-1)) G LRBLTX
 ;
E D A Q:X=""!(X[U)  I $D(N(L,O)) S LRT(2)=$P(^LAB(61,$P(L(L,O),"^",2),0),"^"),LRT(3)=$P(L(L,O),"^",3) W " Specimen: ",LRT(2)," Value: ",LRT(3),!,$P(L(L,O),"^",4),"// " R X:DTIME G:X[U E S:X="" X=$P(L(L,O),"^",4) D C G E
 S DIC(0)="AEQM" D H Q:X<1  S T=X D G,K^LRU,F,Z G E
 ;
C I X="@" W !?3,"SURE YOU WANT TO DELETE ? " S %=0 D RX^LRU G:%=1 K W " <NOTHING DELETED>" Q
 S DIC(0)="EQM" D H Q:X<1  S T=X D G,K^LRU,F,Z Q
 ;
T S DIC(0)="AEQM" D H G:X<1 END S T=X D B G T
B D A Q:X=""!(X[U)
G I '$D(^LRO(69.2,LRAA,60,L,0)) S ^(0)=L,Z=^LRO(69.2,LRAA,60,0),^(0)=$P(Z,"^",1,2)_"^"_L_"^"_($P(Z,"^",4)+1)
 I $D(^LRO(69.2,LRAA,60,L,1,O,0)) S ^(0)=T G SET
 S:'$D(^LRO(69.2,LRAA,60,L,1,0)) ^(0)="^69.34PA^0^0" S Z=^(0),^(0)=$P(Z,"^",1,2)_"^"_O_"^"_($P(Z,"^",4)+1),^LRO(69.2,LRAA,60,L,1,O,0)=T
SET S DA=O,DA(2)=LRAA,DA(1)=L,DIE="^LRO(69.2,LRAA,60,L,1,",DR=".02//^S X=LRT(2);.03//^S X=LRT(3)" D ^DIE S (LRT(2),LRT(3))=""
 I $D(Y) W $C(7),!!,"Must answer ALL prompts.  <ENTRY DELETED>" K ^LRO(69.2,LRAA,60,L,1,DA,0) S X(1)=$O(^LRO(69.2,LRAA,60,L,1,0)) S:'X(1) X(1)=0 S X=^(0),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_$S(X(1)=0:0,1:($P(X,"^",4)-1))
 K DIC,DIE,DA,DR,X,Y Q
 ;
H S:'$D(LRT(2)) LRT(2)="" S:'$D(LRT(3)) LRT(3)="" W ! S DIC=60,DIC("S")="I $P(^(0),U,5)[""CH""" D ^DIC K DIC Q:X=""!(X[U)  S X=+Y Q
A R !,"Enter list#,order# : ",X:DTIME Q:X=""!(X[U)  S L=+X,O=+$P(X,",",2) I L>99!(L<1)!(O>7)!(O<1) D W G A
 Q
W W !!?3,"Enter test list number (1-99) then a ',' then test order number (1-7)",!,"[Entering 2,3 would put the test selected in test list 2 and test order 3]",! Q
END S Z=0 F X=0:0 S X=$O(^LRO(69.2,LRAA,60,X)) Q:'X!(Z=1)  F Y=0:0 S Y=$O(^LRO(69.2,LRAA,60,X,1,Y)) Q:'Y  S Z=1 Q
 G LRBLTX:Z,OUT
K K ^LRO(69.2,LRAA,60,L,1,O) S X(1)=$O(^LRO(69.2,LRAA,60,L,1,0)) S:'X(1) X(1)=0 S X=^LRO(69.2,LRAA,60,L,1,0),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_$S(X(1)=0:0,1:($P(X,"^",4)-1)) D K^LRU,F,Z Q
F W @IOF
 F A=0:0 S A=$O(^LRO(69.2,LRAA,60,A)) Q:'A  F B=0:0 S B=$O(^LRO(69.2,LRAA,60,A,1,B)) Q:'B  S C=^(B,0),N(A,B)=$P(^LAB(60,+C,.1),"^"),L(A,B)=$P($P(^(0),U,5),";",2)_"^"_$P(C,"^",2,3)_"^"_$P(^(0),"^")
 S A=0 F C=0:1 S A=$O(N(A)) Q:'A  D:'C L D:C Z W !,"Test list#: ",$J(A,2),?17,"|" F B=0:0 S B=$O(N(A,B)) Q:'B  W ?10+(B*8),N(A,B),$E("       ",1,7-$L(N(A,B))),"|"
 Q
OUT D V^LRU Q
