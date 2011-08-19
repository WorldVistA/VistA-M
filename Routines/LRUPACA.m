LRUPACA ;AVAMC/REG - LAB ACC COUNTS BY LOC ;2/18/93  13:09 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 D END S DIC=68,DIC(0)="AEQMZ",DIC("S")="I ""AUCYEMSP""'[$P(^(0),U,2)&($P(^(0),U,2)]"""")" D ^DIC K DIC G:Y=-1 END S LRAA=+Y,LRAA(1)=$P(Y,U,2),LRSS=$P(Y(0),U,2)
 K T S (Z(4),T(2))=0
 W !!?20,LRAA(1)," ACCESSION COUNTS" D B^LRU G:Y<0 END
 S LRLDT=LRLDT+.99,T(3)=$S($P(^LRO(68,LRAA,0),U,3)="Y":$E(LRSDT,1,3)_"0000",1:LRSDT),T(4)=$S($P(^LRO(68,LRAA,0),U,3)="Y":$E(LRLDT,1,3)_"0000",1:LRLDT)
DEV S ZTRTN="QUE^LRUPACA" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) D:IOST?1"C".E WAIT^LRU D L^LRU,S^LRU,@($S(T(3)["0000":"ACY",1:"ACD"))
 S Y=$S($D(^TMP($J,"S")):^("S"),1:"") D D^LRU S LRB=Y,Y=$S($D(^TMP($J,"E")):^("E"),1:"") D D^LRU S LRE=Y
 D H1 S LR("F")=1,Q(2)=0,S=-1 F A=0:1 S S=$O(^TMP($J,"B",S)) Q:S=""!(LR("Q"))  D:$Y>(IOSL-6) H1 Q:LR("Q")  W !,S,?30,$J(^TMP($J,"B",S),5) S Q(2)=Q(2)+^(S) D T
 G:LR("Q") OUT W !?30,"-----",!,"Total Accessions: ",?30,$J(Q(2),5),?41,"Total tests: ",?70,$J(T(2),9) D H3 Q:LR("Q")
 F T=0:0 S T=$O(^TMP($J,T)) Q:'T!(LR("Q"))  D:$Y>(IOSL-6) H3 Q:LR("Q")  W !,$S($D(^LAB(60,T,0)):$P(^(0),"^"),1:T) D B Q:LR("Q")
OUT D END^LRUTL,END Q
T F T=0:0 S T=$O(^TMP($J,"B",S,T)) Q:'T!(LR("Q"))  D:$Y>(IOSL-6) H1 Q:LR("Q")  S T(1)=^TMP($J,"B",S,T) W !?41,$S($D(^LAB(60,T,0)):$P(^(0),"^"),1:T),?70,$J(T(1),9) S T(2)=T(2)+T(1)
 Q
B S V=0,S=0 F A=0:1 S S=$O(^TMP($J,T,S)) Q:S=""!(LR("Q"))  D:$Y>(IOSL-6) H3 Q:LR("Q")  S Z=^TMP($J,T,S) W !?30,S,?55,$J(Z,9) S V=V+Z W ?70,$J(V,9)
 Q
ACY S T(3)=T(3)-1,LRB=$O(^LRO(68,LRAA,1,T(3))) F I=T(3):0 S I=$O(^LRO(68,LRAA,1,I)) Q:'I!(I>T(4))  S LRSA=LRSDT-.01,^TMP($J,"S")=$O(^LRO(68,LRAA,1,I,1,"E",LRSA)) D ACY1
 Q
ACY1 S LRE="" F B=LRSA:0 S B=$O(^LRO(68,LRAA,1,I,1,"E",B)) Q:'B!(B>LRLDT)  S LRE=B F LRAN=0:0 S LRAN=$O(^LRO(68,LRAA,1,I,1,"E",B,LRAN)) Q:'LRAN  D AC1
 S ^TMP($J,"E")=LRE Q
AC1 Q:'$D(^LRO(68,LRAA,1,I,1,LRAN,0))  Q:I'=$P(^(0),U,3)  S X=^(0),LRLLOC=$S($L($P(X,U,7)):$P(X,U,7),$P(X,U,2)=62.3:"QC--"_$P(^LAB(62.3,$P(^LR($P(X,"^"),0),U,3),0),"^"),1:"???")
 S:'$D(^TMP($J,"B",LRLLOC)) ^(LRLLOC)=0 S ^(LRLLOC)=^(LRLLOC)+1
 F T=0:0 S T=$O(^LRO(68,LRAA,1,I,1,LRAN,4,T)) Q:'T  S:'$D(^TMP($J,"B",LRLLOC,T)) ^(T)=0 S ^(T)=^(T)+1 S:'$D(^TMP($J,T,LRLLOC)) ^(LRLLOC)=0 S ^(LRLLOC)=^(LRLLOC)+1
 Q
ACD S LRE="",T(3)=T(3)-1,^TMP($J,"S")=$O(^LRO(68,LRAA,1,T(3))) F I=T(3):0 S I=$O(^LRO(68,LRAA,1,I)) Q:'I!(I>T(4))  S LRE=I F LRAN=0:0 S LRAN=$O(^LRO(68,LRAA,1,I,1,LRAN)) Q:'LRAN  D AC1
 S ^TMP($J,"E")=LRE Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"LABORATORY SERVICE ",LRAA(1)," COUNTS (",LRSTR,"-",LRLST,")",!,"INCLUSIVE DATES WITH DATA: ",LRB W:LRE]"" " TO ",LRE Q
H1 D H Q:LR("Q")  W !,"Location",?26,"# Accessions",?69,"Test count",!,LR("%") Q
H2 D H Q:LR("Q")  W !,S Q
H3 D H Q:LR("Q")  W !,"Test",?35,"Location",?55,"Test count",?70,"Cum count",!,LR("%") Q
 ;
END D V^LRU Q
