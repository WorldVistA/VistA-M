LRCAPAUD ;SLC/FHS - DISPLAY WORKLOAD FOR ACCESSION ;2/13/91  11:05
 ;;5.2;LAB SERVICE;;Sep 27, 1994
ASK ;
 K DX D ^%ZISC S LRALL="" W !!?15,"Which File (68 or 64.1 ) " R TAG:DTIME G:'$T!($E(TAG)="^")!(TAG="") STOP D:$D(TAG) @($S(TAG=68:"A",TAG=64.1:"A2",1:"ERR"))
 G ASK
A S %=2 W !?5,"Would like to view verified data from ^LR( also " D YN^DICN Q:%<1  S:%=1 LRVIEW=1
 K DIC W !! S DIC="^LRO(68,",DIC(0)="AEQM" D ^DIC G:Y<1 STOP S LRAA=+Y,LRAA(1)=$P(Y,U,2),LRY=$S($D(^LRO(68,LRAA,1,0)):$P(^(0),U,3),1:"")
D W ! S DIC="^LRO(68,LRAA,1,",DIC("B")=LRY,DIC(0)="AEQM",DIC("A")="Select "_LRAA(1)_" Date: " D ^DIC K DIC G:Y<1 A S LRAD=+Y,Y=$P(Y,U,2) D D^LRU S LRD=Y,X1=""
 S DIC="^LRO(68,"_LRAA_",1,"_LRAD_",1,"
B R !,"Enter Accession #(s) :",X:DTIME G STOP:'$T!(X=U) I $E(X)="?" W !!,"Enter a string of numbers separated by ',' or '-'",!,"You many enter more than one line of numbers ",! G B
 I X'="" S X1=X1_","_X G:X1[U STOP G B
 S X=X1 G:'$L(X) STOP
RANGE K X9 D RANGE^LRWU2 I '$L(X9) W !!?10,"NOTHING ENTERED ",$C(7) G STOP
ZIS K IO("Q") S %ZIS="Q" D ^%ZIS G STOP:POP I '$D(IO("Q")) U IO G QUE
 S ZTRTN="QUE^LRCAPAUD",ZTIO=ION,ZTDESC="PRINT ACCESSION WORK LOAD" S ZTSAVE("LR*")="" F I="X9","DIC" S ZTSAVE(I)=""
 K ZTSK D ^%ZTLOAD W:$G(ZTSK) !!?10,"QUEUED TO "_ION D ^%ZISC K ZTSK G STOP
QUE S:$D(ZTQUEUED) ZTREQ="@" S LRSS=$P($G(^LRO(68,$G(LRAA),0)),U,2)
LOOK G ALL:LRALL K W,DX S X9=X9_"S DA=T1 Q:$D(DTOUT)!($D(DUOUT))  D DIQ^LRCAPAUD"
 X X9 G STOP
ALL ;
 K DX I 'LRAA F DA=0:0 S DA=$O(@(DIC_DA_")")) Q:'DA!($D(DTOUT))!($D(DUOUT))  D EN^LRDIQ Q:$D(DTOUT)!($D(DUOUT))!($D(DIRUT))
 G STOP
DIQ I '$D(@(DIC_T1_",0)")) W !?5,"NO DATA FOR THIS ENTRY  "_T1 Q
 I LRAA S LRDFN=+^(0),LRIDT=+$P($G(^(3)),U,5) W ! S DR=0 D EN^LRDIQ Q:$D(DTOUT)!($D(DUOUT))!($D(DIRUT))  S DR=4 D EN^LRDIQ W !! Q:$D(DTOUT)!($D(DUOUT))!($D(DIRUT))  D
 . I LRDFN,$D(^LR(LRDFN,LRSS,LRIDT,0)) D LRDIQ
 I 'LRAA W ! K DR D EN^LRDIQ Q:$D(DTOUT)!($D(DUOUT))!($D(DIRUT))
 Q
A2 ;Review data in ^LRO(64.1
 I '$D(^LRO(64.1)) W !!,$C(7),"Sorry - There is not a ^LRO(64.1) global ",!,$C(7) G STOP
 W !! S (LRAA,LRAD)=0,X1=""
 K DIC,DA,DR S DIC="^LRO(64.1,",DIC(0)="AQENM" D ^DIC G:Y<1 STOP S LRINST=+Y S DIC="^LRO(64.1,"_LRINST_",1," D ^DIC G:Y<1 STOP S LRDATE=+Y
 S DIC="^LRO(64.1,"_LRINST_",1,"_LRDATE_",1,",ZTSAVE("DIC")="",ZTSAVE("LR*")=""
CODE W !?5,"You may select individual codes",!?10,"or enter 'ALL' for complete list",!
 S (LRALL,LREND,CODE)="",DIC(0)="EQNM" F  R !?10,"ENTER CODE ",X:DTIME S:'$T!($E(X)="^") LREND=1 Q:LREND  S:$E(X)="A" LRALL=1 Q:LRALL!(X="")  D ^DIC S:Y>0 CODE=CODE_+Y_","
 I 'LREND G:LRALL ZIS S:$L(CODE) X=$E(CODE,1,($L(CODE)-1)) G RANGE
STOP W:IOST["P-" @IOF D ^%ZISC K X1,TAG,LRINST,LRDATE,LRVIEW,DTOUT,DUOUT,DR,DIC,T1,DIC,X,LRAA,LRY,LRAD Q
ERR W $C(7),!!,"Select a file or '^' to STOP",!! Q
LRDIQ ;
 ;Display results from ^LR(
 Q:'$G(LRVIEW)
 N I,A,N,Z,Y,X,DA,D0,DIC,DIE,DR,DX
 S:$D(S) S=S+4 S DA=LRIDT,DA(1)=LRDFN,DIC="^LR("_DA(1)_","""_LRSS_""",",DR="0:999999999999"
 W "************ Verified Data ***************"
 D EN^LRDIQ
