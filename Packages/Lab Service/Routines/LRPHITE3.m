LRPHITE3 ;SLC/CJS/RWF-ITEMIZED LOGIN ;9/8/87  12:39
 ;;5.2;LAB SERVICE;**100,198,208,221**;Sep 27, 1994
EXCEPT ;from LRPHEXPT, LRPHITEM
 K LRNATURE,LRCCOM,LRCOM0
 N LRORD,LRODT
 S LRNOP=0,LRORD=LROR(LROR),LRODT=DT D LOOK^LRCENDEL Q
 ;,X=$O(LRCOM(999-LROR)),LRBATCH=$S(X>0:$L(LRCOM(X,1,1)),1:0) D EN^LRCENDEL G ONE2:LRBATCH
 W !,"Cancel entire Order # ",LROR(LROR) S %=1,LRRND="",LRCOM(1,1)=0 D YN^DICN
 ;
 ;
 S LRALL69=% ;-->198
 I %=1 G ONE2
 ;
 ;
MORE W !,?8,"entry",?15,"test",?40,"sample"
 S T=0,J=0 F  S J=$O(T(J)) Q:J<1  S T=J W !,?10,J,?15,$P(^LAB(60,$P(T(J),U,3),0),U),?40,$P(T(J),U,4)
 I T=0 W !,"No tests" G NOMORE
ONE R !,"Cancel which entry: ",LRIX:DTIME W:LRIX["?" !,"Enter 'all' or Pick one of the following entries:" G MORE:LRIX["?",NOMORE:LRIX["^"!(LRIX="")
 S LRRND="" I LRIX="ALL" G ONE2
 I LRIX'=+LRIX!(LRIX<1)!(LRIX>T) W !,"Enter a number between 1 and ",T G ONE
 S LR1=1 D ZAP^LRPHITE1 K LR1 W !,LRORD G ONE
ONE2 S LRIX=0 F  S LRIX=$O(T(LRIX)) Q:LRIX<1  D ZAP^LRPHITE1
 W:'LRNOP !,LRORD,?7,"Canceled" G NOMORE
% R %:DTIME Q:%=""!(%["N")!(%["Y")  W !,"Answer 'Y' or 'N': " G %
NOMORE K LRNATURE Q
