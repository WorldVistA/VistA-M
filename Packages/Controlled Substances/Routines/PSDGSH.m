PSDGSH ;BIR/JPW-Review Green Sheet History ; 29 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 ;S OK=$S($D(^XUSEC("PSJ RPHARM",DUZ)):1,$D(^XUSEC("PSJ RNURSE",DUZ)):1,$D(^XUSEC("PSD NURSE",DUZ)):1,1:0)
 ;I 'OK W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to view",!,?12,"Green Sheets.",! K OK Q
ASKD ;ask disp location
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4)
 G:$P(PSDSITE,U,5) GS
 K DIC,DA S DIC=58.8,DIC(0)="QEAZ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)[""M"":1,$P(^(0),""^"",2)[""S"":1,1:0)"
 S DIC("A")="Select Primary Dispensing Site: ",DIC("B")=PSDSN
 D ^DIC K DIC G:Y<0 END
 S PSDS=+Y,PSDSN=$P(Y,"^",2),$P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
GS ;select green sheet #
 W @IOF,! K DA,DIC S DIC("A")="Select the Green Sheet #: ",DIC("S")="I $P(^(0),""^"",3)=PSDS,$P(^(0),""^"",2)'=5",DIC=58.81,DIC(0)="QEASZ",D="D"
 D IX^DIC K DIC G:Y<0 END S PSDA=+Y,NODE=Y(0)
DEV ;asks device and queueing information
 S Y=$P($G(^PSD(58.8,+PSDS,2)),"^",9),C=$P(^DD(58.8,24,0),"^",2) D Y^DIQ S PSDEV=Y
 W ! K %ZIS,IOP,IO("Q"),POP S %ZIS="QM" S:$D(^XUSEC("PSJ RPHARM",DUZ)) %ZIS("B")=PSDEV D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDGSH1",ZTDESC="CS PHARM GREEN SHEET HISTORY" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G GS
 U IO D START^PSDGSH1 G GS
END K %ZIS,C,D,DA,DIC,DTOUT,DUOUT,NODE,OK,OTR,POP,PSD,PSDA,PSDEV,PSDS,PSDSN,X,Y
 K ZTDESC,ZTRTN,ZTSAVE,ZTSK D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
SAVE ;sets variables for queueing
 S (ZTSAVE("PSDS"),ZTSAVE("PSDSN"),ZTSAVE("PSDA"),ZTSAVE("NODE"))=""
 Q
