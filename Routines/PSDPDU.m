PSDPDU ;BIR/JPW-Print Breakdown/Disp Unit for Stock Drugs ; 6 July 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 W !!,?5,"You may select a single Dispensing Site, several Dispensing Sites,",!,?5,"or enter ^ALL to select all Dispensing Sites.",!!
ASKN ;ask NAOU(s)
 D NOW^%DTC S PSDT=X K DA,DIC S DIC("B")=$P(PSDSITE,U,4)
 F  S DIC=58.8,DIC("A")="Select Dispensing Site: ",DIC(0)="QEA",DIC("S")="I $S('$D(^(""I"")):1,'^(""I""):1,+^(""I"")>PSDT:1,1:0),$S($P(^(0),""^"",2)=""M"":1,$P(^(0),""^"",2)=""S"":1,1:0),$P(^(0),""^"",3)=+PSDSITE" D  Q:Y<0
 .D ^DIC K DIC Q:Y<0  S NAOU(+Y)=""
 I '$D(NAOU)&(X'="^ALL") G END
 I X="^ALL" F PSD=0:0 S PSD=$O(^PSD(58.8,PSD)) Q:'PSD  I $S('$D(^PSD(58.8,PSD,"I")):1,'^("I"):1,+^("I")>PSDT:1,1:0),$S($P($G(^(0)),"^",2)="M":1,$P($G(^(0)),"^",2)="S":1,1:0),$P($G(^(0)),"^",3)=+PSDSITE S NAOU(PSD)=""
 W !!,"This report is designed for a 132 column format.",!,"You may queue this report to print at a later time.",!!
DEV ;asks device and queueing information
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDPDU1",ZTDESC="CS PHARM List Disp Unit" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO G START^PSDPDU1
END ;
 K %,%H,%I,%ZIS,ANS,DA,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,IO("Q"),NAOU,POP,PSD,PSDT,X,Y,ZTDESC,ZTIO,ZTRTN,ZTSAVE D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
SAVE ;save variables for queueing
 S ZTSAVE=("PSDSITE")="",ZTSAVE("PSD")="",ZTSAVE("PSDT")="" S:$D(NAOU) ZTSAVE("NAOU(")=""
 Q
