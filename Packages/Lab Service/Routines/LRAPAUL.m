LRAPAUL ;AVAMC/REG/CYM - PATHOLOGY LIST BY PATHOLOGIST/TECH ;2/9/98  13:59 ;
 ;;5.2;LAB SERVICE;**72,173,201**;Sep 27, 1994
 D ^LRAP G:'$D(Y) END
 S LRP=$S("SPAU"[LRSS:"Resident Pathologist",LRSS="CY":"Cytotechnologist",1:"Resident or EM Technologist")
ASK W !!?17,"1. ",LRO(68)," list by ",LRP,!?17,"2. ",LRO(68)," list by Senior   Pathologist",!?17,"3. ",LRO(68)," list by Surgeon/Physician",!,"Select 1,2 or 3: "
 R X:DTIME G:X=""!(X[U) END I X<1!(X>3) W $C(7),"  Enter 1, 2 or 3" G ASK
 S Y=$S(LRSS="AU":"7^10",1:"4^2"),LRA=$S(X=1:$P(Y,U)_";200",1:$P(Y,U,2)_";200")
 I X=3 D P G END:Y<1,R
 S DIC(0)="AEQM",DIC=$P(LRA,";",2),DIC("A")="Select "_$S(X=1:LRP,1:"SENIOR PATHOLOGIST")_": " D ^DIC K DIC G:Y<1 END S LRB=+Y,X=$P(Y,U,2),LRA=+LRA S:X X=$P(^VA(200,X,0),U)
R S LRD=0,LRB(1)=$P(X,",",2)_" "_$P(X,",")_"'s" I "SPCYEM"[LRSS W !!,"List only reports not released " S %=2 D YN^LRU G:%<1 END S:%=1 LRD=1 W !
 D B^LRU G:Y<0 END S LRLDT=LRLDT+.99,LRSDT=LRSDT-.0001
 S LRF=0 W !!,"Print total count only " S %=2 D YN^LRU G:%<1 END I %=1 S LRF=1,LRV=0 G DEV
 W !!,"Print Topography and Morphology entries " S %=2 D YN^LRU G:%<1 END S LRV=$S(%=1:1,1:0)
DEV S ZTRTN="QUE^LRAPAUL" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO D FIELD^DID(63,13.7,"","POINTER","LRS") S LRE=0 S:LRSS="AU" LRS=LRS("POINTER") D L^LRU,S^LRU,XR^LRU,H S LR("F")=1
 F LRC=LRSDT:0 S LRC=$O(^LR(LRXR,LRC)) Q:'LRC!(LRC>LRLDT)!(LR("Q"))  F LRP=0:0 S LRP=$O(^LR(LRXR,LRC,LRP)) Q:'LRP  D @$S(LRSS="AU":"W",1:"SP")
 W:'LRE !,"No "_LRO(68)_" reports found." W:LRE&(LRF) !!,"Total cases (list not requested): ",LRE D END,END^LRUTL Q
W D:$Y>(IOSL-6) H Q:LR("Q")  I '$D(^LR(LRP,"AU")) K ^LR("AAU",LRC,LRP) Q
 Q:$P($P($G(^LR(LRP,"AU")),U,6)," ")'=LRABV  Q:$P(^LR(LRP,"AU"),"^",LRA)'=LRB  S LRE=LRE+1,Z=^("AU")
PRT Q:LRF  D:$Y>(IOSL-6) H Q:LR("Q")
 W !,LRE,")",?3,$J($P(Z,"^",6),4),?18 S Y=+Z D DT W Y,?35 S X=^LR(LRP,0),Y=$P(X,"^",3),(LRDPF,X)=$P(X,"^",2),X=^DIC(X,0,"GL"),V=@(X_Y_",0)"),SSN=$P(V,"^",9) D SSN^LRU W $P(V,"^") W:LRSS'="AU" "  ",SSN Q:LRSS'="AU"
 S DA=LRP D D^LRAUAW S X2=$P(V,"^",3),X1=LR(63,12) D ^%DTC S X=X\365.25 S:X<1 X="<1" W ?62,$J(X,2)
 S X=$P(Z,"^",11)_":" W ?66,$E($P($P(LRS,X,2),";"),1,12) Q:'LRV
 F T=0:0 S T=$O(^LR(LRP,"AY",T)) Q:'T  S B=+^(T,0),B=$S($D(^LAB(61,B,0)):$P(^(0),"^"),1:B) D:$Y>(IOSL-6) H1 Q:LR("Q")  W !?16,B D M
 Q
M F M=0:0 S M=$O(^LR(LRP,"AY",T,2,M)) Q:'M  S N=+^(M,0),N=$S($D(^LAB(61.1,N,0)):$P(^(0),"^"),1:N) D:$Y>(IOSL-6) H2 Q:LR("Q")  W !?21,N
 Q
 ;
DT D DD^LRX Q
SP F LRI=0:0 S LRI=$O(^LR(LRXR,LRC,LRP,LRI)) Q:'LRI  D WR
 Q
WR D:$Y>(IOSL-6) H1 Q:LR("Q")  I '$D(^LR(LRP,LRSS,LRI,0)) K ^LR(LRXR,LRC,LRP,LRI) Q
 S X=^LR(LRP,LRSS,LRI,0) Q:$P($P(X,U,6)," ")'=LRABV  Q:$P(X,"^",LRA)'=LRB  I LRD,$P(X,"^",11) Q
 S LRE=LRE+1,Z=X D PRT Q:'LRV
 F T=0:0 S T=$O(^LR(LRP,LRSS,LRI,2,T)) Q:'T  S B=+^(T,0),B=$S($D(^LAB(61,B,0)):$P(^(0),"^"),1:B) D:$Y>(IOSL-6) H1 Q:LR("Q")  W !?16,B D MR
 Q
MR F M=0:0 S M=$O(^LR(LRP,LRSS,LRI,2,T,2,M)) Q:'M  S N=+^(M,0),N=$S($D(^LAB(61.1,N,0)):$P(^(0),"^"),1:N) D:$Y>(IOSL-6) H2 Q:LR("Q")  W !?21,N
 Q
P K DIC S DIC("A")="PROVIDER : ",DIC(0)="AEQN",DIC="^VA(200,",D="AK.PROVIDER" D IX^DIC K DIC Q:Y<1  S LRB=+Y,LRA=7,X=$P(Y,U,2) Q
 ;
H I $D(LR("F")),$E(IOST,1,2)="C-" D M^LRU Q:LR("Q")
 D F^LRU W !,LRB(1)," ",LRO(68)," list from:",LRSTR," to:",LRLST W:LRD !,"List of reports not released" W !,"Count",?6,"Case#",?18,"Case date",?35,"Patient" W:LRSS="AU" ?62,"Age",?66,"Autopsy type" W:LRSS'="AU" "/SSN" W !,LR("%") Q
H1 D H Q:LR("Q")  W !,LRE,")",?3,$J($P(Z,"^",6),4),?18 S Y=+Z D DT W Y,?31,$P(V,"^") Q
H2 D H1 Q:LR("Q")  W !?16,B Q
 ;
END D V^LRU Q
