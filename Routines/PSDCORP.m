PSDCORP ;BIR/BJW-CS Correction Log Report ; 6 Feb 98
 ;;3.0; CONTROLLED SUBSTANCES ;**8**;13 Feb 97
 ;**Y2K compliance**,"P" added to date input string
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 I '$D(^XUSEC("PSDMGR",DUZ)) W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to print",!,?12,"the narcotic corrections log.",!!,"PSDMGR security key required.",! Q
ASKD ;ask disp site
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4)
 G:$P(PSDSITE,U,5) TYPE
 W ! K DIC,DA S DIC=58.8,DIC(0)="QEAZ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)[""M"":1,$P(^(0),""^"",2)[""S"":1,1:0)"
 S DIC("A")="Select Primary Dispensing Site: "
 S DIC("B")=PSDSN
 D ^DIC K DIC G:Y<0 END
 S PSDS=+Y,PSDSN=$P(Y,"^",2),$P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
TYPE ;ask correction type
 K DA,DIR,DIRUT S DIR(0)="SO^1:GREEN SHEET READY FOR PICKUP CORRECTION;2:DELETE EXISTING GREEN SHEET CORRECTION;3:ERROR FOUND ON COMPLETED GS;4:RESOLVED ERROR ON GREEN SHEET"
 S DIR("A")="Select Type of Correction Log"
 S DIR("?",1)="Answer '1' to print Green Sheets flagged ready for pickup corrections,"
 S DIR("?",2)="answer '2' to print existing Green Sheets deleted,",DIR("?",3)="answer '3' to print Green Sheets with an error found after initial completion,"
 S DIR("?",4)="answer '4' to print Green Sheets with errors resolved  or",DIR("?")="answer '^' to quit without printing the report."
 D ^DIR K DIR G:$D(DIRUT) END S TYPE=Y
DATE ;ask date range
 W ! K %DT S %DT="AEP",%DT("A")="Start with Date: " D ^%DT I Y<0 S PSDOUT=1 G END
 S PSDSD=Y D D^DIQ S PSDATE=Y,%DT("A")="End with Date: " D ^%DT I Y<0 S PSDOUT=1 G END
 I Y<PSDSD W !!,"The ending date of the range must be later than the starting date." G DATE
 S PSDED=Y D D^DIQ S PSDATE=PSDATE_"^"_Y,PSDSD=PSDSD-.0001,PSDED=PSDED+.9999
DEV ;asks device and queueing information
 W !!,"This report is designed for a 132 column format.",!,"You may queue this report to print at a later time.",!!
 S Y=$P($G(^PSD(58.8,+PSDS,2)),"^",9),C=$P(^DD(58.8,24,0),"^",2) D Y^DIQ S PSDEV=Y
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")=PSDEV D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK S ZTRTN=$S(TYPE=1:"^PSDCORP1",TYPE=2:"^PSDCORP2",1:"^PSDCORP3"),ZTDESC="CS PHARM Correction Log" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO
 G:TYPE=1 ^PSDCORP1 G:TYPE=2 ^PSDCORP2 G:TYPE=3 ^PSDCORP3 G:TYPE=4 ^PSDCORP3
END K %,%DT,%H,%I,AOU,AOUN,C,D,DA,DIC,DIE,DIR,DIROUT,DIRUT,DR,DRUG,DTOUT,DUOUT,IO("Q"),JJ,NODE,NUM,PG,POP,PSD,PSDATE,PSDED,PSDEV,PSDOUT,PSDS,PSDSD,PSDSN,PSDT,TYPE,X,Y
 K ZTDESC,ZTIO,ZTRTN,ZTSAVE D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
SAVE S (ZTSAVE("PSDS"),ZTSAVE("PSDSN"),ZTSAVE("PSDSD"),ZTSAVE("PSDED"),ZTSAVE("PSDATE"),ZTSAVE("TYPE"))=""
 Q
