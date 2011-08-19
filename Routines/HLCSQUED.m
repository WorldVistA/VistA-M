HLCSQUED ;ALB/MFK - Create and edit #870 entries
 ;;1.6;HEALTH LEVEL SEVEN;;Oct 13, 1995
EDITQ ;  edit or create an entry in a queue
 ; INPUT: NONE (made to be called from a menu)
 ; OUTPUT: NONE
 N DIR,DIE,DIC,DA,DR,FLAG,HLDIR,LLE,X,Y,HLZ,ENTRY,DTOUT,DUOUT
LINK ;
 S DIC="^HLCS(870,"
 S DIC(0)="AEMQ"
 D ^DIC K DIC
 Q:(+Y<0)
 S LLE=$P(Y,"^",1)
 Q:(LLE=-1)
DIRECT ;
 S DIR(0)="S^I:IN QUEUE;O:OUT QUEUE"
 S DIR("?")="Select the IN queue or OUT queue (relative to DHCP)"
 S DIR("A")="Select queue"
 S DIR("B")="I"
 D ^DIR K DIR
 Q:(+Y<0)!$D(DUOUT)!$D(DTOUT)
 S HLDIR=$E(Y,1,1)
 S HLDIR=$S(HLDIR="I":1,HLDIR="O":2)
EDCR ;
 S DIR(0)="S^C:CREATE;E:EDIT"
 S DIR("?")="Select if you want to EDIT or CREATE and entry in a queue"
 S DIR("A")="CREATE or EDIT entry"
 S DIR("B")="C"
 D ^DIR K DIR
 S FLAG=$E(Y,1,1)
 Q:(FLAG="^")!(FLAG=-1)!$D(DUOUT)!$D(DTOUT)
 I FLAG="C" S DA=$$CREATE(LLE,HLDIR)
 I FLAG="E" S DA=$$EDIT(LLE,HLDIR)
 Q:(DA'>0)
 S DIE="^HLCS(870,"_LLE_","_HLDIR_","
 S DR="3;1;2"
 W !,"Editing entry number: "_DA,!
 D ^DIE K DIE
 Q
CREATE(LLE,HLDIR) ;
 S ENTRY=$$ENQUEUE^HLCSQUE(LLE,HLDIR)
 S ENTRY=$P(ENTRY,"^",2)
 Q ENTRY
EDIT(LLE,HLDIR) ;
 N ENTRY
 S ENTRY=$O(^HLCS(870,LLE,HLDIR,0))
 I ENTRY'>0 W !,"No Entries in this Queue !" G EXED
 S DIC="^HLCS(870,"_LLE_","_HLDIR_","
 S DIC(0)="AEQM"
 D ^DIC K DIC
 S ENTRY=$P(Y,"^",1)
EXED Q ENTRY
EDIT2 ; Create/edit a queue in file #870
 ; The previous routine created an entry in the queue.  This
 ;  routine actually creates that queue.
 ; INPUT:  NONE (Made to be called from a menu)
 ; OUTPUT: NONE
 N DIC,DA,LLE,DR,DIE,X,Y
 S DIC="^HLCS(870,"
 S DIC(0)="AEMQL"
 D ^DIC K DIC
 Q:(+Y<0)
 S LLE=$P(Y,"^",1)
 S DR=".01;1;2;21;17;12;13;13.1;15;16"
 S DA=LLE
 S DIE="^HLCS(870,"
 D ^DIE K DIE
 Q
