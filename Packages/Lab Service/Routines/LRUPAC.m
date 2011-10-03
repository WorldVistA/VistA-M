LRUPAC ;AVAMC/REG - LAB ACCESSION COUNTS BY DATE ;2/18/93  13:08 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 S DIC=68,DIC(0)="AEMOQZ" D ^DIC K DIC G:Y<1 END S W=+Y,W(1)=$P(Y,U,2),W(2)=$P(Y(0),U,2)
 W !!?20,W(1)," ACCESSION COUNTS" D B^LRU G:Y<0 END
DEV S ZTRTN="QUE^LRUPAC" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO D EN^LRUTL,L^LRU,S^LRU
 S LRLDT=LRLDT+.99,Z=$S($P(^LRO(68,W,0),U,3)="Y":$E(LRSDT,1,3)_"0000",1:LRSDT),Z(1)=$S($P(^LRO(68,W,0),U,3)="Y":$E(LRLDT,1,3)_"0000",1:LRLDT)
 D Z,H S LR("F")=1 G:"AUCYEMSP"[W(2) AN
 F S=0:0 S S=$O(S(S)) Q:'S!(LR("Q"))  D:$Y>(IOSL-6) H Q:LR("Q")  W !,$P(^LAB(61,S,0),"^"),"= ",S(S) F T=0:0 S T=$O(S(S,T)) Q:'T!(LR("Q"))  D:$Y>(IOSL-6) H Q:LR("Q")  W !?5,$P(^LAB(60,T,0),"^"),"= ",S(S,T)
 Q:LR("Q")  W !!,"TOTAL TESTS:" F T=0:0 S T=$O(T(T)) Q:'T!(LR("Q"))  D:$Y>(IOSL-6) H Q:LR("Q")  W !?5,$P(^LAB(60,T,0),"^"),"= ",T(T)
OUT D END^LRUTL,END Q
Z S Z=Z-1 F I=Z:0 S I=$O(^LRO(68,W,1,I)) Q:'I!(I>Z(1))  S LRSA=LRSDT-.01 F B=LRSA:0 S B=$O(^LRO(68,W,1,I,1,"AD",B)) Q:'B!(B>LRLDT)  F W(6)=0:0 S W(6)=$O(^LRO(68,W,1,I,1,"AD",B,W(6))) Q:'W(6)  D AC1 ;tf
 Q
AC1 S S=$S($D(^LRO(68,W,1,I,1,W(6),5,1,0)):+^(0),1:0) S:S<1 S=LRU S:'$D(S(S)) S(S)=0 S S(S)=S(S)+1
 F T=0:0 S T=$O(^LRO(68,W,1,I,1,W(6),4,T)) Q:'T  S:'$D(T(T)) T(T)=0 S T(T)=T(T)+1 S:'$D(S(S,T)) S(S,T)=0 S S(S,T)=S(S,T)+1
 Q
 S Z=Z-1 F I=Z:0 S I=$O(^LRO(68,W,1,I)) Q:'I!(I>Z(1))  F W(6)=0:0 S W(6)=$O(^LRO(68,W,1,I,1,W(6))) Q:'W(6)  D AC1
 Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"LABORATORY SERVICE ",?21,W(1)," COUNTS(",LRSTR,"-",LRLST,")",!,LR("%") Q
AN W !!,"Number of accessions: " W $S($D(S(LRU)):S(LRU),1:0) G OUT
 ;
END D V^LRU Q
