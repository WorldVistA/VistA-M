VAFHPOST ;ALB/JRP,PKE - VAFH POST INIT DRIVER;04-JUN-1996
 ;;5.3;Registration;**91**;AUG 14, 1993
 ;
CHKPTS ;Create check points for post-init
 ;Input  : All variables set by KIDS
 ;Output : None
 ;
 ;Declare variables
 N TMP,X,Y,%,%H
 ;Create check points
 ;
 ;Fix server protocol
 ;;;S TMP=$$NEWCP^XPDUTL("VAFH01","FIXSRVR^VAFHPST1") KIDS CANDO
 ;Fix client protocol
 ;;;S TMP=$$NEWCP^XPDUTL("VAFH02","FIXCLNT^VAFHPST1") KIDS CANDO
 ;
 ;Set Faciltiy name in VAFH,C PIMS, HL7 APPLICATION - File #771
 S TMP=$$NEWCP^XPDUTL("VAFH02","FACILITY^VAFHPST1")
 ;Set PIVOT
 S TMP=$$NEWCP^XPDUTL("VAFH03","PARA^VAFHPST1")
 ;Recompile templates
 S TMP=$$NEWCP^XPDUTL("VAFH04","COMPILE^VAFHPST1")
 ;Disable old philly application
 S TMP=$$NEWCP^XPDUTL("VAFH05","DISABLE^VAFHPST1")
 ;Done
 Q
 ;setup fields not available in HL7 toolkit.
SETUP W !?3
 W "For VAFH entries........"
 W !!?3
 W "You may change NAME of the VAFHL7 TEMPLATE entry"
 W !?3
 W "in the HL7 APPLICATION file to the NAME of the Receiving Application,"
 W !!?3
 W "and the NAME of the VAFH-SEND entry in the HL LOWER LEVEL PROTOCOL PARAMETER "
 W !?3
 W "file #869.2,"
 W !!?3
 W "and the NAME of the VAFH-SEND entry in the HL LOGICAL LINK file #870."
 W !
 ;
 W !!?3,"Editing HL7 APPLICATION File #771"
 S (DIC,DIE)="^HL(771,",DIC("B")="VAFHL7 TEMPLATE",DIC(0)="QEAM" D ^DIC
 I Y<0 Q
 S DA=+Y,DR=".01//" D ^DIE
 ;
 W !!?3,"Editing HL LOWER LEVEL PROTOCOL PARAMETER File #869.2"
 S (DIC,DIE)="^HLCS(869.2,",DIC("B")="VAFH-SEND",DIC(0)="QEAM" D ^DIC
 I Y<0 Q
 S DA=+Y,DR=".01//" D ^DIE
 ;
 W !!?3,"Editing HL LOGICAL LINK File #870"
 S (DIC,DIE)="^HLCS(870,",DIC("B")="VAFH-SEND",DIC(0)="QEAM" D ^DIC
 I Y<0 Q
 S DA=+Y,DR=".01//" D ^DIE
 ;
 W !!?3,"ok..."
 W !
KILL K D0,DIC,DIE,DA,DR,DTOUT,DUOUT,DISYS,%
 Q
 ;setup fields not available in HL7 toolkit.
SETUP23 W !?3
 W "For VAFC entries........"
 W !!?3
 W "You may change NAME of the VAFCHL7TEMPLATE entry"
 W !?3
 W "in the HL7 APPLICATION file to the NAME of the Receiving Application,"
 W !!?3
 W "and the NAME of the VAFC-SEND entry in the HL LOWER LEVEL PROTOCOL PARAMETER "
 W !?3
 W "file #869.2,"
 W !!?3
 W "and the NAME of the VAFC-SEND entry in the HL LOGICAL LINK file #870."
 W !
 ;
 W !!?3,"Editing HL7 APPLICATION File #771"
 S (DIC,DIE)="^HL(771,",DIC("B")="VAFCHL7TEMPLATE",DIC(0)="QEAM" D ^DIC
 I Y<0 Q
 S DA=+Y,DR=".01//" D ^DIE
 ;
 W !!?3,"Editing HL LOWER LEVEL PROTOCOL PARAMETER File #869.2"
 S (DIC,DIE)="^HLCS(869.2,",DIC("B")="VAFC-SEND",DIC(0)="QEAM" D ^DIC
 I Y<0 Q
 S DA=+Y,DR=".01//" D ^DIE
 ;
 W !!?3,"Editing HL LOGICAL LINK File #870"
 S (DIC,DIE)="^HLCS(870,",DIC("B")="VAFC-SEND",DIC(0)="QEAM" D ^DIC
 I Y<0 Q
 S DA=+Y,DR=".01//" D ^DIE
 ;
 W !!?3,"ok..."
 W !
 D KILL
 Q
 ;
SEND N SET S SET=$$EDIT(1) I SET W !?3,"SEND PIMS HL7 v2.2 MESSAGES is set to SEND" Q
 E  W !?3,$P(SET,"^",2) Q
 ;
STOP N SET S SET=$$EDIT(0) I SET W !?3,"SEND PIMS HL7 v2.2 MESSAGES is set to STOP" Q
 E  W !?3,$P(SET,"^",2) Q
 ;
EDIT(ON) ;
 N DIC,DIE,DR,DA,X,Y
 D DT^DICRW
 S (DIC,DIE)="^DG(43,",X=1,DIC(0)=""
 D ^DIC I Y<1 Q "0^Failed to find MAS Parameter file"
 ;
 S DA=+Y,DR="391.7012///"_ON_";"
 L +^DG(43,1):5 I '$T Q "0^MAS Parameters being edited"
 D ^DIE
 L -^DG(43,1)
 Q 1
 ;
SEND23 N SET S SET=$$EDIT23(1) I SET W !?3,"SEND PIMS HL7 v2.3 MESSAGES is set to SEND" Q
 E  W !?3,$P(SET,"^",2) Q
 ;
STOP23 N SET S SET=$$EDIT23(0) I SET W !?3,"SEND PIMS HL7 v2.3 MESSAGES is set to STOP" Q
 E  W !?3,$P(SET,"^",2) Q
 ;
EDIT23(ON) ;
 N DIC,DIE,DR,DA,X,Y
 D DT^DICRW
 S (DIC,DIE)="^DG(43,",X=1,DIC(0)=""
 D ^DIC I Y<1 Q "0^Failed to find MAS Parameter file"
 ;
 S DA=+Y,DR="391.7013///"_ON_";"
 L +^DG(43,1):5 I '$T Q "0^MAS Parameters being edited"
 D ^DIE
 L -^DG(43,1)
 Q 1
