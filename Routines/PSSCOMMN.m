PSSCOMMN ;BIR/RTR-Most Common Dosages Report ;06/07/00
 ;;1.0;PHARMACY DATA MANAGEMENT;**34**;9/30/97
 ;Reference to ^DGPM supported by DBIA 1865
EN ;
 W !!,"This report displays common dosages of Dispense Drugs for Unit Dose orders",!,"based on the time frame entered. Unit Dose orders without a Dosage Ordered",!,"are not included on this report."
 W !,"If there are multiple Dispense Drugs associated with an order, only the first",!,"Dispense Drug of the order will print with the Dosage Ordered.",!
 K DIR S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR K DIR I 'Y!(Y["^") W !!,"Nothing queued to print.",! G ENDX
 W ! K %DT S %DT="AEPX",%DT(0)=-DT,%DT("A")="Enter start date for gathering Dosages: " D ^%DT K %DT I Y<0!($G(DTOUT)) W !!,"Nothing queued to print.",! G ENDX
 S PSSBEG=+Y
 W ! K DIR S DIR(0)="N^1:100^",DIR("A")="Do not print Dosage if frequency is less than"
 S DIR("?")=" ",DIR("?",1)="This number represents the minimum number of times a Dosage was entered",DIR("?",2)="for a Dispense Drug in a Unit Dose order."
 S DIR("B")=1 D ^DIR K DIR I 'Y!($D(DIRUT)) W !!,"Nothing queued to print.",! G ENDX
 S PSSMIN=Y
 W !!,"Because of the length of this report, and the time needed to gather the",!,"information, this report must be queued to a printer.",!
QUEUE ;
 K IOP,%ZIS,POP S %ZIS="QM" D ^%ZIS I $G(POP) W !!,"Nothing queued to print.",! G ENDX
 I '$D(IO("Q")) W !!,"This report must be queued to a printer.",! G QUEUE
 S ZTRTN="START^PSSCOMMN",ZTDESC="Most Common Dosages Report",ZTSAVE("PSSBEG")="",ZTSAVE("PSSMIN")="" D ^%ZTLOAD W !!,"Report queued to print.",! G ENDX
 Q
START ;
 U IO
 I '$G(DT) S DT=$$DT^XLFDT
 S PSSOUT=0,PSSDV="P",PSSCT=1
 K ^TMP("PSSPAT",$J),^TMP("PSSDOS",$J),PSSD,PSSDV,PSSLINE,PSSP,PSSIEN,PSSPAT,PSSOR,PSSORDA,PSSDO,PSSONE,PSSDIEN,PSSDNAME,PSSPFLAG,PSSDNM,PSSDCT,PSSDOSEG,PSSPRINT,PSSXXX
 S $P(PSSLINE,"-",79)=""
 I $G(PSSBEG) S PSSPRINT=$E(PSSBEG,4,5)_"/"_$E(PSSBEG,6,7)_"/"_$E(PSSBEG,2,3)
 D COMMH
 I '$G(PSSBEG) G END
 S PSSD=PSSBEG-.001
 F PSSP=PSSD:0 S PSSP=$O(^DGPM("ATT1",PSSP)) Q:'PSSP!(PSSP>DT)  F PSSIEN=0:0 S PSSIEN=$O(^DGPM("ATT1",PSSP,PSSIEN)) Q:'PSSIEN  D
 .S PSSPAT=$P($G(^DGPM(PSSIEN,0)),"^",3) Q:'PSSPAT
 .Q:$D(^TMP("PSSPAT",$J,PSSPAT))
 .S ^TMP("PSSPAT",$J,PSSPAT)=""
 .F PSSOR=PSSD:0 S PSSOR=$O(^PS(55,PSSPAT,5,"AUS",PSSOR)) Q:'PSSOR  F PSSORDA=0:0 S PSSORDA=$O(^PS(55,PSSPAT,5,"AUS",PSSOR,PSSORDA)) Q:'PSSORDA  D
 ..S PSSDO=$P($G(^PS(55,PSSPAT,5,PSSORDA,.2)),"^",2) Q:PSSDO=""
 ..S PSSONE=$O(^PS(55,PSSPAT,5,PSSORDA,1,0)) Q:'PSSONE
 ..S PSSDIEN=$P($G(^PS(55,PSSPAT,5,PSSORDA,1,PSSONE,0)),"^") Q:'PSSDIEN!($P($G(^PSDRUG(PSSDIEN,0)),"^")="")
 ..S PSSDNAME=$P($G(^PSDRUG(PSSDIEN,0)),"^")
 ..I '$D(^TMP("PSSDOS",$J,PSSDNAME,PSSDO)) S ^TMP("PSSDOS",$J,PSSDNAME,PSSDO)=1 Q
 ..S ^TMP("PSSDOS",$J,PSSDNAME,PSSDO)=^TMP("PSSDOS",$J,PSSDNAME,PSSDO)+1
 S PSSPFLAG=0
 S PSSDNM="" F  S PSSDNM=$O(^TMP("PSSDOS",$J,PSSDNM)) Q:PSSDNM=""  S PSSDCT=1 S PSSDOSEG="" F  S PSSDOSEG=$O(^TMP("PSSDOS",$J,PSSDNM,PSSDOSEG)) Q:PSSDOSEG=""  D
 .Q:^TMP("PSSDOS",$J,PSSDNM,PSSDOSEG)<$G(PSSMIN)
 .S PSSXXX=0
 .I ($Y+5)>IOSL S PSSXXX=1 D COMMH
 .S PSSPFLAG=1
 .I PSSDCT=1 W:'$G(PSSXXX) ! W !,PSSDNM
 .W:PSSDCT'=1 ! W ?43,PSSDOSEG,?65,^TMP("PSSDOS",$J,PSSDNM,PSSDOSEG)
 .S PSSDCT=PSSDCT+1
 I '$G(PSSPFLAG) W !!,"NO DATA TO PRINT",!!
END ;
 W @IOF
ENDX ;
 K ^TMP("PSSPAT",$J),^TMP("PSSDOS",$J),PSSD,PSSDV,PSSLINE,PSSMIN,PSSBEG,PSSP,PSSIEN,PSSPAT,PSSOR,PSSORDA,PSSDO,PSSONE,PSSDIEN,PSSDNAME,PSSPFLAG,PSSDNM,PSSDCT,PSSDOSEG,PSSPRINT,PSSXXX
 K %ZIS D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
COMMH ;
 W @IOF W !?3,"COMMON DOSAGES REPORT STARTING FROM "_$G(PSSPRINT)_$S($G(PSSCT)=1:"",1:"  (cont.)"),?67,"PAGE: "_$G(PSSCT) S PSSCT=PSSCT+1
 W !!,"DRUG",?43,"DOSAGE",?62,"FREQUENCY",!,PSSLINE,!
 Q
