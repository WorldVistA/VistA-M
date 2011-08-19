FHORX2 ; HISC/REL,RTK - List Patient Events ;8/2/94  10:07
 ;;5.5;DIETETICS;;Jan 28, 2005
 S FHALL=1 D ^FHOMDPA
 I 'DFN,'IEN200 G KIL
 G:FHDFN="" KIL D NOW^%DTC S DT=%\1
 I '$D(^FH(119.8,"AP",FHDFN)) W !!,"No Dietetic Events on File." G FHORX2
 D DT G:'SDT!('EDT) FHORX2 S EDT=EDT+.3
 K IOP S %ZIS="MQ",%ZIS("B")="HOME" W ! D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHORX2",FHLST="FHDFN^DFN^SDT^EDT" D EN2^FH G KIL
 U IO D Q1 D ^%ZISC K %ZIS,IOP G FHORX2
Q1 ; Process List
 D HDR F KK=SDT-.1:0 S KK=$O(^FH(119.8,"AP",FHDFN,KK)) Q:KK>EDT!(KK<1)  F DA=0:0 S DA=$O(^FH(119.8,"AP",FHDFN,KK,DA)) Q:DA<1  D ^FHORX3
 G KIL
HDR I DFN S X="Dietetic Events for "_$P($G(^DPT(DFN,0)),"^",1) W:$E(IOST,1,2)="C-" @IOF W !?(80-$L(X)\2),X
 I 'DFN S X="Dietetic Events for "_$P($G(^VA(200,IEN200,0)),"^",1) W:$E(IOST,1,2)="C-" @IOF W !?(80-$L(X)\2),X
 W !!?26,"From " S D1=SDT D DTP^FHORX3 W " to " S D1=EDT\1 D DTP^FHORX3 W !
 Q
DT ; Get From/To Dates
D1 S (SDT,EDT)=0,%DT="AEPX",%DT("A")="Starting Date: " W ! D ^%DT S:$D(DTOUT) X="^" G D3:U[X,D1:Y<1 S SDT=+Y
 I SDT>DT W *7,"  [Cannot Start after Today!] " G D1
D2 S EDT=0,%DT="AEPX",%DT("A")=" Ending Date: ",%DT("B")="T" D ^%DT S:$D(DTOUT) X="^" G D3:U[X,D2:Y<1 S EDT=+Y
 I EDT>DT W *7,"  [Cannot End after Today!] " G D2
 I EDT<SDT W *7,"  [End before Start?] " G D1
D3 K %DT Q
KIL G KILL^XUSCLEAN
