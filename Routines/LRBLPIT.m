LRBLPIT ;AVAMC/REG - PROLONGED TRANSFUSION TIMES ;2/18/93  09:45 ;
 ;;5.2;LAB SERVICE;**247,267**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D END W !?20,"Prolonged transfusion times"
 D B^LRU G:Y<0 END S LRSDT=LRSDT-.0001,LRLDT=LRLDT+.99
 S ZTRTN="QUE^LRBLPIT" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) D L^LRU,S^LRU,H S LR("F")=1
 F LRD=LRSDT:0 S LRD=$O(^LRD(65,"AB",LRD)) Q:'LRD!(LRD>LRLDT)  F LRI=0:0 S LRI=$O(^LRD(65,"AB",LRD,LRI)) Q:'LRI  I $D(^LRD(65,LRI,6)),$P(^(6),"^") S W(6)=^(6),W(4)=^(4),T=$P(W(4),"^",2),W(0)=^(0),C=$P(W(0),"^",4) D CK
 S L=0 F A=0:0 S L=$O(^TMP($J,L)) Q:L=""!(LR("Q"))  D:$Y>(IOSL-6) H Q:LR("Q")  W !!!,"LOCATION: ",L F P=0:0 S P=$O(^TMP($J,L,P)) Q:'P  D W
 D END,END^LRUTL Q
W D:$Y>(IOSL-6) H1 Q:LR("Q")  S X=^LR(P,0),LRDPF=$P(X,U,2),Y=$P(X,"^",3),X=^DIC(LRDPF,0,"GL"),Y=@(X_Y_",0)"),LRP=$P(Y,"^"),SSN=$P(Y,"^",9) D SSN^LRU
 W !!,"Patient: ",LRP,?41,"SSN: ",SSN F C=0:0 S C=$O(^TMP($J,L,P,C)) Q:'C!(LR("Q"))  S C(1)=$E($P(^LAB(66,C,0),"^"),1,30) F LRI=0:0 S LRI=$O(^TMP($J,L,P,C,LRI)) Q:'LRI!(LR("Q"))  S W=^(LRI) D P
 Q
P D:$Y>(IOSL-6) H2 Q:LR("Q")  W !,$P(W,"^"),?15,C(1),?46,$P(W,"^",2),?58,$P(W,"^",3),?70,$P(W,"^",5),?74,$J($P(W,"^",4),5) Q
CK S M=$P(^LAB(66,C,0),"^",24) Q:'M  S R=$O(^LRD(65,LRI,3,0)) Q:'R  S W(3)=^(R,0),R=+W(3),Z=LRD D H^LRUT S J=%H,J(0)=Z(3),Z=R D H^LRUT S X=J-%H*1440,Y=J(0)-Z(3),J=X+Y
 Q:J'>M  S L=$S($P(W(3),"^",4)]"":$P(W(3),"^",4),1:"??"),Y=+W(3) D D S Y(1)=Y,Y=LRD D D S Y(2)=Y,Y=$P(W(4),"^",3) I Y,$D(^VA(200,Y,0)) S Y=$P(^(0),"^",2)
 S ^TMP($J,L,+W(6),C,LRI)=$P(W(0),"^")_"^"_Y(1)_"^"_Y(2)_"^"_J_"^"_Y Q
 ;
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"LABORATORY SERVICE",!?9,"PROLONGED TRANSFUSION TIMES FROM ",LRSTR," TO ",LRLST
 W !,"Unit ID",?15,"Blood Component",?45,"Relocated",?57,"Transfused",?68,"DspBy",?74,"Minutes"
 W !,LR("%") Q
H1 D H Q:LR("Q")  W !!!,"LOCATION: ",L Q
H2 D H1 Q:LR("Q")  W !!,"Patient: ",LRP,?41,"SSN: ",SSN Q
 ;
D S Y=Y_"000",Y=$E(Y,4,5)_"/"_$E(Y,6,7)_$S(Y[".":" "_$E(Y,9,10)_":"_$E(Y,11,12),1:"") Q
END D V^LRU Q
