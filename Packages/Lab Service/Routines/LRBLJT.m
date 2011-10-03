LRBLJT ;AVAMC/REG - BB ITEMIZED TRANSACTIONS ;2/18/93  09:32 ;
 ;;5.2;LAB SERVICE;**247,267,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 Q  D END S X="T",%DT="" D ^%DT,D^LRU S LRH(0)=Y
 S IOP="HOME" D ^%ZIS W @IOF,?18,"BLOOD PRODUCTS: ITEMIZED TRANSACTIONS LIST"
 D EDC,B^LRU G:Y<0 END
 S LRLDT=LRLDT+.99,LRSDT=LRSDT-.01
 S ZTRTN="QUE^LRBLJT" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) S Z=0 D L^LRU,S^LRU
 F B=0:0 S LRSDT=$O(^LRD(65,"A",LRSDT)) Q:'LRSDT!(LRSDT>LRLDT)  F LRA=0:0 S LRA=$O(^LRD(65,"A",LRSDT,LRA)) Q:'LRA  I $D(^LRD(65,LRA,0)) S W=^(0) D SET
 D WRT G:LR("Q") OUT W !!,?69,"--------",!,"Total unit count (all components): ",Z,?50,"Total",?60,"cost",?69,$J(Z(1),8,2)
 S LRB=1 D:$Y>(IOSL-6) H G:LR("Q") OUT S A=0 F A(1)=0:0 S A=$O(LRC(A)) Q:A=""!(LR("Q"))  D:$Y>(IOSL-6) H Q:LR("Q")  W !,A,?5,"= ",$S($D(^LAB(66,LRC(A),0)):$P(^(0),"^"),1:"???")
OUT K ^TMP($J) D END^LRUTL,END Q
SET S LRI=$S($P(W,"^",3)]"":$P(W,"^",3),1:"UNKNOWN"),R=$P($P(W,"^",5),".",1),N=$P(W,"^",14),N=$S($P(W,"^",10):$P(W,"^",10),1:$E(N,2,$L(N)))
 S ^TMP($J,$P(W,"^",2),$P(W,"^",4),R,LRI,$P(W,"^"))=$P(W,"^",6)_"^"_$P(W,"^",7)_"^"_$P(W,"^",8)_"^"_N_"^"_$S($D(^LRD(65,LRA,4)):$P(^(4),"^"),1:""),Z=Z+1
 Q
WRT D H Q:LR("Q")  S LR("F")=1,(Z(1),S)=0 F A(1)=1:1 S S=$O(^TMP($J,S)) Q:S=""!(LR("Q"))  D:$Y>(IOSL-6) H Q:LR("Q")  W !!,"Supplier: ",S,! D C
 Q
C S C=0 F A=0:1 S C=$O(^TMP($J,S,C)) Q:'C!(LR("Q"))  S C(1)=$S($D(^LAB(66,C,0)):$P(^(0),"^",2),1:"???"),LRC(C(1))=C D:$Y>(IOSL-6) H1 Q:LR("Q")  W !!,C(1) D DATE
 Q
DATE S (Z(3),Z(5),R)=0 F B=0:1 S R=$O(^TMP($J,S,C,R)) Q:'R!(LR("Q"))  S Y=R D D^LRU S R(1)=Y D:$Y>(IOSL-6) H2 Q:LR("Q")  W:B ! W ?7,R(1) D L
 Q:LR("Q")  W !?69,"--------",!?50,C(1),?60,"cost",?69,$J(Z(3),8,2) Q
L S L=0 F E=0:1 S L=$O(^TMP($J,S,C,R,L)) Q:L=""!(LR("Q"))  D:$Y>(IOSL-6) H3 Q:LR("Q")  W:E ! W ?21,L D U
 Q
U S L(1)=0 F F=0:1 S L(1)=$O(^TMP($J,S,C,R,L,L(1))) Q:L(1)=""!(LR("Q"))  S W=^(L(1)) D FIN
 Q
FIN S Z(6)=$P(W,"^",4) S:Z(6)'["-" Z(5)=Z(5)+1 D:$Y>(IOSL-6) H3 Q:LR("Q")  W:F ! W:Z(6)'["-" ?30,$J(Z(5),5),")" W ?37,L(1),?51,$P(W,"^",2),?53,$E($P(W,"^",3),1)
 S Z(3)=Z(3)+Z(6),Z(1)=Z(1)+Z(6),Y=$P($P(W,"^"),".",1) D D^LRU W ?55,Y,?71,$J(Z(6),6) S V=$P(W,"^",5) W ?78,V Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"BLOOD BANK INVOICES (from ",LRSTR," to ",LRLST,")" I $D(LRB) W !,LR("%") Q
 W !,"COMPONENT",?12,"DATE",?21,"INVOICE#",?30,"COUNT",?37,"UNIT NO",?51,"TYPE",?58,"EXP DATE",?71,"AMOUNT",?78,"D",!,LR("%") Q
H1 D H Q:LR("Q")  W !!,"Supplier: ",S,! Q
H2 D H1 Q:LR("Q")  W !!,C(1) Q
H3 D H2 Q:LR("Q")  W ?10,R(1) Q
EDC W ! W "Edit supplier charges before listing invoices?  NO// " R X:DTIME Q:X=""!(X[U)!(X?1"N".E)  G EDC:X'?1"Y".E
N S (DIC,DIE)=65,DIC(0)="AEFQM",DIC("A")="Select donor unit: " D ^DIC K DIC Q:X=""!(X[U)  S DA=+Y,DR=".1;.13;.14" D ^DIE K DIC,DIE,DR,DA,DQ G N
 ;
END D V^LRU Q
