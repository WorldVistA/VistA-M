ANRVML3 ;BIRM/LDT - VIST MAILING LABELS BY STATE ; 28 Feb 98 / 3:34 PM
 ;;4.0; Visual Impairment Service Team ;;12 Jun 98
EN1 ;Entry point for Mailing Labels by State
 K ANRVLP W @IOF,!!,"MAILING LABELS BY STATE",!!
 D SEL I '$D(ANRVLP),SEL'="A" G QUIT
 K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!!" G QUIT
 I $D(IO("Q")) K IO("Q") S ZTDESC="VIST MAILING LABELS BY STATE",ZTRTN="DEQ^ANRVML3" S:$D(ANRVLP) ZTSAVE("ANRVLP(")="" S:$D(SEL) ZTSAVE("SEL")=""
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
 I $D(ANRVLP),VAPA(5)]"",$D(ANRVLP($P(VAPA(5),U,2))) D ^ANRVML
 I $D(SEL),SEL="A" D ^ANRVML
 Q
 ;
SEL W !!,"Do you want to print the mailing labels for:",!?3,"(A)ll states or",!?3,"(S)elect states",!!
 S DIR(0)="SAOBM^A:ALL;S:SELECTED",DIR("A")="Choose A or S: ",DIR("?")="^D HELPSEL^ANRVML3" D ^DIR K DIR
 S SEL=Y I SEL="A" Q
 S:SEL="" SEL="^" G:SEL="^" QUIT2
 W !
ASKST K X,Y S DIC(0)="QEAM",DIC="^DIC(5," D ^DIC K DIC
 I Y<0!($D(DTOUT))!($D(DUOUT)) G QUIT2
 I Y>0 D SETLP G ASKST
QUIT2 K %,DTOUT,DUOUT,X,Y Q
SETLP S ANRVLP($P(Y,U,2))=""
 Q
HELPSEL ;
 W !!,"Enter:",!?3,"""A"" to print mailing labels for ALL states.",!?3,"""S"" to select only a specific state or states.",!?3,"""^"" or <return> to halt." Q
