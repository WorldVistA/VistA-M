LRBLPTR ;AVAMC/REG - TRANSFUSION DATA REPORT ;2/18/93  09:47 ;
 ;;5.2;LAB SERVICE;**247,267**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D END W !?30,"Transfusion data report"
 D B^LRBLU G:Y<0 END S LRSDT=LRSDT-.0001,LRLDT=$S(LRLDT'[".":LRLDT+.99,1:LRLDT),LRG=0
 W !!,"Also print transfusions with hematology results " S %=2 D YN^LRU G:%<1 END S:%=1 LRG=1
 S ZTRTN="QUE^LRBLPTR" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J),^TMP("LRBL",$J) D L^LRU,S^LRU,H S LR("F")=1
 F LRD=LRSDT:0 S LRD=$O(^LRD(65,"AB",LRD)) Q:'LRD!(LRD>LRLDT)  F LRI=0:0 S LRI=$O(^LRD(65,"AB",LRD,LRI)) Q:'LRI  I $D(^LRD(65,LRI,6)),$P(^(6),"^") S W(6)=^(6),W(4)=^(4),W(0)=^(0),C=$P(W(0),"^",4) D SET
 F P=0:0 S P=$O(^TMP($J,P)) Q:'P  D PT
 S LRP=0 F  S LRP=$O(^TMP($J,"B",LRP)) Q:LRP=""!(LR("Q"))  F P=0:0 S P=$O(^TMP($J,"B",LRP,P)) Q:'P!(LR("Q"))  S SSN=^(P) D W
 G:LR("Q") OUT D:$Y>(IOSL-9) H G:LR("Q") OUT W !!,LR("%") F A=0:0 S A=$O(LRC(A)) Q:'A  D:$Y>(IOSL-6) H Q:LR("Q")  S X=^LAB(66,A,0) W !?2,$P(X,"^",2),?8,"=",$P(X,"^")
OUT D:LRG&('LR("Q")) ^LRBLPTR1 D END,END^LRUTL Q
W D:$Y>(IOSL-6) H Q:LR("Q")  S (LRE,LRF)="" W !!,"Patient: ",LRP,?41,"SSN: ",SSN D:$O(^LR(P,1.9,0)) B Q:LR("Q")
 F C=0:0 S C=$O(^TMP($J,P,C)) Q:'C!(LR("Q"))  S C(1)=$P(^LAB(66,C,0),"^",2),LRC(C)="",LRD=0 F LRJ=0:1 S LRD=$O(^TMP($J,P,C,LRD)) Q:'LRD!(LR("Q"))  S:'LRJ LRE=LRD D W1
 I LRG S X1=$P(LRE,"."),X2=-1 D C^%DTC S LRE=X,X1=$P(LRF,"."),X2=1 D C^%DTC S ^TMP("LRBL",$J,LRP,P)=LRE_"^"_X
 Q
W1 F LRI=0:0 S LRI=$O(^TMP($J,P,C,LRD,LRI)) Q:'LRI!(LR("Q"))  S W=^(LRI) D P
 I LRG S:LRD<LRE LRE=LRD S:LRD>LRF LRF=LRD
 Q
P D:$Y>(IOSL-6) H1 Q:LR("Q")  W !,$P(W,"^"),?14,C(1),?19,$P(W,"^",8),?24,$P(W,"^",9),?29,$P(W,"^",2),?44,$P(W,"^",4),?47,$P(W,"^",5),?53,$P(W,"^",6),?62,$P(W,"^",3),?77,$P(W,"^",7)
 W:$D(^LAB(65.4,+$P(W,"^",10),0)) !?2,"Transfusion reaction type: ",$P(^(0),"^")
 F W=0:0 S W=$O(^LRD(65,LRI,7,W)) Q:'W!(LR("Q"))  S W(1)=^(W,0) D:$Y>(IOSL-6) H1 Q:LR("Q")  W !?2,W(1)
 Q
SET I LRD'=$P(W(4),"^",2) K ^LRD(65,"AB",LRD,LRI) Q
 S W(3)=$O(^LRD(65,LRI,3,0)) S:W(3) W(3)=^(W(3),0)
 S J=$P(W(3),"^",2),L=$S($P(W(3),"^",4)]"":$E($P(W(3),"^",4),1,9),1:"??"),Y=+W(3) D D S Y(1)=Y,Y=LRD D D S Y(2)=Y,Y=$P(W(3),"^",3) I Y,$D(^VA(200,Y,0)) S Y=$P(^(0),"^",2)
 S X=$P(W(6),"^",5),^TMP($J,+W(6),C,LRD,LRI)=$P(W(0),"^")_"^"_Y(1)_"^"_Y(2)_"^"_J_"^"_Y_"^"_L_"^"_$S(X=0:"NO",X=1:"YES",1:"")_"^"_$P(W(4),"^",4)_"^"_$P(W(0),"^",11)_"^"_$P(W(6),"^",8) Q
PT S X=^LR(P,0),Y=$P(X,"^",3),LRDPF=$P(X,U,2),X=^DIC(LRDPF,0,"GL"),Y=@(X_Y_",0)"),LRP=$P(Y,"^"),SSN=$P(Y,"^",9) D SSN^LRU S ^TMP($J,"B",LRP,P)=SSN Q
B S A=0 F C=0:1 S A=$O(^LR(P,1.9,A)) Q:'A!(LR("Q"))  S LR(1.9)=^(A,0) D:$Y>(IOSL-6) H1 Q:LR("Q")  D:'C L S Y=+LR(1.9) D D^LRU S LRK=Y,LRR=$P($G(^LAB(65.4,+$P(LR(1.9),U,2),0)),U) W !,Y,?21,LRR D A
 Q
A F B=0:0 S B=$O(^LR(P,1.9,A,1,B)) Q:'B!(LR("Q"))  S B(1)=^(B,0) D:$Y>(IOSL-6) H2 Q:LR("Q")  W !,B(1)
 Q
 ;
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"TRANSFUSION DATA REPORT FROM ",LRSTR," TO ",LRLST
 W !,"Unit ID",?14,"Comp",?20,"(#)",?24,"(ml)",?29,"Relocated",?44,"CK",?47,"By",?53,"Location",?62,"Transfused",?77,"RXN"
 W !,LR("%") Q
H1 D H Q:LR("Q")  W !!,"Patient: ",LRP,?41,"SSN: ",SSN Q
H2 D H1 Q:LR("Q")  D L W !,LRK,?21,LRR Q
L W !,"TRANSFUSION REACTIONS WITHOUT UNIT IDENTIFIED" Q
 ;
D S:'Y Y="" Q:'Y  S Y=Y_"000",Y=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)_$S(Y[".":" "_$E(Y,9,10)_":"_$E(Y,11,12),1:"") Q
END D V^LRU Q
