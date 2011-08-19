PSDPUGS ;BIR/JPW-Green Sheets Ready for Pickup Log ; 29 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 S OK=$S($D(^XUSEC("PSJ RPHARM",DUZ)):1,$D(^XUSEC("PSJ PHARM TECH",DUZ)):1,1:0)
 I 'OK W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to",!,?12,"print the Green Sheets Ready for Pickup Log.",!!,"PSJ RPHARM or PSJ PHARM TECH security key required.",! K OK Q
ASKD ;ask disp loccation
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4)
 I $P(PSDSITE,U,5) S PSDS=PSDS_"^"_+$P($G(^PSD(58.8,+PSDS,0)),"^",5) G ASKN
 K DIC,DA S DIC=58.8,DIC(0)="QEAZ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)[""M"":1,$P(^(0),""^"",2)[""S"":1,1:0)"
 S DIC("A")="Select Primary Dispensing Site: ",DIC("B")=$P(PSDSITE,U,4)
 D ^DIC K DIC G:Y<0 END
 S PSDS=+Y,PSDSN=$P(Y,"^",2),PSDS=PSDS_"^"_+$P(Y(0),"^",5)
 S $P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
ASKN ;ask naou or group
 W !!,?5,"Select one of the following:",!!,?10,"N",?20,"NAOU (One, Some, or ^ALL)",!,?10,"G",?20,"Group of NAOUs",!
 K DA,DIR,DIRUT S DIR(0)="SOA^N:NAOU;G:Group of NAOUs",DIR("A")="Select Method: "
 S DIR("?",1)="Enter 'N' to select one, some or ^ALL NAOU(s).",DIR("?")="Enter 'G' to select a group of NAOUs, or '^' to quit"
 D ^DIR K DIR G:$D(DIRUT) END S SEL=Y D NOW^%DTC S PSDT=X,PSDPT=+$E(%,1,12) K DA,DIC S CNT=0
 I SEL="G" D GROUP G:'$D(PSDG) END G DEV
 F  S DIC=58.8,DIC("A")="Select NAOU: ",DIC(0)="QEA",DIC("S")="I $P(^(0),""^"",2)=""N"",'$P(^(0),""^"",7),$P(^(0),""^"",4)=+PSDS" D ^DIC K DIC Q:Y<0  D
 .S NAOU(+Y)="",CNT=CNT+1
 I '$D(NAOU)&(X'="^ALL") G END
 S:X="^ALL" ALL=1
DEV ;ask device and queue info
 W !!,"You may queue this report to print at a later time.",!!
 S Y=$P($G(^PSD(58.8,+PSDS,2)),"^",9),C=$P(^DD(58.8,24,0),"^",2) D Y^DIQ S PSDEV=Y
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")=PSDEV D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDPUGS",ZTDESC="CS Pharm Green Sheets Ready for Pickup Log" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO
START ;compile data
 K ^TMP("PSDPUGS",$J)
 I $D(PSDG) F PSD=0:0 S PSD=$O(PSDG(PSD)) Q:'PSD  F PSDN=0:0 S PSDN=$O(^PSI(58.2,PSD,3,PSDN)) Q:'PSDN  I $D(^PSD(58.8,PSDN,0)),'$P(^(0),"^",7),$P(^(0),"^",4)=+PSDS S NAOU(PSDN)="",CNT=CNT+1
 I $D(ALL) F PSD=0:0 S PSD=$O(^PSD(58.8,PSD)) Q:'PSD  I $D(^PSD(58.8,PSD,0)),$P(^(0),"^",2)="N",$P(^(0),"^",4)=+PSDS,'$P(^(0),"^",7) S NAOU(+PSD)=""
 F PSD=0:0 S PSD=$O(^PSD(58.8,"AC",5,PSD)) Q:'PSD  F DRUG=0:0 S DRUG=$O(^PSD(58.8,"AC",5,PSD,DRUG)) Q:'DRUG  D
 .F PSDA=0:0 S PSDA=$O(^PSD(58.8,"AC",5,PSD,DRUG,PSDA)) Q:'PSDA  I $D(^PSD(58.8,PSD,1,DRUG,3,PSDA,0)) S NODE=^PSD(58.8,PSD,1,DRUG,3,PSDA,0) D
 ..I $D(NAOU(PSD)),$P($G(^PSD(58.81,+$P(NODE,U,17),"CS")),U,4) S PSDNA=$S($P($G(^PSD(58.8,PSD,0)),"^")]"":$P(^(0),"^"),1:"ZZ/"_PSD) D
 ...S DRUGN=$S($P($G(^PSDRUG(DRUG,0)),"^")]"":$P(^(0),"^"),1:"ZZ/"_DRUG),STAT=+$P(NODE,"^",11) Q:STAT'=5
 ...S NUM=$P(NODE,"^",16),^TMP("PSDPUGS",$J,PSDNA,NUM,DRUGN)=""
