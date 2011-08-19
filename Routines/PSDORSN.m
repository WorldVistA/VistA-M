PSDORSN ;BIR/JPW-Nurse Order Stats Report ; 8 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 S OK=$S($D(^XUSEC("PSJ RPHARM",DUZ)):1,$D(^XUSEC("PSJ PHARM TECH",DUZ)):1,$D(^XUSEC("PSJ RNURSE",DUZ)):1,$D(^XUSEC("PSD NURSE",DUZ)):1,1:0)
 I 'OK W $C(7),!!,?9,"** Please contact your Coordinator for access to",!,?12,"print this report.",!!,"PSJ RPHARM, PSJ PHARM TECH, PSJ RNURSE, or PSD NURSE security key required.",! K OK Q
ASKN ;ask naou
 K DA,DIC S DIC=58.8,DIC(0)="QEA",DIC("A")="Select NAOU: "
 S DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S('$D(^(""I"")):1,'^(""I""):1,+^(""I"")>DT:1,1:0),$P(^(0),""^"",2)=""N"",'$P(^(0),""^"",7)" D ^DIC K DIC G:Y<0 END
 S NAOU=+Y,NAOUN=$P(Y,"^",2)
ALL ;asks for all orders
 W ! K DA,DIR,DIRUT S DIR(0)="Y",DIR("A")="Do you want to print this report for all drugs",DIR("B")="NO"
 S DIR("?",1)="Answer 'YES' to list all pending orders for this NAOU,",DIR("?")="answer 'NO' to list orders for a specific drug or '^' to quit."
 D ^DIR K DIR G:$D(DIRUT) END S ALL=+Y
 G:ALL DEV
DRUG ;select drugs
 W ! K DA,DIC S DIC("W")="W:$P(^PSDRUG(Y,0),""^"",9) ""   N/F"" I $P(^PSD(58.8,NAOU,1,Y,0),""^"",14)]"""",$P(^(0),""^"",14)'>DT W $C(7),""  *** INACTIVE ***"""
 S DA(1)=+NAOU,DIC(0)="QEAM",DIC="^PSD(58.8,"_NAOU_",1," D ^DIC K DIC G:Y<0 END S PSDR=+Y
DEV ;ask device and queue info
 W !!,"You may queue this report to print at a later time.",!!
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")="HOME" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDORSN",ZTDESC="Status of Pending Narcotic Orders" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO
START ;loops thru pending orders and orders cancelled in the past 3 days
 K ^TMP("PSDNST",$J)
 D NOW^%DTC S (PSDT,X1)=X,X2=-3 D C^%DTC S PSDST=X
 I ALL F STAT=.5:0 S STAT=$O(^PSD(58.8,"AC",STAT)) Q:'STAT!(STAT>3)  D LOOP
 I ALL S STAT=9 D:$D(^PSD(58.8,"AC",STAT)) LOOP G PRINT
 F STAT=.5:0 S STAT=$O(^PSD(58.8,"AC",STAT)) Q:'STAT!(STAT>3)  D ORD
 S STAT=9 D:$D(^PSD(58.8,"AC",STAT,NAOU,PSDR)) ORD
PRINT ;prints the report
 S (PG,PSDOUT)=0,Y=PSDT X ^DD("DD") S RPDT=Y
 K LN S $P(LN,"-",80)="" D HDR I '$D(^TMP("PSDNST",$J)) W !!,?10,"****  NO PENDING ORDERS TO REPORT  ****" G END
 S PSDR="" F  S PSDR=$O(^TMP("PSDNST",$J,PSDR)) Q:PSDR=""!(PSDOUT)  W !!,?2,"=>  ",PSDR,! D  Q:PSDOUT
 .F ORD=0:0 S ORD=$O(^TMP("PSDNST",$J,PSDR,ORD)) Q:'ORD!(PSDOUT)  D:$Y+4>IOSL HDR Q:PSDOUT  D
 ..S NODE=^TMP("PSDNST",$J,PSDR,ORD) W !,$P(NODE,"^",4),?11,$P(NODE,"^",3),?33,$J($P(NODE,"^",2),6),?42,$P(NODE,"^")
DONE I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSDOUT W ! K DIR,DIRUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu" D ^DIR K DIR
END K %,%H,%I,%ZIS,ALL,DA,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,LN,NAOU,NAOUN,NODE,OK,ORD
 K PG,POP,PSDOUT,PSDPN,PSDR,PSDRN,PSDST,PSDT,QTY,REQ,RPDT,STAT,STATN,X,X1,X2,Y,ZTDESC,ZTDTH,ZTRTN,ZTSAVE,ZTSK
 K ^TMP("PSDNST",$J) D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
LOOP ;starts drug loop for all orders
 F PSDR=0:0 S PSDR=$O(^PSD(58.8,"AC",STAT,NAOU,PSDR)) Q:'PSDR  D ORD
 Q
ORD ;order loop
 F ORD=0:0 S ORD=$O(^PSD(58.8,"AC",STAT,NAOU,PSDR,ORD)) Q:'ORD  D SET
 Q
SET ;sets data for printing
 Q:'$D(^PSD(58.8,NAOU,1,PSDR,3,ORD,0))  S NODE=^(0),PSDRN=$S($P($G(^PSDRUG(PSDR,0)),"^")]"":$P(^(0),"^"),1:"DRUG NAME MISSING")
 I STAT=9,$P(NODE,"^",2)<PSDST Q
 S STATN=$P($G(^PSD(58.82,STAT,0)),"^"),STATN=$E(STATN,1,30),QTY=$P(NODE,"^",6),PSDPN=$P(NODE,"^",16),REQ=$P(NODE,"^",2) I REQ S Y=REQ X ^DD("DD") S REQ=Y
 S ^TMP("PSDNST",$J,PSDRN,ORD)=STATN_"^"_QTY_"^"_REQ_"^"_PSDPN
 Q
HDR ;header for log
 I $E(IOST,1,2)="C-",PG W ! K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 S PG=PG+1 W:$Y @IOF W !,?25,"Status of Pending Narcotic Orders",?70,"Page: ",PG,!,?35,NAOUN,!,?35,RPDT,!
 W !,?2,"=> DRUG",!,?13,"DATE",?33,"QUANTITY",!,"DISP #",?12,"ORDERED",?33,"ORDERED",?48,"ORDER STATUS"
 W !,LN,!
 Q
SAVE S (ZTSAVE("ALL"),ZTSAVE("NAOU"),ZTSAVE("NAOUN"))="" S:$D(PSDR) ZTSAVE("PSDR")=""
 Q
