ORPKFIX ;HISC/JFR - FIX BAD PACKAGE POINTERS IN ^OR(100  11/7/95 10:00
 ;;2.5;ORDER ENTRY/RESULTS REPORTING;**37,44**;Jan 08, 1993
 ; This routine will repoint any orders in file 100 that have a 
 ; different package associated with the order than the protocol 
 ; that created the order.
EN D DT^DICRW
 I $D(^TMP("ORPKFIX")) D
 .W !!,"It appears you may have errored out running this patch before."
 .W !,"Your count of records corrected will be off but all corrections "
 .W !,"will be shown if you print the report."
 .W !! H 2
 W !,"I'll check your ORDER file for bad PACKAGE file pointers.",!
  S (ORCNT,ORREC,ORRECNT)=0 F  S ORREC=$O(^OR(100,ORREC)) Q:'ORREC  D
 .S ORRECNT=ORRECNT+1 W:'(ORRECNT#1000) "."
 .S ORPROT=$P($G(^OR(100,ORREC,0)),"^",5) Q:ORPROT'["ORD"
 .S ORPROTPK=$P($G(^ORD(101,+ORPROT,0)),"^",12),ORDPK=$P($G(^OR(100,ORREC,0)),"^",14)
 .Q:$G(^OR(100,ORREC,1,1,0))["DC"
 .I ORPROTPK'=ORDPK D  Q
 ..S ORCNT=ORCNT+1
 ..S $P(^OR(100,ORREC,0),"^",14)=ORPROTPK
 ..S X=ORDPK S DIC="^DIC(9.4,",DIC(0)="XN" D ^DIC S ORDPK=$P(Y,"^",2)
 ..S X=ORPROTPK S DIC="^DIC(9.4,",DIC(0)="XN" D ^DIC S ORPROTPK=$P(Y,"^",2)
 ..S ^TMP("ORPKFIX",$J,ORREC)=ORREC_"^"_ORDPK_"^"_ORPROTPK
 W !!,"Finished"
 W !!,ORCNT," Orders have been fixed."
 K DIC,ORDPK,ORPROT,ORPROTPK,ORREC,ORRECNT,X,Y
DEVICE ;PRINT THE REPORT IF YOU WANT
 W !!,"You can print a list of corrections if you wish.",!
 S DIR(0)="Y",DIR("A")="Would you like a list",DIR("B")="Y"
 D ^DIR G:($D(DIRUT)!(Y=0)) QUIT K DIR,Y
 I ORCNT>50 W !!,"You have ",ORCNT," corrections, you may want to send output to a printer!",!
 S %ZIS="Q" D ^%ZIS G QUIT:POP
 I $D(IO("Q")) D QUE G QUIT
 U IO D PRT
QUIT D ^%ZISC K %ZIS,DIR,DIROUT,DIRUT,ORCNT,ORJOB,ORNUM,ORNODE,ORPAGE,POP,Y,ZTREQ,ZTQUEUED,^TMP("ORPKFIX")
 Q
PRT ;SHOW THE OUTPUT
 I $D(ZTQUEUED) S ZTREQ="@"
 S ORPAGE=1 D PAGE
 I '$D(^TMP("ORPKFIX")) W !,"No corrections made" G QUIT
 S ORJOB=0 F  S ORJOB=$O(^TMP("ORPKFIX",ORJOB)) G:'ORJOB QUIT D  G:'$D(ORPAGE) QUIT
 .S ORNUM=0 F  S ORNUM=$O(^TMP("ORPKFIX",ORJOB,ORNUM)) Q:'ORNUM  D  I $Y>(IOSL-5) S ORPAGE=ORPAGE+1 D PAGE Q:'$D(ORPAGE)
 .. S ORNODE=$G(^TMP("ORPKFIX",ORJOB,ORNUM))
 .. W !,"Order ",$P(ORNODE,"^")," repointed from ",$E($P(ORNODE,"^",2),1,20)," to ",$E($P(ORNODE,"^",3),1,20)
 .. Q
 G QUIT
PAGE ;NEW PAGE
 I $E(IOST,1,2)["C-",ORPAGE>1 W ! S DIR(0)="E" D ^DIR K:+Y'>0 ORPAGE Q:'$D(ORPAGE)
 W @IOF,"Corrections from OR*2.5*37 ORPKFIX",?65,"Page: ",ORPAGE
 W ! F DASH=1:1:78 W "-"
 K DASH,DIR Q
QUE ;QUE THE OUTPUT 
 S ZTRTN="PRT^ORPKFIX",ZTDESC="OR*2.5*37 corrections"
 S ZTSAVE("^TMP(""ORPKFIX"",")=""
 D ^%ZTLOAD
 I '$G(ZTSK) W !!,"Report cancelled!",!
 E  W !,"Report queued!"
 D HOME^%ZIS
 K ZTDESC,ZTRTN,ZTSAVE,ZTSK
