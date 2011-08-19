ANRVRP4 ;BIRM/LDT - VIST ZIP CODE LIST ; 05 Aug 98 / 2:17 PM
 ;;4.0; Visual Impairment Service Team ;**1**;12 Jun 98
EN1 ;Entry point for Zip Code List
 K ANRVLP W @IOF,!!,"SORT BY ZIP CODE",!!
 D SEL I '$D(ANRVLP),SEL'="A" G QUIT
 K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!!" G QUIT
 I $D(IO("Q")) K IO("Q") S ZTDESC="VIST ROSTER LIST BY ZIP CODE",ZTRTN="DEQ^ANRVRP4" S:$D(ANRVLP) ZTSAVE("ANRVLP(")="" S:$D(SEL) ZTSAVE("SEL")=""
 I  D ^%ZTLOAD K ZTSK G QUIT
 U IO
DEQ ;Entry point when queued.
 K ^TMP("ANRV",$J)
 S ANRVP=0 F  S ANRVP=$O(^ANRV(2040,ANRVP)) Q:'ANRVP  I $P($G(^ANRV(2040,ANRVP,13)),U,2)'="I" S DFN=$P($G(^ANRV(2040,ANRVP,0)),U) D 4^VADPT,SETTMP
 S HDR="VIST ROSTER LIST BY ZIP CODE"
 S (PG,QFLG)=0,$P(LN,"-",81)="" D NOW^%DTC S Y=$E(%,1,12) X ^DD("DD") S HDT=Y D HDR
 I '$D(^TMP("ANRV",$J)) W !,"NO DATA TO PRINT!" G QUIT
 D REPORT
 ;
QUIT K %,%H,%I,%T,%Y,ANRV,ANRVLPP,ANRVP,DFN,HDR,HDT,LN,NAME,ZIP,ZIP2,PG,POP,QFLG,SEL,SUB,X,Y,XX,DTOUT,DUOUT,DIRUT,^TMP("ANRV",$J) D KVAR^VADPT,KVA^VADPT
 W:$E(IOST)'="C" @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
SETTMP ;Set ^TMP for report
 I $D(ANRVLP),VAPA(11)]"",$D(ANRVLP(VAPA(6))) S ^TMP("ANRV",$J,"A"_VAPA(6),VADM(1))=VADM(1)_U_$P(VADM(2),U,2)_U_VAPA(4)_U_$S($P(VAPA(11),U,2)]"":$P(VAPA(11),U,2),1:$P(VAPA(11),U))
 I $D(SEL),SEL="A" S SUB=$S(VAPA(11)]"":"A"_VAPA(6),1:"zzz"),^TMP("ANRV",$J,SUB,VADM(1))=VADM(1)_U_$P(VADM(2),U,2)_U_VAPA(4)_U_$S($P(VAPA(11),U,2)]"":$P(VAPA(11),U,2),1:$P(VAPA(11),U))
 Q
 ;
HDR ;Report header
 I $E(IOST)="C",PG>0 S DIR(0)="E" D ^DIR K DIR I 'Y S QFLG=1 Q
 S PG=PG+1 W:$Y!($E(IOST)="C") @IOF Q:(PG>1)&($E(IOST)="C")  W !,HDR,?46,"Printed ",HDT,?72,"Page ",PG,!!,"NAME",?27,"SSN",?46,"CITY",?64,"ZIP CODE",!,LN
 Q
 ;
REPORT ;Print Report
 S (ZIP,ZIP2,NAME)="" F  S ZIP=$O(^TMP("ANRV",$J,ZIP)) Q:ZIP=""  F  S NAME=$O(^TMP("ANRV",$J,ZIP,NAME)) Q:NAME=""  D
 .Q:QFLG  D:$Y+5>IOSL HDR Q:QFLG  I ZIP'=ZIP2,ZIP2]"" W !
 .F XX=1:1:4 S ANRV(XX)=$P($G(^TMP("ANRV",$J,ZIP,NAME)),U,XX)
 .Q:QFLG  D:$Y+5>IOSL HDR Q:QFLG  W !,ANRV(1),?27,ANRV(2),?46,ANRV(3),?64,$S(ANRV(4)]"":ANRV(4),1:"NONE")
 .S ZIP2=ZIP
 Q:QFLG  W !
 Q
SEL W !!,"Do you want the report to list:",!?3,"(A)ll zip codes or",!?3,"(S)elect zip codes",!!
 S DIR(0)="SAOBM^A:ALL;S:SELECTED",DIR("A")="Choose A or S: ",DIR("?")="^D HELPSEL^ANRVRP4" D ^DIR K DIR
 S SEL=Y I SEL="A" Q
 S:SEL="" SEL="^" G:SEL="^" QUIT2
 W !
ASKZIP S DIR(0)="FAO^5:5^K:$A(X)=45 X",DIR("A")="Select ZIP CODE: ",DIR("?")="^D HELPZIP^ANRVRP4" D ^DIR K DIR
 I Y]"",Y'="^"  D SETLP G ASKZIP
QUIT2 K:SEL="^"!(SEL="") %,DIR,X,Y Q
SETLP ;
 S ANRVLP(Y)=""
 Q
HELPSEL ;
 W !!,"Enter:",!?3,"""A"" to list patients for ALL zip codes from the VIST ROSTER file.",!?3,"""S"" to select only specific zip code(s).",!?3,"""^"" or <return> to halt." Q
HELPZIP ;
 W !!,"Enter the zip code [5 characters] that you wish to select." Q
