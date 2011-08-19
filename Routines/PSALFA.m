PSALFA ;BIR/LTL-Automated DRUG/ITEM MASTER file Link by FSN ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**15**; 10/24/97
 ;This routine automatically loops by FSN.
 ;References to $$DESCR^PRCPUX1 are covered by IA #259
 ;References to ^PSDRUG( are covered by IA #2095
 ;References to ^PRC( are covered by IA #214
 ;References to ^PSDRUG("AB" are covered by IA #2095
 ;
 D DT^DICRW
START ;sets up edit loop
 N D0,D1,DA,DIC,DIE,DLAYGO,DR,DTOUT,DUOUT,DIR,DIRUT,PSAD,PSADD,PSAF,PSAFSN,PSAIT,PSALN,PSAOUT,PSARPDT,PSAPG,X,Y
QUES S DIR(0)="Y",DIR("A")="Have you run the Report Potential FSN Matches option",DIR("??")="^D RUN^PSALFA",PSAOUT=1 D ^DIR K DIR G:$D(DIRUT) QUIT D:'Y
 .S DIR(0)="Y",DIR("A")="Would you like to run the report now",DIR("B")="Yes" D ^DIR K DIR D:Y ^PSALFS
 S DIR(0)="Y",DIR("A")="Are you ready to link ALL of the drugs that have matches in the ITEM MASTER file",DIR("B")="No" D ^DIR K DIR G:'Y QUIT
DEV ;asks device and queueing info
 W !,"I'll list each DRUG/ITEM MASTER file entry as they're linked.",!
 K IO("Q") N %ZIS,%ZIS,IOP,POP S %ZIS="Q",%ZIS("A")="Please select DEVICE for output: " D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G QUIT
 I $D(IO("Q")) N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK S ZTRTN="LOOP^PSALFA",ZTDESC="Linking DRUG/ITEM FILE by FSN" D ^%ZTLOAD,HOME^%ZIS S PSAOUT=1 G QUIT
LOOP S (PSAD,PSAPG,PSAOUT)=0,Y=DT D DD^%DT S PSARPDT=Y,Y=1 D HEADER
 F  S PSAD=$O(^PSDRUG(PSAD)) G:'PSAD QUIT D:$Y+4>IOSL HEADER G:PSAOUT QUIT I $P($G(^PSDRUG(PSAD,0)),U,6)]"",'$O(^PSDRUG(PSAD,441,0)),'$D(^PSDRUG(PSAD,"I")) D
FORM .S PSAFSN=$P(^PSDRUG(PSAD,0),U,6) W !,PSAFSN D
 ..I $O(^PRC(441,"BB",PSAFSN,0)) N PSADD S PSAIT=$O(^PRC(441,"BB",PSAFSN,0)) D  W !,$E($P(^PSDRUG(PSAD,0),U),1,39),?40,$E($$DESCR^PRCPUX1(0,PSAIT),1,39),! D:'$D(PSADD) LINK
USED ...I $O(^PSDRUG("AB",PSAIT,"")) S PSADD=$O(^PSDRUG("AB",PSAIT,"")) W !,"**"_$P(^PSDRUG(PSADD,0),U)_" is already linked to Item #"_PSAIT_"**"
INAC ...I $E($G(^PRC(441,PSAIT,3)),1)=1 W !,"Sorry, Item #"_PSAIT_" is INACTIVE, can't link.",! S PSADD=""
QUIT W:$E(IOST)'="C" @IOF
 I $E(IOST,1,2)="C-",'PSAOUT W !! S DIR(0)="E",DIR("A")="END OF REPORT!  Press <RET> to return to the menu" D ^DIR
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" K IO("Q") Q
LINK S DIE=50,DA=PSAD,DR="441///^S X=PSAIT" D ^DIE W "Linked to Item #"_PSAIT Q
HEADER ;prints header info
 I $E(IOST,1,2)'="P-",PSAPG S DIR(0)="E" D ^DIR K DIR I 'Y S PSAOUT=1 Q
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),U),"." S PSAOUT=1 Q
 W:$Y @IOF S $P(PSALN,"-",81)="",PSAPG=PSAPG+1 W !?2,"Linking DRUG/ITEM MASTER file by FSN",?55,PSARPDT,?70,"PAGE: "_PSAPG,!,PSALN,!,"DRUG file",?40,"ITEM MASTER file"
 Q
READY ;Extended help for 'Have you run the Report Potential FSN Matches option?'
 W !?5,"Enter YES to begin linking every drug that has been matched.",!?5,"Enter NO to exit the option."
 Q
RUN ;Extended help to 'Have you run the Report Potential FSN Matches option?'
 W !?5,"Enter YES if you have run the Report Potential FSN Matches option",!?5,"and produced a report.",!!?5,"Enter NO if you have not run the option.  You will be given the",!?5,"opportunity to run the report now."
 Q 
