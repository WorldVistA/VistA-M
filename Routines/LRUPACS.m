LRUPACS ;AVAMC/REG - LAB ACCESSION COUNTS BY SHIFT ;2/18/93  13:09 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 D END S DIC=68,DIC(0)="AEMOQZ",DIC("S")="I ""AUCYEMSP""'[$P(^(0),U,2)&($P(^(0),U,2)]"""")" D ^DIC K DIC G:Y<1 END S W=+Y,W(1)=$P(Y,U,2)
 W !!?20,W(1)," ACCESSION & TEST COUNTS BY SHIFT" D B G:Y<0 END
 K X,Y,XY S ZTRTN="QUE^LRUPACS" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO D L^LRU,S^LRU,EN^LRUTL
 S LRLDT=LRLDT+.99,Z=$S($P(^LRO(68,W,0),U,3)="Y":$E(LRSDT,1,3)_"0000",1:LRSDT),Z(1)=$S($P(^LRO(68,W,0),U,3)="Y":$E(LRLDT,1,3)_"0000",1:LRLDT)
 D H,Z S LR("F")=1 F S=4:1:8 S A(S)=0
 F S=0:0 S S=$O(S(S)) Q:'S!(LR("Q"))  D:$Y>(IOSL-6) H Q:LR("Q")  W !,$E($P(^LAB(61,S,0),"^"),1,19) S A(1)=$S($D(S(S,1)):S(S,1),1:0),A(2)=$S($D(S(S,2)):S(S,2),1:0),A(3)=$S($D(S(S,0)):S(S,0),1:0) D SUM
 G:LR("Q") OUT D TOT K A,S D TST Q:LR("Q")  D TOT
OUT W:IOST'?1"C".E @IOF D END^LRUTL,END Q
TOT D:$Y>(IOSL-6) H Q:LR("Q")  W !,?20,"-----",?35,"-----",?50,"-----",?65,"-------",!,"Total",$S($D(S):" Accessions",1:" Tests"),?20,$J(A(7),5),?35,$J(A(5),5),?50,$J(A(6),5),?65,$J(A(8),7)
 W:A(8) !?5,"%",?20,$J(A(7)/A(8)*100,5,1),?35,$J(A(5)/A(8)*100,5,1),?50,$J(A(6)/A(8)*100,5,1) Q
SUM S A(4)=A(1)+A(2)+A(3),A(5)=A(5)+A(1),A(6)=A(6)+A(2),A(7)=A(7)+A(3),A(8)=A(8)+A(4)
 W ?20,$J(A(3),5),?35,$J(A(1),5),?50,$J(A(2),5),?65,$J(A(4),7) Q
TST D:$Y>(IOSL-6) H Q:LR("Q")  W !! F T=5:1:8 S A(T)=0
 F T=0:0 S T=$O(T(T)) Q:'T!(LR("Q"))  D:$Y>(IOSL-6) H Q:LR("Q")  W !,$E($P(^LAB(60,T,0),"^"),1,19) S A(1)=$S($D(T(T,1)):T(T,1),1:0),A(2)=$S($D(T(T,2)):T(T,2),1:0),A(3)=$S($D(T(T,0)):T(T,0),1:0) D SUM
 Q
 Q
Z S Z=Z-1
 F I=Z:0 S I=$O(^LRO(68,W,1,I)) Q:'I!(I>Z(1))  S Z(3)=LRSDT-.01 F B=Z(3):0 S B=$O(^LRO(68,W,1,I,1,"AC",B)) Q:'B!(B>LRLDT)  S Y=B#1*10000\800 F W(6)=0:0 S W(6)=$O(^LRO(68,W,1,I,1,"AC",B,W(6))) Q:'W(6)  D AC1
 Q
AC1 S S=$S($D(^LRO(68,W,1,I,1,W(6),5,1,0)):+^(0),1:0) S:S<1 S=LRU S:'$D(S(S,Y)) S(S,Y)=0 S S(S,Y)=S(S,Y)+1
 F T=0:0 S T=$O(^LRO(68,W,1,I,1,W(6),4,T)) Q:'T  S:'$D(T(T,Y)) T(T,Y)=0 S T(T,Y)=T(T,Y)+1 ;S:'$D(S(S,T,Y)) S(S,T,Y)=0 S S(S,T,Y)=S(S,T,Y)+1
 Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"LABORATORY SERVICE ",W(1)," COUNTS",!?21,"From:",LRSTR,"  To:",LRLST
 W !,?20,"12am-8am",?35,"8am-4pm",?50,"4pm-midnight",?65,"Total count",!,LR("%") Q
 ;
B D ^LRU S %DT="AEX",%DT(0)="-N",%DT("A")="Start with Date: T-1// " D ^%DT K %DT I X="" S X="T-1" D ^%DT S X=Y D D^LRU W Y S Y=X
 Q:Y<1  S LRSDT=Y I Y=DT D N G B
 S %DT="AEX",%DT("A")="Go    to   Date: T-1// " D ^%DT K %DT I X="" S X="T-1" D ^%DT S X=Y D D^LRU W Y S Y=X
 Q:Y<1  S LRLDT=Y I Y=DT D N G B
 I LRSDT>LRLDT S X=LRSDT,LRSDT=LRLDT,LRLDT=X
 S Y=LRSDT D D^LRU S LRSTR=Y,Y=LRLDT D D^LRU S LRLST=Y Q
N W $C(7),!?3,"Date cannot be TODAY." Q
 ;
END D V^LRU Q
