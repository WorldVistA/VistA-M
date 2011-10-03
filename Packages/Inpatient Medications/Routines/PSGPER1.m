PSGPER1 ;BIR/CML3-PRINTS PRE-EXCHANGE NEEDS REPORT ;18 MAR 03 / 5:08 PM
 ;;5.0; INPATIENT MEDICATIONS ;**80,127**;16 DEC 97
 ;
 S PSGPERRF=0
DEV ;
 S PSGION=ION
DEV1 K IOP,%ZIS,IO("Q") S %ZIS="Q",%ZIS("A")="Select DEVICE for PRE-EXCHANGE UNITS REPORT: ",%ZIS("B")="" W ! D ^%ZIS K %ZIS
 I POP D POP G:%=1 DEV1 G DONE
 I $D(IO("Q")) K ZTSAVE S PSGTIR="^PSGPER2",ZTDESC="PRE-EXCHANGE UNITS REPORT",ZTDTH=$H,ZTSAVE("PSGPXN")="" D ENTSK^PSGTI G:'$D(ZTSK) DEV K ZTSK G OUT
 D ENP^PSGPER2,AG I %=1 S PSGPERRF=1 G DEV
 ;
DONE ;
 S DIK="^PS(53.4,",DA=PSGPXN D ^DIK
 ;
OUT ;
 K PSGPERRF,PSGPXN
 Q:$G(PSJCOM)!$G(PSJPREX)
 D ENIVKV^PSGSETU,ENCV^PSGSETU
 Q
 ;
POP ;
 S %=2 W:'PSGPERRF !!,"IF A DEVICE IS NOT CHOSEN, NO REPORT WILL BE RUN AND THE DATA WILL NO LONGER BE RETRIEVABLE THROUGH THIS REPORT."
 I 'PSGPERRF F  W !,"Do you want another chance to choose a device" S %=1 D YN^DICN Q:%  W !?3,"Enter 'YES' to choose a device to print.  Enter 'NO' to quit now."
 I %'=1 S IOP=PSGION D ^%ZIS S %=2
 Q
 ;
AG ;
 F  W !!,"DO YOU NEED TO PRINT THIS REPORT AGAIN" S %=0 D YN^DICN Q:%  D AGMSG
 Q
 ;
AGMSG ;
 I %Y'?1."?" W $C(7),"  ANSWER 'YES' OR 'NO' (Entry required)" Q
 W !,"  Enter 'YES' to print this report again.  Enter 'NO' (or an '^') to quit",!,"now.  PLEASE NOTE that you will NOT be able to retrieve this data at a later",!,"date.  You should print this information now." Q
 ;
DEFON() ; All Pre-Exchange Devices have been removed from Ward Parameters - restore previous functionality
 N ON,W S ON=0,W=0 F  S W=$O(^PS(59.6,W)) Q:'W!ON  I $P(^(W,0),U,29)]"" S ON=1
 I $G(PSJPXDOF) S ON=0 K PSJPXDOF
 Q ON
