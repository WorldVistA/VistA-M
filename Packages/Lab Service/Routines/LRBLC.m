LRBLC ;AVAMC/REG - ABO/RH COUNT ;2/18/93  08:37 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D END W !!?20,"ABO/Rh recheck counts"
 D B^LRU G:Y=-1 END
 S LRSDT=LRSDT-.01,LRLDT=LRLDT+.99,(LRABO,LRRH)=0
 S ZTRTN="QUE^LRBLC" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO D L^LRU,S^LRU S A=LRSDT F B=0:0 S A=$O(^LRD(65,"A",A)) Q:'A!(A>LRLDT)  F C=0:0 S C=$O(^LRD(65,"A",A,C)) Q:'C  D C
 D H,END,END^LRUTL Q
C I $D(^LRD(65,C,10)),$P(^(10),"^")]"","ABO"[$P(^(10),"^"),'$P(^(10),"^",4) S LRABO=LRABO+1
 I $D(^LRD(65,C,11)),$P(^(11),"^")]"","POSNEG"[$P(^(11),"^"),'$P(^(11),"^",4) S LRRH=LRRH+1
 Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"BLOOD BANK ABO/Rh counts from: ",LRSTR," to ",LRLST,!,LR("%"),!,"ABO re-check count: ",$J(LRABO,5),!,"Rh  re-check count: ",$J(LRRH,5) Q
 ;
END D V^LRU Q
