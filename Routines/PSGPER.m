PSGPER ;BIR/CML3-PRINTS PRE-EXCHANGE NEEDS REPORT ;04 JAN 95 / 5:08 PM
 ;;5.0; INPATIENT MEDICATIONS ;**95,115,127,133**;16 DEC 97
 ;
 S PSGPERRF=0
DEV ;
 S PSGION=ION
DEV1 ;
 Q:'$$DEFON^PSGPER1
 S D=$G(PSGPXDEV) S:'D D=$P(PSJSYSW0,U,29) S:D="" D="HOME" S IOP=$S(D:"`"_D,1:D) K %ZIS S %ZIS="NQ" D ^%ZIS S D=$G(ION)
 K IOP,%ZIS,IO("Q"),ION S %ZIS="QM",%ZIS("A")="Select DEVICE for PRE-EXCHANGE UNITS REPORT: ",%ZIS("B")=D D ^%ZIS K %ZIS
 I POP D POP G:%=1 DEV1 G DONE
 I $G(ION)]"",D'=ION D CURDEF
 I $D(IO("Q")) K ZTSAVE S PSGTIR="^PSGPER0",ZTDESC="PRE-EXCHANGE UNITS REPORT",ZTDTH=$H,ZTSAVE("PSGPXN")="" D ENTSK^PSGTI G:'$D(ZTSK) DEV K ZTSK G OUT
 D ENP^PSGPER0:'$G(PSGPXPT),ENPAT^PSGPER0:$G(PSGPXPT),AG
 I %=1 S PSGPERRF=1 G DEV
 ;
DONE ;
 S DIK="^PS(53.4,",DA=PSGPXN D ^DIK
 ;
OUT ;
 K PSGPERRF,PSGPXN
 Q:$G(PSJCOM)!$G(PSJPREX)
 N PSJSYSW0,PSGVBW,PSJPWD,PSJSYSL D  Q
 . D:'$G(PSGPXPT) ENIVKV^PSGSETU
 ;
POP ;
 S %=2 W:'PSGPERRF !!,"IF A DEVICE IS NOT CHOSEN, NO REPORT WILL BE RUN AND THE DATA WILL NO LONGER BE RETRIEVABLE THROUGH THIS REPORT."
 I 'PSGPERRF F  W !,"Do you want another chance to choose a device" S %=1 D YN^DICN Q:%  W !?3,"Enter 'YES' to choose a device to print.  Enter 'NO' to quit now."
 I %'=1 S IOP=PSGION D ^%ZIS S %=2
 Q
 ;
AG ;
 F  W !!,"DO YOU NEED TO PRINT THIS REPORT AGAIN" S %=2 D YN^DICN Q:%  D AGMSG
 Q
 ;
AGMSG ;
 I %Y'?1."?" W $C(7),"  ANSWER 'YES' OR 'NO' (Entry required)" Q
 W !,"  Enter 'YES' to print this report again.  Enter 'NO' (or an '^') to quit",!,"now.  PLEASE NOTE that you will NOT be able to retrieve this data at a later",!,"date.  You should print this information now." Q
CURDEF ;
 Q:$G(PSGPXDEV)=0
 K DIC,DR,DA,X,Y,DIE S DIC="^%ZIS(1,",DIC(0)="SOX",X=ION D ^DIC Q:'($G(Y)>0)
 N D S D=+$G(Y)
 F  W !!,"Keep ",ION," as the PRE-EXCHANGE REPORT DEVICE for this session" S %=0 D YN^DICN S PSGPXDEV=$S(%=1:D,1:0) Q:%  D DEFMSG
 I $G(Y) S $P(PSJSYSW0,"^",29)=+Y
 K DIC,DR,DA,X,Y,DIE
 Q
 ;
DEFMSG ;
 I %Y'?1."?" W !,$C(7),"     ANSWER 'YES' OR 'NO' (Entry required)" Q
 W !!,"  Enter 'YES' to make ",ION," the PRE-EXCHANGE REPORT default DEVICE"
 W !,"  for the current session. PLEASE NOTE that this will override the ward"
 W !,"  default PRE-EXCHANGE REPORT DEVICE for this session only."
 Q
