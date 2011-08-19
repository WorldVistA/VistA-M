YTACL ; REL - ADJECTIVE CHECK LIST ; 4/1/86  12:29 PM ;
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
 S R="",J=1,X(1)=^YTD(601.2,YSDFN,1,YSET,1,YSED,1),X(2)=^(2)
T0 ;
 S YSKK=1,YSTL=0
T1 ;
 I $D(^YTT(601,YSTEST,"S",J,"K",YSKK,0))#2=0 S R=R_YSTL_"^",J=J+1 G T0:J<26,TD
 S Y=^YTT(601,YSTEST,"S",J,"K",YSKK,0),P=1
T2 ;
 S YSIT=$P(Y,"^",P) I YSIT="" S YSKK=YSKK+1 G T1
 S A=$P(Y,"^",P+1),P=P+2
 S M=$S(YSIT<201:$E(X(1),YSIT),1:$E(X(2),YSIT-200))
 S:M="T" YSTL=YSTL+$S(A="T":1,1:-1) G T2
TD ;
 S YSTL=0 F I=1:1:200 S:$E(X(1),I)="T" YSTL=YSTL+1
 F I=1:1:100 S:$E(X(2),I)="T" YSTL=YSTL+1
 I YSSX="M" S R=YSTL_"^"_$P(R,"^",1)_"^"_$P(R,"^",3,24),A=$S(YSTL<76:1,YSTL<96:3,YSTL<122:5,1:7)
 E  S R=YSTL_"^"_$P(R,"^",2,23)_"^"_$P(R,"^",25),A=$S(YSTL<79:1,YSTL<99:3,YSTL<120:5,1:7)
 S S="",J=1 I '$D(YSSX) W !?5,"Patient's sex unknown",!,$C(7) H 3 Q
 I YSSX="M"!(YSSX="F") S P=YSSX
 E  W !!?5,"Patient's sex NOT defined correctly",!,$C(7) H 3 Q
S1 ;
 S M=$P(R,"^",J) G:M="" REPT
 S X=^YTT(601,YSTEST,"S",J,P),S=S_$J((M-$P(X,"^",A)/$P(X,"^",A+1)*10+50),0,0)_"^",J=J+1 G S1
REPT ;
 S ^YTD(601.2,YSDFN,1,YSET,1,YSED,100)=S,J=1 W @IOF,YSHDR,!!?22,$P(^YTT(601,YSTEST,"P"),"^",1),!!!?24,"S C A L E",?43,"RAW",?51,"T",!
R1 ;
 S YSRS=$P(R,"^",J) I YSRS="" W ! K A,I,YSIT,J,YSKK,M,P,R,YSRS,S,YSSS,YSTL,X,Y Q
 S YSSS=$P(S,"^",J) W !?19,$P(^YTT(601,YSTEST,"S",J,0),"^",2),?43,$J(YSRS,4,0),?49,$J(YSSS,4,0)
 S J=J+1 G R1
