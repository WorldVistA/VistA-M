LRUPACT ;AVAMC/REG - LAB ACC COUNTS BY TREATING SPECIALTY ;9/30/93  11:57 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 D END S DIC=68,DIC(0)="AEMQZ" D ^DIC K DIC G:Y<1 END S LRAA=+Y,LRAA(1)=$P(Y,U,2),LRSS=$P(Y(0),U,2)
 W !!?10,LRAA(1)," ACCESSION COUNTS BY TREATING SPECIALTY" D B^LRU G:Y<0 END
 S LRLDT=LRLDT+.99,T(3)=$S($P(Y(0),U,3)="Y":$E(LRSDT,1,3)_"0000","MQ"[$P(Y(0),U,3):$E(LRSDT,1,5)_"00",1:LRSDT),T(4)=$S($P(Y(0),U,3)="Y":$E(LRLDT,1,3)_"0000","MQ"[$P(Y(0),U,3):$E(LRLDT,1,5)_"00",1:LRLDT)
DEV S ZTRTN="QUE^LRUPACT" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) S LRT=0 D L^LRU,S^LRU,@($S($E(T(3),6,7)="00":"ACY",1:"ACD"))
 S S=0 F A=0:0 S S=$O(^TMP($J,"B",S)) Q:S=""  S B=$S(S=+S&($D(^DIC(45.7,+S,0))):$P(^DIC(45.7,S,0),"^"),1:S),^TMP($J,"C",B,S)=""
 F T=0:0 S T=$O(^TMP($J,T)) Q:'T  S ^TMP($J,"T",$P(^LAB(60,T,0),"^"),T)=""
 D H1 S LR("F")=1,Q(2)=0,M=-1
 F A=0:1 S M=$O(^TMP($J,"C",M)) Q:M=""!(LR("Q"))  S S=0 F N=0:0 S S=$O(^TMP($J,"C",M,S)) Q:S=""!(LR("Q"))  D:$Y>(IOSL-6) H1 Q:LR("Q")  S T(6)=M W !,T(6),?30,$J(^TMP($J,"B",S),5) S Q(2)=Q(2)+^(S),T(5)=0 D T
 G:LR("Q") OUT W !?30,"-----",!,"Total Accessions: ",?30,$J(Q(2),5),?41,"Total tests: ",?70,$J(LRT,9) D H4
 G:LR("Q") OUT S N=0 F A=0:0 S N=$O(^TMP($J,"T",N)) Q:N=""!(LR("Q"))  F T=0:0 S T=$O(^TMP($J,"T",N,T)) Q:'T!(LR("Q"))  D:$Y>(IOSL-6) H4 Q:LR("Q")  W !,N S V=0,S=-1 D F
OUT W:IOST'?1"C".E @IOF D END^LRUTL,END Q
F S M=0 F B=0:0 S M=$O(^TMP($J,"C",M)) Q:M=""!(LR("Q"))  S S=0 F C=0:0 S S=$O(^TMP($J,"C",M,S)) Q:S=""!(LR("Q"))  I $D(^TMP($J,T,S)) S Z=^(S) D:$Y>(IOSL-6) H4 Q:LR("Q")  W !?30,M,?55,$J(Z,9) S V=V+Z W ?70,$J(V,9)
 Q:LR("Q")  W !,LR("%") Q
T S N=0 F B=0:0 S N=$O(^TMP($J,"T",N)) Q:N=""!(LR("Q"))  F T=0:0 S T=$O(^TMP($J,"T",N,T)) Q:'T!(LR("Q"))  I $D(^TMP($J,"B",S,T)) S T(1)=^(T) D:$Y>(IOSL-6) H1 Q:LR("Q")  W !?41,N,?70,$J(T(1),9) S LRT=LRT+T(1),T(5)=T(5)+T(1)
 Q:LR("Q")  D:$Y>(IOSL-6) H1 Q:LR("Q")  W !?70,"---------",!?25,"Sub-total for ",T(6),":",?70,$J(T(5),9),!,LR("%") Q
ACY S T(3)=T(3)-1 F I=T(3):0 S I=$O(^LRO(68,LRAA,1,I)) Q:'I!(I>T(4))  S LRSA=LRSDT-.01 F B=LRSA:0 S B=$O(^LRO(68,LRAA,1,I,1,"E",B)) Q:'B!(B>LRLDT)  F LRAN=0:0 S LRAN=$O(^LRO(68,LRAA,1,I,1,"E",B,LRAN)) Q:'LRAN  D AC1
 Q
AC1 Q:'$D(^LRO(68,LRAA,1,I,1,LRAN,0))  S X=^(0) Q:I'=$P(X,"^",3)&("AUCYEMSP"'[LRSS)  S P(9)=$P(X,"^",9) S:'P(9) P(9)=$P(X,"^",7) S:'$L(P(9)) P(9)="???" S:'$D(^TMP($J,"B",P(9))) ^(P(9))=0 S ^(P(9))=^(P(9))+1
 F T=0:0 S T=$O(^LRO(68,LRAA,1,I,1,LRAN,4,T)) Q:'T  I $P($G(^LAB(60,T,0)),U,4)'="WK" S:'$D(^TMP($J,"B",P(9),T)) ^(T)=0 S ^(T)=^(T)+1 S:'$D(^TMP($J,T,P(9))) ^(P(9))=0 S ^(P(9))=^(P(9))+1
 Q
ACD S T(3)=T(3)-1 F I=T(3):0 S I=$O(^LRO(68,LRAA,1,I)) Q:'I!(I>T(4))  F LRAN=0:0 S LRAN=$O(^LRO(68,LRAA,1,I,1,LRAN)) Q:'LRAN  D AC1
 Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"LABORATORY SERVICE ",LRAA(1)," COUNTS(",LRSTR,"-",LRLST,")" Q
H1 D H Q:LR("Q")  W !,"Specialty",?26,"# Accessions",?69,"Test count",!,LR("%") Q
H2 D H Q:LR("Q")  W !,S Q
H4 D H Q:LR("Q")  W !,"Test",?35,"Specialty",?55,"Test count",?70,"Cum count",!,LR("%") Q
END D V^LRU Q
