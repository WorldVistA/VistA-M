ANRVRP7 ;BIRM/LDT - VIST ROSTER PRINTOUT ; 27 Apr 98 / 9:20 AM
 ;;4.0; Visual Impairment Service Team ;;12 Jun 98
EN1 ;Entry point for Roster Printout.
 K ANRVLP W @IOF,!!,"VIST ROSTER PRINTOUT",!!
 D SEL I '$D(ANRVLP),SEL'="A" G QUIT
 W !!,"The right margin for this report is 132.",!
 K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!!" G QUIT
 I $D(IO("Q")) K IO("Q") S ZTDESC="VIST ROSTER PRINTOUT",ZTRTN="DEQ^ANRVRP7" S:$D(ANRVLP) ZTSAVE("ANRVLP(")="" S:$D(SEL) ZTSAVE("SEL")=""
 I  D ^%ZTLOAD K ZTSK G QUIT
 U IO
DEQ ;Entry point when queued.
 K ^TMP("ANRV",$J)
 S ANRVP=0 F  S ANRVP=$O(ANRVLP(ANRVP)) Q:'ANRVP  S DFN=$P($G(^ANRV(2040,ANRVP,0)),U) D 2^VADPT,SETTMP
 S HDR="VIST ROSTER PRINTOUT"
 S (PG,QFLG)=0,$P(LN,"-",133)="" D NOW^%DTC S Y=$E(%,1,12) X ^DD("DD") S HDT=Y D HDR
 I '$D(^TMP("ANRV",$J)) W !,"NO DATA TO PRINT!" G QUIT
 D REPORT
 ;
QUIT K %,%H,%I,%T,%Y,ANRVP,ANRV,ANRVLP,DFN,HDR,HDT,JJ,LN,NAME,PG,POP,SEL,QFLG,X,Y,XX,^TMP("ANRV",$J) D KVAR^VADPT,KVA^VADPT
 W:$E(IOST)'="C" @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
SETTMP ;Set TMP global
 S:VADM(6)="" ^TMP("ANRV",$J,VADM(1))=VADM(1)_U_$P(VADM(2),U,2)_U_$P($G(^ANRV(2040,ANRVP,13)),U,2)_U_$P(VAEL(2),U,2)_U_$G(^ANRV(2040,ANRVP,2))
 Q
 ;
HDR ;Report header
 I $E(IOST)="C",PG>0 S DIR(0)="E" D ^DIR K DIR I 'Y S QFLG=1 Q
 S PG=PG+1 W:$Y!($E(IOST)="C") @IOF Q:(PG>1)&($E(IOST)="C")  W !,HDR,?73,"Printed ",HDT,?100,"Page ",PG,!!,"NAME",?27,"SSN",?47,"VIST ELIGIBLE",?73,"PERIOD OF",?93,"VIST ELIGIBILITY"
 W !?73,"SERVICE",!,LN
 Q
 ;
REPORT ;Print Report
 S NAME="" F  S NAME=$O(^TMP("ANRV",$J,NAME)) Q:NAME=""  D:$Y+13>IOSL HDR Q:QFLG  D
 .F XX=1:1:5 S ANRV(XX)=$P($G(^TMP("ANRV",$J,NAME)),U,XX)
 .D:$Y+13>IOSL HDR Q:QFLG  W !,ANRV(1),?27,ANRV(2),?47,$S(ANRV(3)="001":"YES (001)",ANRV(3)="002":"NO - REVIEWED FOR BRC",ANRV(3)="003":"NO - OTHER (003)",ANRV(3)="NO":"NO - NOT LEGALLY BLIN",1:""),?73,ANRV(4),?93,ANRV(5)
 Q
SEL W !!,"Do you want the report to list:",!?3,"(A)ll patients, or",!?3,"(S)elect patients",!!
 S DIR(0)="SAOBM^A:ALL;S:SELECTED",DIR("A")="Choose A or S: ",DIR("?")="^D HELPSEL^ANRVRP7" D ^DIR K DIR
 S SEL=Y I SEL="A" G ANRVLP
 S:SEL="" SEL="^" G:SEL="^" QUIT2
 W !
ASKPT  S DIC="^ANRV(2040,",DIC(0)="QEAM",DIC("S")="I $P($G(^ANRV(2040,+Y,13)),U,2)'=""I""" D ^DIC K DIC I Y<0 Q
 S DFN=$P($G(^ANRV(2040,+Y,0)),U),ANRVP=+Y D DEM^VADPT I VADM(6) W !?5,"Patient died "_$P($P(VADM(6),"^",2),"@")_"." G ASKPT
 S ANRVLP(ANRVP)="" G ASKPT
QUIT2 K:SEL="^"!(SEL="") %,DIC,X,Y Q
HELPSEL ;
 W !!,"Enter ""A"" to select all patients from the VIST ROSTER file.",!?6,"""S"" to select only specific patients.",!?6,"""^"" or <return> to halt." Q
ANRVLP ;Set ANRVLP for all patients who are not inactive for AMIS
 S JJ=0 F  S JJ=$O(^ANRV(2040,JJ)) Q:'JJ  I $P($G(^ANRV(2040,JJ,13)),U,2)'="I" S ANRVLP(JJ)=""
 Q
