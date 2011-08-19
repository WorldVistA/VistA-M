PSALNA ;BIR/LTL-Automated DRUG/ITEM MASTER file Link by NDC ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**15**; 10/24/97
 ;
 ;References to ^PSDRUG( are covered by IA #2095
 ;References to ^PRC( are covered by IA #214
 ;References to ^PSDRUG("AB" are covered by IA #2095
 ;
 D DT^DICRW
START ;sets up edit loop
 N D0,D1,DA,DIC,DIE,DLAYGO,DR,DIR,DIRUT,DTOUT,DUOUT,PSAD,PSADD,PSAIT,PSALN,PSAOUT,PSAPG,PSARPDT,X,Y
QUES S DIR(0)="Y",DIR("A")="Have you run the Report Potential NDC Matches option",DIR("??")="^D RUN^PSALNA",PSAOUT=1 D ^DIR K DIR G:$D(DIRUT) QUIT D:Y<1  G:PSAOUT QUIT
 .S DIR(0)="Y",DIR("A")="Would you like to run the report now",DIR("B")="YES",DIR("??")="^D NOW^PSALNA" D ^DIR K DIR S:$G(DIRUT) PSAOUT=1 I Y D ^PSALND S PSAOUT=0
 W ! S DIR(0)="Y",DIR("A",1)="Are you ready to link ALL of the drugs",DIR("A")="that have matches in the ITEM MASTER file",DIR("B")="N",DIR("??")="^D READY^PSALNA"
 D ^DIR K DIR G:'Y!($G(DIRUT)) QUIT
DEV ;asks device and queueing info
 W !!,"I'll list each DRUG/ITEM MASTER file entry as they're linked.",!
 K IO("Q") N %ZIS,%ZIS,IOP,POP S %ZIS="Q",%ZIS("A")="Please select DEVICE for output: " D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G QUIT
 I $D(IO("Q")) N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK S ZTRTN="LOOP^PSALNA",ZTDESC="Linking DRUG/ITEM FILE by NDC" D ^%ZTLOAD,HOME^%ZIS S PSAOUT=1 G QUIT
LOOP S (PSAD,PSAPG,PSAOUT)=0,Y=DT D DD^%DT S PSARPDT=Y,Y=1 D HEADER
 F  K PSADD S PSAD=$O(^PSDRUG(PSAD)) G:'PSAD QUIT D:$Y+4>IOSL HEADER G:PSAOUT QUIT W:'(PSAD#100) "." I $P($G(^PSDRUG(PSAD,2)),U,4)]"" S PSAD(1)=$P($G(^(2)),U,4) D:'$D(^PSDRUG(PSAD,"I"))
 .S PSAIT=$$ITEM^PSAUTL(PSAD(1)) Q:'PSAIT  I $D(^PRC(441,+PSAIT,0)) D  Q:$D(PSADD)  W !,$E($P(^PSDRUG(PSAD,0),U),1,39),?40,$E($P(^PRC(441,PSAIT,0),U,2),1,39),!
NOT ..S:$O(^PSDRUG("AB",PSAIT,"")) PSADD="" I $D(^PRC(441,PSAIT,3)),$P(^(3),U)=1 S PSADD=""
OK .I '$D(PSADD) S DIE=50,DA=PSAD,DR="441///^S X=PSAIT" D ^DIE W "Linked to Item #"_PSAIT
QUIT I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSAOUT W !! S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu." D ^DIR
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" K IO("Q") Q
HEADER ;prints header info
 I $E(IOST,1,2)'="P-",PSAPG S DIR(0)="E" D ^DIR K DIR I 'Y S PSAOUT=1 Q
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),U),"." S PSAOUT=1 Q
 W:$Y @IOF S $P(PSALN,"-",81)="",PSAPG=PSAPG+1 W !?2,"Linking DRUG/ITEM MASTER file by NDC",?55,PSARPDT,?70,"PAGE: "_PSAPG,!,PSALN,!,"DRUG file",?40,"ITEM MASTER file"
 Q
NOW ;Extended help to 'Would you like to run the report now?'
 W !?5,"Enter YES if you want to print the report now.",!!?5,"Enter NO if you do not want to run the report now.",!?5,"You will not exit the option."
 Q
READY ;Extended help to 'Are you ready to link ALL of the drugs that have matches in the ITEM MASTER file?'
 W !?5,"Enter YES to begin linking every drug that has been matched.",!?5,"Enter NO to exit the option."
 Q
RUN ;Extended help to 'Have you run the Report Potential NDC Matches option?'
 W !?5,"Enter YES if you have run the Report Potential NDC Matches option",!?5,"and produced a report.",!!?5,"Enter NO if you have not run the option. You will be given the",!?5,"opportunity to run the report now."
 Q 
