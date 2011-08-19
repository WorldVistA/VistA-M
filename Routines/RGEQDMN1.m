RGEQDMN1 ;BHM/RGY-DEQUEUE PROCESSOR CONTINUED ;2/17/98
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**19**;30 Apr 99
STOP ;Stop dequeue processor
 NEW ENT,DIR,DTOUT,DUOUT,DIRUT,DIE,DA,DR,Y,STAT
 S DIR("A")="Do you want to stop ALL MPI/PD processing"
 S DIR(0)="Y",DIR("B")="NO"
 D ^DIR K DIR Q:$D(DIRUT)
 I Y=1 S ^RGEQ("ASTOP")="YES" W " ... Done" Q
 S DIR("A")="Do you want to ENABLE/DISABLE a particular data class"
 S DIR(0)="Y",DIR("B")="NO"
 D ^DIR K DIR Q:$D(DIRUT)
 I Y=1 D
   .S DIR(0)="PO^995:QEAM",DIR("A")="Select MPI/PD Data Class"
   .D ^DIR K DIR Q:$D(DIRUT)
   .S ENT=+Y,STAT=+$P(^RGEQASN(ENT,0),"^",5)
   .W !
   .S DIR("A",1)="NOTE: This class is currently "_$P("enabled^disabled","^",STAT+1)
   .S DIR("A")="   ...Do you want to "_$P("DISABLE^ENABLE","^",STAT+1)
   .S DIR(0)="Y",DIR("B")="NO"
   .D ^DIR K DIR Q:$D(DIRUT)
   .I Y=0 Q
   .S DIE="^RGEQASN(",DA=ENT,DR="5////^S X="_$P("1^0","^",STAT+1) D ^DIE
   .W " ...Done."
   .Q
 Q
START ;Start the queue processor
 NEW DIR,DTOUT,DUOUT,DIRUT,ZTSK,ZTIO,ZTRTN,ZTSAVE,ZTDESC
 L +^RGEQ("MAIN"):0 E  D  Q
   .W !!,"The MPI/PD processor is already running!"
   .Q
 L -^RGEQ("MAIN")
 S DIR("A")="Are you sure you want to start the MPI/PD processor"
 S DIR(0)="Y",DIR("B")="NO"
 D ^DIR K DIR Q:$D(DIRUT)
 I Y=1 D  Q
   .S ZTRTN="MAIN^RGEQDMN",ZTDESC="'MAIN' MPI/PD process"
   .S ZTREQ="@",ZTDTH=$H,ZTIO=""
   .D ^%ZTLOAD
   .I $G(ZTSK) W " ... done."
   .S ^RGEQ("ASTOP")="NO"
   .Q
 W "...NOT queued"
 Q
AUTO ;Automatically start background process
 NEW ZTSK,ZTIO,ZTRTN,ZTSAVE,ZTDESC
 L +^RGEQ("MAIN"):0 E  Q
 L -^RGEQ("MAIN")
 S ZTRTN="MAIN^RGEQDMN",ZTDESC="'MAIN' MPI/PD process"
 S ZTREQ="@",ZTDTH=$H,ZTIO=""
 D ^%ZTLOAD
 S ^RGEQ("ASTOP")="NO"
 Q
TEST(TYPE,PARAM,ERROR,HL7) ;Test queue processor
 Q
ESTOP(TYPE) ;Check to see if filer should stop
 I ($G(^RGEQ("ASTOP"))="YES")!($$SEND^RGJUSITE=0) Q 1
 I TYPE="MAIN" Q 0
 Q ($$SEND^RGJUSITE=2)!(+$P($G(^RGEQASN(+$O(^RGEQASN("B",TYPE,0)),0)),"^",5))
STATUS ;check current status of event queue, used for menu entry actions
 ;added by CML 4/1/99
 L +^RGEQ("MAIN"):0 E  D  Q
 .W !!,"=> MPI/PD Event Queue processor is currently running.",!
 .Q
 W $C(7),$C(7),!!,"=> MPI/PD Event Queue processor is <<NOT>> currently running.",!
 L -^RGEQ("MAIN")
 Q
