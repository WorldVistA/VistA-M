HLCSUTL1 ;ALB/JRP - COMMUNICATION SERVER UTILITIES;15-MAY-95
 ;;1.6;HEALTH LEVEL SEVEN;**99**;Oct 13, 1995
 ;
CRTFLR(TASKNUM,FLRTYPE) ;CREATE/FIND ENTRY IN FILER MULT OF FILE 869.3
 ;INPUT  : TASKNUM - Task number of filer
 ;         FLRTYPE - Indicates type of filer
 ;                   IN = Incoming (default)
 ;                   OUT = Outgoing
 ;OUTPUT : X - Entry number in INCOMING FILER TASK NUMBER multiple
 ;             (field #20) or OUTGOING FILER TASK NUMBER multiple
 ;             (field #30) of the HL COMMUNICATION SERVER PARAMETER
 ;             file (#869.3)
 ;         -1^ErrorText - Entry not created/found
 ;NOTES  : Entries in multiple will be DINUMed to their task number
 ;
 ;Check input
 S TASKNUM=+$G(TASKNUM)
 Q:('TASKNUM) "-1^Did not pass task number of filer"
 S FLRTYPE=$G(FLRTYPE)
 ;Declare variables
 N DA,DG,DIC,DINUM,DLAYGO,FLDNUM,NODE,PTRMAIN,PTRSUB,X,Y
 S NODE=$S(FLRTYPE="OUT":3,1:2)
 S FLDNUM=$S(FLRTYPE="OUT":30,1:20)
 ;Get entry in parameter file
 S PTRMAIN=+$O(^HLCS(869.3,0))
 Q:('PTRMAIN) "-1^Entry in file #869.3 does not exist"
 ;Set up call to FileMan
 S DIC="^HLCS(869.3,"_PTRMAIN_","_NODE_","
 S DIC(0)="LOX"
 S (X,DINUM)=TASKNUM
 S DLAYGO=869.3
 S DIC("DR")=".02///NO"
 ;These extra variables are needed since it's a multiple
 S DA(1)=PTRMAIN
 S DIC("P")=$P(^DD(869.3,FLDNUM,0),"^",2)
 ;Create/find entry
 D ^DIC
 S PTRSUB=+Y
 Q:(PTRSUB<1) "-1^Unable to create entry in filer multiple"
 Q PTRSUB
DELFLR(PTRSUB,FLRTYPE) ;DELETE ENTRY IN FILER MULT OF FILE 869.3
 ;INPUT  : PTRSUB - Pointer to incoming or outgoing filer subentry
 ;         FLRTYPE - Indicates type of filer
 ;                   IN = Incoming (default)
 ;                   OUT = Outgoing
 ;OUTPUT : None
 ;NOTES  : This will delete the entry in the INCOMING FILER TASK NUMBER
 ;         multiple (field #20) or OUTGOING FILER TASK NUMBER multiple
 ;         (field #30) of the HL COMMUNICATION SERVER PARAMETER
 ;         file (#869.3) without prompting for confirmation
 ;
 ;Check input
 Q:('$G(PTRSUB))
 S FLRTYPE=$G(FLRTYPE)
 ;Declare variables
 N DA,DG,DIK,NODE,PTRMAIN
 S NODE=$S(FLRTYPE="OUT":3,1:2)
 ;Get entry in parameter file
 S PTRMAIN=+$O(^HLCS(869.3,0))
 Q:('PTRMAIN)
 ;Nothing to delete
 Q:('$D(^HLCS(869.3,PTRMAIN,NODE,PTRSUB)))
 ;Set up call to FileMan
 S DIK="^HLCS(869.3,"_PTRMAIN_","_NODE_","
 S DA=PTRSUB
 S DA(1)=PTRMAIN
 ;Delete subentry
 D ^DIK
 Q
SETFLRDH(PTRSUB,FLRTYPE) ;UPDATE $H FIELD FOR FILER MULT IN FILE 869.3
 ;INPUT  : PTRSUB - Pointer to incoming or outgoing filer subentry
 ;         FLRTYPE - Indicates type of filer
 ;                   IN = Incoming (default)
 ;                   OUT = Outgoing
 ;OUTPUT : None
 ;NOTES  : This updates the LAST KNOW $H field (.03) of the INCOMING
 ;         FILER TASK NUMBER and OUTGOING FILER TASK NUMBER multiples
 ;         (fields 20 & 30) of the HL COMMUNICATION SERVER PARAMETER
 ;         file (#869.3)
 ;
 ;Check input
 Q:('$G(PTRSUB))
 S FLRTYPE=$G(FLRTYPE)
 ;Declare variables
 N DA,DG,DIE,DR,LOCKTRY,NODE,PTRMAIN
 S NODE=$S(FLRTYPE="OUT":3,1:2)
 ;Get entry in parameter file
 S PTRMAIN=+$O(^HLCS(869.3,0))
 Q:('PTRMAIN)
 ;Subentry doesn't exist
 Q:('$D(^HLCS(869.3,PTRMAIN,NODE,PTRSUB)))
 ;Lock subentry
 F LOCKTRY=0:1:20 L +^HLCS(869.3,PTRMAIN,NODE,PTRSUB):1 I ($T) S LOCKTRY=0 Q
 ;Couldn't lock subentry
 Q:(LOCKTRY)
 ;Set up call to FileMan
 S DIE="^HLCS(869.3,"_PTRMAIN_","_NODE_","
 S DA(1)=PTRMAIN
 S DA=PTRSUB
 S DR=".03///"_$H
 ;Update value
 D ^DIE
 ;Unlock subentry
 L -^HLCS(869.3,PTRMAIN,NODE,PTRSUB)
 Q
STOPFLR(PTRSUB,FLRTYPE) ;UPDATE STOP FIELD FOR FILER MULT IN FILE 869.3
 ;INPUT  : PTRSUB - Pointer to incoming or outgoing filer subentry
 ;         FLRTYPE - Indicates type of filer
 ;                   IN = Incoming (default)
 ;                   OUT = Outgoing
 ;OUTPUT : None
 ;NOTES  : This sets the STOP FILER field (#.02) of the INCOMING
 ;         FILER TASK NUMBER and OUTGOING FILER TASK NUMBER multiples
 ;         (fields 20 & 30) of the HL COMMUNICATION SERVER PARAMETER
 ;         file (#869.3).  Setting this field to YES will ask the
 ;         filer to stop.
 ;
 ;Check input
 Q:('$G(PTRSUB))
 S FLRTYPE=$G(FLRTYPE)
 ;Declare variables
 N PTRMAIN,NODE,DIE,DA,DR,LOCKTRY
 S NODE=$S(FLRTYPE="OUT":3,1:2)
 ;Get entry in parameter file
 S PTRMAIN=+$O(^HLCS(869.3,0))
 Q:('PTRMAIN)
 ;Subentry doesn't exist
 Q:('$D(^HLCS(869.3,PTRMAIN,NODE,PTRSUB)))
 ;Lock subentry
 F LOCKTRY=0:1:20 L +^HLCS(869.3,PTRMAIN,NODE,PTRSUB):1 I ($T) S LOCKTRY=0 Q
 ;Couldn't lock subentry
 Q:(LOCKTRY)
 ;Set up call to FileMan
 S DIE="^HLCS(869.3,"_PTRMAIN_","_NODE_","
 S DA(1)=PTRMAIN
 S DA=PTRSUB
 S DR=".02///YES"
 ;Update value
 D ^DIE
 ;Unlock subentry
 L -^HLCS(869.3,PTRMAIN,NODE,PTRSUB)
 Q
 ;
CLEAN ; Clean out invalid 869.3 data.  (HL*1.6*99 Post-init routine)
 N IEN,KILLSUB,MIEN,SUB
 S IEN=0
 F  S IEN=$O(^HLCS(869.3,IEN)) Q:IEN'>0  D
 .  F SUB=2,3 D  ; Errors only in 2, but adding 3 just in case...
 .  .  S MIEN=0
 .  .  S MIEN=$O(^HLCS(869.3,IEN,SUB,MIEN)) Q:MIEN'>0  D
 .  .  .  S KILLSUB=0  ; Leave the zero node, but all above go!
 .  .  .  F  S KILLSUB=$O(^HLCS(869.3,IEN,SUB,MIEN,KILLSUB)) Q:KILLSUB'>0  D
 .  .  .  .  KILL ^HLCS(869.3,IEN,SUB,MIEN,KILLSUB)
 QUIT
 ;
