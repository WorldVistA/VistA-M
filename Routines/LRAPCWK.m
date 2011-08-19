LRAPCWK ;AVAMC/REG - STUFF CYTOPATH WORKLOAD ;8/3/94  08:05
 ;;5.2;LAB SERVICE;;Sep 27, 1994
ASK W ! S %DT("A")="Date/time Specimen(s) Processed: " D W^LRAPWU I LRK<1 W $C(7),!!,"Processing workload not recorded.  Is this what you want " S %=2 D YN^LRU Q:%<2  G ASK
 K A F A=0:0 S A=$O(^LR(LRDFN,LRSS,LRI,.1,A)) Q:'A  S A(A)=$P(^(A,0),"^",2)
 S:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,0)) ^(0)="^68.04PA^^" F A=0:0 S A=$O(A(A)) Q:'A  S LRT=A(A) D:LRT STF,R
 Q
R F C=0:0 S C=$O(^LAB(60,LRT,9.1,C)) Q:'C  D CAP
 I $G(LRW("S")) S C=LRW("S") D CAP
 D SET F LRX=0:0 S LRX=$O(^LAB(60,LRT,2,LRX)) Q:'LRX  S X(1)=+^(LRX,0),X(2)=$P($G(^LAB(60,X(1),0)),"^",19) I X(2),$D(^LAB(62.07,X(2),0)) S Y=$P(^(0),"^") D B
 Q
CAP I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,C,0)) S ^(0)=C_"^1^0^0^^"_LRRC_"^"_DUZ_"^"_DUZ(2)_"^"_LRAA_"^"_LRAA_"^"_LRAA,X=^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,0),^(0)=$P(X,"^",1,2)_"^"_C_"^"_($P(X,"^",4)+1) Q
 S X=^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,C,0),$P(X,"^",2)=$S($P(X,"^",3):1,1:$P(X,"^",2)+1),$P(X,"^",3)=0,^(0)=X Q
 ;
B Q:'$D(LRZ(Y))  S LRO=LRT,LRO(1)=LRRC,LRRC=LRK,LRT=X(1) D STF F C=0:0 S C=$O(^LAB(60,LRT,9,C)) Q:'C  D CAP
 D SET S LRT=LRO,LRRC=LRO(1),E=+LRZ(Y),Y(2)=$S($P(LRZ(Y),"^",4)]"":$P(LRZ(Y),"^",4),1:$E(Y,1,9)) S:'$D(^LR(LRDFN,LRSS,LRI,.1,A,E,0)) ^(0)="^"_$P(LRZ(Y),"^",2)_"^^" S B=$P(^(0),"^",3)+1
G I $D(^LR(LRDFN,LRSS,LRI,.1,A,E,B,0)) S B=B+1 G G
 S F=^LR(LRDFN,LRSS,LRI,.1,A,E,0),^(0)=$P(F,"^",1,2)_"^"_B_"^"_($P(F,"^",4)+1),^(B,0)=Y(2)
 S:'$D(^LR(LRDFN,LRSS,LRI,.1,A,E,B,1,0)) ^(0)="^"_$P(LRZ(Y),"^",3)_"^^"
 F C=0:0 S C=$O(^LAB(60,X(1),2,C)) Q:'C  S C(1)=^(C,0) D S
 Q
S I '$D(^LR(LRDFN,LRSS,LRI,.1,A,E,B,1,+C(1),0)) S ^(0)=$P(C(1),"^",1,2),F=^LR(LRDFN,LRSS,LRI,.1,A,E,B,1,0),^(0)=$P(F,"^",1,2)_"^"_+C(1)_"^"_($P(F,"^",4)+1) Q
 S F=^LR(LRDFN,LRSS,LRI,.1,A,E,B,1,+C(1),0),$P(F,"^",2)=$P(F,"^",2)+$P(C(1),"^",2),^(0)=F Q
 ;
STF I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,0)) S ^(0)=LRT_"^50^^"_DUZ_"^"_LRRC,X=^LRO(68,LRAA,1,LRAD,1,LRAN,4,0),^(0)=$P(X,"^",1,2)_"^"_LRT_"^"_($P(X,"^",4)+1)
 S:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,0)) ^(0)="^68.14P^^" Q
SET S ^LRO(68,"AA",LRAA_"|"_LRAD_"|"_LRAN_"|"_LRT)="" Q
 ;
CK I '$O(^LR(LRDFN,LRSS,LRI,.1,0)) S Y=1 W !!,"No SPECIMEN entered." G OUT
 K A S A=0 F B=1:1 S A=$O(^LR(LRDFN,LRSS,LRI,.1,A)) Q:'A  S X=$P(^(A,0),"^",2) S:X'=+X X=0 I '$D(^LAB(60,X,0)) S $P(^LR(LRDFN,LRSS,LRI,.1,A,0),U,2)="" W:B=1 ! W !,"WORKLOAD PROFILE NOT ENTERED FOR ",$P(^(0),U) S Y=1
OUT Q
C ;from LRAPDA
 S LRK=1,C=0 F A=0:0 S A=$O(^LR(LRDFN,LRSS,LRI,.1,A)) Q:'A!(C)  F B=0:0 S B=$O(^(A,B)) Q:'B  S C=1
 Q:C  D EN^LRAPST,ASK Q
