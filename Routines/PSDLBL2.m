PSDLBL2 ;B'ham ISC/JPW - CS Label Print for CS Nurses Name ; 27 Dec 93
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 S OK=$S($D(^XUSEC("PSDMGR",DUZ)):1,$D(^XUSEC("PSD ERROR",DUZ)):2,1:0)
 I 'OK W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to",!,?12,"the pending Controlled Substances error log.",! K OK Q
NUR ;ask nurse name
 W !!,?5,"You may select a single name, several names",!,?5,"or enter ""^ALL"" to select all names to be printed.",!!
 W ! S PSDCNT=0 K DA,DIC
 F  S DIC=200,DIC(0)="QEAM",DIC("S")="I $S($D(^XUSEC(""PSJ RNURSE"",+Y)):1,$D(^XUSEC(""PSD NURSE"",+Y)):1,1:0)",DIC("A")="Select Nurses Name: " D ^DIC K DIC Q:Y<0  D
 .S PSDTMP(+Y)="",PSDCNT=PSDCNT+1
 I '$D(PSDTMP)&(X'="^ALL") G END
 I X="^ALL" S ALL=1
DEV ;ask device and queue info
 W $C(7),!!,?3,"WARNING: The printing of these labels require the use of a sheet fed",!,?12,"laser printer setup to create Controlled Substances",!,?12,"barcodes.",!
 W !,?12,"*** Check Printer for LABEL paper before printing! ***",!
 W !!,"This report is designed for a 3 column label format.",!,"You may queue this report to print at a later time.",!!
 S PSDCPI=12
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDLBL2",ZTDESC="Print Nurses Labels for CS PHARM" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO
START ;entry for compile and print labels
 K ^TMP("PSDLBL2",$J),PSDPRT
 F JJ=0,1 S @("PSDBAR"_JJ)="" I $D(^%ZIS(2,+$G(IOST(0)),"BAR"_JJ)) S @("PSDBAR"_JJ)=^("BAR"_JJ)
 I PSDBAR1]"",PSDBAR0]"" S PSDPRT=1
 I $D(ALL) F PSDR=0:0 S PSDR=$O(^XUSEC("PSJ RNURSE",PSDR)) Q:'PSDR  I $D(^VA(200,PSDR,0)) S PSDTMP(+PSDR)="",PSDCNT=PSDCNT+1
 I $D(ALL) F PSDR=0:0 S PSDR=$O(^XUSEC("PSD NURSE",PSDR)) Q:'PSDR  I $D(^VA(200,PSDR,0)) S PSDTMP(+PSDR)="",PSDCNT=PSDCNT+1
 F PSD=0:0 S PSD=$O(PSDTMP(PSD)) Q:'PSD  I $D(^VA(200,PSD,0)),$D(^VA(200,PSD,1)) D
 .S PSDN=$S($P($G(^VA(200,+PSD,0)),"^")]"":$P($G(^(0)),"^"),1:"UNKNOWN")
 .S SSN=$P($G(^VA(200,+PSD,1)),"^",9) S:SSN SSN="N"_$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9)
 .S ^TMP("PSDLBL2",$J,PSDN)=SSN
PRINT ;print labels
 S (PSDOUT,PSDCNT)=0,PSDX2=1
 S PSD="" F  S PSD=$O(^TMP("PSDLBL2",$J,PSD)) Q:PSD=""!(PSDOUT)  S PSDCNT=PSDCNT+1,TEMP(PSDCNT)=PSD,TEST(PSDCNT)=$P(^TMP("PSDLBL2",$J,PSD),"^") D:PSDCNT=3 PRINT1
 I PSDCNT,PSDCNT<3 D PRINT1
DONE I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSDOUT W ! K DIR,DIRUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu" D ^DIR K DIR
END ;kill variables and exit
 K %ZIS,ALL,DA,DIC,DIR,DIROUT,DIRUT,DRUG,DTOUT,DUOUT,JJ,JLP1,OK,POP,PSD,PSDBAR0,PSDBAR1,PSDCNT,PSDN,PSDOUT,PSDCPI,PSDEV,PSDPRT
 K PSDR,PSDTMP,PSDX1,PSDX2,SSN,TEMP,TEST,X,Y,ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK
 K ^TMP("PSDLBL2",$J)
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
SAVE ;save queued variables
 S ZTSAVE("PSDCNT")="",ZTSAVE("PSDCPI")="" S:$D(ALL) ZTSAVE("ALL")=""
 S:$D(PSDTMP) ZTSAVE("PSDTMP(")=""
 Q
PRINT1 ;prints labels
 W ! F PSDX1=0:1:PSDCNT-1 W ?PSDX1*33+1,TEMP(PSDX1+1)
 I $D(PSDPRT) W !! F PSDX1=1:1:PSDCNT W @PSDBAR1,TEST(PSDX1),@PSDBAR0
 W ! F PSDX1=0:1:PSDCNT-1 W ?PSDX1*32+3,TEST(PSDX1+1)
 W !!
 S PSDCNT=0,PSDX2=PSDX2+1 S:PSDX2=11 PSDX2=1
 Q
