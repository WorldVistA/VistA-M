YTPHQ9 ;ALB/ASF- TEST PRIME MD PHQ9 ;7/2/03  14:23
 ;;5.01;MENTAL HEALTH;**70**;Dec 30, 1994
 ;
 N A,B,B1,C,D,E,E1,F,F1,G,G1,H,I,J,J1,J2,J3,J4,K,L,L1,L2,M,N
 N N1,N2,N3,N4,P,P0,P1,P3,R1,S1,T,T1,T2,TT,V,V1,V2,V3
 N V4,V5,V6,W,X,X0,X1,X2,X3,X4,X7,X8,X9,Y,Y1,Y2,Z,Z1,Z3
 S YSNOITEM="DONE^YTPHQ9"
 S X=^YTD(601.2,YSDFN,1,YSET,1,YSED,1)
 S R=0
 F I=1:1:9 S R=$S($E(X,I)'="X":R+$E(X,I)-1,1:R)
 S YSNX=$L(X,"X")-1
 S YSN3=$L(X,3)-1,YSN4=$L(X,4)-1
 S S=""
 I (($E(X,1)>2)!($E(X,2)>2))&(($E(X,2)>2)) S S="Other Depressive Syndrome"
 I (($E(X,1)>2)!($E(X,2)>2))&(($E(X,3)>2)) S S="Other Depressive Syndrome"
 I (($E(X,1)>2)!($E(X,2)>2))&(($E(X,4)>2)) S S="Other Depressive Syndrome"
 I (($E(X,1)>2)!($E(X,2)>2))&((YSN3+YSN4)>4) S S="Major Depressive Syndrome"
 Q:YSTY'["*"
 D DTA^YTREPT
 W !?21,$P(^YTT(601,YSTEST,"P"),U)
 W !,$S(S'="":"**** "_S_" suggested ****",1:"No depressive syndrome suggested")
 W !,"PHQ9 score= ",R
 S N=0 F  S N=$O(^YTT(601,YSET,"G",1,1,N)) Q:N'>0  W !,^YTT(601,YSET,"G",1,1,N,0)
 ;W:(R>14) !,"This score warrants treatment for depression using antidepressant, psychotherapy and/or a combination of treatment."
 ;W:((R>4)&(R<15)) !,"This score suggests Physician uses clinical judgement about treatment based on patient's duration of symptoms and functional impairment."
 ;W:(R<5) !,"This score suggests the patient may not need depression treatment"
 W !
 F I=1:1:9 W !,$S($E(X,I)="X":"X",1:$E(X,I)-1)_"  "_$C(96+I)_"."_$E(^YTT(601,YSET,"Q",I,"T",1,0),1,60) W:$D(^YTT(601,YSET,"Q",I,"T",2,0)) " ..."
 W !!,"0= Not at all  1= Several days  2= More than half the days  3= Nearly every day"
 D:$Y+4>IOSL WAIT
DONE Q
WAIT ;
 ;  Added 5/6/94 LJA
 ;
 F I0=1:1:(IOSL-$Y-2) W !
 N DTOUT,DUOUT,DIRUT
 S DIR(0)="E" D ^DIR K DIR S YSTOUT=$D(DTOUT),YSUOUT=$D(DUOUT),YSLFT=$D(DIRUT)
 W @IOF Q
