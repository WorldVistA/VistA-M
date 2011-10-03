PSDNSCL ;BIR/JPW - Nurse Shift Check Log ; 2 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;**57**;13 Feb 97
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 S OK=$S($D(^XUSEC("PSJ RNURSE",DUZ)):1,$D(^XUSEC("PSD NURSE",DUZ)):1,1:0)
 ;I 'OK W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to",!,?12,"print this shift check log.",! K OK Q
ASKN ;ask naou
 K DA,DIC S DIC=58.8,DIC(0)="QEA",DIC("A")="Select NAOU: "
 S DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S('$D(^(""I"")):1,'^(""I""):1,+^(""I"")>DT:1,1:0),$P(^(0),""^"",2)=""N"",'$P(^(0),""^"",7)"
 D ^DIC K DIC G:Y<0 END S NAOU=+Y,NAOUN=$P(Y,"^",2)
DEV ;ask device and queue info
 W !!,"You may queue this report to print at a later time.",!!
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDNSCL",ZTDESC="CS Nursing Shift Check Log",(ZTSAVE("NAOU"),ZTSAVE("NAOUN"))="" D ^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO
START ;loops thru active orders 
 K ^TMP("PSDNSCL",$J) D NOW^%DTC S Y=+$E(%,1,12) X ^DD("DD") S RPDT=Y
 F STAT=2.99:0 S STAT=$O(^PSD(58.8,"AC",STAT)) Q:('STAT)!(STAT>5)  D LOOP
 S STAT=10 F PSD=0:0 S PSD=$O(^PSD(58.8,"AC",STAT,PSD)) Q:'PSD  D LOOP
 S STAT=13 F PSD=0:0 S PSD=$O(^PSD(58.8,"AC",STAT,PSD)) Q:'PSD  D LOOP
PRINT ;prints the report
 S (PG,PSDOUT)=0
 K LN S $P(LN,"-",80)="" I '$D(^TMP("PSDNSCL",$J)) D HDR W !!,?10,"****  NO ACTIVE ORDERS TO REPORT  ****",! G DONE
 D HDR
 S DRUG="" F  S DRUG=$O(^TMP("PSDNSCL",$J,DRUG)) Q:DRUG=""!(PSDOUT)  W !!,?2,"=>  ",DRUG,! S NUM="" F  S NUM=$O(^TMP("PSDNSCL",$J,DRUG,NUM)) Q:NUM=""!(PSDOUT)  D
 .I $Y+8>IOSL D HDR Q:PSDOUT  W !!,?2,"=>  ",DRUG,!
 .S NODE=^TMP("PSDNSCL",$J,DRUG,NUM) W !,NUM,?12,$P(NODE,"^",3),?34,$J($P(NODE,"^",2),6),?45,$P(NODE,"^",4),?55,$P($P(NODE,"^")," ")
 .W ! W:$P($G(^DPT(+$P($G(^PSD(58.81,+$O(^PSD(58.81,"D",NUM,0)),9)),U),0)),U)]"" $P($G(^(0)),U)
 .W ?50,$S($P(NODE,"^",5)="*":$P($P(NODE,"^")," ",2,99),1:$P($P(NODE,"^"),"-",2)),!
DONE I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSDOUT W ! K DIR,DIRUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu" D ^DIR K DIR
END K %,%H,%I,%ZIS,ALL,DA,DIC,DIR,DIROUT,DIRUT,DRUG,DRUGN,DTOUT,DUOUT,LN,NAOU,NAOUN,NODE,NUM,OK,ORD
 K PG,POP,PSD,PSDOUT,PSDPN,PSDST,PSDT,PSDTR,QTY,REC,REQ,RPDT,RQTY,STAT,STATN,X,Y,ZTDESC,ZTDTH,ZTRTN,ZTSAVE,ZTSK
 K ^TMP("PSDNSCL",$J) D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
LOOP ;drug loop
 F DRUG=0:0 S DRUG=$O(^PSD(58.8,"AC",STAT,NAOU,DRUG)) Q:'DRUG  F ORD=0:0 S ORD=$O(^PSD(58.8,"AC",STAT,NAOU,DRUG,ORD)) Q:'ORD  D
 .Q:'$D(^PSD(58.8,NAOU,1,DRUG,3,ORD,0))  S NODE=^(0),DRUGN=$S($P($G(^PSDRUG(DRUG,0)),"^")]"":$P(^(0),"^"),1:"DRUG NAME MISSING")
 .S PSDTR=$P(NODE,"^",17) I STAT=10 Q:$D(^PSD(58.81,"AE",PSDTR))
 .S STATN=$P($G(^PSD(58.82,STAT,0)),"^"),RQTY=$P(NODE,"^",20),PSDPN=$S($P(NODE,"^",16)]"":$P(NODE,"^",16),1:"UNKNOWN")
 .S REQ=$P(NODE,"^",15) I REQ S Y=REQ X ^DD("DD") S REQ=Y
 .S REC=$P(NODE,"^",7),REC=$P($G(^VA(200,+REC,0)),"^"),REC=$E($P(REC,",",2))_$E(REC)
 .S ^TMP("PSDNSCL",$J,DRUGN,PSDPN)=STATN_"^"_RQTY_"^"_REQ_"^"_REC_"^"_$S(STAT=10:"*",1:"")
 Q
HDR ;header for log
 I $E(IOST,1,2)="C-",PG W ! K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 S PG=PG+1 W:$Y @IOF W !,?15,"Nursing Shift Check Log for ",NAOUN,?70,"Page: ",PG,!,?20,RPDT,!
 W !,?2,"=> DRUG",!,?18,"DATE",?44,"RECD"
 W !,"DISP #",?18,"RECD",?37,"QTY",?45,"BY",?54,"ORDER STATUS"
 W !,LN,!
 Q
