DGGECSR ;ALB/MJK,RMO - Read Processor Routine ; 24 AUG 89 11:00am
 ;;5.3;Registration;;Aug 13, 1993
SET S:'$D(DGRD(0)) DGRD(0)="" W:DGRD(0)'["S" !?2,"Choose one of the following:"
 F I=0:0 S I=$O(DGRD(I)) Q:'I  W:DGRD(0)'["S" !?10,$P(DGRD(I),"^",1) S V=$P(DGRD(I),"^",1) D UPPER S $P(DGRD(I),"^",3)=S
READ K S,I,J,L,I W !!,$S($D(DGRD("A")):DGRD("A"),1:"Enter Response: ")
 I $D(DGRD("B")),$D(DGRD(DGRD("B"))) W $P(DGRD(DGRD("B")),"^",1),"// "
 R X:$S($D(DGRD("DTIME")):+DGRD("DTIME"),1:DTIME) S X1=X G HELP:X="?" S DTOUT='$T,L=$L(X) I X["^" S X="^" G Q
 I DTOUT S X=$S('$D(DGRD("DTOUT")):"^",'$D(DGRD(+DGRD("DTOUT"))):"^",1:$P(DGRD(+DGRD("DTOUT")),"^")) G Q
 I 'L S X=$S('$D(DGRD("B")):"",'$D(DGRD(+DGRD("B"))):"",1:$P(DGRD(+DGRD("B")),"^")) G Q
 S V=X D UPPER
 F I=0:0 S I=$O(DGRD(I)) Q:'I  I S=$E($P(DGRD(I),"^",3),1,L) S X=$P(DGRD(I),"^",1) W $E(X,L+1,99) G Q
 W *7
HELP ;
 I $D(DGRD("XQH")) S XQH=DGRD("XQH") D EN^XQH W ! G SET
 W !!?2,"Enter one of the following:"
 F I=0:0 S I=$O(DGRD(I)) Q:'I  W !?5,"'",$P(DGRD(I),"^",1),"'",?25,"to ",$E($P(DGRD(I),"^",2),1,79-$X)
 W !?5,"^",?25,"to stop." G READ
 ;
Q K DTOUT,S,C,I,L Q
 ;
UPPER ;
 S S="" F J=1:1 S C=$E($P(V,"^",1),J) Q:C=""  S:$A(C)>96&($A(C)<123) C=$C($A(C)-32) S S=S_C
 K C,V Q
