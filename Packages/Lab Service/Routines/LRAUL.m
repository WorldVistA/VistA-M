LRAUL ;AVAMC/REG - PATHOLOGY LIST BY PATHOLOGIST/TECH ;2/18/93  10:54 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 D END
 S DIC=68,DIC(0)="AEQMZ",DIC("S")="I ""AUCYEMSP""[$P(^(0),U,2)",DIC("A")="Select ANATOMIC PATHOLOGY SECTION: " D ^DIC K DIC G:Y<1 END S LRAA=+Y,LRAA(1)=$P(Y,U,2),LRSS=$P(Y(0),U,2)
 S LRP=$S("SPAU"[LRSS:"Resident Pathologist",LRSS="CY":"Cytotechnologist",1:"Resident or EM Technologist")
ASK W !!?15,"1. "_LRAA(1)_" list by "_LRP,!?15,"2. "_LRAA(1)_" list by Senior   Pathologist",!,"Select 1 or 2: " R X:DTIME Q:X=""!(X[U)  I X<1!(X>2) W $C(7),"  Enter a '1' or a '2'." G ASK
 S Y=$S(LRSS="AU":"7^10",1:"4^2"),LRA=$S(X=1:$P(Y,U)_";16",1:$P(Y,U,2)_";6")
 S DIC(0)="AEQM",DIC=$P(LRA,";",2),DIC("A")="Select "_$S(X=1:LRP,1:"SENIOR PATHOLOGIST")_": " D ^DIC K DIC G:Y<1 END S LRB=+Y,X=$P(Y,U,2),LRA=+LRA S:X X=$P(^VA(200,X,0),U)
 S LRB(1)=$P(X,",",2)_" "_$P(X,",")_"'s"
 D B^LRU G:Y<0 END S LRLDT=LRLDT+.99,LRSDT=LRSDT-.0001
 W !!,"Print Topography and Morphology entries " S %=2 D YN^LRU G:%<1 END S LRV=$S(%=1:1,1:0)
 S ZTRTN="QUE^LRAUL" D BEG^LRUTL Q:POP!($D(ZTSK))
QUE U IO S LRO="A"_LRSS,LRE=0 S:LRSS="AU" LRS=$P(^DD(63,13.7,0),U,3) D L^LRU,S^LRU,H
 F LRC=LRSDT:0 S LRC=$O(^LR(LRO,LRC)) Q:'LRC!(LRC>LRLDT)  F LRP=0:0 S LRP=$O(^LR(LRO,LRC,LRP)) Q:'LRP  D @$S(LRSS="AU":"W",1:"SP")
 W:'LRE !,"No "_LRAA(1)_" reports found." D END,END^LRUTL Q
W D:$Y>(IOSL-6) H I '$D(^LR(LRP,"AU")) K ^LR("AAU",LRC,LRP) Q
 Q:$P(^LR(LRP,"AU"),"^",LRA)'=LRB  S LRE=LRE+1,Z=^("AU")
PRT W !,$J(LRE,3),")",?6,$J($P(Z,"^",6),4),?16 S Y=+Z D DT W Y,?31 S X=^LR(LRP,0),Y=$P(X,"^",3),(LRDPF,X)=$P(X,"^",2),X=^DIC(X,0,"GL"),V=@(X_Y_",0)"),SSN=$P(V,"^",9) D SSN^LRU W $P(V,"^") W:LRSS="AU" ?62,SSN W:LRSS'="AU" "  ",SSN
 Q:LRSS'="AU"  S X=$P(Z,"^",11)_":" W ?66,$E($P($P(LRS,X,2),";"),1,12) Q:'LRV
 F T=0:0 S T=$O(^LR(LRP,"AY",T)) Q:'T  S B=+^(T,0),B=$S($D(^LAB(61,B,0)):$P(^(0),"^"),1:B) D:$Y>(IOSL-6) H1 W !?16,B D M
 Q
M F M=0:0 S M=$O(^LR(LRP,"AY",T,2,M)) Q:'M  S N=+^(M,0),N=$S($D(^LAB(61.1,N,0)):$P(^(0),"^"),1:N) D:$Y>(IOSL-6) H2 W !?21,N
 Q
 ;
DT S Y=Y_"000",Y=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)_" "_$S(Y[".":$E(Y,9,10)_":"_$E(Y,11,12),1:"") Q
SP F LRI=0:0 S LRI=$O(^LR(LRO,LRC,LRP,LRI)) Q:'LRI  D WR
 Q
WR D:$Y>(IOSL-6) H1 I '$D(^LR(LRP,LRSS,LRI,0)) K ^LR(LRO,LRC,LRP,LRI) Q
 Q:$P(^LR(LRP,LRSS,LRI,0),"^",LRA)'=LRB  S LRE=LRE+1,Z=^(0) D PRT Q:'LRV
 F T=0:0 S T=$O(^LR(LRP,LRSS,LRI,2,T)) Q:'T  S B=+^(T,0),B=$S($D(^LAB(61,B,0)):$P(^(0),"^"),1:B) D:$Y>(IOSL-6) H1 W !?16,B D MR
 Q
MR F M=0:0 S M=$O(^LR(LRP,LRSS,LRI,2,T,2,M)) Q:'M  S N=+^(M,0),N=$S($D(^LAB(61.1,N,0)):$P(^(0),"^"),1:N) D:$Y>(IOSL-6) H2 W !?21,N
 Q
 ;
H S LRQ=LRQ+1,X="N",%DT="T" D ^%DT,D^LRU W @IOF,Y," ",LRQ(1),?(IOM-10),"Pg:",LRQ
 W !,LRB(1)," ",LRAA(1)," list from:",LRSTR," to:",LRLST,!,"Count",?6,"Case#",?16,"Case date",?31,"Patient" W:LRSS="AU" ?62,"Age",?66,"Autopsy type" W:LRSS'="AU" "/SSN" W !,LR("%") Q
H1 D H W !,$J(LRE,3),?6,$J($P(Z,"^",6),4),?16 S Y=+Z D DT W Y,?31,$P(V,"^") Q
H2 D H1 W !?16,B Q
 ;
 ;
END D V^LRU Q
