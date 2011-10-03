LRBLDW ;AVAMC/REG/CYM - BLOOD DONOR WORKLIST ;6/28/96  09:06 ;
 ;;5.2;LAB SERVICE;**72,247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D V^LRU W !!?20,"BLOOD DONOR WORKLIST" K A,T
 I '$D(^LRE("AT")) W $C(7),!,"No tests pending",! Q
 F A=10:1:20 D FIELD^DID(65.54,A,"","LABEL","LRA") S LRA(A)=LRA("LABEL") W !,$J(A,3),") ",LRA(A)
SEL W !!,"Select test(s) by number: " R X:DTIME G:X=""!(X[U) END I X["?" W !,"Enter one or more of the above numbers",!,"For 2 or more selections separate each with a ',' (ex. 12,13,15)",!,"Enter 'ALL' for all tests." G SEL
 I X="ALL" D ALL G SHOW
 I X?.E1CA.E!($L(X)>200) W $C(7),!,"No CONTROL CHARACTERS, LETTERS or more than 200 characters allowed." G SEL
 I '+X W $C(7),!,"START with a NUMBER !!",! G SEL
 S LRN=X F LRB=0:0 S LRV=+LRN,LRN=$E(LRN,$L(LRV)+2,$L(LRN)) S:$D(LRA(LRV)) LRT(LRV)=LRA(LRV) Q:'$L(LRN)
SHOW I '$D(LRT) W $C(7),!,"None of the listed tests selected, try again " S %=1 D YN^LRU G LRBLDW:%=1,END
 W !!,"You have selected the following tests:" F A=0:0 S A=$O(LRT(A)) Q:'A  W !,$J(A,3),") ",LRT(A)
 W !,"OK " S %=1 D YN^LRU G:%'=1 LRBLDW
 S ZTRTN="QUE^LRBLDW" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO D L^LRU,S^LRU,H S LR("F")=1
 S C="" F A=1:1 S C=$O(^LRE("AT",C)) Q:C=""!(LR("Q"))  K C(1) D T
 W:IOST'?1"C".E @IOF D END^LRUTL,END Q
T S T=0 F B=1:1 S T=$O(^LRE("AT",C,T)) Q:'T!(LR("Q"))  D:$D(LRT(T)) W
 Q:LR("Q")  I $D(C(1)) W !,LR("%")
 Q
W I '$D(C(1)) S P=$O(^LRE("AT",C,T,0)),C(4)=$O(^(P,0)),P=^LRE(P,0),C(4)=^(5,C(4),0),Y=+C(4) D D^LRU S C(2)=Y D:$Y>(IOSL-6) H Q:LR("Q")  W !,C,?42,$P(P,"^",5),?46,$P(P,"^",6),?55,C(2),! S C(1)=1
 D:$Y>(IOSL-6) H Q:LR("Q")  W !,LRT(T) Q
 ;
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"LABORATORY SERVICE",?23,"BLOOD DONOR WORKLIST"
 W !,"DONOR ID",?42,"ABO",?46,"RH",?55,"Collection date",!,LR("%") Q
ALL F A=0:0 S A=$O(LRA(A)) Q:'A  S LRT(A)=LRA(A)
 Q
END D V^LRU Q
