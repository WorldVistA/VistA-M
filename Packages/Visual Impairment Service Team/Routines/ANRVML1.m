ANRVML1 ;BIRM/LDT - VIST MAILING LABELS BY COUNTY ; 28 Apr 98 / 12:59 PM
 ;;4.0; Visual Impairment Service Team ;;12 Jun 98
EN1 ;Entry point for Mailing Labels by County
 K ANRVLP W @IOF,!!,"MAILING LABELS BY COUNTY",!!
 D SEL I '$D(ANRVLP),SEL'="A" G QUIT
 K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!!" G QUIT
 I $D(IO("Q")) K IO("Q") S ZTDESC="VIST MAILING LABELS BY COUNTY",ZTRTN="DEQ^ANRVML1" S:$D(ANRVLP) ZTSAVE("ANRVLP(")="" S:$D(SEL) ZTSAVE("SEL")=""
 I  D ^%ZTLOAD K ZTSK G QUIT
 U IO
DEQ ;Entry point when queued.
 S ANRVP=0 F  S ANRVP=$O(^ANRV(2040,ANRVP)) Q:'ANRVP  I $P($G(^ANRV(2040,ANRVP,13)),U,2)'="I" S DFN=$P($G(^ANRV(2040,ANRVP,0)),U) D 4^VADPT,MAILBL
 ;
QUIT K %,%H,%I,%T,%Y,ANRVP,ANRV,ANRVLP,DFN,SEL D KVAR^VADPT,KVA^VADPT
 W:$E(IOST)'="C" @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
MAILBL ;
 I $D(ANRVLP),VAPA(7)]"",$D(ANRVLP($P(VAPA(7),U,2))) D ^ANRVML
 I $D(SEL),SEL="A" D ^ANRVML
 Q
 ;
SEL W !!,"Do you want to print the mailing labels for:",!?3,"(A)ll counties or",!?3,"(S)elect county/counties",!!
 S DIR(0)="SAOBM^A:ALL;S:SELECTED",DIR("A")="Choose A or S: ",DIR("?")="^D HELPSEL^ANRVML1" D ^DIR K DIR
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
 W !!,"Enter:",!?3,"""A"" to print mailing labels for ALL counties.",!?3,"""S"" to select only a specific county or counties.",!?3,"""^"" or <return> to halt." Q
