ECXXREV ;ALB/JAP,BIR/DMA-Status Report from the Extract Log ; [ 05/29/96  5:38 PM ]
 ;;3.0;DSS EXTRACTS;**8**;Dec 22, 1997
EN ;entry point from option
 N EC,EC0,ECM,ECXDIQ,X,Y,DIC,DIQ,DR,POP
 S DIC=727,DIC(0)="AEQMZ" D ^DIC K DIC
 Q:Y<0
 S EC=+Y,EC0=Y(0)
 D SHOW
 K IO("Q") S %ZIS="Q" D ^%ZIS K %ZIS
 Q:POP 
 I $D(IO("Q")) D  Q
 .S ZTSAVE("EC")="",ZTSAVE("EC0")="",ZTDESC="DSS Extract Status Report",ZTRTN="START^ECXXREV"
 .D ^%ZTLOAD
 D START W !!
 G EN
 Q
 ;
START ;queued entry
 N ECXDIQ,ECXRUN,C,L,LN,PG,QFLG
 U IO
 S $P(LN,"-",80)="",PG=0,QFLG=0
 D NOW^%DTC S Y=$E(%,1,12) D DD^%DT S ECXRUN=Y
 D HDR
 D SHOW
 W !,"Purged:      ",$S(ECXDIQ(727,EC,9,"E")]"":ECXDIQ(727,EC,9,"E"),1:"(Not purged)")
 W !,"Transmitted: ",$S(ECXDIQ(727,EC,300,"E")]"":ECXDIQ(727,EC,300,"E"),1:"(Not transmitted)")
 I ECXDIQ(727,EC,300,"E")]"" D
 .I '$O(^ECX(727,EC,1,0)) W !,"All transmission messages confirmed." Q
 .W !,"Unconfirmed transmission message numbers --"
 .F ECM=0:0 S ECM=$O(^ECX(727,EC,1,ECM)) Q:'ECM  D  Q:QFLG
 ..W !,ECM
 ..S ECM=$O(^ECX(727,EC,1,ECM)) I 'ECM S QFLG=1 Q
 ..W ?20,ECM
 ..S ECM=$O(^ECX(727,EC,1,ECM)) I 'ECM S QFLG=1 Q
 ..W ?40,ECM
 ..I $Y+3>IOSL D HDR Q:QFLG
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" K IO("Q")
 Q
 ;
HDR ;header
 N JJ,SS
 I $E(IOST)="C" D
 .S SS=22-$Y F JJ=1:1:SS W !
 .I PG>0 S DIR(0)="E" W ! D ^DIR K DIR S:'Y QFLG=1
 Q:QFLG
 W:$Y @IOF S PG=PG+1
 W !,"Status Report for DSS Extract #",EC," ("_$P(EC0,U,3)_")"
 I $E(IOST)'="C" W !,"Printed: ",ECXRUN,?68,"Page: ",PG
 W !,LN
 I PG>1 W !,"Unconfirmed transmission message numbers (con.t) --",!
 Q
 ;
SHOW ;get data on extract
 S DIC="^ECX(727,",DR="1;6;3;4;5;9;15;300",DA=+EC,DIQ(0)="E",DIQ="ECXDIQ" D EN^DIQ1
 W !!,ECXDIQ(727,EC,6,"E")_" Extract (#"_EC_")",?42,"Records:    ",ECXDIQ(727,EC,5,"E")
 W !,"Generated:   ",ECXDIQ(727,EC,1,"E"),?42,"Start date: ",ECXDIQ(727,EC,3,"E")
 W !,"Division:    ",$E(ECXDIQ(727,EC,15,"E"),1,26),?42,"End date:   ",ECXDIQ(727,EC,4,"E")
 Q
