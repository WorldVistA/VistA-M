LRAPWR ;AVAMC/REG - DATE/TIME SLIDES READ ;8/15/95  11:10
 ;;5.2;LAB SERVICE;**72**;Sep 27, 1994
 S LRDICS="CY" D ^LRAP G:'$D(Y) END D CY^LRAPWR1 G:Y=-1 END D S^LRAPST K Y
ASK S %DT="",X="T" D ^%DT S LRY=$E(Y,1,3)+1700 W !,"Enter year: ",LRY,"// " R X:DTIME G:'$T!(X[U) END S:X="" X=LRY
 S %DT="EQ" D ^%DT G:Y<1 ASK S LRY=$E(Y,1,3),LRH(0)=LRY+1700 W "  ",LRH(0)
 S LRN="",LRAD=$E(LRY,1,3)_"0000"
 I '$O(^LRO(68,LRAA,1,LRAD,1,0)) W $C(7),!!,"NO ",LRO(68)," ACCESSIONS IN FILE FOR ",LRH(0),!! Q
W K LR("CK") W !!,"Select ",LRO(68)," (",LRABV,") Accession Number: ",LRN,$S(LRN:"//",1:"") R LRAN:DTIME G:'$T!(LRAN[U)!(LRN=""&(LRAN="")) END S:LRAN="" LRAN=LRN
 I LRAN'?1N.N!($E(LRAN)=0) S LRN="" W $C(7),!!,"Enter a number, no leading zero's." G W
 S LRN=$O(^LRO(68,LRAA,1,LRAD,1,LRAN)) S:LRN'=+LRN LRN="" D REST G W
REST W "  for ",LRH(0) I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) W $C(7),!!,"Accession # ",LRAN," for ",LRH(0)," not in ACCESSION file",!! Q
 S X=^LRO(68,LRAA,1,LRAD,1,LRAN,0),LRAC=$P($G(^(.2)),U),LRI=$P(^(3),U,5),LRDFN=+X Q:'$D(^LR(LRDFN,0))  S X=^(0) D ^LRUP
 W ! S %DT("A")="Date/time slides examined: " D W^LRAPWU Q:LRK<1  D ^LRAPWU I F W $C(7),!!,"Use 'Blocks, Stains, Procedures, anat path' option to enter date slides",!,"stained.  This must be done before entering date slides examined." Q
B Q:$D(LR("CK"))  K LR S LR=0 I '$D(IOF) S IOP="HOME" D ^%ZIS
 S LRA=^LR(LRDFN,LRSS,LRI,0),Y=+LRA D D^LRU S LRE=Y,LRW=$S(Y'[1700:Y,1:"")
 S LRM=0 D H F A=0:0 S A=$O(^LR(LRDFN,LRSS,LRI,.1,A)) Q:'A  S LRB=^(A,0) D:$Y>(IOSL-3) M Q:LRM[U  W !,$P(LRB,U) D S
 W !,"Data displayed ok " S %=2 D YN^LRU Q:%<1  I %=1 D ^LRAPWR1 Q
 I LR S DIE="^LR(LRDFN,LRSS,",DA=LRI D CK^LRU Q:$D(LR("CK"))  W ! D E D FRE^LRU
 G B
S F E=0:0 S E=$O(^LR(LRDFN,LRSS,LRI,.1,A,E)) Q:'E  S B=0 F F=1:1 S B=$O(^LR(LRDFN,LRSS,LRI,.1,A,E,B)) Q:'B!(LRM[U)  S LRB(1)=^(B,0) D:$Y>(IOSL-3) M Q:LRM[U  W:F=1 !,LRSS(LRSS,E) W !?3,$P(LRB(1),U),?16,"Stain/Procedure" D T
 Q
T F C=0:0 S C=$O(^LR(LRDFN,LRSS,LRI,.1,A,E,B,1,C)) Q:'C!(LRM[U)  S Y=^(C,0),X=$P(Y,"^",2),Z=$P(Y,"^",3),V=X+Z,LRZ=V-$P(Y,"^",8) S:LRZ>0 $P(^(0),"^",8)=V D:$Y>(IOSL-3) M Q:LRM[U  D A
 Q
A S:LRZ<1 LRZ=0 S LR=LR+1,Y=$P(Y,"^",5),LR(LR)=A_"^"_E_"^"_B_"^"_C_"^"_Y_"^"_LRZ W !,?15,"*",$J(LR,2),")",?20,$S($D(^LAB(60,C,0)):$E($P(^(0),"^"),1,25),1:C),?47 W:X $J(X,5) W:Z ?52,"/",Z D:Y D^LRU W ?60,Y Q
E R !,"Select *Stain #: ",LRX:DTIME Q:LRX[U!(LRX="")  I '$D(LR(LRX)) W $C(7),"  Select a number from 1 to ",LR G E
 S X=LR(LRX),A=$P(X,U),E=$P(X,U,2),B=$P(X,U,3),C=$P(X,U,4) W "   ",$P(^LR(LRDFN,LRSS,LRI,.1,A,E,B,0),U)," ",$P(^LAB(60,C,0),U)
N S %DT="AEQTRX",%DT("A")="Date/time slides examined: ",%DT(0)="-N",Y=$P(^LR(LRDFN,LRSS,LRI,.1,A,E,B,1,C,0),U,5),X(4)=$P(^(0),U,4) D:Y DA^LRU S:Y %DT("B")=Y D ^%DT K %DT Q:Y<1  I Y<X(4) D CK G E
 S $P(^(0),U,5)=Y,$P(LR(LRX),"^",5)=Y G E
CK W $C(7),!?3,"Date/time slides examined (" D DD^%DT W Y,") cannot be before",!?3,"Date/time slides  stained" S Y=X(4) D:Y DD^%DT W:Y]"" " (",Y,")" Q
 ;
 ;
M R !,"'^' TO STOP: ",LRM:DTIME S:'$T LRM=U D:LRM'[U H Q
H W @IOF,LRP," ",SSN(1)," Acc #: ",LRAC," Date: ",LRE,!?47,"Slide/Ctrl",?60,"Date Slides Examined" Q
 ;
END D V^LRU Q
