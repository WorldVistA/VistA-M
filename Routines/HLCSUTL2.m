HLCSUTL2 ;ALB/JRP - COMMUNICATION SERVER UTILITIES;15-MAY-95 ;11/06/2000  06:39
 ;;1.6;HEALTH LEVEL SEVEN;**18,28,62**;Oct 13, 1995
CHK4STOP(PTRSUB,FLRTYPE,HLEXIT) ;DETERMINE IF FILER SHOULD STOP
 ;INPUT  : PTRSUB - Pointer to incoming or outgoing filer subentry
 ;         FLRTYPE - Indicates type of filer
 ;                   IN = Incoming (default)
 ;                   OUT = Outgoing
 ;         HLEXIT - =0 (must be set by calling routine)
 ;         HLEXIT("LASTCHK") - The last time the check was done. (Set by
 ;               this routine for input to the next call to this routine
 ;OUTPUT : HLEXIT - Indicates whether Filer/task has been asked to stop
 ;                  0 = no; 1 = yes
 ;         HLEXIT("LASTCHK") - The last time the check was done.
 ;NOTES  : This checks the STOP FILER field (#.02) of the INCOMING
 ;         FILER TASK NUMBER and OUTGOING FILER TASK NUMBER multiples
 ;         (fields 20 & 30) of the HL COMMUNICATION SERVER PARAMETER
 ;         file (#869.3).  If this field is set to YES, the filer
 ;         has been asked to stop.  After checking this, TaskMan
 ;         will be asked if the task has been asked to stop [by
 ;         calling $$S^%ZTLOAD].
 ;       : FileMan is not used when determining if the STOP FILER field
 ;         has been set to YES
 Q:$$HDIFF^XLFDT($H,$G(HLEXIT("LASTCHK")),2)<60
 ;Check input
 S PTRSUB=+$G(PTRSUB)
 S FLRTYPE=$G(FLRTYPE)
 ;Declare variables
 N PTRMAIN,NODE
 S NODE=$S(FLRTYPE="OUT":3,1:2)
 ;Get entry in parameter file
 S PTRMAIN=+$O(^HLCS(869.3,0))
 I PTRMAIN D  Q:HLEXIT
 .;Lock/unlock zero node of multiple - force buffer update
 .L +^HLCS(869.3,PTRMAIN,NODE,0):1
 .L -^HLCS(869.3,PTRMAIN,NODE,0)
 .;If subentry doesn't exist, filer won't die off
 .I '$D(^HLCS(869.3,PTRMAIN,NODE,PTRSUB)) S HLEXIT=1 Q
 .N NODE1
 .;Get subentry zero node
 .S NODE1=$G(^HLCS(869.3,PTRMAIN,NODE,PTRSUB,0))
 .I NODE1="" S HLEXIT=1 Q
 .;no record of task
 .I $P(NODE1,"^")="" S HLEXIT=1 Q
 .;STOP FILER field is piece 2
 .I +$P(NODE1,"^",2) S HLEXIT=1
 ;Filer asked to stop
 ;Check if filer asked to stop via TaskMan
 I +$$S^%ZTLOAD S HLEXIT=1
 S HLEXIT("LASTCHK")=$H
 Q
CNTFLR(FLRTYPE) ;RETURN NUMBER OF INCOMING/OUTGOING FILERS CURRENTLY RUNNING
 ;INPUT  : FLRTYPE - Indicates type of filer
 ;                   IN = Incoming (default)
 ;                   OUT = Outgoing
 ;OUTPUT : X - Number of incoming/outgoing filers that are currently
 ;             running.  This will typically be the number of entries
 ;             in the INCOMING FILER TASK NUMBER or OUTGOING FILER
 ;             TASK NUMBER multiples (fields 20 & 30) of the HL
 ;             COMMUNICATION SERVER PARAMETER file (#869.3).  The
 ;             tasks associated with the entries will be checked to
 ;             determine if they have errored out - if so, they will
 ;             not be included in the count.
 ;        -1 - Error
 ;
 ;Check input
 S FLRTYPE=$G(FLRTYPE)
 ;Declare variables
 N PTRMAIN,NODE,COUNT,PTRSUB,ZTSK
 S NODE=$S(FLRTYPE="OUT":3,1:2)
 ;Get entry in parameter file
 S PTRMAIN=+$O(^HLCS(869.3,0))
 Q:('PTRMAIN) -1
 ;Lock/unlock zero node of multiple - force buffer update
 L +^HLCS(869.3,PTRMAIN,NODE,0):1
 L -^HLCS(869.3,PTRMAIN,NODE,0)
 ;Count number of subentries
 S PTRSUB=0
 S COUNT=0
 F  S PTRSUB=+$O(^HLCS(869.3,PTRMAIN,NODE,PTRSUB)) Q:('PTRSUB)  D
 .;Get task number
 .K ZTSK
 .S ZTSK=+$G(^HLCS(869.3,PTRMAIN,NODE,PTRSUB,0))
 .Q:('ZTSK)
 .;Check status of task
 .D STAT^%ZTLOAD
 .;Task not defined, is inactive, or errored out
 .Q:("12"'[ZTSK(1))
 .;Increment count
 .S COUNT=COUNT+1
 Q COUNT
GETFLRS(FLRTYPE,ARRAY) ;RETURN LIST OF FILERS
 ;INPUT  : FLRTYPE - Indicates type of filer
 ;                   IN = Incoming (default)
 ;                   OUT = Outgoing
 ;         ARRAY - Array to return list of filers in (full global ref)
 ;OUTPUT : ARRAY will have the following format
 ;           ARRAY(PtrSubEntry)=TaskNumber ^ LastKnown$H ^ Stop
 ;             PtrSubEntry - Pointer to subentry in HL COMMUNICATION
 ;                           SERVER PARAMETER file (#869.3)
 ;             TaskNumber - Task number of filer
 ;             LastKnown$H - Value of LAST KNOWN $H (field #.03) for
 ;                           subentry
 ;             Stop - Flag indicating if filer was asked to stop
 ;                    (field #.02 for subentry)
 ;                    1 = YES
 ;                    0 = NO
 ;NOTES  : ARRAY will be initialized (KILLed) upon entry.  If no
 ;         entries are found in ARRAY() then no filers are running.
 ;       : ARRAY() will not be defined on bad input
 ;
 ;Check input
 Q:($G(ARRAY)="")
 S FLRTYPE=$G(FLRTYPE)
 ;Declare variables
 N PTRMAIN,NODE,PTRSUB,ZERONODE,TASKNUM,LASTDH,STOP
 S NODE=$S(FLRTYPE="OUT":3,1:2)
 ;Initialize output array
 K @ARRAY
 ;Get entry in parameter file
 S PTRMAIN=+$O(^HLCS(869.3,0))
 Q:('PTRMAIN)
 ;Lock/unlock zero node of multiple - force buffer update
 L +^HLCS(869.3,PTRMAIN,NODE,0):1
 L -^HLCS(869.3,PTRMAIN,NODE,0)
 ;Get list of filers
 S PTRSUB=0
 F  S PTRSUB=+$O(^HLCS(869.3,PTRMAIN,NODE,PTRSUB)) Q:('PTRSUB)  D
 .;Get filer information
 .S ZERONODE=$G(^HLCS(869.3,PTRMAIN,NODE,PTRSUB,0))
 .S TASKNUM=+ZERONODE
 .S STOP=+$P(ZERONODE,"^",2)
 .S LASTDH=$P(ZERONODE,"^",3)
 .;Put info into output array
 .S @ARRAY@(PTRSUB)=TASKNUM_"^"_LASTDH_"^"_STOP
 Q
