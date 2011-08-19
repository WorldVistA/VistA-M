ANRVML4 ;BIRM/LDT - VIST MAILING LABELS BY PATIENT ; 27 Apr 98 / 9:20 AM
 ;;4.0; Visual Impairment Service Team ;;12 Jun 98
EN1 ;Entry point for Mailing Labels by Patient.
 K ANRVLP W @IOF,!!,"MAILING LABLES BY PATIENT",!!
 D SEL I '$D(ANRVLP),SEL'="A" G QUIT
 K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!!" G QUIT
 I $D(IO("Q")) K IO("Q") S ZTDESC="VIST MAILING LABELS BY PATIENT",ZTRTN="DEQ^ANRVML4" S:$D(ANRVLP) ZTSAVE("ANRVLP(")="" S:$D(SEL) ZTSAVE("SEL")=""
 I  D ^%ZTLOAD K ZTSK G QUIT
 U IO
DEQ ;Entry point when queued.
 S ANRVP=0 F  S ANRVP=$O(ANRVLP(ANRVP)) Q:'ANRVP  S DFN=$P($G(^ANRV(2040,ANRVP,0)),U) D 2^VADPT,MAILBL
 ;
QUIT K %,%H,%I,%T,%Y,ANRVP,ANRV,ANRVLP,DFN,SEL D KVAR^VADPT,KVA^VADPT
 W:$E(IOST)'="C" @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
MAILBL ;
 D ^ANRVML
 Q
 ;
SEL W !!,"Do you want to print the mailing lables for:",!?3,"(A)ll patients, or",!?3,"(S)elect patients",!!
 S DIR(0)="SAOBM^A:ALL;S:SELECTED",DIR("A")="Choose A or S: ",DIR("?")="^D HELPSEL^ANRVML4" D ^DIR K DIR
 S SEL=Y I SEL="A" G ANRVLP
 S:SEL="" SEL="^" G:SEL="^" QUIT2
 W !
ASKPT  S DIC="^ANRV(2040,",DIC(0)="QEAM",DIC("S")="I $P($G(^ANRV(2040,+Y,13)),U,2)'=""I""" D ^DIC K DIC I Y<0 Q
 S DFN=$P($G(^ANRV(2040,+Y,0)),U),ANRVP=+Y
 S ANRVLP(ANRVP)="" G ASKPT
QUIT2 K:SEL="^"!(SEL="") %,DIC,X,Y Q
HELPSEL ;
 W !!,"Enter ""A"" to print mailing labels for all patients.",!?6,"""S"" to select only specific patients.",!?6,"""^"" or <return> to halt." Q
ANRVLP ;Set ANRVLP for all patients who are not inactive for AMIS
 S JJ=0 F  S JJ=$O(^ANRV(2040,JJ)) Q:'JJ  I $P($G(^ANRV(2040,JJ,13)),U,2)'="I" S ANRVLP(JJ)=""
 Q
