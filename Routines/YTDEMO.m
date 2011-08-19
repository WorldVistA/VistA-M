YTDEMO ;SLC/DKG-TEST PKG: CRT DEMO PROGRAM ; 10/19/88  17:29 ;
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
 S YSTEST=$O(^YTT(601,"B","DEMO",0)) G:'YSTEST END S J=1,C=" ;3;T; ;^; "
D0 ;
 D D1,RD G:J<7 D0
END ;
 K C,J,K,L,X,YSTEST Q
D1 ;
 W:'$D(E) @IOF W !! F L=1:1 Q:'$D(^YTT(601,YSTEST,"Q",J,"T",L,0))  W !?3 W:'$D(E) ^(0) W:$D(E)&(^(0)'["!") ^(0)
 K E Q
RD ;
 R *X:900 G:'$T!(X=42) H^XUS G:X<32 RD S X=$C(X)
 I X=$P(C,";",J) S J=J+1 Q
 S K=J,J=7,E=1
 I K=5,X=6 S J=8 D D2 S E1=1,J=5 D D2 K E1 G RD
 I K=5,X="N" S J=10 D D2 S E1=1,J=5 D D2 K E1 G RD
 D D2 S J=K Q
D2 ;
 W:'$D(E1) @IOF F L=1:1 Q:'$D(^YTT(601,YSTEST,"Q",J,"T",L,0))  W:^(0)'["!" !?3,^(0)
 Q
