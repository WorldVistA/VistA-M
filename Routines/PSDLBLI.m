PSDLBLI ;BIR/JPW-CS Label Print for CS Inspectors Name ; 30 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 I '$D(^XUSEC("PSDMGR",DUZ)) W !!,"Contact your Pharmacy Coordinator.  You do not have the Supervisor",!,"access required to print labels.",!!,"PSDMGR security key required.",! Q
INSP ;ask inspector name
 W !!,?5,"You may select a single name or several names.",!
 W ! S PSDCNT=0 K DA,DIC
 F  S DIC=200,DIC(0)="QEA",DIC("A")="Select CS Inspectors Name: " D ^DIC K DIC Q:Y<0  D
 .S PSDTMP(+Y)="",PSDCNT=PSDCNT+1
 G:'$D(PSDTMP) END
DEV ;ask device and queue info
 W $C(7),!!,?3,"WARNING: The printing of these labels requires the use of a sheet fed",!,?12,"laser printer setup to create Controlled Substances",!,?12,"barcodes.",!
 W !,?12,"*** Check printer for LABEL paper before printing! ***",!
 W !!,"This report is designed for a 3 column label format.",!,"You may queue this report to print at a later time.",!!
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDLBLI",ZTDESC="Print Inspector Labels for CS PHARM" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO
START ;entry for compile and print labels
 K ^TMP("PSDLBLI",$J),PSDPRT
 F JJ=0,1 S @("PSDBAR"_JJ)="" I $D(^%ZIS(2,^%ZIS(1,IOS,"SUBTYPE"),"BAR"_JJ)) S @("PSDBAR"_JJ)=^("BAR"_JJ)
 I PSDBAR1]"",PSDBAR0]"" S PSDPRT=1
 F PSD=0:0 S PSD=$O(PSDTMP(PSD)) Q:'PSD  I $D(^VA(200,PSD,0)),$D(^VA(200,PSD,1)) D
 .S PSDN=$S($P($G(^VA(200,+PSD,0)),"^")]"":$P($G(^(0)),"^"),1:"UNKNOWN")
 .S SSN=$P($G(^VA(200,+PSD,1)),"^",9) S:SSN SSN="I"_$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9)
 .S ^TMP("PSDLBLI",$J,PSDN)=SSN
PRINT ;print labels
 S (PSDOUT,PSDCNT)=0,PSDX2=1
 S PSD="" F  S PSD=$O(^TMP("PSDLBLI",$J,PSD)) Q:PSD=""!(PSDOUT)  S PSDCNT=PSDCNT+1,TEMP(PSDCNT)=PSD,TEST(PSDCNT)=$P(^TMP("PSDLBLI",$J,PSD),"^") D:PSDCNT=3 PRINT1
 I PSDCNT,PSDCNT<3 D PRINT1
DONE I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSDOUT W ! K DIR,DIRUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu" D ^DIR K DIR
END ;kill variables and exit
 K %ZIS,ALL,DA,DIC,DIR,DIROUT,DIRUT,DRUG,DTOUT,DUOUT,JJ,JLP1,POP,PSD,PSDBAR0,PSDBAR1,PSDCNT,PSDN,PSDOUT,PSDPRT,PSDR,PSDTMP,PSDX1,PSDX2,SSN,TEMP,TEST,X,Y,ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK
 K ^TMP("PSDLBLI",$J)
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
SAVE ;save queued variables
 S ZTSAVE("PSDCNT")="" S:$D(ALL) ZTSAVE("ALL")=""
 S:$D(PSDTMP) ZTSAVE("PSDTMP(")=""
 Q
PRINT1 ;prints labels
 W ! F PSDX1=0:1:PSDCNT-1 W ?PSDX1*33+1,TEMP(PSDX1+1)
 I $D(PSDPRT) W !! F PSDX1=1:1:PSDCNT W @PSDBAR1,TEST(PSDX1),@PSDBAR0
 W ! F PSDX1=0:1:PSDCNT-1 W ?PSDX1*32+3,"Ins"
 W !!
 S PSDCNT=0,PSDX2=PSDX2+1 S:PSDX2=11 PSDX2=1
 Q
