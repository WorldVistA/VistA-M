LRAUS ;AVAMC/REG - PRINT ICD SEARCH ;9/13/89  18:55 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 S LRND=^TMP($J,0),T(0)=$P(LRND,"^",3),LRFLD=$P(LRND,"^",4) D L^LRU,H S LR("F")=1
 F Y=0:0 S Y=$O(^TMP($J,Y)) Q:'Y!(LR("Q"))  D N
 I $D(LRSS),LRSS="AU" W !!,"NUMBER OF AUTOPSIES SEARCHED WITH ",$P(^TMP($J,0,1)," ",1)," CODING: ",LRPAT1
 K T(0),LRFLD,LRND Q
N F N=0:0 S N=$O(^TMP($J,Y,N)) Q:'N!(LR("Q"))  S LRND=^(N) D:$Y>(IOSL-6) H Q:LR("Q")  W !,$P(LRND,"^"),?9,$E($P(LRND,"^",4),1,18),?28,$P(LRND,"^",5),?34,$P(LRND,"^",3),?38,$P(LRND,"^",2),?41,$J($P(LRND,"^",6),5) D T
 Q
T S T=0 F A=0:1 S T=$O(^TMP($J,Y,N,T)) Q:'T!(LR("Q"))  W:A>0 ! W ?47,$E(^(T),1,16) D D
 Q
D S M=0 F B=0:1 S M=$O(^TMP($J,Y,N,T,M)) Q:'M!(LR("Q"))  W:B>0 ! W ?65,$E(^(M),1,15)
 Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,T(0)," SEARCH (",LRSTR,"=>",LRLST,")",!,^TMP($J,0,1)
 W !,"ACC NUM",?9,"NAME",?28,"ID",?33,"SEX",?37,"AGE",?41,"MO/DA",!,LR("%") Q
