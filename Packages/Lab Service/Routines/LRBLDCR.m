LRBLDCR ;AVAMC/REG - COMPONENT PREPARATION REPORT ;2/18/93  08:44 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D END W !?20,"Blood donor component preparation report"
 D B^LRU G:Y<0 END S LRSDT=LRSDT-.0001,LRLDT=LRLDT+.99
 S ZTRTN="QUE^LRBLDCR" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) D L^LRU,S^LRU S LRA=$P(^DD(65.54,4.11,0),U,3),LRD=$P(^DD(65.54,6.1,0),U,3),LRB=$P(^DD(65.54,1.1,0),U,3) D H S LR("F")=1
 F A=LRSDT:0 S A=$O(^LRE("AD",A)) Q:'A!(A>LRLDT)  S C=9999999-A F B=0:0 S B=$O(^LRE("AD",A,B)) Q:'B  I $D(^LRE(B,5,C,0)),$P(^(0),"^",4)]"" S E=^(0),F=$S($D(^(2)):^(2),1:"") D SET
 F A=0:0 S A=$O(^TMP($J,A)) Q:'A!(LR("Q"))  D:$Y>(IOSL-6) H Q:LR("Q")  S Y=A D D^LRU S LRD=Y W !!,"DONATION DATE: ",Y S B=0 D A
 Q:LR("Q")  W !,LR("%") S A=0 F B=0:0 S A=$O(LRT(A)) Q:A=""!(LR("Q"))  D:$Y>(IOSL-6) H3 Q:LR("Q")  S X=$P($P(LRB,A_":",2),";") W !,$S(X]"":X,1:"?")," DONATION TYPE",?40,"COUNT:",$J(LRT(A),5)
 Q:LR("Q")  W !,LR("%") F A=0:0 S A=$O(LRC(A)) Q:'A!(LR("Q"))  D:$Y>(IOSL-6) H3 Q:LR("Q")  W !,$S($D(^LAB(66,A,0)):$P(^(0),"^"),1:"??"),?40,"COUNT:",$J(LRC(A),5)
 D END,END^LRUTL Q
A F C=1:1 S B=$O(^TMP($J,A,B)) Q:B=""!(LR("Q"))  S E=^(B),M=$S($P(E,"^")]"":$P(E,"^"),1:"?") D:$Y>(IOSL-6) H1 Q:LR("Q")  D W
 Q
W W !,B,?15,M,?19,$P(E,"^",2),?22,$P(E,"^",3),?29,$J($P(E,"^",4),4),?34,$J($P(E,"^",5),4),?39,$P(E,"^",6),?44,$P(E,"^",7) S:'$D(LRT(M)) LRT(M)=0 S LRT(M)=LRT(M)+1
 S F=0 F G=0:1 S F=$O(^TMP($J,A,B,F)) Q:'F!(LR("Q"))  S H=^(F) D:$Y>(IOSL-6) H4 Q:LR("Q")  W:G ! W ?49,$P(H,"^"),?66,$J($P(H,"^",2),4),?71,$J($P(H,"^",3),5) S:'$D(LRC(F)) LRC(F)=0 S LRC(F)=LRC(F)+1
 Q
SET S G=$P(F,"^",9)_":",G=$P($P(LRA,G,2),";"),H=$P(E,"^",10)_":",H=$E($P($P(LRD,H,2),";"),1,4),I=$P(F,"^",8) I I,$D(^VA(200,I,0)) S I=$P(^(0),"^",2)
 S Z=$P(F,"^",3) D H^LRUT S J(3)=%H,J(0)=Z(3),(J,Z)=$P(F,"^",2) I Z D H^LRUT S X=J(3)-%H*1440,Y=J(0)-Z(3),J=X+Y
 S (K,Z)=$P(F,"^",4) I Z D H^LRUT S X=%H-J(3)*1440,Y=Z(3)-J(0),K=X+Y
 S ^TMP($J,A,$P(E,"^",4))=$P(E,"^",11)_"^"_$P(F,"^")_"^"_G_"^"_J_"^"_K_"^"_H_"^"_I
 F L=0:0 S L=$O(^LRE(B,5,C,66,L)) Q:'L  S X=^(L,0) D C S ^TMP($J,A,$P(E,"^",4),L)=L(1)_"^"_L(2)_"^"_L(3)
 Q
C S L(1)=$S($D(^LAB(66,L,0)):$E($P(^(0),"^"),1,16),1:"??"),L(2)=$P(X,"^",5),(Z,L(3))=$P(X,"^",3) I Z D H^LRUT S X=%H-J(3)*1440,Y=Z(3)-J(0),L(3)=X+Y
 Q
 ;
H D H2 Q:LR("Q")
 W !?22,"Anti",?29,"Coll",?34,"Proc",?39,"Coll",?66,"Vol",?71,"Storage"
 W !,"Unit ID",?13,"Type",?18,"Bag",?22,"Coag",?30,"Min",?35,"Min",?39,"Disp",?44,"Tech",?49,"Blood component",?66,"(ml)",?71,"Minutes",!,LR("%") Q
H1 D H Q:LR("Q")  W !!,"DONATION DATE: ",LRD Q
H2 I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"LABORATORY SERVICE",!?9,"BLOOD COMPONENT PREPARATION FROM ",LRSTR," TO ",LRLST Q
H3 D H2 W !,LR("%") Q
H4 D H1 W !,B,?15,M,?19,$P(E,"^",2),?22,$P(E,"^",3),?29,$J($P(E,"^",4),4),?34,$J($P(E,"^",5),4),?39,$P(E,"^",6),?44,$P(E,"^",7) Q
END D V^LRU Q
