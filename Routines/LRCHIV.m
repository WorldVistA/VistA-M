LRCHIV ;SLC/RWF - SET UP O("S") VARIABLES FOR ARCHIVE. ;2/5/91  12:30 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
EN01 ;
SEARCH ;
 D FLAG G RESTART:F1=1
 I F1>1 W !,"Please finish the Clear and Purge steps first." G QUIT
 I F1=0 S:'$D(^LAB(69.9,1,6,0)) ^LAB(69.9,1,6,0)="^69.9003A^^" D TAPE G QUIT:DA<1
 G QUIT:P1<1 D DEV G QUIT:POP S LRDFN=0
PAT W !,"Do you want a list of patients that will have data archived" S %=2 D YN^DICN I %=0 W !,"Answering YES to this question will produce a list of patients that will have data archived." G PAT
 S LRPAT=0 S:%=1 LRPAT=1
T S ^LAB(69.9,1,"TAPE")=P1,$P(^LAB(69.9,1,6,P1,0),U,4)=1,X=1
 I $D(IO("Q")) S ZTRTN="DQ1^LRCHIV" F I="F1","P1","LR(","LRDFN","LRPAT" S ZTSAVE(I)=""
 I $D(IO("Q")) D ^%ZTLOAD K IO("Q") G QUIT
DQ1 U IO S C1=1,C2=0,C3=0,Y=LR(1) D DD^LRX W @IOF,!,"LAB DATA ARCHIVED for data before ",Y W ". on" D STAMP^LRX S X=1 X ^%ZOSF("PRIORITY")
 S LRSUB=1 F  S LRSUB=$O(^DD(63.04,LRSUB)) Q:LRSUB<1  I $D(^(LRSUB,0)),'$D(^DD(63.999904,LRSUB)) S X0=^DD(63.04,LRSUB,0),X3=$S($D(^(3)):^(3),1:""),^DD(63.999904,LRSUB,0)=X0 S:X3'="" ^(3)=X3 S ^DD(63.999904,"B",$P(X0,U),LRSUB)=""
 K X,Y,L1,L2
 L +^LAR D DFN^LRCHIVE S $P(^LAB(69.9,1,6,P1,0),U,4)=2 L -^LAR
LST I LRPAT W @IOF S PNM="" F  S PNM=$O(^LAR("NAME",PNM)) Q:PNM=""  S LRDFN=0 F  S LRDFN=$O(^LAR("NAME",PNM,LRDFN)) Q:LRDFN<1  D
 . I $D(^LR(LRDFN,0))#2 N PNM S LRDPF=$P(^LR(LRDFN,0),"^",2),DFN=$P(^(0),"^",3) D DEM^LRX W !,PNM,?30,SSN
 . I '$D(^LR(LRDFN,0))#2 W !!,PNM," LRDFN # "_LRDFN_" Has Been Deleted from ^LR( ",!,$C(7),"SSN = Unknown",!
QUIT D KILL D ^%ZISC,KVAR^VADPT K F1,C1,C2,C3 U IO(0) Q
RESTART W !,"Search not complete." L +^LAR:1 I '$T W !,"Searching in progress, please wait for it to finish." G QUIT
 L -^LAR
 W !,"Do you want to restart the search" S %=1 D YN^DICN I %'=1 W:%=0 !,"Continue where the last search stopped." G RESTART:%=0,QUIT
 D DEV G QUIT:POP S LRDFN=$S($D(^LAB(69.9,1,"LRDFN")):^("LRDFN"),1:0) G PAT
TAPE S DA=0,DIC="^LAB(69.9,1,6,",DIC(0)="AEMQL",DLAYGO=69 D ^DIC K DLAYGO Q:Y<1  S DA=+Y I '$P(Y,U,3) W !,"You must create a NEW name for this ARCHIVE." G TAPE
DT S %DT("A")="Archive DATE: ",%DT("B")="T-90",%DT="AEQ" D ^%DT I Y<1 W !,"OK, lets forget it." S DA=-1 Q
 S LR(1)=$E(Y,1,5)_"00",LR(2)=9999999-LR(1),X1=LR(1),X2=-365 D C^%DTC S LR(3)=9999999-X
 S P1=DA,DIE=DIC,DR="1;2///N;4///"_LR(1) D ^DIE K DIC Q
EN02 ;
CLEAN ;REMOVE ^LAR FOR READ TAPE IN
 W !,"I will now CLEAR out the global"
 D FLAG I F1<2 W !,"Search pass has not completed. Want to CLEAR ^LAR anyway" S %=1 D YN^DICN G QUIT:%'=1
 S X="" F I=0:0 S X=$O(^LAR(X)) Q:X=""  K ^LAR(X)
 S ^LAR("Z",0)="ARCHIVED LR DATA^63.9999"
 I P1,$P(^LAB(69.9,1,6,P1,0),U,4)=2 S $P(^(0),U,4)=3
 W !!,"Now read the tape back in to make sure we have a good tape."
 W !,"Then do the PURGE pass." Q
EN03 ;
PURGE ;PURGE DATA FROM ^LR THAT IS IN ^LAR
 D FLAG
 I F1<3 W !,"You have not done the clear and reload of the global yet.",$C(7) Q
 I F1'=3 W !,"PURGE in progress, or completed. Please let it finish." Q
 D DEV G QUIT:POP
 I $D(IO("Q")) K IO("Q") S ZTRTN="DQ2^LRCHIV",ZTSAVE("P1")="",ZTSAVE("F1")="",ZTSAVE("LR(")="" D ^%ZTLOAD G QUIT
DQ2 I $P(^LAB(69.9,1,6,P1,0),U,4)'=3 W !!,"Not in the right state.",!! G QUIT
 S $P(^LAB(69.9,1,6,P1,0),U,4)=4 D EN^LRCHIVK S $P(^LAB(69.9,1,6,P1,0),U,4)=5
 K ^LAR("NAME"),^LAR("SSN"),^LAR("Z"),^LAB(69.9,1,"TAPE"),^LAB(69.9,1,"LRDFN"),^LAB(69.9,1,"PURGE LRDFN") S ^LAR("Z",0)="ARCHIVED LR DATA^63.9999" G QUIT
FLAG S U="^",P1=$S($D(^LAB(69.9,1,"TAPE")):^("TAPE"),1:0),F1=$S($D(^LAB(69.9,1,6,P1,0)):$P(^(0),U,4),1:0)
 I P1,F1 S LR(1)=$P(^LAB(69.9,1,6,P1,0),U,5),LR(2)=9999999-LR(1),X1=LR(1),X2=-365 D C^%DTC S LR(3)=9999999-X
 Q
DEV S %ZIS="Q" S:'$D(%ZIS("A")) %ZIS("A")="ERROR LOG REPORT: " D ^%ZIS K %ZIS Q
 Q
KILL W ! W:$E(IOST,1,2)="P-" @IOF
 S ZTQUE="@" D ^%ZISC K I,J,LRPAT,LRDAT,LRDPF,LRIDT,LRSS,LRSUB,P1,PNM,SSN,X0,X1,X2,X3,ZTSK,ZTRTN,ZTIO,ZTDESC,ZTSAVE
 Q
PRT ;
 S %ZIS="Q",%ZIS("A")="Printer " D DEV I POP D KILL Q
 S LRPAT=1 I $D(IO("Q")) S ZTRTN="LST^LRCHIV",ZTSAVE("LRPAT")="",ZTDESC="Print Archive Patients" D ^%ZTLOAD G KILL
 D LST G KILL
