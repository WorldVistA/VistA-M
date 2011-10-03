PSDACT ;BIR/BJW-Print Daily Activity Log ; 3 Feb 98
 ;;3.0; CONTROLLED SUBSTANCES ;**8**;13 Feb 97
 ;**Y2K compliance**,"P" added to date input string
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 I '$D(^XUSEC("PSJ RPHARM",DUZ))&('$D(^XUSEC("PSD TECH",DUZ))) W !!,"Contact your Pharmacy Coordinator for access to display the daily CS activity.",!!,"PSJ RPHARM or PSD TECH security key required.",! Q
ASKD ;ask disp location
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4)
 G:$P(PSDSITE,U,5) CHKD
 K DIC,DA S DIC=58.8,DIC(0)="QEAZ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)[""M"":1,$P(^(0),""^"",2)[""S"":1,1:0)"
 S DIC("A")="Select Primary Dispensing Site: "
 S DIC("B")=$P(PSDSITE,U,4)
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
DATE W ! K %DT S %DT="AEPTX",%DT("A")="Start with Date: " D ^%DT I Y<0 G END
 S PSDSD=Y D D^DIQ S PSDATE=Y,%DT("A")="End with Date: " D ^%DT I Y<0 G END
 I Y<PSDSD W !!,"The ending date of the range must be later than the starting date." G DATE
 S PSDED=Y D D^DIQ S PSDATE=PSDATE_"^"_Y,PSDSD=PSDSD-.00001
 S:'$P(PSDED,".",2) PSDED=PSDED+.99999
 W !!,"This report is designed for a 132 column format.",!,"You may queue this report to print at a later time.",!!
DEV ;sel device
 S Y=$P($G(^PSD(58.8,+PSDS,2)),"^",9),C=$P(^DD(58.8,24,0),"^",2) D Y^DIQ S PSDEV=Y
 W ! K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")=PSDEV D ^%ZIS I POP W !!,"NO DEVICE SELECTED OR REPORT PRINTED!!",! G END
 I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK S PSDIO=ION,ZTIO="",ZTRTN="START^PSDACT1",ZTDESC="CS PHARM Compile Daily Activity Log" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO G START^PSDACT1
END ;
 D KVAR^VADPT
 K %,%DT,%H,%I,%ZIS,ACT,ALL,BFWD,C,DA,DATE,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,LN,MFG,NAOU,NODE,NQTY,NUM
 K PAT,PG,PHARM,POP,PSD,PSDA,PSDATE,PSDED,PSDEV,PSDIO,PSDOUT,PSDPN,PSDR,PSDRG,PSDRGN,PSDS,PSDSD,PSDSN,PSDUZ,PSDUZN,RX,TEXT,TYP,QTY,TYPE,X,Y,VA("BID"),VA("PID")
 K ^TMP("PSDACT",$J),ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
SAVE ;sets variables for queueing
 S (ZTSAVE("PSDS"),ZTSAVE("PSDSN"),ZTSAVE("PSDSD"),ZTSAVE("PSDED"),ZTSAVE("PSDATE"),ZTSAVE("PSDIO"))=""
 S:$D(ALL) ZTSAVE("ALL")="" S:$D(PSDRG) ZTSAVE("PSDRG(")=""
 Q
