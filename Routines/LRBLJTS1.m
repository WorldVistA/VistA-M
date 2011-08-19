LRBLJTS1 ;AVAMC/REG - TRANSFUSION STATS ;3/3/93  22:49 ;
 ;;5.2;LAB SERVICE;**247,267**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 S L=0,B=LRSDT F B(1)=0:0 S B=$O(^LRD(65,"AB",B)) Q:'B!(B>LRLDT)  S A=0 F A(1)=0:0 S A=$O(^LRD(65,"AB",B,A)) Q:'A  I $D(^LRD(65,A,4)),$P(^(4),"^")="T" S Y=$P(^(4),"^",2) D T
 D K^LRU,P,^LRBLJTS2 Q
T Q:'$D(^LRD(65,A,6))  S X=$P(^(6),"^",3) Q:X']LRA!(X]LRB)  S J=$P(^(0),"^",4),Z=^LAB(66,J,0),Z(1)=$P(Z,"^"),Z(26)=$P(Z,"^",26) Q:Z(1)']LRC!(Z(1)]LRE)
 S W=^LRD(65,A,0),W(1)=$P(W,"^"),V=^(6),V(2)=$P(V,"^",2),V=+V,Z(9)=$P(Z,"^",19) I V'=L S L=V,G=^LR(L,0),H=$P(G,"^",3),G=$P(G,"^",2),G=^DIC(G,0,"GL"),G=@(G_H_",0)"),^TMP($J,"P",$P(G,"^"),L)=""
 S ^TMP($J,"A",X,J,V,$P(Y,"."),A)=W(1)_"^"_V(2)_"^"_$P(W,"^",10)_"^"_Z(26),^TMP($J,"C",Z(1),J)=""
 S W(4)=+$P($G(^LAB(66,+$P(W,"^",4),0)),"^",26)
 I Z(9) S ^TMP($J,"B",X,1,V)=""
 E  S ^TMP($J,"B",X,2,V)=""
 Q
P D HDR S LR("F")=1,T=0 F A=0:0 S T=$O(^TMP($J,"A",T)) Q:T=""!(LR("Q"))  D H1,Q
 Q
Q S C(1)=0 F B=0:0 S C(1)=$O(^TMP($J,"C",C(1))) Q:C(1)=""!(LR("Q"))  S C=+$O(^(C(1),0)) I $D(^TMP($J,"A",T,C)) D H2 Q:LR("Q")  D L
 Q:LR("Q")  S R=0 F R(1)=0:1 S R=$O(^TMP($J,"B",T,1,R)) Q:'R
 I R(1) D:$Y>(IOSL-5) H1 Q:LR("Q")  W !!,T," patients given RBC components: ",R(1) S ^TMP($J,"B",T,1,0)=R(1)
 S R=0 F R(1)=0:1 S R=$O(^TMP($J,"B",T,2,R)) Q:'R
 I R(1) D:$Y>(IOSL-5) H1 Q:LR("Q")  W !,T," patients given non-RBC components: ",R(1) S ^TMP($J,"B",T,2,0)=R(1)
 W !,T," cost of all components: ",$J(^TMP($J,"A",T,0),9,2)
 Q
L S (K,Z,Z(1),L(1))=0 F F=0:0 S L(1)=$O(^TMP($J,"P",L(1))) Q:L(1)=""!(LR("Q"))  F L=0:0 S L=$O(^TMP($J,"P",L(1),L)) Q:'L!(LR("Q"))  I $D(^TMP($J,"A",T,C,L)) D R
 Q:LR("Q")  W:K !?50,"---------",!?50,$J(K,9,2) S ^TMP($J,"D",C,T)=K_"^"_Z
 S:'$D(^TMP($J,"D",C,0)) ^(0)="0^0" S X=^(0),^(0)=($P(X,"^")+K)_"^"_($P(X,"^",2)+Z) S:'$D(^TMP($J,"A",T,0)) ^(0)=0 S X=^(0),^(0)=X+K Q
R F W=0:0 S W=$O(^TMP($J,"A",T,C,L,W)) Q:'W!(LR("Q"))  S T(2)=$E(W,4,5)_"/"_$E(W,6,7)_"/"_$E(W,2,3) F I=0:0 S I=$O(^TMP($J,"A",T,C,L,W,I)) Q:'I!(LR("Q"))  S V=^(I) D W
 Q
W D:$Y>(IOSL-5) H3 Q:LR("Q")  S V(1)=$P(V,"^",3),Y=$P(V,"^",2),K=K+V(1),Z=Z+1 W ! I L'=Z(1) S Z(1)=L W $E(L(1),1,20)
 W ?21,T(2),?30,$E($P(V,"^",2),1,18),?49,$J(V(1),9,2),?60,$P(V,"^"),?75,$J(Z,4)
 S X=$P(V,"^",4) S:X="" X="?" S:'$D(^TMP($J,"Z",X,T,Y)) ^(Y)="0^0" S X=^(Y),X(1)=$P(X,"^")+V(1),X(2)=$P(X,"^",2)+1,^(Y)=X(1)_"^"_X(2) Q
H ;from LRBLJTS2
 I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"Transfusions by Treating Specialty/Physician (",LRSTR," - ",LRLST,")" Q
 ;
HDR D H Q:LR("Q")  W !,"Patient transfused",?21,"Date",?30,"Physician",?53,"Cost",?60,"Unit ID",?74,"Count",!,LR("%") Q
H1 D:$Y>(IOSL-5) HDR Q:LR("Q")  W !!?20,"TREATING SPECIALTY: ",T Q
H2 D:$Y>(IOSL-5) H1 Q:LR("Q")  W !,"Component: ",C(1),":",!?11 F X=1:1:$L(C(1)) W "-"
 Q
H3 D H2 S Z(1)=0 Q
