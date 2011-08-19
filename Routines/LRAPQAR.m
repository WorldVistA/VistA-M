LRAPQAR ;AVAMC/REG/CYM - 10% SURG PATH REVIEW ;8/4/97  19:35
 ;;5.2;LAB SERVICE;**72,173**;Sep 27, 1994
 S LRDICS="SP" D ^LRAP G:'$D(Y) END
 W !!?25,"10% ",LRO(68),"  Review",!,"This report may take a while and should be queued to print at non-peak hours.",!,"OK to continue " S %=2 D YN^LRU Q:%'=1
 D ASK^LRAPQAFS G:%<1 END
 W ! D B^LRU G:Y<0 END S LRSDT=LRSDT-.01,LRLDT=LRLDT+.99
 S ZTRTN="QUE^LRAPQAR" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J),^TMP("LRAP",$J) S LRN="ALL",(LRQ(9),LRS(5),LRS(99))=1,LR("DIWF")="W",(LR,LR("A"),LR(1),LR(2),LR(3),LRQ(2),LRG,LRJ)=0 D L^LRU,S^LRU,L1^LRU,XR^LRU,H S LR("F")=1 W !,LR("%")
 F X=0:0 S LRSDT=$O(^LR(LRXR,LRSDT)) Q:'LRSDT!(LRSDT>LRLDT)  F LRDFN=0:0 S LRDFN=$O(^LR(LRXR,LRSDT,LRDFN)) Q:'LRDFN  F LRI=0:0 S LRI=$O(^LR(LRXR,LRSDT,LRDFN,LRI)) Q:'LRI  D T
 W !,"Total accessions:",?23,$J(LRG,5),! D A,EN2^LRUA,SET^LRUA S LRQ=0,LRA=1 D W
 K ^TMP("LRAP",$J) D END^LRUTL,END Q
T I $P($P($G(^LR(LRDFN,"SP",LRI,0)),U,6)," ")=LRABV S X=^(0),Z=$E($P(X,U,10),1,3),A=+$P($P(X,U,6)," ",3) D T1
 Q
T1 F X=0:0 S X=$O(^LR(LRDFN,"SP",LRI,2,X)) Q:'X  S Y=+^(X,0) I Y,$D(^LAB(61,Y,0)) S Y=$E($P(^(0),U,2)) S:Y]"" ^TMP($J,"B",Y,Z,A)="",LRG=LRG+1
 Q
A F X=0,1,2,3,4,5,6,7,8,9,0,"X","Y" I $D(^TMP($J,"B",X)) D C
 K ^TMP($J,"B") S X=-1 F Y=0:0 S X=$O(^TMP($J,X)) Q:X=""  W !?3,"Topography ",X,": ",$J(^(X),4)
 F X=0,1,2,3,4,5,6,7,8,9,"X","Y" I $D(^TMP($J,X)) S T=^(X),C=0 D S
 Q
W W !!,"Accessions for review: ",$J(LRJ,5) W:LRG&(LRJ) " (",$J(LRJ/LRG*100,5,2),"%)" I 'LRQA D H1 Q:LR("Q")
 F LRY=0:0 S LRY=$O(^TMP("LRAP",$J,LRY)) Q:'LRY!(LR("Q"))  F LRAN=0:0 S LRAN=$O(^TMP("LRAP",$J,LRY,LRAN)) Q:'LRAN!(LR("Q"))  D D
 S:LRQA LRQ=0 F LRY=0:0 S LRY=$O(^TMP("LRAP",$J,LRY)) Q:'LRY!(LR("Q"))  D B
 Q
D S LRDFN=$O(^LR("ASPA",LRY,LRABV,LRAN,0)),LRI=$O(^(LRDFN,0)),LRAC=$P($G(^LR(LRDFN,LRSS,LRI,0)),U,6) D:LRQA EN^LRSPRPT D:'LRQA ^LRUA S ^TMP("LRAP",$J,LRY,LRAN)=LRP_U_SSN_U_LRI_U_LRDFN_U_LRAC D:LRC L^LRAPQAMR Q
B F LRAN=0:0 S LRAN=$O(^TMP("LRAP",$J,LRY,LRAN)) Q:'LRAN!(LR("Q"))  S X=^(LRAN),LRP=$P(X,"^"),SSN=$P(X,"^",2),LRI=$P(X,"^",3),LRDFN=$P(X,"^",4),LRAC=$P(X,U,5) D:$Y>(IOSL-6) H1 Q:LR("Q")  D R
 Q
R W !,LRAC,?18,LRP,?50,SSN I LRI F LRT=0:0 S LRT=$O(^LR(LRDFN,LRSS,LRI,2,LRT)) Q:'LRT!(LR("Q"))  S X=+^(LRT,0),LRX=$P(^LAB(61,X,0),"^") D:$Y>(IOSL-6) H2 Q:LR("Q")  W !?5,LRX D M
 W !,LR("%") Q
M F LRM=0:0 S LRM=$O(^LR(LRDFN,LRSS,LRI,2,LRT,2,LRM)) Q:'LRM!(LR("Q"))  S X=+^(LRM,0),M=$P(^LAB(61.1,X,0),"^") D:$Y>(IOSL-6) H3 Q:LR("Q")  W !?10,M
 Q
C S C=0 F A=0:0 S A=$O(^TMP($J,"B",X,A)) Q:'A  F B=0:0 S B=$O(^TMP($J,"B",X,A,B)) Q:'B  S C=C+1,^TMP($J,X,C)=A_"^"_B
 S ^TMP($J,X)=C Q
S S N=T*.1 S:N<1 N=1 I N["." S N=N_"00",A=$E($P(N,".",2),1,3),B=$P(N,"."),N=$S(A>499:B+1,1:B)
 I T=1 S F=^TMP($J,X,1),^TMP("LRAP",$J,$P(F,"^"),$P(F,"^",2))="",LRJ=LRJ+1 K ^TMP($J,X,1) Q
 F Y=0:0 Q:C=N  S E=$R(T)+1 I $D(^TMP($J,X,E)) S F=^(E),^TMP("LRAP",$J,$P(F,"^"),$P(F,"^",2))="",C=C+1,LRJ=LRJ+1 K ^TMP($J,X,E)
 Q
 ;
H I $D(LR("F")),$E(IOST,1,2)="C-" D M^LRU Q:LR("Q")
 D F^LRU W !,"10% ",LRAA(1)," Review from ",LRSTR," to ",LRLST Q
H1 D H Q:LR("Q")  W !,"ACC #",?20,"NAME",?55,"SSN",!,LR("%") Q
H2 D H1 Q:LR("Q")  W !,LRAC,?18,LRP,?50,SSN Q
H3 D H2 Q:LR("Q")  W !?5,LRX Q
END D V^LRU Q
