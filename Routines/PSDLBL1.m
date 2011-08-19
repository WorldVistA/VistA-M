PSDLBL1 ;BIR/JPW-CS Label Print for Vault Drugs ; 29 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 S OK=$S($D(^XUSEC("PSJ RPHARM",DUZ)):1,$D(^XUSEC("PSJ PHARM TECH",DUZ)):1,1:0)
 I 'OK W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to",!,?12,"print CS dispensing labels.",!!,"PSJ RPHARM or PSJ PHARM TECH security key required.",! K OK Q
ASKD ;ask disp location
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4)
 G:$P(PSDSITE,U,5) CHKD
 K DIC,DA S DIC=58.8,DIC(0)="QEAZ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)[""M"":1,$P(^(0),""^"",2)[""S"":1,1:0)"
 S DIC("A")="Select Primary Dispensing Site: ",DIC("B")=PSDSN
 D ^DIC K DIC G:Y<0 END
 S PSDS=+Y,PSDSN=$P(Y,"^",2),$P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
CHKD I '$O(^PSD(58.8,PSDS,1,0)) W !!,"There are no CS stocked drugs for your dispensing vault.",!! G END
DRUG ;ask drug
 W !!,?5,"You may select a single drug, several drugs,",!,?5,"or enter ^ALL to select all drugs.",!!
 W ! K DA,DIC
 F  S DIC("W")="W:$P(^PSDRUG(Y,0),""^"",9) ""   N/F"" I $P(^PSD(58.8,PSDS,1,Y,0),""^"",14)]"""",$P(^(0),""^"",14)'>DT W $C(7),""   *** INACTIVE ***""",DA(1)=+PSDS,DIC(0)="QEAM",DIC="^PSD(58.8,"_PSDS_",1," D ^DIC K DIC Q:Y<0  D
 .S PSDRG(+Y)=""
 I '$D(PSDRG)&(X'="^ALL") G END
 I X="^ALL" S ALL=1
DEV ;ask device and queue info
 W $C(7),!!,?3,"WARNING: The printing of these labels requires the use of a sheet fed",!,?12,"laser printer setup to create Controlled Substances",!,?12,"barcodes.",!
 W !,?12,"*** Check printer for LABEL paper before printing! ***",!
 W !!,"This report is designed for a 3 column label format.",!,"You may queue this report to print at a later time.",!!
 S Y=$P($G(^PSD(58.8,+PSDS,2)),"^",10),C=$P(^DD(58.8,24,0),"^",2) D Y^DIQ S PSDEV=Y
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")=PSDEV D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDLBL1",ZTDESC="Print Vault Labels for CS PHARM" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO
START ;entry for compile and print labels
 K ^TMP("PSDLBL1",$J),PSDPRT
 F JJ=0,1 S @("PSDBAR"_JJ)="" I $D(^%ZIS(2,^%ZIS(1,IOS,"SUBTYPE"),"BAR"_JJ)) S @("PSDBAR"_JJ)=^("BAR"_JJ)
 I PSDBAR1]"",PSDBAR0]"" S PSDPRT=1
 I $D(ALL) F PSD=0:0 S PSD=$O(^PSD(58.8,+PSDS,1,PSD)) Q:'PSD  S:$S('$P($G(^PSD(58.8,+PSDS,1,PSD,0)),U,14):1,$P($G(^(0)),U,4):1,$P($G(^(0)),U,14)>DT:1,1:0) PSDRG(PSD)=""
 F PSD=0:0 S PSD=$O(PSDRG(PSD)) Q:'PSD  I $D(^PSD(58.8,+PSDS,1,PSD,0)) D
 .S PSDRN=$S($P($G(^PSDRUG(+PSD,0)),"^")]"":$P($G(^(0)),"^"),1:"UNKNOWN")
 .S ^TMP("PSDLBL1",$J,PSDRN)=PSD
PRINT ;print labels
 S (PSDOUT,PSDCNT)=0,PSDX2=1
 S PSD="" F  S PSD=$O(^TMP("PSDLBL1",$J,PSD)) Q:PSD=""!(PSDOUT)  S PSDCNT=PSDCNT+1,TEMP(PSDCNT)=$E(PSD,1,28),TEST(PSDCNT)=$P(^TMP("PSDLBL1",$J,PSD),"^") D:PSDCNT=3 PRINT1
 I PSDCNT,PSDCNT<3 D PRINT1
DONE I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSDOUT W ! K DIR,DIRUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu" D ^DIR K DIR
END ;kill variables and exit
 K %ZIS,ALL,C,DA,DIC,DIR,DIROUT,DIRUT,DRUG,DTOUT,DUOUT,JJ,JLP1,OK,POP,PSD,PSDBAR0,PSDBAR1,PSDCNT,PSDEV,PSDOUT,PSDRG,PSDPRT,PSDRN,PSDS,PSDSN,PSDX1,PSDX2,TEMP,TEST,X,Y,ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK
 K ^TMP("PSDLBL1",$J)
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
SAVE ;save queued variables
 S:$D(ALL) ZTSAVE("ALL")=""
 S:$D(PSDRG) ZTSAVE("PSDRG(")=""
 S (ZTSAVE("PSDS"),ZTSAVE("PSDSN"))=""
 Q
PRINT1 ;prints labels
 W ! F PSDX1=0:1:PSDCNT-1 W ?PSDX1*33+1,$E(TEMP(PSDX1+1),1,30)
 I $D(PSDPRT) W !! F PSDX1=1:1:PSDCNT W @PSDBAR1,TEST(PSDX1),@PSDBAR0
 W ! F PSDX1=0:1:PSDCNT-1 W ?PSDX1*32+3,TEST(PSDX1+1)
 W !!
 S PSDCNT=0,PSDX2=PSDX2+1 S:PSDX2=11 PSDX2=1
 Q
