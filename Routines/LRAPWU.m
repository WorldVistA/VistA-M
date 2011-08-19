LRAPWU ;AVAMC/REG - AP WORKLOAD UTILITY ;8/12/95  19:30
 ;;5.2;LAB SERVICE;**72**;Sep 27, 1994
 I '$O(^LR(LRDFN,LRSS,LRI,.1,0)) W $C(7),!!?20,"*** No specimen entered ***" S F=1 Q
 S F=0 F A=0:0 S A=$O(^LR(LRDFN,LRSS,LRI,.1,A)) Q:'A!(F)  D F Q:F
 Q
F I '$O(^LR(LRDFN,LRSS,LRI,.1,A,0)) S F=1 W $C(7),!!,"*** No blocks or preps entered for ",$P(^(0),U)," ***" Q
 F E=0:0 S E=$O(^LR(LRDFN,LRSS,LRI,.1,A,E)) Q:'E!(F)  D E Q:F
 Q
E Q:$P($G(^LR(LRDFN,LRSS,LRI,.1,A,E,0)),U,4)<1  I '$O(^(0)) S F=1 W $C(7),!!,"No blocks or preps for ",$P(^LR(LRDFN,LRSS,LRI,.1,A,0),U) Q
 F B=0:0 S B=$O(^LR(LRDFN,LRSS,LRI,.1,A,E,B)) Q:'B!(F)  D X
 Q
X I '$O(^LR(LRDFN,LRSS,LRI,.1,A,E,B,1,0)) S F=1 W $C(7),!!,"No stains for ",$P(^LR(LRDFN,LRSS,LRI,.1,A,0),U),"  ",$P(^(E,B,0),U) Q
 I LRSS="EM" D EM Q
 F C=0:0 S C=$O(^LR(LRDFN,LRSS,LRI,.1,A,E,B,1,C)) Q:'C!(F)  S G=^(C,0),G(4)=$P(G,"^",4),G(5)=$P(G,"^",5) S:'G(4) F=1 I 'F,'G(5) S:G(4)<LRK $P(^(0),"^",5)=LRK I G(4)'<LRK S T=LRK D CK
 Q
EM S G=$G(^LR(LRDFN,LRSS,LRI,.1,A,E,B,1,LRW,0)),G(4)=$P(G,"^",4),G(5)=$P(G,"^",5),G(11)=$P(X,"^",11) S:'G(4) F=1 Q:F  I LRK(1),'G(5) S:G(4)<LRK(1) $P(^(0),"^",5)=LRK(1) I G(4)'<LRK(1) S C=LRW,T=LRK(1) D CK
 I LRK,'G(11) S:G(4)<LRK $P(^(0),"^",11)=LRK I G(4)'<LRK S C=LRW D C W !?3,"Date/time prints made    (" S Y=LRK D CK1
 Q
A ;from LRAPLG,LRAPBS
 S A="63."_$S(LRSS="CY":902,LRSS="SP":812,LRSS="EM":202,1:"033") F X=.999:0 S X=$O(^DD(A,X)) Q:'X  S Y=^(X,0),LRZ($P(Y,"^"))=$P($P(Y,"^",4),";")_"^"_$P(Y,"^",2)_"^"_$P(^DD(+$P(Y,"^",2),1,0),"^",2)
 S A="" F  S A=$O(LRZ(A)) Q:A=""  S X=+$O(^LRO(69.2,LRAA,.3,"B",A,0)),Y=$P($G(^LRO(69.2,LRAA,.3,X,0)),"^",2),$P(LRZ(A),"^",4)=Y
 K A,Y Q
 ;
W S %DT="AEQTXR",%DT(0)="-N",%DT("B")="NOW" S:'$D(%DT("A")) %DT("A")="Workload date/time: " D ^%DT S LRK=Y I Y>1 W " OK " S %=1 D YN^LRU G:%'=1 W
 K %DT Q
 ;
CK D C W !?3,"Date/time ",$S(LRSS="EM":"grids scanned ",1:"slides examined")," (" S Y=T
CK1 D DD^%DT W Y,") cannot be before",!?3,"Date/time ",$S(LRSS="EM":"grids prepared",1:"slides  stained")," ("
 S Y=G(4) D DD^%DT W Y,")",$C(7),!!,"Press Return or Enter key: " R X:DTIME Q
C W !!,$P(^LR(LRDFN,LRSS,LRI,.1,A,0),U)," ",$P(^LR(LRDFN,LRSS,LRI,.1,A,E,B,0),U)," ",$P(^LAB(60,C,0),U) Q
