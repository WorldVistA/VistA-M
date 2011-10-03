LRBLJTS2 ;AVAMC/REG - TRANSFUSION STATISTICS ;9/14/89  08:54 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 S LRT=0 D H S C(1)=0 F A=0:0 S C(1)=$O(^TMP($J,"C",C(1))) Q:C(1)=""!(LR("Q"))  S C=+$O(^(C(1),0)) I $D(^TMP($J,"D",C)) D H1 Q:LR("Q")  D L
 Q:LR("Q")  W !,"Total cost of all components: ",$J(LRT,9,2) D H2 Q:LR("Q")
 S A=0 F  S A=$O(^TMP($J,"Z",A)) Q:A=""  D A
 F A=1:1:6 S S(A)=0
 S A=0 F A(3)=0:1 S A=$O(^TMP($J,"Z",A)) Q:A=""  S A(1)=^(A),A(2)=LRF(A) D:$Y>(IOSL-6) H2 Q:LR("Q")  W ! W:A(3) LR("%") W !,A(2),?20,$J($P(A(1),"^",2),5),?50,$J($P(A(1),"^"),8,2) D B Q:LR("Q")
 W !,LR("%"),!,"Totals",?20,$J(S(1),5),?30,$J(S(2),5),?40,$J(S(3),5),?50,$J(S(4),8,2),?60,$J(S(5),8,2),?70,$J(S(6),8,2) Q
B S S(1)=S(1)+$P(A(1),"^",2),S(4)=S(4)+$P(A(1),"^"),T=0 F  S T=$O(^TMP($J,"Z",A,T)) Q:T=""!(LR("Q"))  S T(1)=^(T) D:$Y>(IOSL-6) H3 Q:LR("Q")  W !!?3,T,?30,$J($P(T(1),"^",2),5),?60,$J($P(T(1),"^"),8,2) D C Q:LR("Q")
 Q
C S S(2)=S(2)+$P(T(1),"^",2),S(5)=S(5)+$P(T(1),"^"),P=0
 F  S P=$O(^TMP($J,"Z",A,T,P)) Q:P=""!(LR("Q"))  S P(1)=^(P),S(3)=S(3)+$P(P(1),"^",2),S(6)=S(6)+$P(P(1),"^") D:$Y>(IOSL-6) H4 Q:LR("Q")  W !?6,P,?40,$J($P(P(1),"^",2),5),?70,$J($P(P(1),"^"),8,2)
 Q
A S (A(1),A(2),T)=0 F  S T=$O(^TMP($J,"Z",A,T)) Q:T=""  D T
 S ^TMP($J,"Z",A)=A(1)_"^"_A(2) Q
T S (T(1),T(2),P)=0 F  S P=$O(^TMP($J,"Z",A,T,P)) Q:P=""  S X=^(P),X(1)=$P(X,"^"),X(2)=$P(X,"^",2),T(1)=T(1)+X(1),T(2)=T(2)+X(2)
 S ^TMP($J,"Z",A,T)=T(1)_"^"_T(2),A(1)=A(1)+T(1),A(2)=A(2)+T(2) Q
L S X=^TMP($J,"D",C,0),K=+X,Z=$P(X,"^",2),T=0
 F B=0:0 S T=$O(^TMP($J,"D",C,T)) Q:T=""!(LR("Q"))  S X=^(T),Z(1)=$P(X,"^",2),K(1)=$P(X,"^") D:$Y>(IOSL-6) H1 Q:LR("Q")  W !,T,?31,$J(Z(1),6),?43,$J(Z(1)/Z*100,4,1),?55,$J(K(1),9,2)
 Q:LR("Q")  W !?31,"------",?55,"---------",!?31,$J(Z,6),?55,$J(K,9,2),!,LR("%") S LRT=LRT+K Q
H D H^LRBLJTS1 Q:LR("Q")  W !,"Treating specialty",?31,"# units",?40,"% total units",?58,"Cost",!,LR("%") Q
H1 D:$Y>(IOSL-6) H Q:LR("Q")  W !!,C(1),":",! F X=1:1:$L(C(1)) W "-"
 Q
H2 D H^LRBLJTS1 Q:LR("Q")
 W !,"Administrative",?20,"Component",?30,"Specialty",?40,"Physician",?50,"Component",?60,"Specialty",?70,"Physician",!,"Category",?23,"Units",?33,"Units",?43,"Units",?53,"Cost",?63,"Cost",?73,"Cost",!,LR("%") S A(3)=0 Q
H3 D H2 Q:LR("Q")  W !,A(2)," (continued from ",LRQ-1,")" Q
H4 D H3 Q:LR("Q")  W !?6,T Q
