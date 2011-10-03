PSDERP ;BIR/BJW-CS Error Log Report ; 6 Feb 98
 ;;3.0; CONTROLLED SUBSTANCES ;**8**;13 Feb 97
 ;**Y2K compliance**,"P" added to date input string
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 S OK=$S($D(^XUSEC("PSDMGR",DUZ)):1,$D(^XUSEC("PSD ERROR",DUZ)):2,1:0)
 I 'OK W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to",!,?12,"the pending Controlled Substances error log.",!!,"PSDMGR or PSD ERROR security key required.",! K OK Q
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4) G:$P(PSDSITE,U,5) DATE
ASKD ;ask disp location
 W !!,"You may select a Dispensing Site at the prompt.",!
 W ! K DIC,DA S DIC=58.8,DIC(0)="QEAZ"
 I OK=1 S DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)[""M"":1,$P(^(0),""^"",2)[""S"":1,1:0)"
 S DIC("A")="Select Dispensing Site: ",DIC("B")=PSDSN
 D ^DIC K DIC G:Y<0 END
 S PSDS=+Y,PSDSN=$P(Y,"^",2),$P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
DATE ;ask date range
 W ! K %DT S %DT="AEP",%DT("A")="Start with Date: " D ^%DT I Y<0 S PSDOUT=1 G END
 S PSDSD=Y D D^DIQ S PSDATE=Y,%DT("A")="End with Date: " D ^%DT I Y<0 S PSDOUT=1 G END
 I Y<PSDSD W !!,"The ending date of the range must be later than the starting date." G DATE
 S PSDED=Y D D^DIQ S PSDATE=PSDATE_"^"_Y,PSDSD=PSDSD-.0001,PSDED=PSDED+.9999
DEV ;select device
 W !!,"This report is designed for a 80 column format.",!,"You may queue this report to print at a later time.",!!
 S Y=$P($G(^PSD(58.8,+PSDS,2)),"^",9),C=$P(^DD(58.8,24,0),"^",2) D Y^DIQ S PSDEV=Y
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")=PSDEV D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDERP",ZTDESC="CS Pending Error Log Report" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO
START ;start looping
 K ^TMP("PSDERP",$J)
 D NOW^%DTC S Y=X X ^DD("DD") S RPDT=Y
 K LN S (CNT,PG,PSDOUT)=0,$P(LN,"-",80)=""
 F PSD=PSDSD:0 S PSD=$O(^PSD(58.89,"AD",PSD)) Q:'PSD!(PSD>PSDED)  F PSDA=0:0 S PSDA=$O(^PSD(58.89,"AD",PSD,PSDS,PSDA)) Q:'PSDA  D
 .Q:'$D(^PSD(58.89,+PSDA,0))  S NODE=^PSD(58.89,+PSDA,0) Q:+$P(NODE,"^",5)
 .S PSDN=+$P(NODE,"^",2)  Q:'$D(^PSD(58.81,+PSDN,0))  S NODE1=^PSD(58.81,+PSDN,0),PSDR=+$P(NODE1,"^",5)
 .S NODE9=$G(^PSD(58.81,+PSDN,9)),PHARM=$S(+$P(NODE9,"^",2):+$P(NODE9,"^",2),+$P(NODE9,"^",8):+$P(NODE9,"^",8),+$P(NODE9,"^",11):+$P(NODE9,"^",11),1:"")
 .S PHARM2=$S(+$P(NODE9,"^",6):+$P(NODE9,"^",6),+$P(NODE9,"^",9):+$P(NODE9,"^",9),+$P(NODE9,"^",12):+$P(NODE9,"^",12),1:""),PHARMN2=""
 .S PSDRN=$S($P($G(^PSDRUG(+PSDR,0)),"^")]"":$P($G(^PSDRUG(+PSDR,0)),"^"),1:"#"_+PSDR_" DRUG NAME MISSING")
 .S QTY=$P(NODE1,"^",6),PHARMN=$S($P($G(^VA(200,+PHARM,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN") S:PHARM2 PHARMN2=$S($P($G(^VA(200,+PHARM2,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 .S PSDT=$E(PSD,4,5)_"/"_$E(PSD,6,7)_"/"_$E(PSD,2,3),TYP=+$P(NODE1,"^",2),TYP=$P($G(^PSD(58.84,+TYP,0)),"^")
 .S ^TMP("PSDERP",$J,PSDRN,PSDA)=QTY_"^"_PHARMN_"^"_PHARMN2_"^"_PSDT_"^"_TYP,CNT=CNT+1
 I CNT=0 D HDR W !!,?10,"*** NO CONTROLLED SUBSTANCES PENDING ERRORS/ADJUSTMENTS ***",!! G DONE
PRINT ;prints data
 D HDR Q:PSDOUT
 S PSDRN="" F  S PSDRN=$O(^TMP("PSDERP",$J,PSDRN)) Q:PSDRN=""  D:$Y+4>IOSL HDR Q:PSDOUT  W !,?2,"=> ",PSDRN,! F PSDA=0:0 S PSDA=$O(^TMP("PSDERP",$J,PSDRN,PSDA)) Q:'PSDA  D  Q:PSDOUT
 .I $Y+4>IOSL D HDR Q:PSDOUT  W !,?2,"=> ",PSDRN,!
 .S NODE=^TMP("PSDERP",$J,PSDRN,PSDA) W !,PSDA,?10,$J($P(NODE,"^"),6),?20,$P(NODE,"^",4),?35,$P(NODE,"^",5),!,?5,$P(NODE,"^",2) W:$P(NODE,"^",3)]"" ?45,$P(NODE,"^",3) W !
DONE I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSDOUT W ! K DIR,DIRUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu" D ^DIR K DIR
END ;
 K %,%DT,%H,%I,%ZIS,C,CNT,DA,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,LN,NODE,NODE1,NODE9,OK
 K PG,PHARM,PHARM2,PHARMN,PHARMN2,POP,PSD,PSDA,PSDATE,PSDED,PSDEV,PSDN,PSDOUT,PSDR,PSDRG,PSDRN,PSDS,PSDSD,PSDSN,PSDT,QTY,RPDT,TYP,X,Y,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 K ^TMP("PSDERP",$J)
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
HDR ;prints header information
 I $E(IOST,1,2)="C-",PG W ! K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 S PG=PG+1 W:$Y @IOF W !,?15,"CS PENDING ERROR/ADJ LOG REPORT",?70,"PAGE: ",PG
 W !,?15,"NAOU: ",PSDSN,!,?15,"Period From: ",$P(PSDATE,"^")," to: ",$P(PSDATE,"^",2),!,?15,"Run Date: ",RPDT
 W !!,"LOG #",?10,"QUANTITY",?22,"DATE",?35,"ERR/ADJ TYPE",!,?5,"LOGGED BY",?45,"WITNESSED BY",!,LN,!
 Q
SAVE ;saves variables for queueing
 S (ZTSAVE("PSDSD"),ZTSAVE("PSDED"),ZTSAVE("PSDATE"),ZTSAVE("PSDS"),ZTSAVE("PSDSN"))=""
 Q
