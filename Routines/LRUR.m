LRUR ;AVAMC/REG - LAB TEST COUNTS BY SPECIMEN ;2/18/93  13:14 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 D END W !?20,"Lab test counts by specimen type"
 D B^LRU G:Y<0 END S LRLDT=9999999-LRLDT-.01,LRSDT=9999999-LRSDT+.99
 S ZTRTN="QUE^LRUR" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) D L^LRU,S^LRU,EN^LRUTL,H S LR("F")=1
 F LRDFN=0:0 S LRDFN=$O(^LR(LRDFN)) Q:'LRDFN  F A=LRLDT:0 S A=$O(^LR(LRDFN,"CH",A)) Q:'A!(A>LRSDT)  S S=$P(^(A,0),"^",5) S:'S S=LRU D C
 F A=0:0 S A=$O(^TMP($J,A)) Q:'A!(LR("Q"))  S X=$P(^LAB(61,A,0),"^"),^TMP($J,"B",X,A)="" F B=0:0 S B=$O(^TMP($J,A,B)) Q:'B!(LR("Q"))  S X=$S($D(^DD(63.04,B,0)):$P(^(0),"^"),1:B),^TMP($J,"C",X,B)=""
 S LRS=0 F LRA=0:0 S LRS=$O(^TMP($J,"B",LRS)) Q:LRS=""!(LR("Q"))  F LRI=0:0 S LRI=$O(^TMP($J,"B",LRS,LRI)) Q:'LRI!(LR("Q"))  D:$Y>(IOSL-6) H Q:LR("Q")  W !,"Specimen: ",LRS," (",^TMP($J,LRI),")" D T
 D END^LRUTL,END Q
T S LRT=0 F LRB=0:0 S LRT=$O(^TMP($J,"C",LRT)) Q:LRT=""!(LR("Q"))  F LRJ=0:0 S LRJ=$O(^TMP($J,"C",LRT,LRJ)) Q:'LRJ!(LR("Q"))  D:$Y>(IOSL-6) H1 Q:LR("Q")  I $D(^TMP($J,LRI,LRJ)) W !?3,LRT,?40,$J(^(LRJ),6)
 Q
C S:'$D(^TMP($J,S)) ^(S)=0 S X=^(S),^(S)=X+1 F B=1:0 S B=$O(^LR(LRDFN,"CH",A,B)) Q:'B  S:'$D(^TMP($J,S,B)) ^(B)=0 S X=^(B),^(B)=X+1
 Q
 ;
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"LABORATORY SERVICE ",!?9,"TEST COUNTS FROM ",LRSTR," TO ",LRLST,!,LR("%") Q
H1 D H Q:LR("Q")  W !,"Specimen: ",LRS Q
END D V^LRU Q
