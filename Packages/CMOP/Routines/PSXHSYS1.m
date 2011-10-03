PSXHSYS1 ;BIR/WPB/PDW-EDIT INTERAGENCY PARAMETERS ;MAR 1,2002@16:11:17
 ;;2.0;CMOP;**38**;11 Apr 97
EDITDOD ; this entry point grants access to the setting of the host directories 
 ; and the scheduling of the interface option for importing other agencies CMOP RXs
 ; Called from PSXHSYS the user must have the PSXDOD key
 ; 
 N TSK,DATE,HOUR,HOST,PSXOPTDA
 D EDIT
 Q
EDIT ;
 N PSXT,XX S XX="PSX DOD CMOP INTERFACE" D OPTSTAT^XUTMOPT(XX,.PSXT)
 I '+PSXT D  Q
 .W !,"You must first use Kernel Option Scheduling to setup the option 'PSX DOD CMOP INTERFACE'."
 ; gather existing information
 S XX="PSX DOD CMOP INTERFACE"
 K TSK D OPTSTAT^XUTMOPT(XX,.TSK) S TSK(1)=$G(TSK(1))
 S TSK=+TSK(1),DATE=$P(TSK(1),U,2),HOUR=$P(TSK(1),U,3)
 S Y=DATE X ^DD("DD") S DATE=Y
 K HOST D GETS^DIQ(554,1,"20:23","","HOST"),TOP^PSXUTL("HOST")
 ;display information
 W @IOF W !,"Host Directory Paths",?40,"Schedule"
 W !!,"In",?10,HOST(20),?40,"Next Run",?60,DATE
 W !,"Out",?10,HOST(21),?40,"Frequency",?60,HOUR
 W !,"Archive",?10,HOST(22),?40,"Tasking ID",?60,TSK
 W !,"Pending",?10,HOST(23)
 ;request edit information or quit
 K DIR S DIR(0)="SO^P:Paths;S:Schedule",DIR("A")="Edit  Paths <P>  or  Schedule <S>, or Exit <cr>"
 D ^DIR K DIR
 I Y'="S",Y'="P" Q
 ;edit information
 I Y="S" D EDIT^XUTMOPT("PSX DOD CMOP INTERFACE") G EDIT
 L +^PSX(554,1):600
 K DIE,DR,DA S DIE="^PSX(554,",DA=1,DR="20;21;22;23" D ^DIE
 L -^PSX(554,1)
 G EDIT
 Q
