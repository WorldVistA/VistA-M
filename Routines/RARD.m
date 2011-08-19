RARD ;HISC/CAH,FPT,GJC AISC/MJK-Read Processor ;9/12/94  11:26
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
SET S:'$D(RARD(0)) RARD(0)="" W:RARD(0)'["S" !?2,"Choose one of the following:"
 F I=0:0 S I=$O(RARD(I)) Q:'I  W:RARD(0)'["S" !?10,$P(RARD(I),"^") S V=$P(RARD(I),"^") D UPPER S $P(RARD(I),"^",3)=S
READ K S,I,J,L,I W !!?2,$S($D(RARD("A")):RARD("A"),1:"Enter Response: ")
 I $D(RARD("B")),$D(RARD(RARD("B"))) W $P(RARD(RARD("B")),"^"),"// "
 R X:$S($D(RARD("DTIME")):+RARD("DTIME"),1:DTIME) S X1=X G HELP:X="?" S DTOUT='$T,L=$L(X) I X["^" S X="^" G Q
 I DTOUT S X=$S('$D(RARD("DTOUT")):"^",'$D(RARD(+RARD("DTOUT"))):"^",1:$P(RARD(+RARD("DTOUT")),"^")) G Q
 I 'L S X=$S('$D(RARD("B")):"",'$D(RARD(+RARD("B"))):"",1:$P(RARD(+RARD("B")),"^")) G Q
 S V=X D UPPER
 F I=0:0 S I=$O(RARD(I)) Q:'I  I S=$E($P(RARD(I),"^",3),1,L) S X=$P(RARD(I),"^") W $E(X,L+1,99) G Q
 W *7
HELP ;
 I $D(RARD("XQH")) S XQH=RARD("XQH") D EN^XQH W ! G SET
 W !!?2,"Enter one of the following:"
 F I=0:0 S I=$O(RARD(I)) Q:'I  W !?5,"'",$P(RARD(I),"^"),"'",?25,"to ",$E($P(RARD(I),"^",2),1,79-$X)
 W !?5,"^",?25,"to stop." G READ
 ;
Q K DTOUT,S,C,I,L Q
 ;
UPPER ;
 S S="" F J=1:1 S C=$E($P(V,"^"),J) Q:C=""  S:$A(C)>96&($A(C)<123) C=$C($A(C)-32) S S=S_C
 K C,V Q
