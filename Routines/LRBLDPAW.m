LRBLDPAW ;AVAMC/REG - BLOOD DONOR PRINT  ;6/24/90  20:57 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D:$Y>(IOSL-6) M^LRBLDPA1 Q:LR("Q")  W !! D T
 F LRT=0:0 S LRT=$O(^LRE(LR,5,LRI,99,LRT)) Q:'LRT!(LR("Q"))  F LRD=0:0 S LRD=$O(^LRE(LR,5,LRI,99,LRT,1,LRD)) Q:'LRD!(LR("Q"))  S LRX=^(LRD,0) D W
 Q
W D:$Y>(IOSL-6) H Q:LR("Q")  S Y=LRD D A^LRU S X=+$P(LRX,"^",2),X=$S($D(^VA(200,X,0)):$P(^(0),"^"),1:X),LRX(1)=Y,LRX(2)=X W !,$P(^LAB(60,LRT,0),"^"),?32,Y,?49,X
 F LRC=0:0 S LRC=$O(^LRE(LR,5,LRI,99,LRT,1,LRD,1,LRC)) Q:'LRC!(LR("Q"))  S LRW=^(LRC,0) D:$Y>(IOSL-6) H1 Q:LR("Q")  W !?2,$P(^LAM(LRC,0),"^"),?35,"CAP Count:",$J($P(LRW,"^",2),3),?50,"Counted: ",$S($P(LRW,"^",3):"YES",1:"NO")
 Q
 ;
H D M^LRBLDPA1 Q:LR("Q")  D T Q
H1 D H Q:LR("Q")  W !,$P(^LAB(60,LRT,0),"^"),?32,LRX(1),?49,LRX(2) Q
T W !,"Workload Entry",?36,"Date",?54,"Tech" Q
