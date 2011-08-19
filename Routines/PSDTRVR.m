PSDTRVR ;BIR/BJW-CS Transfer Between Vaults Report ; 12 Feb 98
 ;;3.0; CONTROLLED SUBSTANCES ;**8,23**;13 Feb 97
 ;**Y2K compliance**,"P" added to input date string
 ;Reference to ^PS(59.4 supported by DBIA #1043
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 I '$D(^XUSEC("PSJ RPHARM",DUZ))&('$D(^XUSEC("PSD TECH",DUZ))) W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to",!,?12,"print CS reports.",!!,"PSJ RPHARM or PSD TECH security key required.",! Q
 W !!,"CS Transfer Controlled Substances Between Vaults Report",!
ASK K DA,DIR,DTOUT,DUOUT S DIR(0)="YO",DIR("A")="Do you wish to print a Transferred/Received By signature line",DIR("B")="NO"
 S DIR("?")="Answer YES to print the signature line, NO or <RET> to omit the signature line."
 D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) G END
 S ASK=+Y
SITE ;sel one, some or all inp sites
 S CNT=0 F JJ=0:0 S JJ=$O(^PS(59.4,JJ)) Q:'JJ  I $P($G(^PS(59.4,JJ,0)),"^",31) S SITE(JJ)="",CNT=CNT+1
 I 'CNT W !!,"There are no Inpatient Sites defined for Controlled Substances use.",!,"Please contact your Pharmacy Coordinator for assistance.",! G END
 G:CNT=1 DATE K SITE
 W !!,?2,"You may display Dispensing Sites transfers from a single Inpatient Site, ",!,?2,"several Inpatient Sites, or enter ^ALL to select all Inpatient Sites.",!!
 F  S DIC=59.4,DIC("A")="Select Inpatient Site: ",DIC(0)="QEA",DIC("S")="I $P(^(0),""^"",31)" D ^DIC K DIC Q:Y<0  S SITE(+Y)=""
 G END:$O(SITE(0))'>0 I '$D(SITE)&(X'="^ALL") G END
 I X="^ALL" F PSD=0:0 S PSD=$O(^PS(59.4,PSD)) Q:'PSD  I $P($G(^PS(59.4,PSD,0)),"^",31) S SITE(PSD)=""
DATE ;ask date range
 W ! K %DT S %DT="AEP",%DT("A")="Start with Date: " D ^%DT I Y<0 S PSDOUT=1 G END
 S PSDSD=Y D D^DIQ S PSDATE=Y,%DT("A")="End with Date: " D ^%DT I Y<0 S PSDOUT=1 G END
 I Y<PSDSD W !!,"The ending date of the range must be later than the starting date." G DATE
 S PSDED=Y D D^DIQ S PSDATE=PSDATE_"^"_Y,PSDSD=PSDSD-.0001,PSDED=PSDED+.9999
DEV ;dev & queue info
 W !!,"This report is designed for a 80 column format.",!,"You may queue this report to print at a later time.",!!
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDTRVR1",ZTDESC="CS Transfer Between Vaults Report" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO G ^PSDTRVR1
END ;
 K %,%DT,%H,%I,%ZIS,ASK,CNT,DA,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,JJ,OK
 K POP,PSD,PSDATE,PSDED,PSDOUT,PSDSD,SITE,SITEN,X,Y,ZTDESC,ZTDTH,ZTRTN,ZTSAVE,ZTSK
 K ^TMP("PSDTRVR",$J) D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
SAVE S (ZTSAVE("SITE("),ZTSAVE("PSDSD"),ZTSAVE("PSDED"),ZTSAVE("ASK"),ZTSAVE("PSDATE"))=""
 Q
