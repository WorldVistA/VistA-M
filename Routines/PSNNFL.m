PSNNFL ;BIR/WRT-Report of National Formulary Names from VA PRODUCT file ; 11/01/99 7:20
 ;;4.0; NATIONAL DRUG FILE;**3,22**; 30 Oct 98
PRELIM W !,"This report will print out all National Formulary marked for National",!,"Formulary. You may sort by National Formulary Name or by VA Class.",!
 W "This information comes from the VA Product file.",!,"This report requires 132 columns. You may queue the report to print,",!,"if you wish.",!!
ASK K DIR S DIR(0)="SA^C:CLASS;N:NAME",DIR("A")="Sort by VA Class (C) or National Formulary Name (N)? " D ^DIR Q:$D(DIRUT)
 I Y(0)="NAME" S PSNANS=Y(0) G DVC
 I Y(0)="CLASS" S PSNANS=Y(0) G ^PSNNFL1
 Q
DVC K IO("Q"),%ZIS,POP,IOP S %ZIS="QM",%ZIS("B")="",%ZIS("A")="Select Printer: " D ^%ZIS G:POP DONE W:$E(IOST)'="P" !!,"This report must be run on a printer.",!! G:$E(IOST)'="P" DVC I POP K IOP,POP,IO("Q") Q
QUEUE I $D(IO("Q")) K IO("Q") S ZTRTN="ENQ^PSNNFL" K ZTSAVE,ZTDTH,ZTSK S PSNDEV=ION_";"_IOST_";"_IOM_";"_IOSL,ZTSAVE("PSNDEV")="",ZTSAVE("PSNANS")="",ZTDESC="National Formulary Report",ZTIO=""
 I  D ^%ZTLOAD K MJT,%ZIS,POP,IOP,ZTSK D ^%ZISC Q
ENQ ;ENTRY POINT WHEN QUEUED
 D LOOPA
 I $D(ZTQUEUED) D QUEUE1
 U IO
ENQ1 S PSNPGCT=0,PSNPGLNG=IOSL-6
 D TITLE,LOOP1 W @IOF G DONE
TITLE I $D(IOF),IOF]"" W @IOF S PSNPGCT=PSNPGCT+1
 W !,?37,"VHA NATIONAL FORMULARY    (BY NAME)"
 S X="T" D ^%DT X ^DD("DD") W ?85,"Date printed: ",Y,!!,"R   Indicates that a Restriction exists for the Product.",?85,"Page: ",PSNPGCT,!!
 W !,"NATIONAL FORMULARY NAME",?100,"VA CLASS",?110,"RESTRICTION",!
 F MJT=1:1:132 W "-"
 Q
DONE S:$D(ZTQUEUED) ZTREQ="@" K ^TMP($J,"PSNF"),PSNB,PSNFLG,PSNAME,REST,RESTSS,PSNAR,PSNFF,PSNFG,PSNGG,PSNPR,PSNATF,PSNPGCT,PSNPGLNG,ZTRTN,Y,PSNDEV,MJT,CLASS,PSNKK,PC,RS,PSNFLG,PSNFLG1,X0,DA,NA,CL,CLNM,DIR
 K PSNANS,SF,DU,PSNANSR,PSNTRD,PSNUM,PSNDATE,X,IOP,POP,IO("Q") W:$Y @IOF D ^%ZISC
 Q
QUEUE1 S IOP=PSNDEV F  D ^%ZIS Q:'POP  H 20
 Q
LOOP S X0=^PSNDF(50.68,DA,0) I $D(^PSNDF(50.68,DA,5)),$P(^PSNDF(50.68,DA,5),"^")=1 S NA=$P(X0,"^",6),CL=$P(^PSNDF(50.68,DA,3),"^"),CL=$P($G(^PS(50.605,+CL,0)),"^"),RS=" " D CHECK S ^TMP($J,"PSNF",NA,CL,RS)=""
 Q
LOOPA K ^TMP($J,"PSNF") S DA=0 F  S DA=$O(^PSNDF(50.68,DA)) Q:'DA  D LOOP
 Q
LOOP1 S PSNATF="" F  S PSNATF=$O(^TMP($J,"PSNF",PSNATF)) Q:PSNATF=""  S PSNFLG=1 D LOOP2
 Q
LOOP2 S CLASS="" F  S CLASS=$O(^TMP($J,"PSNF",PSNATF,CLASS)) Q:CLASS=""  D LOOP3
 Q
LOOP3 S REST="" F  S REST=$O(^TMP($J,"PSNF",PSNATF,CLASS,REST)) Q:REST=""  D WRITE
 Q
WRITE D:$Y>PSNPGLNG TITLE W:PSNFLG !,PSNATF S PSNFLG=0 W ?100,CLASS,?110,REST,!
 Q
CHECK I $D(^PSNDF(50.68,DA,6)) S PC=$P(^PSNDF(50.68,DA,6,1,0),"^") I $E(PC,1,1)'="*" S RS="R"
 Q
