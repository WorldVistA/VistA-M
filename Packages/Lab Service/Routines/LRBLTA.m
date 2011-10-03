LRBLTA ;AVAMC/REG - TRANSFUSION REACTION COUNTS ;7/2/93  07:05 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D END,B^LRU G:Y<0 END W !!,"List patients " S %=2,LRF=0 D YN^LRU G:%<1 END S:%=1 LRF=1 W !
 S ZTRTN="QUE^LRBLTA" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) S LRSDT=9999998.9-LRSDT,LRLDT=9999997.9-LRLDT
 D L^LRU,S^LRU,H S LR("F")=1
 F LRDFN=0:0 S LRDFN=$O(^LR("AB",LRDFN)) Q:'LRDFN  F LRR=0:0 S LRR=$O(^LR("AB",LRDFN,LRR)) Q:'LRR  F LRI=LRLDT:0 S LRI=$O(^LR("AB",LRDFN,LRR,LRI)) Q:'LRI!(LRI>LRSDT)  D S
 F LRR=0:0 S LRR=$O(^TMP($J,LRR)) Q:'LRR!(LR("Q"))  D:$Y>(IOSL-6) H Q:LR("Q")  S LRR(1)=$P(^LAB(65.4,LRR,0),U) W !!,LRR(1),?31,$J(^TMP($J,LRR),4) D A
 G:LR("Q") OUT W ! S A=0 F  S A=$O(^TMP($J,"B",A)) Q:A=""!(LR("Q"))  D:$Y>(IOSL-6) H Q:LR("Q")  W !,A,?5,"= ",^TMP($J,"B",A)
OUT D:'LR("Q") ^LRBLTA1 D END^LRUTL,END Q
S S X=$G(^LR(LRDFN,1.6,LRI,0)),C=$P(X,"^",2) Q:'C
 S:'$D(^TMP($J,LRR)) ^(LRR)=0 S ^(LRR)=^(LRR)+1
 S:'$D(^TMP($J,LRR,C)) ^(C)=0 S ^(C)=^(C)+1 S:LRF ^(C,LRDFN,LRI)=+X_"^"_$P(X,"^",3) Q
A F LRC=0:0 S LRC=$O(^TMP($J,LRR,LRC)) Q:'LRC!(LR("Q"))  D:$Y>(IOSL-6) H1 Q:LR("Q")  S LRE=$P(^LAB(66,LRC,0),U,2) S:LRE]"" ^TMP($J,"B",LRE)=$P(^(0),U) W !?41,LRE,?51,$J(^TMP($J,LRR,LRC),4) D:LRF B
 Q
B S LRDFN=0 F  S LRDFN=$O(^TMP($J,LRR,LRC,LRDFN)) Q:'LRDFN!(LR("Q"))  D N,C
 Q
C S LRI=0 F  S LRI=$O(^TMP($J,LRR,LRC,LRDFN,LRI)) Q:'LRI!(LR("Q"))  S LRX=^(LRI) D:$Y>(IOSL-6) H2 Q:LR("Q")  W !,SSN,?5,LRP,?36 S Y=+LRX D DT^LRU W Y,?67,$P(LRX,"^",2)
 Q
N S X=^LR(LRDFN,0),Y=$P(X,"^",3),X=$P(X,"^",2),X=^DIC(X,0,"GL"),X=@(X_Y_",0)"),LRP=$P(X,"^"),SSN=$E($P(X,"^",9),6,9) Q
 ;
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"TRANSFUSION REACTION COUNTS FROM ",LRSTR," TO ",LRLST,!,"REACTION",?31,"COUNT",?41,"COMPONENT",?51,"SUBCOUNT" W:LRF !,"SSN",?5,"Patient",?36,"Transfusion Date",?67,"Unit ID" W !,LR("%") Q
H1 D H Q:LR("Q")  W !,LRR(1) Q
H2 D H1 Q:LR("Q")  W ?41,LRE Q
 ;
END D V^LRU Q
