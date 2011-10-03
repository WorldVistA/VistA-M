DENTAR4 ;ISC2/SAW,HAG-PERSONNEL SERVICE REPORT RELEASE OPTION ;9/11/89  15:59 ;
 ;;1.2;DENTAL;**8,10,25**;Jan 26, 1989
 K ^UTILITY($J,"DENTP") I '$D(ZTSK)&(IO=IO(0)) R !,"One moment please while I total your non clinical time entries",X:3
 S Y(0)=DENTY0,A1=$E($P(Y(0),U,1),1,5)_"00",A2=$E(A1,1,5)_31.2359 F I=0:0 S A1=$O(^DENT(226,"A",Z2,A1)) Q:A1=""!(A1>A2)  S A3="" F J=0:0 S A3=$O(^DENT(226,"A",Z2,A1,A3)) Q:A3=""  D T
 G P
T I $D(^DENT(226,A3,.1)),$P(^(.1),U,1) Q
 S X=^DENT(226,A3,0),A4=$E($P(X,U,3),1),A4=$S(A4=0:6,A4=2:1,A4>6:6,1:A4) I '$D(G(A4)) S G(A4)="^^^"
 S A5=$P(X,U,4),A5=$S(A5="R":1,A5="E":2,A5="F":3,1:4),$P(G(A4),U,A5)=$P(G(A4),U,A5)+$P(X,U,5),^UTILITY($J,"DENTP",A3)=Z2_","_A1 Q
P S Z1="PERSONNEL (TYPE 4) REPORT FOR "_Z1,Z3="STATION NUMBER: "_Z2,DENTCD=$P(Y(0),"^",11),DENT=$S(DENTCD="C":9,DENTCD="D":"E",1:4)_DENTSTA_$E(DENT,4,5)_$E(DENT,6,7)_$E(DENT,2,3) F I=1:1:6 S (A(I),T(I),D(I))=""
 W @IOF,?(80-$L(Z1)/2),Z1,!,?(80-$L(Z3)/2),Z3
 W !,?15,"(All values are in days except Consultant Visits)"
 W !!,?37,"NON CLINICAL TIME",!,?16,"DAYS WORKED",?30,"RESEARCH  EDUCATION  FEE  ADMIN",?65,"CLINICAL TIME",!,?16,"___________",?30,"________  _________  ___  _____",?65,"_____________"
 F I=1:1:6 S G(I)=$S($D(G(I)):G(I),1:"^^^")
 S A(1)=$P(Y(0),U,2),A(2)=$P(G(1),U,1)+4\8,A(3)=$P(G(1),U,2)+4\8,A(4)=$P(G(1),U,3)+4\8,A(5)=$P(G(1),U,4)+4\8,A(6)=A(2)+A(3)+A(4)+A(5)
 W !,"DENTISTS",?20,$J(A(1),3) S A=1,L=3 D B W ?32,$J(A(2),3) S A=2,L=3 D B W ?43,$J(A(3),3) S A=3,L=3 D B
 W ?51,$J(A(4),3) S A=4,L=3 D B W ?57,$J(A(5),3) S A=5,L=3 D B S A(6)=A(1)-A(6),A=6,L=3 D B W ?69,$J(A(6),3) S:A(6)<0 DENTF=1
 S A(1)=$P(Y(0),U,3),A(2)=$P(G(3),U,1)+4\8,A(3)=$P(G(3),U,2)+4\8,A(6)=A(2)+A(3)
 W !,"RESIDENTS",?20,$J(A(1),3) S A=1,L=3 D B W ?32,$J(A(2),3) S A=2,L=3 D B W ?43,$J(A(3),3) S A=3,L=3 D B S A(6)=A(1)-A(6),A=6,L=3 D B W ?69,$J(A(6),3) S:A(6)<0 DENTF=1
 S A(1)=$P(Y(0),U,4),A(2)=$P(G(5),U,1)+4\8,A(3)=$P(G(5),U,2)+4\8,A(6)=A(2)+A(3)
 W !,"HYGIENISTS",?20,$J(A(1),3) S A=1,L=2 D B W ?32,$J(A(2),3) S A=2,L=2 D B W ?43,$J(A(3),3) S A=3,L=2 D B S A(6)=A(1)-A(6),A=6,L=2 D B W ?69,$J(A(6),3) S:A(6)<0 DENTF=1
 S A(1)=$P(Y(0),U,5),A(2)=$P(G(4),U,1)+4\8,A(3)=$P(G(4),U,2)+4\8,A(6)=A(2)+A(3)
 W !,"EFDAs",?20,$J(A(1),3) S A=1,L=2 D B W ?32,$J(A(2),3) S A=2,L=2 D B W ?43,$J(A(3),3) S A=3,L=2 D B S A(6)=A(1)-A(6),A=6,L=2 D B W ?69,$J(A(6),3) S:A(6)<0 DENTF=1
 S A(1)=$P(Y(0),U,6) W !,"ASSISTANTS",?20,$J(A(1),3) S A=1,L=3 D B
 S A(1)=$P(Y(0),U,7) W !,"LAB TECHS",?20,$J(A(1),3) S A=1,L=3 D B
 S A(1)=$P(Y(0),U,8) W !,"ADMIN/CLER",?20,$J(A(1),3) S A=1,L=2 D B
 S A(2)=$P(G(6),U,1)+4\8,A(3)=$P(G(6),U,2)+4\8
 W !,"ALL OTHERS",?32,$J(A(2),3) S A=2,L=3 D B W ?43,$J(A(3),3) S A=3,L=3 D B
 W !!,?5,"TOTALS",?19,$J(T(1),4),?31,$J(T(2),4),?42,$J(T(3),4),?50,$J(T(4),4),?56,$J(T(5),4),?68,$J(T(6),4)
 W !!,"CONSULTANTS VISITS: ",$J($P(Y(0),U,9),3) S V="000"_$P(Y(0),U,9),D(1)=D(1)_$E(V,$L(V)-1,$L(V))
 F I=1:1:6 S DENT=DENT_D(I)
 I $D(DENTF) W *7,!!,"ERROR!!! Clinical time values cannot be negative.  Report not released.",!
 K A,A1,A2,A3,A4,A5,D,DENTCD,G,I,J,L,P,T,V,X,Y Q
B S V="000"_A(A),D(A)=D(A)_$E(V,$L(V)-(L-1),$L(V)),T(A)=T(A)+A(A) Q
