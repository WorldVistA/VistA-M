LRPHSET ;SLC/CJS - COLLECTION LIST TO ACCESSIONS ;2/19/91  11:16 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 K LRPARAM D ^LRPARAM Q:'$D(LRPARAM)
 S:$D(ZTQUEUED) LRLABLTF=1,LRTE=1 S LREND=0 D:$P(^LAB(69.9,1,"RO"),U,2)!($P(^("RO"),U))<$P($H,",") ROLL G:LREND=1 END1 D NOW G END1:'$D(LRDTI) G MANUAL:'$D(ZTQUEUED) G NEW:$D(ZTQUEUED)
NEW G RUNING:$P(^LAB(69.9,1,5),"^",10) K ^LRO(69.1,1),^("B"),^("LRPH") S ^LRO(69.1,1,0)=1_"^"_DT_"^"_$P(LRDTI,".",2),^LRO(69.1,"B",1,1)="",$P(^LRO(69.1,0),"^",3,4)=1_"^"_1,LRTE=1,$P(^LAB(69.9,1,5),"^",14,15)=LRDTI_"^"
ADD S LRPHSET=1,LRODT=DT I '$D(ZTQUEUED) W !,"BUILDING THE LIST"
 S TIME=$P($H,",",2) D EN^LRPHSET1 S TIME1=$P($H,",",2),TIME3=TIME1-TIME
 G END
MANUAL ;ENTRY POINT
 S LRTE=1 G RUNING:$P(^LAB(69.9,1,5),"^",10) I '$D(^LRO(69.1,LRTE,0)) S ^(0)=1_"^"_DT_"^"_$P(LRDTI,".",2)
 I $O(^LRO(69.1,LRTE,1,0))'="" S LROCT=$P(^LRO(69.1,1,0),U,2)_"."_$P(^LRO(69.1,1,0),U,3) I LROCT<LRDTI S Y=LROCT D DD^LRX W !,"The collection list for ",Y," still exists, you must clear it before ",!,"building a new list." G B
 I $O(^LRO(69.1,LRTE,1,0))'="" W !,"There is some data in the current collection list." I $D(^LRO(69.1,LRTE,0))#2,$L($P(^LRO(69.1,LRTE,0),U,2)) S Y=$P(^(0),U,2) D DD^LRX W !,"Labels last printed on ",Y,!
A S %=2 I $S('$D(^LRO(69.1,1,0))#2:1,$P(^(0),U,2)'<DT:1,1:0) F I=0:0 W !,"Do you wish to add entries.) " S %=1 D YN^DICN Q:%  W !,"Your wish is my command. Please enter Yes or No."
 G END1:%<0,ADD:%=1
B F I=0:0 W !,"Are you ready to clear the current collection list",!,"and start a new one" S %=2 D YN^DICN Q:%  W !,"Answer 'Y'es or 'N'o."
 G NEW:%=1,END1
END K LRPHSET,LRTJ,LRDUZ S:$D(ZTQUEUED) ZTREQ="@"
 I '$D(ZTQUEUED) W !,+LRCOUNT," specimens added to collection list."
 D ^LRPHLIST D ^%ZISC
END1 K DIC,LRPHSET,LRTJ,LRDUZ,%DT,%H,%ZA,%ZB,%ZC,DA,DO,I2,I5,LABEL,LRBED,LRCCOM,LRCS,LRCSN,LRCSS,LREXP,LRFIN,LRFLOG,LRGCOM,LRIOZERO,LRLABLTF,LRLBLD,LRLWC,LRM,LRNCWL,LRNIDT,LRNOLABL,LROCN,LROID,LROLRDFN,LRORDER,LRORDR,LRORDTIM,LROSN,LROT,LROUTINE
 K LREND,LRLBL,LRQ,LRSLIP,LRSSX,LRSTA,LRSTIK,LRSUM,LRSXN,LRTOP,LRTP,LRTSTNM,LRUR,LRUSNM,LRWPC,S5,ZTIO,TIME,TIME1,TIME3 Q
NOW K LRDTI I '$D(ZTQUEUED) S %DT("A")="Date and Time of collection: ",%DT="ETR" D TIME,DATE^LRWU Q:Y<0  I +Y'=DT W !,"Are you sure" S %=2 D YN^DICN I %'=1 W:%=0 !,"The date should be today's date." G NOW:%=0 Q
 I $D(ZTQUEUED) S %DT="T" D TIME S X=%DT("B") D ^%DT
 S LRDTI=Y Q
TIME S Y=$O(^LAB(69.9,1,4,"AC",$P($H,",",2))),Y=$S(Y>0:$O(^(Y,0)),1:Y) I Y'>0 S %DT("B")="NOW" Q
 S Y=$P(^LAB(69.9,1,4,Y,0),U,2)
 S Z=$S(+$E(Y,1,2)>11:"PM",1:"AM"),Y=$E(Y_0,1,2)-$S($E(Y_0,1,2)=12:0,Z="PM":12,1:0)_":"_$E(Y_"000",3,4)_Z
 S %DT("B")="T@"_Y
 Q
RUNING W:'$D(ZTQUEUED) !!,"ALREADY RUNNING.",!! Q
ROLL ;ROLLOVER NOT FINISHED OR NOT RUN...BLOCKS COLLECTION LIST
 W @IOF S X="N",%DT="ET" D ^%DT
 I $P(^LAB(69.9,1,"RO"),U,2)>0 W:'$D(ZTQUEUED) !,"CAN'T BUILD COLLECTION LIST WHILE ROLLOVER IS STILL RUNNING!",!,"Contact IRM for the reason ROLLOVER is still running, then manually build the collection list." S LREND=1 Q
 I $P(^LAB(69.9,1,"RO"),U)<$P($H,",") W:'$D(ZTQUEUED) !,"I NEED TO RUN ROLLOVER BEFORE BUILDING THE COLLECTION LIST!",!,"After ROLLOVER completes, I will build the collection list." D ^LROLOVER Q