PRINT ;print green sheets ready for pickup by naou, green sheet #
 S (PG,PSDOUT,NAOU)=0 D NOW^%DTC S Y=+$E(%,1,12) X ^DD("DD") S RPDT=Y
 K LN S $P(LN,"-",80)="" I '$D(^TMP("PSDPUGS",$J)) D HDR W !!,?10,"****  NO PENDING GREEN SHEETS READY FOR PICKUP  ****" G END
 S NAOU="" F  S NAOU=$O(^TMP("PSDPUGS",$J,NAOU)) Q:NAOU=""!(PSDOUT)  D HDR Q:PSDOUT  W !,?2,"=> NAOU: "_NAOU,! D  Q:PSDOUT
 .S NUM="" F  S NUM=$O(^TMP("PSDPUGS",$J,NAOU,NUM)) Q:NUM=""!(PSDOUT)  D:$Y+4>IOSL HDR Q:PSDOUT  S DRUG=$O(^TMP("PSDPUGS",$J,NAOU,NUM,0)) Q:DRUG=""  D
 ..W !,NUM,?12,DRUG,?55,"__________",?68,"__________",!,?55,"(Pharmacy)",?70,"(Nurse)",!
DONE I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSDOUT W ! K DIR,DIRUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu" D ^DIR K DIR
END K %,%H,%I,%ZIS,ALL,C,CNT,DA,DIC,DIR,DIROUT,DIRUT,DRUG,DRUGN,DTOUT,DUOUT,LN,NAOU,NODE,NUM
 K OK,PG,POP,PSD,PSDA,PSDEV,PSDG,PSDIO,PSDN,PSDNA,PSDS,PSDSN,PSDOUT,PSDPT,PSDT,RPDT,SEL,STAT,X,Y,ZTDESC,ZTDTH,ZTRTN,ZTSAVE,ZTSK
 K ^TMP("PSDPUGS",$J) D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
GROUP ;select group of naous
 K DA,DIC F  S DIC=58.2,DIC("A")="Select NAOU INVENTORY GROUP NAME: ",DIC(0)="QEA",DIC("S")="I $S($D(^PSI(58.2,""CS"",+Y)):1,1:0)" D ^DIC K DIC Q:Y<0  S PSDG(+Y)=""
 Q
SAVE S (ZTSAVE("PSDT"),ZTSAVE("CNT"),ZTSAVE("PSDS"))="" S:$D(PSDG) ZTSAVE("PSDG(")="" S:$D(NAOU) ZTSAVE("NAOU(")="" S:$D(ALL) ZTSAVE("ALL")=""
 Q
HDR ;header for log
 I $E(IOST,1,2)="C-",PG W ! K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 S PG=PG+1 W:$Y @IOF W !,?25,"Green Sheets Ready for Pickup",?70,"Page: ",PG,!,?30,RPDT,!
 W !,?57,"PICKED",?70,"GIVEN",!,"DISP #",?12,"DRUG",?57,"UP BY",?70,"TO BY"
 W !,LN,!
 Q
