ANRVRP3 ;BIRM/LDT - VIST CITY LIST ; 05 Aug 98 / 2:16 PM
 ;;4.0; Visual Impairment Service Team ;**1**;12 Jun 98
EN1 ;Entry point for City List
 K ANRVLP W @IOF,!!,"SORT BY CITY",!!
 D SEL I '$D(ANRVLP),SEL'="A" G QUIT
DEV K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!!" G QUIT
 I $D(IO("Q")) K IO("Q") S ZTDESC="VIST ROSTER LIST BY CITY",ZTRTN="DEQ^ANRVRP3" S:$D(ANRVLP) ZTSAVE("ANRVLP(")="" S:$D(SEL) ZTSAVE("SEL")=""
 I  D ^%ZTLOAD K ZTSK G QUIT
 U IO
DEQ ;Entry point when queued.
 K ^TMP("ANRV",$J)
 S ANRVP=0 F  S ANRVP=$O(^ANRV(2040,ANRVP)) Q:'ANRVP  I $P($G(^ANRV(2040,ANRVP,13)),U,2)'="I" S DFN=$P($G(^ANRV(2040,ANRVP,0)),U) D 4^VADPT,SETTMP
 S HDR="VIST ROSTER LIST BY CITY"
 S (PG,QFLG)=0,$P(LN,"-",81)="",$P(LN2,"-",33)="" D NOW^%DTC S Y=$E(%,1,12) X ^DD("DD") S HDT=Y D HDR
 I '$D(^TMP("ANRV",$J)) W !,"NO DATA TO PRINT!" G QUIT
 D REPORT
 ;
QUIT K %,%H,%I,%T,%Y,ANRVP,ANRV,ANRVLP,CITY,CITY2,DFN,HDR,HDT,LN,LN2,NAME,PG,POP,QFLG,SEL,SUB,SUBCNT,TOTAL,X,Y,XX,DTOUT,DUOUT,DIRUT,^TMP("ANRV",$J) D KVAR^VADPT,KVA^VADPT
 W:$E(IOST)'="C" @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
SETTMP ;Set ^TMP for report
 I $D(ANRVLP),VAPA(4)]"",$D(ANRVLP(VAPA(4))) S ^TMP("ANRV",$J,VAPA(4),VADM(1))=VADM(1)_U_$P(VADM(2),U,2)_U_VAPA(4)
 I $D(SEL),SEL="A" S SUB=$S(VAPA(4)]"":VAPA(4),1:"zzz"),^TMP("ANRV",$J,SUB,VADM(1))=VADM(1)_U_$P(VADM(2),U,2)_U_VAPA(4)
 Q
 ;
HDR ;Report header
 I $E(IOST)="C",PG>0 S DIR(0)="E" D ^DIR K DIR I 'Y S QFLG=1 Q
 S PG=PG+1 W:$Y!($E(IOST)="C") @IOF Q:(PG>1)&($E(IOST)="C")  W !,HDR,?45,"Printed ",HDT,?72,"Page ",PG,!!,"NAME",?27,"SSN",?47,"CITY",!,LN
 Q
 ;
REPORT ;Print Report
 S (NAME,CITY,CITY2)="",(TOTAL,SUBCNT)=0 F  S CITY=$O(^TMP("ANRV",$J,CITY)) Q:CITY=""  F  S NAME=$O(^TMP("ANRV",$J,CITY,NAME)) Q:NAME=""  D
 .Q:QFLG  D:$Y+5>IOSL HDR Q:QFLG  I CITY'=CITY2,CITY2]"" W !?47,LN2,!,"Subcount",?50,$J(SUBCNT,4),! S SUBCNT=0
 .F XX=1:1:3 S ANRV(XX)=$P($G(^TMP("ANRV",$J,CITY,NAME)),U,XX)
 .Q:QFLG  D:$Y+5>IOSL HDR Q:QFLG  W !,ANRV(1),?27,ANRV(2),?47,$S(ANRV(3)]"":ANRV(3),1:"NONE") S TOTAL=TOTAL+1,SUBCNT=SUBCNT+1
 .S CITY2=CITY
 Q:QFLG  W:NAME="" !?47,LN2,!,"Subcount",?50,$J(SUBCNT,4) W !?47,LN2,!,"Count",?50,$J(TOTAL,4)
 Q
SEL W !!,"Do you want the report to list:",!?3,"(A)ll cities or",!?3,"(S)elect city/cities",!!
 S DIR(0)="SAOBM^A:ALL;S:SELECTED",DIR("A")="Choose A or S: ",DIR("?")="^D HELPSEL^ANRVRP3" D ^DIR K DIR
 S SEL=Y I SEL="A" Q
 S:SEL="" SEL="^" G:SEL="^" QUIT2
 W !
ASKCTY S DIR(0)="FAO^2:15",DIR("A")="Select CITY NAME: " D ^DIR K DIR
 I Y]"",Y'="^"  D SETLP G ASKCTY
QUIT2 K:SEL="^"!(SEL="") %,DIR,X,Y Q
SETLP I Y?1U.E S ANRVLP($TR(Y,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ"))="",ANRVLP($TR($E(Y,1),"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")_$E(Y,2,15))=""
 I Y?1L.E S ANRVLP($TR(Y,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ"))="",ANRVLP($TR($E(Y,1),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")_$E(Y,2,15))=""
 I Y?1U.E S ANRVLP($E(Y)_($TR($E(Y,2,15),"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")))="",ANRVLP($TR(Y,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz"))=""
 S ANRVLP(Y)=""
 Q
HELPSEL ;
 W !!,"Enter:",!?3,"""A"" to list patients for ALL cities from the VIST ROSTER file.",!?3,"""S"" to select only a specific city or cities.",!?3,"""^"" or <return> to halt." Q
