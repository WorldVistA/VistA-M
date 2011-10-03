LRBLRCT ;AVAMC/REG/CYM - CROSSMATCH:TRANSFUSION REPORT ;6/19/96  09:50 ;
 ;;5.2;LAB SERVICE;**72,247,267**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D END W !!?20,"Crossmatch:Transfusion Report",!
 D B^LRU G:Y<0 END S LRLDT=LRLDT+.99,LRSDT=LRSDT-.0001
 S ZTRTN="QUE^LRBLRCT" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO S LRG("?")="UNKNOWN",LRF("?")=0,LRQ(2)=1
 K ^TMP($J) D L^LRU,S^LRU,H S LR("F")=1 D C
 W ! W:IOST'?1"C".E @IOF D END^LRUTL,END Q
C F A=LRSDT:0 S A=$O(^LRD(65,"AN",A)) Q:'A!(A>LRLDT)  F I=0:0 S I=$O(^LRD(65,"AN",A,I)) Q:'I  F P=0:0 S P=$O(^LRD(65,"AN",A,I,P)) Q:'P  F B=0:0 S B=$O(^LRD(65,"AN",A,I,P,B)) Q:'B  D SET
 F A=0:0 S A=$O(^TMP($J,A)) Q:'A  S X=^LR(A,0),Y=$P(X,"^",3),X=$P(X,"^",2),X=^DIC(X,0,"GL"),X=@(X_Y_",0)"),^TMP($J,"B",$P(X,"^"),A)=$P(X,"^",9)
 D W Q:LR("Q")  D STATS Q
SET S Z=$O(^LRD(65,I,3,0)) I Z S X=^(Z,0),Z=$P(X,"^",4)
 S X=^LRD(65,I,2,P,1,B,0),Y=$P(X,"^",4),LRF(Y)=0,^TMP($J,P,+X,I)=$P(X,"^",10)_"^"_$S(Y]"":Y,1:"?")_"^"_Z Q
 ;
W S (LRP,LRX,LRX(1),LRT,LRZ)=0 F A=0:0 S LRP=$O(^TMP($J,"B",LRP)) Q:LRP=""!(LR("Q"))  F LRDFN=0:0 S LRDFN=$O(^TMP($J,"B",LRP,LRDFN)) Q:'LRDFN!(LR("Q"))  S SSN=^(LRDFN),LRDPF=$P(^LR(LRDFN,0),U,2),LRZ=LRZ+1 W:LRZ>1 !,LR("%") D V
 Q
V D:$Y>(IOSL-6) H Q:LR("Q")  D SSN^LRU W !,$J(LRZ,3),")",?6,LRP,?38,SSN F LRS=0:0 S LRS=$O(^TMP($J,LRDFN,LRS)) Q:'LRS!(LR("Q"))  S Y=LRS D DT^LRU S LRD=Y D U
 Q
U S LRI=0 F LRE=0:1 S LRI=$O(^TMP($J,LRDFN,LRS,LRI)) Q:'LRI  S:'LRE LRX(1)=LRX(1)+1 S LRC=^(LRI),LRX=LRX+1,LRH=1 D:$P(LRC,"^")="TRANSFUSED" A D:$Y>(IOSL-6) H1 Q:LR("Q")  D X
 Q
X S Y=$P(LRC,"^",2),X=^LRD(65,LRI,0),C=$P(^LAB(66,$P(X,"^",4),0),"^",2) W !,LRD,?17,$P(X,"^"),?32,C,?37,Y,?40,$E($P(LRC,"^"),1,23)
 I $D(^LRD(65,"AP",LRDFN,LRI)) W " On x-match, not counted" W ?65,$E($P(LRC,U,3),1,14) S LRX=LRX-1 Q
 S LRF(Y)=LRF(Y)+LRH Q
A S Y=$O(^LRD(65,LRI,9,0)) I 'Y S LRT=LRT+1 Q
 S Y=^LRD(65,LRI,9,Y,0),Y(2)=$P(Y,"^",2),Y=+Y,Z=0
 F X=0:0 S X=$O(^LRD(65,"B",Y(2),X)) Q:'X  I $D(^LRD(65,X,0)),$P(^(0),"^",4)=Y S Z=$S($D(^LRD(65,X,9,0)):$P(^(0),"^",4),1:0) Q
 I Z S LRH=$S(Z=1:0,1:+(1/Z)),LRT=LRT+$S(Z=1:1,1:LRH),LRX=LRX-1
 Q
 ;
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"BLOOD BANK",!,"CROSSMATCH:TRANSFUSIONS (from: ",LRSTR," to ",LRLST,")"
 W:LRQ(2) !,"Specimen date",?17,"Unit ID",?32,"Comp",?37,"XM",?40,"Release Reason",?65,"Location"
 W !,LR("%") Q
H1 D H Q:LR("Q")  W !,?6,LRP,?38,SSN Q
H2 S LRQ(2)=0 D H Q
 ;
STATS D:$Y>(IOSL-11) H2 Q:LR("Q")  I LRT["." S X=LRT D Z S LRT=X
 W !,LR("%"),!,"Number of specimens crossmatched:",$J(LRX(1),6)
 W !,"Total units         crossmatched:",$J(LRX,6)
 W !,"Total units           transfused:",$J(LRT,6)
 I LRT W !,"Crossmatch/transfusion     ratio:",$J(LRX/LRT,9,2)
 D:$Y>(IOSL-11) H2 Q:LR("Q")  S A=0 F B=0:0 S A=$O(LRF(A)) Q:A=""!(LR("Q"))  W:LRF(A) !,"Number of units ",$$EXTERNAL^DILFD(65.02,.04,"",A),"(",A,"):",$P(LRF(A),".")+$S($P(LRF(A),".",2)>5:1,1:0)
 Q
 ;
Z S Z=$P(X,".",2),Y=$P(X,"."),X=Y+$S(Z>5:1,1:0) Q
END D V^LRU Q
