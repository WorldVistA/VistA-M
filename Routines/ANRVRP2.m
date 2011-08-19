ANRVRP2 ;BIRM/LDT - VIST COUNTY LIST ; 18 Sep 98 / 8:37 AM
 ;;4.0; Visual Impairment Service Team ;**1**;12 Jun 98
EN1 ;Entry point for County List
 K ANRVLP W @IOF,!!,"SORT BY COUNTY",!!
 D SEL I '$D(ANRVLP),SEL'="A" G QUIT
 K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!!" G QUIT
 I $D(IO("Q")) K IO("Q") S ZTDESC="VIST ROSTER LIST BY COUNTY",ZTRTN="DEQ^ANRVRP2" S:$D(ANRVLP) ZTSAVE("ANRVLP(")="" S:$D(SEL) ZTSAVE("SEL")=""
 I  D ^%ZTLOAD K ZTSK G QUIT
 U IO
DEQ ;Entry point when queued.
 K ^TMP("ANRV",$J)
 S ANRVP=0 F  S ANRVP=$O(^ANRV(2040,ANRVP)) Q:'ANRVP  I $P($G(^ANRV(2040,ANRVP,13)),U,2)'="I" S DFN=$P($G(^ANRV(2040,ANRVP,0)),U) D 4^VADPT,SETTMP
 S HDR="VIST ROSTER LIST BY COUNTY"
 S (PG,QFLG)=0,$P(LN,"-",81)="" D NOW^%DTC S Y=$E(%,1,12) X ^DD("DD") S HDT=Y D HDR
 I '$D(^TMP("ANRV",$J)) W !,"NO DATA TO PRINT!" G QUIT
 D REPORT
 ;
QUIT K %,%H,%I,%T,%Y,ANRVP,ANRV,ANRVLP,CNTY,CNTY2,DFN,DTOUT,DUOUT,DIRUT,HDR,HDT,LN,NAME,PG,POP,QFLG,SEL,SUB,X,Y,XX,^TMP("ANRV",$J) D KVAR^VADPT,KVA^VADPT
 W:$E(IOST)'="C" @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
SETTMP ;Set ^TMP for report
 I $D(ANRVLP),VAPA(7)]"",$P(VAPA(7),U,2)]"",$D(ANRVLP($P(VAPA(7),U,2))) S ^TMP("ANRV",$J,$P(VAPA(7),U,2),VADM(1))=VADM(1)_U_$P(VADM(2),U,2)_U_$P(VAPA(7),U,2)_U_$P($G(^DIC(5,+VAPA(5),1,+VAPA(7),0)),U,3)
 I $D(SEL),SEL="A" S SUB=$S($P(VAPA(7),U,2)]"":$P(VAPA(7),U,2),1:"zzz"),^TMP("ANRV",$J,SUB,VADM(1))=VADM(1)_U_$P(VADM(2),U,2)_U_$S(SUB="zzz":"",1:SUB)_U_$S(SUB="zzz":"",1:$P($G(^DIC(5,+VAPA(5),1,+VAPA(7),0)),U,3))
 Q
 ;
HDR ;Report header
 I $E(IOST)="C",PG>0 S DIR(0)="E" D ^DIR K DIR I 'Y S QFLG=1 Q
 S PG=PG+1 W:$Y!($E(IOST)="C") @IOF Q:(PG>1)&($E(IOST)="C")  W !,HDR,?45,"Printed ",HDT,?72,"Page ",PG,!!,"NAME",?27,"SSN",?47,"COUNTY",!,LN
 Q
 ;
REPORT ;Print Report
 S (CNTY,CNTY2,NAME)="" F  S CNTY=$O(^TMP("ANRV",$J,CNTY)) Q:CNTY=""  F  S NAME=$O(^TMP("ANRV",$J,CNTY,NAME)) Q:NAME=""  D
 .Q:QFLG  D:$Y+5>IOSL HDR Q:QFLG  I CNTY'=CNTY2 W !?10,"==> COUNTY: ",$S(CNTY="zzz":"UNSPECIFIED",1:CNTY),!
 .F XX=1:1:4 S ANRV(XX)=$P($G(^TMP("ANRV",$J,CNTY,NAME)),U,XX)
 .Q:QFLG  D:$Y+5>IOSL HDR Q:QFLG  W !,ANRV(1),?27,ANRV(2),?47,ANRV(3)_$S(CNTY="zzz":"",1:" ("_ANRV(4)_")")
 .S CNTY2=CNTY W !
 Q
SEL W !!,"Do you want the report to list:",!?3,"(A)ll counties or",!?3,"(S)elect county/counties",!!
 S DIR(0)="SAOBM^A:ALL;S:SELECTED",DIR("A")="Choose A or S: ",DIR("?")="^D HELPSEL^ANRVRP2" D ^DIR K DIR
 S SEL=Y I SEL="A" Q
 S:SEL="" SEL="^" G:SEL="^" QUIT2
 W !
ASKCTY S DIR(0)="FAO^1:30",DIR("A")="Select COUNTY NAME: " D ^DIR K DIR
 I Y]"",Y'="^"  D SETLP G ASKCTY
QUIT2 K:SEL="^"!(SEL="") %,DIR,X,Y Q
SETLP I Y?1U.E S ANRVLP($TR(Y,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ"))=""
 I Y?1L.E S ANRVLP($TR(Y,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ"))=""
 S ANRVLP(Y)=""
 Q
HELPSEL ;
 W !!,"Enter:",!?3,"""A"" to list patients for ALL counties from the VIST ROSTER file.",!?3,"""S"" to select only a specific county or counties.",!?3,"""^"" or <return> to halt." Q
