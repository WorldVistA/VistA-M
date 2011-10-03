LRAPSL1 ;AVAMC/REG - ANATOMIC PATH SLIDE LABELS ;5/9/91  12:08
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 S LRAD=$E(LRY,1,3)_"0000"
 I '$D(^LRO(68,LRAA,1,LRAD,0)) W $C(7),!!,"NO ",LRAA(1)," ACCESSIONS IN FILE FOR ",LRH(0),!! Q
W K LR S LR=0 R !!,"Select Accession Number: ",LRAN:DTIME G:LRAN=""!(LRAN[U) OUT I LRAN'?1N.N W $C(7),!!,"Enter a number." G W
 D REST G W
REST W "  for ",LRH(0) I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) W $C(7),!!,"Accession # ",LRAN," for ",LRH(0)," not in ACCESSION file",!! Q
 S X=^LRO(68,LRAA,1,LRAD,1,LRAN,0),LRDFN=+X Q:'$D(^LR(LRDFN,0))  S X=^(0) D ^LRUP
 S LRI=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,3),"^",5),LRA=$S(LRSS'="AU":^LR(LRDFN,LRSS,LRI,0),1:^LR(LRDFN,"AU")) I '$D(IOF) S IOP="HOME" D ^%ZIS
 S Y=+LRA D D^LRU S LRE=Y,LRM=0 D H I LRSS="AU" D AU W ! D:LR E Q
 F A=0:0 S A=$O(^LR(LRDFN,LRSS,LRI,.1,A)) Q:'A  S LRB=^(A,0) D:$Y>(IOSL-3) M Q:LRM[U  W !,$P(LRB,U) D S
 W ! D:LR E Q
S F E=0:0 S E=$O(^LR(LRDFN,LRSS,LRI,.1,A,E)) Q:'E!(LRM[U)  S B=0 F F=1:1 S B=$O(^LR(LRDFN,LRSS,LRI,.1,A,E,B)) Q:'B!(LRM[U)  S LRB(1)=^(B,0) D:$Y>(IOSL-3) M Q:LRM[U  W:F=1 !,LRSS(LRSS,E) W !?3,$P(LRB(1),U),?16,"Stain/Procedure" D T
 Q
T F C=0:0 S C=$O(^LR(LRDFN,LRSS,LRI,.1,A,E,B,1,C)) Q:'C!(LRM[U)  S Y=^(C,0),X=$P(Y,U,2),Z=$P(Y,U,3) D:$Y>(IOSL-3) M Q:LRM[U  D A
 Q
A S LR=LR+1,LR(LR)=A_U_E_U_B_U_C W !,?15,"*",$J(LR,2),")",?20,$E($P(^LAB(60,C,0),U),1,25),?47 W:X $J(X,5) W:Z ?52,"/",Z S Y=$P(Y,U,7) W ?66,$J(Y,3) Q
E R !,"Select *Stain #: ",X:DTIME Q:X[U!(X="")  I '$D(LR(X)) W $C(7),"  Select a number from 1 to ",LR G E
 S X=LR(X),A=$P(X,U),E=$P(X,U,2),B=$P(X,U,3),C=$P(X,U,4) W "   ",$S(LRSS'="AU":$P(^LR(LRDFN,LRSS,LRI,.1,A,E,B,0),U),1:$P(^LR(LRDFN,33,A,E,B,0),U))," ",$P(^LAB(60,C,0),U)
N W !,"Number of labels: ",$S(LRSS'="AU":$P(^LR(LRDFN,LRSS,LRI,.1,A,E,B,1,C,0),U,7),1:$P(^LR(LRDFN,33,A,E,B,1,C,0),U,7)),"// " R X:DTIME Q:'$T!(X[U)  G:X="" E I X=+X,X<100,X>0 S $P(^(0),U,7)=X G E
 W $C(7),!,"Enter a number from 0 to 99." G N
 Q
AU F A=0:0 S A=$O(^LR(LRDFN,33,A)) Q:'A!(LRM[U)  S LRB=^(A,0) D:$Y>(IOSL-3) M Q:LRM[U  W !,$P(LRB,U) D AUS
 Q
AUS F E=0:0 S E=$O(^LR(LRDFN,33,A,E)) Q:'E!(LRM[U)  S B=0 F F=1:1 S B=$O(^LR(LRDFN,33,A,E,B)) Q:'B!(LRM[U)  S LRB(1)=^(B,0) D:$Y>(IOSL-3) M Q:LRM[U  W:F=1 !,LRSS(LRSS,E) W !?3,$P(LRB(1),U),?16,"Stain/Procedure" D AUT
 Q
AUT F C=0:0 S C=$O(^LR(LRDFN,33,A,E,B,1,C)) Q:'C!(LRM[U)  S Y=^(C,0),X=$P(Y,U,2),Z=$P(Y,U,3) D:$Y>(IOSL-3) M Q:LRM[U  D A
 Q
M R !,"'^' TO STOP: ",LRM:DTIME S:'$T LRM=U D:LRM'[U H Q
H W @IOF,LRP," ",SSN(1)," Acc #: ",LRAN," Date: ",LRE,!?47,"Slide/Ctrl",?60,"Labels to Print" Q
 ;
OUT D K^LRU K LR,LRAX,LRDFN,LRDPAF,LRPARAM,LRSF,LRWHO,LRA,LRB,LRD,LRE,LRI,LRP,LRM,LRU,DOB,SEX,SSN,LRAD,LRAN,LRSS(LRSS) Q
