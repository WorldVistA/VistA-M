ANRVML2 ;BIRM/LDT - VIST MAILING LABELS BY CITY ; 28 Feb 98 / 2:38 PM
 ;;4.0; Visual Impairment Service Team ;;12 Jun 98
EN1 ;Entry point for City List
 K ANRVLP W @IOF,!!,"MAILING LABELS BY CITY",!!
 D SEL I '$D(ANRVLP),SEL'="A" G QUIT
DEV K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!!" G QUIT
 I $D(IO("Q")) K IO("Q") S ZTDESC="VIST MAILING LABELS BY CITY",ZTRTN="DEQ^ANRVML2" S:$D(ANRVLP) ZTSAVE("ANRVLP(")="" S:$D(SEL) ZTSAVE("SEL")=""
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
 I $D(ANRVLP),VAPA(4)]"",$D(ANRVLP(VAPA(4))) D ^ANRVML
 I $D(SEL),SEL="A" D ^ANRVML
 Q
 ;
SEL W !!,"Do you want to print the mailing labels for:",!?3,"(A)ll cities or",!?3,"(S)elect city/cities",!!
 S DIR(0)="SAOBM^A:ALL;S:SELECTED",DIR("A")="Choose A or S: ",DIR("?")="^D HELPSEL^ANRVML2" D ^DIR K DIR
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
 W !!,"Enter:",!?3,"""A"" to print mailing labels for ALL cities.",!?3,"""S"" to select only a specific city or cities.",!?3,"""^"" or <return> to halt." Q
