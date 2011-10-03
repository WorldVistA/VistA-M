ANRVRP6 ;BIRM/LDT - VIST PERIOD OF SERVICE LIST ; 05 Aug 98 / 2:19 PM
 ;;4.0; Visual Impairment Service Team ;**1**;12 Jun 98
EN1 ;Entry point for Period of Service List
 K ANRVLP W @IOF,!!,"SORT BY PERIOD OF SERVICE",!!
 D SEL I '$D(ANRVLP),SEL'="A" G QUIT
 K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!!" G QUIT
 I $D(IO("Q")) K IO("Q") S ZTDESC="VIST ROSTER LIST BY PERIOD OF SERVICE",ZTRTN="DEQ^ANRVRP6" S:$D(ANRVLP) ZTSAVE("ANRVLP(")="" S:$D(SEL) ZTSAVE("SEL")=""
 I  D ^%ZTLOAD K ZTSK G QUIT
 U IO
DEQ ;Entry point when queued.
 K ^TMP("ANRV",$J)
 S ANRVP=0 F  S ANRVP=$O(^ANRV(2040,ANRVP)) Q:'ANRVP  I $P($G(^ANRV(2040,ANRVP,13)),U,2)'="I" S DFN=$P($G(^ANRV(2040,ANRVP,0)),U) D 2^VADPT,SETTMP
 S HDR="VIST ROSTER LIST BY PERIOD OF SERVICE"
 S (PG,QFLG)=0,$P(LN,"-",81)="",$P(LN2,"-",33)="" D NOW^%DTC S Y=$E(%,1,12) X ^DD("DD") S HDT=Y D HDR
 I '$D(^TMP("ANRV",$J)) W !,"NO DATA TO PRINT!" G QUIT
 D REPORT
 ;
QUIT K %,%H,%I,%T,%Y,ANRVP,ANRV,ANRVLP,DFN,HDR,HDT,LN,LN2,NAME,PG,POP,POS,POS2,QFLG,SEL,SUB,SUBCNT,TOTAL,X,Y,XX,DTOUT,DUOUT,DIRUT,^TMP("ANRV",$J) D KVAR^VADPT,KVA^VADPT
 W:$E(IOST)'="C" @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
SETTMP ;Set ^TMP for report
 I $D(ANRVLP),VAEL(2)]"",$D(ANRVLP($P(VAEL(2),U,2))) S ^TMP("ANRV",$J,$P(VAEL(2),U,2),VADM(1))=VADM(1)_U_$P(VADM(2),U,2)_U_$P(VAEL(2),U,2)
 I $D(SEL),SEL="A" S SUB=$S(VAEL(2)]"":$P(VAEL(2),U,2),1:"zzz"),^TMP("ANRV",$J,SUB,VADM(1))=VADM(1)_U_$P(VADM(2),U,2)_U_$P(VAEL(2),U,2)
 Q
 ;
HDR ;Report header
 I $E(IOST)="C",PG>0 S DIR(0)="E" D ^DIR K DIR I 'Y S QFLG=1 Q
 S PG=PG+1 W:$Y!($E(IOST)="C") @IOF Q:(PG>1)&($E(IOST)="C")  W !,HDR,?45,"Printed ",HDT,?72,"Page ",PG,!!,"NAME",?27,"SSN",?47,"PERIOD OF SERVICE",!,LN
 Q
 ;
REPORT ;Print Report
 S (POS,POS2,NAME)="",(TOTAL,SUBCNT)=0 F  S POS=$O(^TMP("ANRV",$J,POS)) Q:POS=""  F  S NAME=$O(^TMP("ANRV",$J,POS,NAME)) Q:NAME=""  D
 .Q:QFLG  D:$Y+5>IOSL HDR Q:QFLG  I POS'=POS2,POS2]"" W !?47,LN2,!,"Subcount",?50,$J(SUBCNT,4),! S SUBCNT=0
 .F XX=1:1:3 S ANRV(XX)=$P($G(^TMP("ANRV",$J,POS,NAME)),U,XX)
 .Q:QFLG  D:$Y+5>IOSL HDR Q:QFLG  W !,ANRV(1),?27,ANRV(2),?47,$S(ANRV(3)]"":ANRV(3),1:"NONE") S TOTAL=TOTAL+1,SUBCNT=SUBCNT+1
 .S POS2=POS
 Q:QFLG  W:POS="" !?47,LN2,!,"Subcount",?50,$J(SUBCNT,4) W !?47,LN2,!,"Count",?50,$J(TOTAL,4)
 Q
SEL W !!,"Do you want the report to list:",!?3,"(A)ll periods of service or",!?3,"(S)elect periods of service",!!
 S DIR(0)="SAOBM^A:ALL;S:SELECTED",DIR("A")="Choose A or S: ",DIR("?")="^D HELPSEL^ANRVRP6" D ^DIR K DIR
 S SEL=Y I SEL="A" Q
 S:SEL="" SEL="^" G:SEL="^" QUIT2
 W !
ASKPOS K X,Y S DIC(0)="QEAM",DIC="^DIC(21," D ^DIC K DIC
 I Y<0!($D(DTOUT))!($D(DUOUT)) G QUIT2
 I Y>0 D SETLP G ASKPOS
QUIT2 K %,DTOUT,DUOUT,X,Y Q
SETLP ;
 S ANRVLP($P(Y,U,2))=""
 Q
HELPSEL ;
 W !!,"Enter:",!?3,"""A"" to list patients for ALL periods of service from the VIST ROSTER file.",!?3,"""S"" to select only specific periods of service.",!?3,"""^"" or <return> to halt." Q
