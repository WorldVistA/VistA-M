LRAPWKA ;AVAMC/REG - STUFF AP WORKLOAD ;7/22/94  15:28
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 I $D(LRF) D G Q
 F A=0:0 S A=$O(^LR(LRDFN,LRSS,LRI,.1,A)) Q:'A  F B=0:0 S B=$O(^LR(LRDFN,LRSS,LRI,.1,A,B)) Q:'B  S E=0 F G=1:1 S E=$O(^LR(LRDFN,LRSS,LRI,.1,A,B,E)) Q:'E  S X=^(E,0),LR(63.8122)=$P(X,U,9),(F(1),F)=0 D:'$P(X,"^",3)&("SPEM"[LRSS) BLK D T
 Q
T F LRT=0:0 S LRT=$O(^LR(LRDFN,LRSS,LRI,.1,A,B,E,1,LRT)) Q:'LRT  S X=^(LRT,0) D C
 I LRSS="SP",B=1,F(1)>1 S X(9)=$S(LR(63.8122):F-1,1:F),LRT=LRW(0),LRK=LRK(2) D:LRK A
 I LRSS="SP",B=3,F(1)>0 S X(9)=F,LRT=LRW(6),LRK=LRK(2) D:LRK A
 Q
C S Y=$P(X,"^",2)+$P(X,"^",3),X(9)=$P(X,"^",2)-$P(X,"^",9),X(6)=Y-$P(X,"^",6) S:X(6)>0 $P(X,"^",6)=Y,$P(X,"^",7)=X(6) S:X(9)>0 $P(X,"^",9)=$P(X,"^",2) S ^LR(LRDFN,LRSS,LRI,.1,A,B,E,1,LRT,0)=X
 I X(9)>0 S:B=1!(B=3) F=F+X(9),F(1)=F(1)+Y S $P(X,"^",6)=Y,$P(X,"^",7)=X(6),^(0)=X,LRK=$P(X,"^",4) D A
 Q
A S:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,0)) ^(0)="^68.04PA^^" S:LRK>LRK(2)&((B=1)!(B=3)) LRK(2)=LRK
 I LRSS="SP",B=3,LRT=LRW(7) S F=F-X(9),F(1)=F(1)-Y Q:Y<2
 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,0)) S ^(0)=LRT_"^50^^"_DUZ_"^"_LRK,X=^LRO(68,LRAA,1,LRAD,1,LRAN,4,0),^(0)=$P(X,"^",1,2)_"^"_LRT_"^"_($P(X,"^",4)+1)
 S:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,0)) ^(0)="^68.14P^^"
 F C=0:0 S C=$O(^LAB(60,LRT,9,C)) Q:'C  S C(3)=$P(^(C,0),"^",3) S:'C(3) C(3)=1 S A(1)=C(3)*X(9) D CAP
 S ^LRO(68,"AA",LRAA_"|"_LRAD_"|"_LRAN_"|"_LRT)="" Q
 ;
CAP I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,C,0)) S ^(0)=C_"^"_A(1)_"^0^0^^"_LRK_"^"_DUZ_"^"_DUZ(2)_"^"_LRAA_"^"_LRAA_"^"_LRAA,X=^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,0),^(0)=$P(X,"^",1,2)_"^"_C_"^"_($P(X,"^",4)+1) Q
 S X=^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,C,0),$P(X,"^",2)=$S($P(X,"^",3):A(1),1:$P(X,"^",2)+A(1)),$P(X,"^",3)=0,$P(X,"^",6)=LRK,^(0)=X Q
 ;
BLK S LRK=$P(X,"^",2) Q:'LRK  S X(9)=1,H=$P(X,"^",4),LRT=$S(B=1:LRW(1),B=2:LRW(2),B=3&(H)&(G>2):LRW(5),B=3&(H)&(G=1):LRW(3),B=3&('H):LRW(4),1:0) Q:'LRT  D A,B Q  ;G=block count,H=1 rush H=0 not rush
B S $P(^LR(LRDFN,LRSS,LRI,.1,A,B,E,0),"^",3)=1 Q
 ;
G S (B,LRK(2))=0,X(9)=1 F A=0:0 S A=$O(^LR(LRDFN,LRSS,LRI,.1,A)) Q:'A  S X=^(A,0) D:'$P(X,"^",5) GA
 Q
GA S LRK=$P(X,"^",3),X=$P(X,"^",4) Q:'LRK!('X)  S LRT=LRW(X) D A Q
EN ;
 G:'LRCAPA ^LRAPWKA1 S LRK(2)=0 G:LRSS'="AU" LRAPWKA
 F A=0:0 S A=$O(^LR(LRDFN,33,A)) Q:'A  F B=0:0 S B=$O(^LR(LRDFN,33,A,B)) Q:'B  S E=0 F G=1:1 S E=$O(^LR(LRDFN,33,A,B,E)) Q:'E  S X=^(E,0) D:'$P(X,"^",3) AUBLK D AUT
 Q
AUT F LRT=0:0 S LRT=$O(^LR(LRDFN,33,A,B,E,1,LRT)) Q:'LRT  S X=^(LRT,0) D C1
 Q
C1 S Y=$P(X,"^",2)+$P(X,"^",3),X(9)=$P(X,"^",2)-$P(X,"^",9),X(6)=Y-$P(X,"^",6) I LRT=LRW(0),X(9)>0 S X(9)=$S($P(X,"^",9)=0&(X(9)=1):0,X(9)>0:X(9)-1,1:0)
 S:X(9)>0 $P(X,"^",9)=$P(X,"^",2) S $P(X,"^",6)=Y,$P(X,"^",7)=X(6),LRK=$P(X,"^",4),^LR(LRDFN,33,A,B,E,1,LRT,0)=X D:X(9)>0 A Q
 ;
AUBLK S LRK=$P(X,"^",2) Q:'LRK  S X(9)=1,LRT=LRW(1) Q:'LRT  D A
 S $P(^LR(LRDFN,33,A,B,E,0),"^",3)=1 Q
