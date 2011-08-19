PSNDELTE ;BIRM/WRT-Deletes PMI files for PMI Update Patches ; 10/27/03 10:27
 ;;4.0; NATIONAL DRUG FILE;**75**; 30 Oct 98
 Q
START ; Begin update process
 W !!,"This option will run the auto-mapping process. This will be accomplished by",!,"taking NDCs from NDC/UPN file #50.67 and the VA Products tied to these NDCs"
 W !,"in file #50.68 AND attempt to find a match in PMI NDC/GCNSEQNO file #50.628."
 W ! S DIR("A")="Are you sure you are ready to proceed? "
 S DIR("B")="NO",DIR(0)="YA" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) Q
 I Y=0 Q
 Q
 ;
 ;
BEGIN I $D(DUZ)#2 N DIC,X,Y S DIC=200,DIC(0)="N",X="`"_DUZ D ^DIC I Y>0,$D(DUZ(0))#2,DUZ(0)="@" G TEXT
 E  W !!,"You must be a valid user with DUZ(0)=""@"""
 Q
TEXT W !,"This option will automatically DELETE all Patient Medication Information Sheet",!,"data from your system."
 W !!,"If you are not absolutely sure what you are about to do, exit this option",!,"immediately by entering ""^"" at the next prompt."
 W !!,"This option should only be used when installing a update Patient Medication",!,"Information Sheet Data Update patch."
 W "Immediately after running this option, the",!,"new data global MUST be installed using instructions from the Patient Medication",!,"Sheet Data Update patch."
 W !,"You are about to DELETE ALL Patient Medication Sheet data from the following",!,"files:",!
 W !!,?7,"50.621       PMI-ENGLISH             ^PS(50.621,"
 W !,?7,"50.622       PMI-SPANISH             ^PS(50.622,"
 W !,?7,"50.623       PMI MAP-ENGLISH         ^PS(50.623,"
 W !,?7,"50.624       PMI MAP-SPANISH         ^PS(50.624,"
 W !,?7,"50.625       WARNING LABEL-ENGLISH   ^PS(50.625,"
 W !,?7,"50.626       WARNING LABEL-SPANISH   ^PS(50.626,"
 W !,?7,"50.627       WARNING LABEL MAP       ^PS(50.627,"
 W ! S DIR("A")="Are you sure you want to delete the Patient Medication Information Sheet data?   "
 S DIR("B")="NO",DIR(0)="YA" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) Q
 I Y=0 Q
 D SECND
 Q
SECND ; Ask a second time
 W !!,"Because running this process inadvertently could cause serious problems, you",!,"will be asked to confirm that you want to proceed."
 K DIR W ! S DIR("A")="Are you sure you are ready to proceed, deleting the Patient Medication          Information Sheet data?  "
 S DIR("B")="NO",DIR(0)="YA" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) Q
 I Y=0 Q
DELETE  K ^PS(50.621),^PS(50.622),^PS(50.623),^PS(50.624),^PS(50.625),^PS(50.626),^PS(50.627)
 W !!,"Deleting all Patient Medication Information Sheet data...",!,"The deletion process has completed.",!!,"Now, IMMEDIATELY install (restore) the new data global from the latest"
 W !,"Patient Medication Information Sheet data update patch."
 Q
