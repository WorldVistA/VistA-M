RTRD ;MJK/TROY ISC;Read Processor Routine; ; 2/24/87  12:43 PM ;
 ;;v 2.0;Record Tracking;;10/22/91 
R R X:$S($D(RTRD("DTIME")):+RTRD("DTIME"),1:DTIME) Q
SET S:'$D(RTRD(0)) RTRD(0)="" W:RTRD(0)'["S" !?2,"Choose one of the following:"
 F I=0:0 S I=$O(RTRD(I)) Q:'I  W:RTRD(0)'["S" !?10,$P(RTRD(I),"^",1) S V=$P(RTRD(I),"^",1) D UPPER S $P(RTRD(I),"^",3)=S
READ K S,I,J,L,I W !!,$S($D(RTRD("A")):RTRD("A"),1:"Enter Response: ")
 I $D(RTRD("B")),$D(RTRD(RTRD("B"))) W $P(RTRD(RTRD("B")),"^",1),"// "
 D R S X1=X G HELP:X="?" S DTOUT='$T,L=$L(X) I X["^" S X="^" G Q
 I DTOUT S X=$S('$D(RTRD("DTOUT")):"^",'$D(RTRD(+RTRD("DTOUT"))):"^",1:$P(RTRD(+RTRD("DTOUT")),"^")) G Q
 I 'L S X=$S('$D(RTRD("B")):"",'$D(RTRD(+RTRD("B"))):"",1:$P(RTRD(+RTRD("B")),"^")) G Q
 S V=X D UPPER
 F I=0:0 S I=$O(RTRD(I)) Q:'I  I S=$E($P(RTRD(I),"^",3),1,L) S X=$P(RTRD(I),"^",1) W $E(X,L+1,99) G Q
 W *7
HELP ;
 I $D(RTRD("XQH")) S XQH=RTRD("XQH") D EN^XQH W ! G SET
 W !!?2,"Enter one of the following:"
 F I=0:0 S I=$O(RTRD(I)) Q:'I  W !?5,"'",$P(RTRD(I),"^",1),"'",?25,"to ",$E($P(RTRD(I),"^",2),1,79-$X)
 W !?5,"^",?25,"to stop." G READ
 ;
Q K S,C,I,L,DTOUT Q
 ;
UPPER ;
 S S="" F J=1:1 S C=$E($P(V,"^",1),J) Q:C=""  S S=S_$S(C?1L:$C($A(C)-32),1:C)
 K C,V Q
 ;
SEL K RTY I $S(RTSEL["L":1,RTSEL'["O":0,RTC=1:1,1:0),$D(RTS) S RTY(1)=RTS(1) S (X,RTC)=1 Q
 S C=0 I RTSEL["A" S X=1 F I=0:0 S I=$O(RTS(I)) G SELQ:'I S C=C+1,RTY(C)=RTS(I)
SEL1 K RTY S C=0 W !!,$S($D(RTRD("A")):RTRD("A"),1:"Select: ") W:$D(RTRD("B")) RTRD("B"),"// " D R G QUES:X["?" S:X=""&($D(RTRD("B"))) X=RTRD("B") G SELQ:"^"[X S I=0
 I X[","!(X["-"),RTSEL'["S" G ERR
LOOP S I=I+1 S X1=$P(X,",",I) I 'X1,X1]"" G ERR
 G SELQ:'X1 I RTSEL["S",X1["-" G RANGE
 G ERR:'$D(RTS(X1))!(X1>RTC) S C=C+1,RTY(C)=RTS(X1) G LOOP
RANGE G ERR:X1'?1N.N1"-"1N.N!(+X1>$P(X1,"-",2)) F N=+X1:1:+$P(X1,"-",2) G ERR:'$D(RTS(N))!(N>RTC) S C=C+1,RTY(C)=RTS(N)
 G LOOP
 ;
ERR W !,*7,"Your input is invalid."
QUES W !!,"Enter ",?6,$S(RTSEL["S":"a) ",1:""),"a single number between 1 and ",RTC
 W:RTSEL["S" !?6,"b) more than one number by separating numbers by commas (ie. 1,3)",!?6,"c) a range of numbers (ie. 1-3)",!?6,"d) a combination of 'a','b' and 'c' (ie. 1,3,4-5)"
 W !!?3,"...OR enter an '^' to stop."
 G SEL1
SELQ S RTC=C K X1,C Q
 ;
ESC W !!,"Press <Return> to continue or '^' to stop: " R X:DTIME S:'$T!(X["^") RTESC="" Q
