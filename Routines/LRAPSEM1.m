LRAPSEM1 ;AVAMC/REG - SEARCH BY SNOMED CODE PRINT ;8/15/95  10:51 ;
 ;;5.2;LAB SERVICE;**72**;Sep 27, 1994
 S LRP=0,LRJ(1)=$S($D(^VA(200,DUZ,0)):$P(^(0),U),1:"") D S^LRU I LRD(1) D ^LRAPSEM2,F Q
 D H1 S LR("F")=1
 F LRB=0:1 S LRP=$O(^TMP("LR",$J,"B",LRP)) Q:LRP=""!(LR("Q"))  S X=$O(^(LRP,0)),Y=$O(^(X,0)),LRW=^TMP("LR",$J,X,Y) D:$Y>(IOSL-6) H1 Q:LR("Q")  W ! W:$P(LRW,"^",7)'=2 "#" W LRP,?32,$P(LRW,"^",5),?46,$P(LRW,"^",3) D Y
 Q:LR("Q")  S LRY=1 D H2 Q:LR("Q")  D L,F Q
 ;
Y S LRY=0 F B=0:0 S LRY=$O(^TMP("LR",$J,"B",LRP,LRY)) Q:'LRY!(LR("Q"))  D A
 Q:LR("Q")  W !,LR("%") Q
A S (LRC,LRAN)=0 F  S LRAN=$O(^TMP("LR",$J,"B",LRP,LRY,LRAN)) Q:'LRAN!(LR("Q"))  S LRC=LRC+1 W:LRC>1 ! D P
 Q
P S LRW=^TMP("LR",$J,LRY,LRAN),LRW(2)=$P(LRW,"^",2),LRW(1)=$P(LRW,"^")
 S LRDFN=$P(LRW,"^",8),LRI=$P(LRW,"^",9),LRT=0 F LRG=0:1 S LRT=$O(^LR(LRDFN,LRSS,LRI,2,LRT)) Q:'LRT!(LR("Q"))  S LRT(1)=$P(^LAB(61,+^(LRT,0),0),"^") D S
 Q
S D:$Y>(IOSL-6) H3 Q:LR("Q")  W !?5,LRT(1) W:'LRG ?50,LRW(2),?58,$J(LRW(1),7) F V=2,4,1,3 I $D(LRN(V)) D T
 Q
T F LRM=0:0 S LRM=$O(^LR(LRDFN,LRSS,LRI,2,LRT,V,LRM)) Q:'LRM!(LR("Q"))  S X=^(LRM,0),LRX=+X,LRX(1)=$P(X,"^",2) D U
 I LRD F LRM=0:0 S LRM=$O(^LR(LRDFN,LRSS,LRI,2,LRT,5,LRM)) Q:'LRM!(LR("Q"))  S LRX=^(LRM,0) D:$Y>(IOSL-6) H4 Q:LR("Q")  D G
 Q
G S X=LRX,Y=$P(X,"^",2),W=$P(X,"^",3),Z=$P(X,"^")_":",Z=$P($P(LR(LRSS),Z,2),";") D D^LRU W !?10,Z," ",W," Date: ",Y Q
 Q
U Q:'$D(^LAB(+LRSN(V),LRX,0))  S LRM(1)=$P(^(0),"^") D:$Y>(IOSL-6) H4 Q:LR("Q")  W !?10,LRM(1) W:LRX(1)]"" " (",$S(LRX(1)=1:"Positive",LRX(1)=0:"Negative",1:"?"),")" D:V=2 E
 Q
E F LRE=0:0 S LRE=$O(^LR(LRDFN,LRSS,LRI,2,LRT,2,LRM,1,LRE)) Q:'LRE!(LR("Q"))  S LRX=+^(LRE,0) I $D(^LAB(61.2,LRX,0)) S LRX=$P(^(0),"^") D:$Y>(IOSL-6) H5 Q:LR("Q")  W !?15,LRX
 Q
L F B=0:1 S LRY=$O(^TMP("LR",$J,LRY)) Q:'LRY!(LR("Q"))  D W
 Q
W S LRAN=0 F C=0:1 S LRAN=$O(^TMP("LR",$J,LRY,LRAN)) Q:'LRAN!(LR("Q"))  D B
 Q
B D:$Y>(IOSL-6) H2 Q:LR("Q")
 S LRW=^TMP("LR",$J,LRY,LRAN) W !,$P(LRW,U),?12 W:$P(LRW,"^",7)'=2 "#" W $P(LRW,"^",4),?40,$P(LRW,"^",5),?53,$P(LRW,"^",3),?56,$J($P(LRW,"^",2),3),?60,$J($P(LRW,"^",6),5)
 Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,LRO(68)," SEARCH (",LRSTR,"-",LRLST,")"
 W !,"# = Not VA patient",?25,"SNOMED FIELDS",?45,"For:",LRJ(1) W:LRH]"" !,"Comment: ",LRH Q
H1 D H Q:LR("Q")  W !?8,"NAME",?36,"ID",?45,"SEX",?49,"AGE",?60,"ACC #",!,LR("%") Q
H2 D H Q:LR("Q")  W !,"ACC #",?11,"NAME",?44,"ID",?52,"SEX",?56,"AGE",?60,"MO/DA",!,LR("%") Q
H3 D H1 Q:LR("Q")  W !,LRP,?32,$P(LRW,"^",5),?46,$P(LRW,"^",3) Q
H4 D H3 Q:LR("Q")  W !?5,LRT(1),?50,$P(LRW,"^",2),?58,$J($P(LRW,"^"),7) Q
H5 D H4 Q:LR("Q")  W !?10,LRM(1) Q
F D H Q:LR("Q")  W !,LR("%"),!?5,"RESULT OF ",LRO(68)," (",LRABV,") SEARCH: "
 W !,LRAA(1)," PATIENTS WITHIN PERIOD SEARCHED: ",LR(2) W:LRSS'="AU" !,LRO(68)," ACCESSIONS WITHIN PERIOD SEARCHED: ",LR(3)
 I LR W !,LRO(68)," ORGAN/TISSUE SPECIMENS WITHIN PERIOD SEARCHED: ",LR
 I 'LRD(0),LR(2) W !!,$J(LRB,5)," OF ",$J(LR(2),5)," ",LRAA(1)," PATIENTS(",$J(LRB*100/LR(2),5,2),"%) FOUND"
 W !!,"The following fields were used for the search :",!?5,"TOPOGRAPHY FIELD: ",S(2)
 F V=2,4,1,3 I $D(LRN(V)) D C
 Q
C S A=-1 F F=0:0 S A=$O(LRN(V,A)) Q:A=""  W !?10,$O(^DD(+LRSN(V),0,"NM",0)),?26,": ",$S(A'="Z":A,1:"ALL") D:V=2 D
 Q
D S B=-1 F G=0:0 S B=$O(LRN(2,A,B)) Q:B=""  W !?15,"ETIOLOGY FIELD: ",$S(B'="Z":B,1:"ALL")
 Q
