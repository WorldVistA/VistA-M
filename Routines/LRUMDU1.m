LRUMDU1 ;AVAMC/REG - MD SELECTED TEST UTILITY ;2/18/93  13:01
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 D K^LRU K XY,LRCAPA,LRSF,LRWHO,LRQ,LRH,LRPARAM S ZTRTN="QUE^LRUMDU1" W ! D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K LR("F") D S^LRU,F,END^LRUTL,END Q
 D END^LRUTL,END Q
F D H S LR("F")=1 F A=0:0 S A=$O(^LRO(69.2,LRAA,7,DUZ,60,A)) Q:'A  F B=0:0 S B=$O(^LRO(69.2,LRAA,7,DUZ,60,A,1,B)) Q:'B  S C=^(B,0),N(A,B)=$P(^LAB(60,C,.1),"^"),L(A,B)=$P($P(^(0),U,5),";",2)
 S A=0 F C=0:1 S A=$O(N(A)) Q:'A  D:$Y>(IOSL-5) H Q:LR("Q")  D Z W !,"Test list#: ",$J(A,2),?17,"|" F B=0:0 S B=$O(N(A,B)) Q:'B  W ?10+(B*8),N(A,B),$E("       ",1,7-$L(N(A,B))),"|"
 D:C&('LR("Q")) Z Q
 ;
Z W !,"-----------------|-------|-------|-------|-------|-------|-------|-------|" Q
 ;
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"Test list for ",$P(^VA(200,DUZ,0),U),!?6,"Test order#:",?21,1,?29,2,?37,3,?45,4,?53,5,?61,6,?69,7 Q
 ;
END D V^LRU Q
