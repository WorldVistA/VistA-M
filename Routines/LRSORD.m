LRSORD ;SLC/RWF/DALISC/JBM - CRITICAL VALUE REPORT ; 8/30/87  17:25 ;
 ;;5.2;LAB SERVICE;**84**;Sep 27, 1994
EN ;
 D OPTIONS
 D:'LREND DEVICE
 I LREND D END^LRSORD1A Q
 D DQ
 Q
OPTIONS ;
 S LREDT="T-1",LREND=0 D ^LRWU3
 D GAA,SORTBY:'LREND,SELPAT:'LREND,SELLOC:'LREND
 Q
GAA S LRAA=0 W !
 K DIR,X,Y S DIR(0)="S^Y:YES;N:NO",DIR("B")="NO"
 S DIR("A")="Do you want to select accession areas (YES or NO) "
 S DIR("?")="Enter 'YES' to limit report to one or more accession areas."
 D ^DIR
 Q:Y="N"
 I ($D(DTOUT))!($D(DUOUT)) S LREND=1 Q
 K DIC S DIC=68,DIC(0)="AEMQZ"
 F  D ^DIC Q:Y=-1  D
 .S LRAA=+Y,LRAA($P(Y(0),U,11))=+Y
 I ($D(DTOUT))!($D(DUOUT)) S LREND=1 Q
 Q
SORTBY K DIR S DIR("B")="P",DIR("A")="Sort by PATIENT or by LOCATION"
 S DIR(0)="S^P:PATIENT;L:LOCATION",DIR("?")="Choose print sorting order."
 D ^DIR S:($D(DUOUT))!($D(DTOUT)) LREND=1 Q:LREND  S LRSRT=Y
 Q
SELPAT S LRPTS=0
 K DIC S DIC="^DPT(",DIC(0)="AEMQ",DIC("A")="Select PATIENT NAME: All//"
 F I=1:1 D ^DIC Q:Y=-1  S LRPTS(+Y)=$P(Y,U,2),DIC("A")="Select another PATIENT: ",LRPTS=I
 S:($D(DUOUT))!($D(DTOUT)) LREND=1
 Q
SELLOC S LRLCS=0
 K DIC S DIC="^SC(",DIC(0)="AEMQZ",DIC("A")="Select LOCATION: All//"
 F I=1:1 D ^DIC Q:Y=-1  D
 .S DIC("A")="Select another LOCATION: "
 .I '$L($P(Y(0),"^",2)) W !!,$P(Y,"^",2)," does not have an Abbreviation in the Hospital Location file.",! Q
 .S LRLCS($P(Y(0),U,2))=+Y,LRLCS=I
 .Q
 S:($D(DUOUT))!($D(DTOUT)) LREND=1
 Q
DEVICE ;
 I 'LREND D
 .S %ZIS="Q" D ^%ZIS S:POP LREND=1
 .I ($D(IO("Q")))&('LREND) D
 ..S ZTRTN="DQ^LRSORD",ZTSAVE("LR*")=""
 ..K IO("Q") D ^%ZTLOAD S LREND=1
 Q
DQ ;
 K ^TMP("LR",$J)
 S:$D(ZTQUEUED) ZTREQ="@" U IO
 S (LRPAG,LREND)=0,$P(LRDASH,"-",IOM)="-"
 K %DT S X="N",%DT="T" D ^%DT,DD^LRX S LRDATE=Y
 K %DT S X=$P(LRSDT,"."),%DT="X" D ^%DT,DD^LRX S LRSDAT=Y
 K %DT S X=LREDT,%DT="X" D ^%DT,DD^LRX S LREDAT=Y
 S LRHDR2="For date range: "_LREDAT_" to "_LRSDAT
 D BUILD^LRSORD1
 D ^LRSORD1A
 QUIT
