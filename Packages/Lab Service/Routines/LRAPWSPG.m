LRAPWSPG ;AVAMC/REG - GROSS DESCRIPTION WORKLOAD ;8/4/91  09:25 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 D END,AA G:Y=-1 END S X="ROUTINE GROSS SURGICAL" D X^LRUWK S LRW(1)=LRT K LRT
 S X="EXTENSIVE GROSS SURGICAL" D X^LRUWK S LRW(2)=LRT K LRT
 S X="TECHNICAL ASSISTANCE SURGICAL" D X^LRUWK S LRW(3)=LRT K LRT I 'LRW(1)!('LRW(2))!('LRW(3)) Q
 S DR=.012,DR(2,63.812)=".03;.04"
ASK S %DT="",X="T" D ^%DT S LRY=$E(Y,1,3)+1700 W !!,"Enter year: ",LRY,"// " R X:DTIME G:'$T!(X[U) END S:X="" X=LRY
 S %DT="EQ" D ^%DT G:Y<1 ASK S LRY=$E(Y,1,3),LRAD=$E(LRY,1,3)_"0000",LRH(0)=LRY+1700 W "  ",LRH(0)
 I '$O(^LRO(68,LRAA,1,LRAD,1,0)) W $C(7),!!,"NO ",LRAA(1)," ACCESSIONS IN FILE FOR ",LRH(0),!! Q
ACC D ^LRAPWA Q:'LRAN  D STF G ACC
 ;
STF F A=0:0 S A=$O(^LR(LRDFN,LRSS,LRI,.1,A)) Q:'A  S X=^(A,0) D:'$P(X,"^",5) A
 Q
A S LRK=$P(X,"^",3),X=$P(X,"^",4) Q:'LRK!('X)  S LRT=LRW(X)
 S:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,0)) ^(0)="^68.04PA^^"
 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,0)) S ^(0)=LRT_"^50^^"_DUZ_"^"_LRK,X=^LRO(68,LRAA,1,LRAD,1,LRAN,4,0),^(0)=$P(X,"^",1,2)_"^"_LRT_"^"_($P(X,"^",4)+1)
 S:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,0)) ^(0)="^68.14P^^"
 F C=0:0 S C=$O(^LAB(60,LRT,9,C)) Q:'C  S A(1)=$P(^(C,0),"^",3) S:'A(1) A(1)=1 D CAP
 S $P(^LR(LRDFN,LRSS,LRI,.1,A,0),"^",5)=1,^LRO(68,"A",LRAA_"|"_LRAD_"|"_LRAN_"|"_LRT)="" Q
 ;
CAP I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,C,0)) S ^(0)=C_"^"_A(1)_"^0^0^^"_LRK_"^"_DUZ_"^"_DUZ(2)_"^"_LRAA_"^"_LRAA_"^"_LRAA,X=^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,0),^(0)=$P(X,"^",1,2)_"^"_C_"^"_($P(X,"^",4)+1) Q
 S X=^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,C,0),$P(X,"^",2)=$S($P(X,"^",3):A(1),1:$P(X,"^",2)+A(1)),$P(X,"^",3)=0,^(0)=X Q
 ;
AA S X="SURGICAL PATHOLOGY" D ^LRUTL Q:Y<1  S X=$P(Y,U,2),LR("K")=$P(^LRO(68,LRAA,0),U,14),LRABV=$P(^(0),U,11)
 I LR("K")]"",$D(^DIC(19.1,LR("K"),0)) S LR("K")=$P(^(0),U) I LR("K")]"",'$D(^XUSEC(LR("K"),DUZ)) W $C(7),!!,"You do not have the appropriate security key for SURGICAL PATHOLOGY",! S Y=-1
 Q
 ;
END D V^LRU Q
