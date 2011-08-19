LRAPSEM2 ;AVAMC/REG/CYM- SEARCH BY SNOMED CODE PRINT ;3/10/98  10:16 ;
 ;;5.2;LAB SERVICE;**72,201**;Sep 27, 1994
 D H S LR("F")=1,DIWF="W",DIWL=5,DIWR=IOM-5
 F LRY=0:0 S LRY=$O(^TMP("LR",$J,LRY)) Q:'LRY!(LR("Q"))  F LRAN=0:0 S LRAN=$O(^TMP("LR",$J,LRY,LRAN)) Q:'LRAN!(LR("Q"))  S LRW=^(LRAN) D:$Y>(IOSL-6) H Q:LR("Q")  D Y
 Q
Y S LRP=$E($P(LRW,"^",4),1,20),LRI=$P(LRW,"^",9),LRDFN=$P(LRW,"^",8),LRW(7)=$S($P(LRW,"^",7)=2:"",1:"#"),LRA=^LR(LRDFN,LRSS,LRI,0),LRA(1)=+LRA,LRA(8)=$E($P(LRA,"^",8),1,5),LRA(7)=$E($P($G(^VA(200,+$P(LRA,"^",7),0)),"^"),1,12)
 S LRA(2)=$E($P($G(^VA(200,+$P(LRA,"^",2),0)),"^"),1,13),LRW(1)=$P(LRW,"^"),LRW(2)=$P(LRW,"^",2) D A
 S A=0 F A(2)=0:1 S A=$O(^LR(LRDFN,LRSS,LRI,.1,A)) Q:'A!(LR("Q"))  S A(1)=$P(^(A,0),"^") D:$Y>(IOSL-6) H1 Q:LR("Q")  W ! W:'A(2) "Specimen(s):" W ?15,A(1)
 Q:LR("Q")  K ^TMP($J) S LRZ=0 F LRZ(2)=0:1 S LRZ=$O(^LR(LRDFN,LRSS,LRI,1.1,LRZ)) Q:'LRZ!(LR("Q"))  S LRZ(1)=^(LRZ,0) D:$Y>(IOSL-6) H1 Q:LR("Q")  S X=LRZ(1) D ^DIWP
 Q:LR("Q")  D:LRZ(2) ^DIWW
 Q:LR("Q")  K ^TMP($J) S LRZ=0 F LRZ(2)=0:1 S LRZ=$O(^LR(LRDFN,LRSS,LRI,1.4,LRZ)) Q:'LRZ!(LR("Q"))  S LRZ(1)=^(LRZ,0) D:$Y>(IOSL-6) H1 Q:LR("Q")  S X=LRZ(1) D ^DIWP
 Q:LR("Q")  D:LRZ(2) ^DIWW I 'LRD(2) W !,LR("%") Q
 F LRT=0:0 S LRT=$O(^LR(LRDFN,LRSS,LRI,2,LRT)) Q:'LRT!(LR("Q"))  S X=$G(^LAB(61,+^(LRT,0),0)),LRT(1)=$P(X,"^"),LRT(2)=$P(X,"^",2) D S
 W !,LR("%") Q
S D:$Y>(IOSL-6) H1 Q:LR("Q")  W !?5,"T-",LRT(2)," ",LRT(1) F V=2,4,1,3 I $D(LRN(V)) D T
 Q:LR("Q")  I LRD F LRM=0:0 S LRM=$O(^LR(LRDFN,LRSS,LRI,2,LRT,5,LRM)) Q:'LRM!(LR("Q"))  S LRX=^(LRM,0) D:$Y>(IOSL-6) H4 Q:LR("Q")  D G
 Q
T F LRM=0:0 S LRM=$O(^LR(LRDFN,LRSS,LRI,2,LRT,V,LRM)) Q:'LRM!(LR("Q"))  S X=^(LRM,0),LRX=+X,LRX(1)=$P(X,"^",2) D U
 Q
G S X=LRX,Y=$P(X,"^",2),W=$P(X,"^",3),Z=$P(X,"^")_":",Z=$P($P(LR(LRSS),Z,2),";") D D^LRU W !?10,Z," ",W," Date: ",Y D B Q
 ;
U Q:'$D(^LAB(+LRSN(V),LRX,0))  S X=^(0),LRM(1)=$P(X,"^"),LRM(2)=$P(X,"^",2) D:$Y>(IOSL-6) H4 Q:LR("Q")  W !?10,$P(LRSN(V),"^",2),"-",LRM(2)," ",LRM(1) W:LRX(1)]"" " (",$S(LRX(1)=1:"Positive",LRX(1)=0:"Negative",1:"?"),")" D:V=2 E
 Q
B K ^TMP($J) S LRZ=0 F LRZ(2)=0:0 S LRZ=$O(^LR(LRDFN,LRSS,LRI,2,LRT,5,LRM,1,LRZ)) Q:'LRZ!(LR("Q"))  S LRZ(1)=^(LRZ,0) D:$Y>(IOSL-6) H4 Q:LR("Q")  S X=LRZ(1) D ^DIWP
 D:LRZ(2) ^DIWW Q
E F LRE=0:0 S LRE=$O(^LR(LRDFN,LRSS,LRI,2,LRT,2,LRM,1,LRE)) Q:'LRE!(LR("Q"))  S LRX=+^(LRE,0) I $D(^LAB(61.2,LRX,0)) S X=^(0),LRX=$P(X,"^"),LRX(2)=$P(X,"^",2) D:$Y>(IOSL-6) H5 Q:LR("Q")  W !?15,"E-",LRX(2)," ",LRX
 Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,LRO(68)," (",LRABV,") SEARCH (",LRSTR,"-",LRLST,")" W !,"Date",?8,"# = Not VA patient",?35,"For:",LRJ(1)
 W !,"Taken",?11,"Patient",?30,"ID",?35,"Physician",?48,"LOC",?55,"Acc#",?67,"PATHOLOGIST",!,LR("%") Q
H1 D H Q:LR("Q")  D A S A(2)=0 Q
H4 D H1 Q:LR("Q")  W !?5,LRT(1) Q
H5 D H4 Q:LR("Q")  W !?10,LRM(1) Q
A W !,$$Y2K^LRX(LRA(1),"5D"),?10,LRW(7),?11,LRP,?32,$P($P(LRW,"^",5),"-",3),?37,LRA(7),?50,LRA(8),?57,$P(LRA,"^",6),?69,LRA(2) Q
