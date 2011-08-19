LRUMDF ;AVAMC/REG - DEFAULT TEST LIST ;8/11/93  17:51 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 D L^LRUMD Q:Y=-1  S LRQ=0 D F
 G:'C N D Z
ASK W !,"(E)nter/edit a test  (D)elete a test list  (R)emove all test lists",!,"(P)rint test lists",! R "Enter E, D, R, P or <CR> to accept lists: ",X:DTIME Q:X=""!(X[U)
 G R:$A(X)=82,D:$A(X)=68,E:$A(X)=69,P:$A(X)=80 W $C(7) G ASK
 ;
L W !?6,"Test order#:",?21,1,?29,2,?37,3,?45,4,?53,5,?61,6,?69,7 D Z Q
 ;
Z Q:LR("Q")  W !,"-----------------|-------|-------|-------|-------|-------|-------|-------|" Q
 ;
R W !!,"SURE YOU WANT TO DELETE ALL THE LISTS " S %=2 D YN^LRU Q:%'=1  K ^LRO(69.2,LRAA,60) S ^(60,0)="^69.33A^0^0" Q
 ;
D R !,"Select list number to delete: ",X:DTIME G:X=""!(X[U) LRUMDF I '$D(N(X)) W $C(7),!,"Enter the test list number",! G D
 K ^LRO(69.2,LRAA,60,X) S X(1)=$O(^LRO(69.2,LRAA,60,0)) S:'X(1) X(1)=0 S X=^LRO(69.2,LRAA,60,0),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_$S(X(1)=0:X(1),1:($P(X,"^",4)-1)) G LRUMDF
 ;
E D A Q:X=""!(X[U)  I $D(N(L,O)) W " ",N(L,O),"// " R X:DTIME G:X=""!(X[U) E D C G E
 S DIC(0)="AEQM" D H Q:X<1  S T=X D G,K^LRU,F,Z G E
 ;
C I X="@" W !?3,"SURE YOU WANT TO DELETE ? " S %=0 D RX^LRU G:%=1 K W " <NOTHING DELETED>" Q
 S DIC(0)="EQM" D H Q:X<1  S T=X D G,K^LRU,F,Z Q
 ;
P S ZTRTN="QUE^LRUMDF" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO S (LR("Q"),LRQ)=0,LRQ(1)=^DD("SITE") D L^LRU,HDR S LR("F")=1
 D F1 W !,LR("%") D END^LRUTL,OUT Q
N W !,"You have no test lists.  Instead of creating your own",!,"would you prefer to copy another user's lists " S %=2 D YN^LRU I %=1 D I G END
T S DIC(0)="AEQM" D H G:X<1 END S T=X D B G T
B D A Q:X=""!(X[U)
G I '$D(^LRO(69.2,LRAA,60,L,0)) S ^(0)=L,Z=^LRO(69.2,LRAA,60,0),^(0)=$P(Z,"^",1,2)_"^"_L_"^"_($P(Z,"^",4)+1)
 I $D(^LRO(69.2,LRAA,60,L,1,O,0)) S ^(0)=T Q
 S:'$D(^LRO(69.2,LRAA,60,L,1,0)) ^(0)="^69.34PA^0^0" S Z=^(0),^(0)=$P(Z,"^",1,2)_"^"_O_"^"_($P(Z,"^",4)+1),^LRO(69.2,LRAA,60,L,1,O,0)=T Q
 ;
H W ! S DIC=60,DIC("S")="I $P(^(0),U,5)?1""CH;""1N.N.E" D ^DIC K DIC Q:X=""!(X[U)  S X=+Y Q
A R !,"Enter list#,order# : ",X:DTIME Q:X=""!(X[U)  S L=+X,O=+$P(X,",",2) I L>99!(L<1)!(O>7)!(O<1) D W G A
 Q
W W !!?3,"Enter test list number (1-99) then a ',' then test order number (1-7)",!,"[Entering 2,3 would put the test selected in test list 2 and test order 3]",! Q
 ;
END S Z=0 F X=0:0 S X=$O(^LRO(69.2,LRAA,60,X)) Q:'X!(Z=1)  F Y=0:0 S Y=$O(^LRO(69.2,LRAA,7,DUZ,60,X,1,Y)) Q:'Y  S Z=1 Q
 G:Z LRUMDF Q
K K ^LRO(69.2,LRAA,60,L,1,O) S X(1)=$O(^LRO(69.2,LRAA,60,L,1,0)) S:'X(1) X(1)=0 S X=^LRO(69.2,LRAA,60,L,1,0),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_$S(X(1)=0:X(1),1:($P(X,"^",4)-1)) D K^LRU,F,Z Q
F W @IOF
F1 S A=0 F  S A=$O(^LRO(69.2,LRAA,60,A)) Q:'A  F B=0:0 S B=$O(^LRO(69.2,LRAA,60,A,1,B)) Q:'B  S C=+^(B,0),N(A,B)=$P(^LAB(60,C,.1),"^"),L(A,B)=$P($P(^(0),U,5),";",2)
 S (LR("Q"),A)=0 F C=0:1 S A=$O(N(A)) Q:'A!(LR("Q"))  D:'C L D:C Z D:$Y>(IOSL-4) HDR Q:LR("Q")  W !,"Test list#: ",$J(A,2),?17,"|" F B=0:0 S B=$O(N(A,B)) Q:'B  W ?10+(B*8),N(A,B),$E("       ",1,7-$L(N(A,B))),"|"
 Q
I W ! S DIC=200,DIC(0)="AEQM" D ^DIC K DIC Q:Y<1  S X=+Y I '$O(^LRO(69.2,LRAA,7,X,60,0)) W $C(7),!,$P(Y,"^",2)," has no test lists." G I
 S:'$D(^LRO(69.2,LRAA,60,0)) ^(0)="^69.34A^^" S %X="^LRO(69.2,LRAA,7,X,60,",%Y="^LRO(69.2,LRAA,60," D %XY^%RCR Q
HDR I IOST?1"C".E D M^LRU Q:LR("Q")  W @IOF Q
 D F^LRU W !,"Test list for ",$P(^VA(200,DUZ,0),U),!,LR("%") Q
OUT D V^LRU Q
