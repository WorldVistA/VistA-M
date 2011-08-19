LRUMD2 ;AVAMC/REG - MD SELECTED TESTS/PATIENTS ;2/18/93  12:57 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 W !!,"Remove patients by (N)umber or (P)atient name" R !,"Enter N or P: ",X:DTIME Q:X=""!(X[U)  S:X="n" X="N" S:X="p" X="P"
 I X'="N"&(X'="P") W !,"Enter 'N' to delete by number or 'P' to delete by patient." G LRUMD2
 S LRF=1 D @X Q
N Q:$D(L)'=11  W !!,"Select number to delete patient " W:LRF "(1-",R-1,")" W ": " R X:DTIME Q:X=""!(X[U)
 I X<1!(X>(R-1))!(+X'=X) W $C(7),!,"To delete a patient select a number " W:'LRF "within range shown above" W:LRF "from 1 to ",R-1 G N
 I '$D(L(X)) W $C(7),!,"Number ",X," was deleted.  It is not necessary to enter the same number again." G N
 S LRF=0,LRB=L(X) K L(X) D K G N
K S Y=^LRO(69.2,LRAA,7,DUZ,1,LRB,0) W !,$P(Y,"^",2),"  SSN:",$P(Y,U,10)," deleted."
 S DA(2)=LRAA,DA(1)=DUZ,DA=LRB,DIK="^LRO(69.2,DA(2),7,DA(1),1," D ^DIK K DIC,DIK,DR,DA Q
 ;
D W ! S ZTRTN="QUE^LRUMD2" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO D L^LRU,S^LRU,H S LR("F")=1
L S P=0 F R=1:1 S P=$O(^LRO(69.2,LRAA,7,DUZ,1,"C",P)) Q:P=""!(LR("Q"))  F L=0:0 S L=$O(^LRO(69.2,LRAA,7,DUZ,1,"C",P,L)) Q:'L!(LR("Q"))  D:$Y>(IOSL-6)&(R#2=1) H Q:LR("Q")  D W
 Q
W S P(1)=$E(P,1,28),X=$S($D(^LRO(69.2,LRAA,7,DUZ,1,L,1)):"("_$E(^(1),1,3)_")",1:"") S:X="()" X="" W:R#2=1 !,$J(R,2),")",?5,P(1),?33,X W:R#2=0 ?40,$J(R,2),")",?44,P(1),?74,X Q
 D END^LRUTL,END Q
 Q
 ;
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"Patient list for: ",$P(^VA(200,DUZ,0),U),!,LR("%") Q
EN ;group removal
 K L D EN1^LRUMDS Q:'$D(X)  F LRB=0:0 S LRB=$O(^LRO(69.2,LRAA,7,DUZ,1,"D",LRA,LRB)) Q:'LRB  D K
 Q
P Q:'$O(^LRO(69.2,LRAA,7,DUZ,1,0))  K L W ! S DIC="^LRO(69.2,LRAA,7,DUZ,1,",DIC(0)="AEQ",DIC("A")="Select patient to delete: ",DIC("W")="W ""  SSN:"",$P(^(0),U,10)",D="C" D IX^DIC K DIC Q:Y<1  S LRB=+Y D K G P
LR ;from LRUMD,LRUMDU
 I '$D(^LRO(69.2,LRAA,0)) L +^LRO(69.2) S ^LRO(69.2,LRAA,0)=LRAA_"^"_LRAA(2),X=^LRO(69.2,0),^(0)=$P(X,"^",1,2)_"^"_LRAA_"^"_($P(X,"^",4)+1),^LRO(69.2,"B",LRAA,LRAA)="",^LRO(69.2,"C",LRAA(2),LRAA)="" L -^LRO(69.2)
 S:'$D(^LRO(69.2,LRAA,7,0)) ^(0)="^69.28PA^0^0" I '$D(^(DUZ,0)) L +^LRO(69.2,LRAA,7) S ^LRO(69.2,LRAA,7,DUZ,0)=DUZ,X=^LRO(69.2,LRAA,7,0),^(0)=$P(X,"^",1,2)_"^"_DUZ_"^"_($P(X,"^",4)+1) L -^LRO(69.2,LRAA,7)
 S ^LRO(69.2,LRAA,7,DUZ,0)=DUZ_"^"_DT S:'$D(^(60,0)) ^(0)="^69.35A^0^0" S:'$D(^LRO(69.2,LRAA,7,DUZ,1,0)) ^(0)="^69.3PA^0^0" Q
 ;
END D V^LRU Q
