LRBLJRB ;AVAMC/REG - UNIT ISSUE BOOK ;2/18/93  09:30 ;
 ;;5.2;LAB SERVICE;**247,267**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 W !!?20,"UNIT issue book" D END
 W !!,"Delete issue book entries over 31 days " S %=2 D YN^LRU G:%<1 END D:%=1 D
 W !!?15,"1. Print issue book entries by date",!?15,"2. Print issue book entries by patient"
ASK R !,"Select 1 or 2: ",LRA:DTIME G:LRA["^"!(LRA="") END I LRA<1!(LRA>2) W $C(7),"  Enter a '1' or '2'.",! G ASK
 D ^LRU S %DT="AETX",%DT(0)="-N",%DT("A")="Start with Date TODAY// " D ^%DT K %DT I X="" S Y=DT W H(10)
 G:Y<1 END S LRSDT=Y
 S %DT="AETX",%DT("A")="Go    to   Date TODAY// " D ^%DT K %DT I X="" S Y=DT W H(10)
 G:Y<1 END S LRLDT=Y D D^LRU S LRLST=Y I LRSDT>LRLDT S X=LRSDT,LRSDT=LRLDT,LRLDT=X
 S Y=LRSDT D D^LRU S LRSTR=Y,Y=LRLDT D D^LRU S LRLST=Y
 S LRSDT=LRSDT-.0001 S:LRLDT'["." LRLDT=LRLDT+.99
 S ZTRTN="QUE^LRBLJRB" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) D L^LRU,S^LRU,H1 S LR("F")=1
 S A=LRSDT F E=0:0 S A=$O(^LRD(65,"AL",A)) Q:'A!(A>LRLDT)  S B=0 F F=0:0 S B=$O(^LRD(65,"AL",A,B)) Q:'B  S C=9999999-A D W
 K G S J=0 F I=0:0 S J=$O(^TMP($J,J)) Q:J=""!(LR("Q"))  S A=0 F LRA=0:0 S A=$O(^TMP($J,J,A)) Q:A=""!(LR("Q"))  F B=0:0 S B=$O(^TMP($J,J,A,B)) Q:'B!(LR("Q"))  S C=^(B) D X
 Q:LR("Q")  D SUM W:IOST'?1"C".E @IOF D END^LRUTL,END Q
X S W=^LRD(65,B,0),G=^(3,C,0),T=+G D T S L=$P(G,"^",4),M=$P(^LAB(66,$P(W,"^",4),0),"^",2),V=$P(G,"^",3) S:V="" V="?" S V=$S($D(^VA(200,V,0)):$P(^(0),"^",2),1:V)
 D:$Y>(IOSL-6) H1 Q:LR("Q")
 W !,T,?12,$P(W,"^"),?28,M,?33,$P(G,"^",2),?37,V,?41,$E($P(G,"^",5),1,9),?51,$E($P(G,"^",6),1,19),?71,$E(L,1,8) S X=$P(G,"^",7)
 I X S X=$S($D(^DPT(X,0)):$P(^(0),"^",9),1:"") I X]"" S LRDPF=2,SSN=X D SSN^LRU W:IOM>80 ?81,SSN W:IOM<81 !?51,SSN
 S:L="" L="UNKNOWN" S:'$D(G(L)) G(L)=0 S G(L)=G(L)+1 S:'$D(G(L,M)) G(L,M)=0 S G(L,M)=G(L,M)+1 Q
T S T=T_"000",T=$E(T,4,5)_"/"_$E(T,6,7)_$S(T[".":" "_$E(T,9,10)_":"_$E(T,11,12),1:"") Q
W I '$D(^LRD(65,B,3,C,0)) K ^LRD(65,"AL",C,B) Q
 I LRA=1 S ^TMP($J,"B",A,B)=C Q
 S G=^LRD(65,B,3,C,0),G(6)=$S($P(G,"^",6)]"":$P(G,"^",6),1:"?"),^TMP($J,G(6),A,B)=C Q
HDR I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"TRANSFUSION SERVICE   Unit issue book" Q
 ;
H1 D HDR Q:LR("Q")  W !,"Mo/Da TIME",?12,"Unit ID",?27,"Prod",?32,"Insp",?37,"By",?41,"Issued to",?51,"Patient",?71,"Location" W:IOM>80 ?81,"Patient SSN" W:IOM<81 !?53,"SSN" W !,LR("%") Q
 ;
D S X="T-31",%DT="" D ^%DT F A=0:0 S A=$O(^LRD(65,"AL",A)) Q:'A!(A>Y)  K ^LRD(65,"AL",A) W "."
 W $C(7),!!,"Deletion completed.",! Q
SUM D H Q:LR("Q")  S Z=-1,T=0 F A=1:1 S Z=$O(G(Z)) Q:Z=""!(LR("Q"))  S T=T+G(Z) D A
 W !,"-----------------------------------------",!,"Totals",?36,$J(T,5)
 S L=-1 F A=0:0 S L=$O(L(L)) Q:L=""!(LR("Q"))  W !?8,L,?20,$J(L(L),5) S X=$O(^LAB(66,"B",L,0)) W:X " (",$P(^LAB(66,X,0),"^"),")" D G:$D(G("BLOOD BANK",L)) D:$Y>(IOSL-6) H Q:LR("Q")
 Q
A D:$Y>(IOSL-6) H Q:LR("Q")  W !,$J(A,2),".)",?6,Z,?36,$J(G(Z),5) S M=-1 F B=0:0 S M=$O(G(Z,M)) Q:M=""!(LR("Q"))  D:$Y>(IOSL-6) H Q:LR("Q")  W !?8,M,?20,$J(G(Z,M),5) S:'$D(L(M)) L(M)=0 S L(M)=L(M)+G(Z,M)
 Q
G S X=G("BLOOD BANK",L),Y=L(L)-X I X,Y,X<Y W ?(IOM-15),$J(X*100/Y,4,1),"% returned"
 Q
H D HDR Q:LR("Q")  W !,"Unit counts by location from ",LRSTR," to ",LRLST,!,LR("%") Q
 ;
END D V^LRU Q
