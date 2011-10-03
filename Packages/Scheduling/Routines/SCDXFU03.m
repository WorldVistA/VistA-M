SCDXFU03 ;ALB/JRP - AMBULATORY CARE FILE UTILITIES;01-JUL-1996
 ;;5.3;Scheduling;**44,110,121,126,128**;AUG 13, 1993
 ;
DELXMIT(PTR,PTR2) ;Delete entry in TRANSMITTED OUTPATIENT ENCOUNTER
 ; file (#409.73)
 ;
 ;Input  : PTR - Pointer to entry in one of the following files
 ;               *  TRANSMITTED OUTPATIENT ENCOUNTER file (#409.73)
 ;               *  OUTPATIENT ENCOUNTER file (#409.68)
 ;               *  DELETED OUTPATIENT ENCOUNTER file (#409.74)
 ;         PTR2 - Denotes which file PTR points to
 ;                0 = TRANSMITTED OUTPATIENT ENCOUNTER file (Default)
 ;                1 = OUTPATIENT ENCOUNTER file
 ;                2 = DELETED OUTPATIENT ENCOUNTER file
 ;Output : 0 - Success
 ;        -1 - Unable to delete entry
 ;Note   : Success (0) is returned when a valid pointer to the
 ;         specified file is not passed or an entry in the
 ;         TRANSMITTED OUTPATIENT ENCOUNTER file can not be found
 ;         (Deleting an entry that doesn't exist is successful)
 ;       : If the TRANSMITTED OUTPATIENT ENCOUNTER points to an entry
 ;         in the DELETED OUTPATIENT ENCOUNTER file, the DELETED
 ;         OUTPATIENT ENCOUNTER will also be deleted
 ;
 ;Check input
 S PTR=+$G(PTR)
 S PTR2=+$G(PTR2)
 S:((PTR2<0)!(PTR2>2)) PTR2=0
 ;Declare variables
 N DIK,DA,X,Y,DIC,XMITPTR,DELPTR
 ;Get pointer to TRANSMITTED OUTPATIENT ENCOUNTER file
 S XMITPTR=PTR
 S:(PTR2=1) XMITPTR=+$O(^SD(409.73,"AENC",PTR,0))
 S:(PTR2=2) XMITPTR=+$O(^SD(409.73,"ADEL",PTR,0))
 ;Entry in TRANSMITTED OUTPATIENT ENCOUNTER file doesn't exist - success
 Q:('$D(^SD(409.73,XMITPTR,0))) 0
 ;Delete all entries in TRANSMITTED OUTPATIENT ENCOUNTER ERROR file
 ; (#409.75) that refer to entry being deleted
 D DELAERR^SCDXFU02(XMITPTR)
 ;Delete all entries in ACRP Transmission History file (#409.77)
 D DELAHIST^SCDXFU10(XMITPTR)
 ;Delete entry in DELETED OUTPATIENT ENCOUNTER file (#409.74)
 S DELPTR=+$$XMIT4DEL^SCDXFU11(XMITPTR)
 S:(DELPTR>0) X=$$DELDEL^SCDXFU02(DELPTR)
 ;Delete entry
 S DIK="^SD(409.73,"
 S DA=XMITPTR
 D ^DIK
 ;Done
 Q 0
 ;
XMITDATA(XMITPTR,XMITDATE,MID,BID) ;Store transmission data for entry in
 ; TRANSMITTED OUTPATIENT ENCOUNTER file (#409.73)
 ;
 ;Input  : XMITPTR - Pointer to entry in TRANSMITTED OUTPATIENT
 ;                   ENCOUNTER file (#409.73)
 ;         XMITDATE - FileMan ate/time entry was transmitted to National
 ;                    Patient Care Database (Defaults to NOW)
 ;         MID - Message Control ID used when entry was transmitted
 ;               to National Patient Care Database
 ;         BID - Batch Control ID used when entry was transmitted
 ;               to National Patient Care Database
 ;Output : None
 ;
 ;Check input
 S XMITPTR=+$G(XMITPTR)
 Q:('$D(^SD(409.73,XMITPTR)))
 S XMITDATE=+$G(XMITDATE)
 S:('XMITDATE) XMITDATE="NOW"
 S MID=$G(MID)
 S BID=$G(BID)
 ;Declare variables
 N DIE,DA,DR,DIDEL,X,Y,DIC
 ;Store transmission data
 S DIE="^SD(409.73,"
 S DA=XMITPTR
 S DR="11///^S X=XMITDATE;12///^S X=MID;13///^S X=BID"
 D ^DIE
 ;Done
 Q
 ;
ACKDATA(XMITPTR,ACKDATE,ACKCODE) ;Store acknowledgement data for entry
 ; in TRANSMITTED OUTPATIENT ENCOUNTER file (#409.73)
 ;
 ;Input  : XMITPTR - Pointer to entry in TRANSMITTED OUTPATIENT
 ;                   ENCOUNTER file (#409.73)
 ;         ACKDATE - FileMan date/time acknowledgement from National
 ;                   Patient Care Database was received (Defaults to NOW)
 ;         ACKCODE - Denotes type of acknowledgement received
 ;                   A = Transmission was accepted (DEFAULT)
 ;                   R = Transmission was rejected
 ;                   E = Error
 ;Output : None
 ;
 ;Check input
 S XMITPTR=+$G(XMITPTR)
 Q:('$D(^SD(409.73,XMITPTR)))
 S ACKDATE=+$G(ACKDATE)
 S:('ACKDATE) ACKDATE="NOW"
 S ACKCODE=$G(ACKCODE)
 S:("ARE"'[ACKCODE) ACKCODE="A"
 ;Declare variables
 N DIE,DA,DR,DIDEL,X,Y,DIC
 ;Store acknowledgement data
 S DIE="^SD(409.73,"
 S DA=XMITPTR
 S DR="14///^S X=ACKDATE;15////^S X=ACKCODE"
 D ^DIE
 ;Done
 Q
 ;
XMITED(ENCPTR) ;Determine if Outpatient Encounter was ever transmitted to the
 ; National Patient Care Database
 ;
 ;Input  : ENCPTR - Pointer to Outpatient Encounter
 ;Output : DateTime - Date of last transmission (FileMan format)
 ;         0 - Encounter never transmitted
 ;Notes  : Zero (0) will be returned on bad input
 ;
 ;Check input
 S ENCPTR=+$G(ENCPTR)
 Q:('ENCPTR) 0
 ;Declare variables
 N XMITPTR,XMITDATE,XMITHIST
 S XMITHIST=$NA(^TMP("SCDXFU03",$J,"XMITED"))
 K @XMITHIST
 ;Find entry in transmission file (#409.73)
 S XMITPTR=+$O(^SD(409.73,"AENC",ENCPTR,0))
 Q:('XMITPTR) 0
 Q:('$D(^SD(409.73,XMITPTR,0))) 0
 ;Get transmission history
 S XMITDATE=$$HST4XMIT^SCDXFU13(XMITPTR,XMITHIST,1)
 ;Get last transmission date/time
 S XMITDATE=+$O(@XMITHIST@(""),-1)
 ;Clean up and return date/time of last transmission
 K @XMITHIST
 Q XMITDATE
 ;
ACCEPTED(ENCPTR) ;Determine if Outpatient Encounter was ever accepted
 ; by the National Patient Care Database (i.e. ACK = Accept)
 ;
 ;Input  : ENCPTR - Pointer to Outpatient Encounter
 ;Output : DateTime - Date/time of last successfull ack (FileMan)
 ;         0 - Encounter never accepted
 ;Notes  : Zero (0) will be returned on bad input
 ;
 ;Check input
 S ENCPTR=+$G(ENCPTR)
 Q:('ENCPTR) 0
 ;Declare variables
 N XMITPTR,ACKDATE,ACKHIST
 S ACKHIST=$NA(^TMP("SCDXFU03",$J,"ACCEPTED"))
 K @ACKHIST
 ;Find entry in transmission file (#409.73)
 S XMITPTR=+$O(^SD(409.73,"AENC",ENCPTR,0))
 Q:('XMITPTR) 0
 Q:('$D(^SD(409.73,XMITPTR,0))) 0
 ;Get acknowledgement history
 S ACKDATE=$$HST4XMIT^SCDXFU13(XMITPTR,ACKHIST,2)
 ;Search history for last ack with code of ACCEPT
 S ACKDATE=""
 F  S ACKDATE=+$O(@ACKHIST@(ACKDATE),-1) Q:('ACKDATE)  Q:($P($G(@ACKHIST@(ACKDATE)),"^",3)="A")
 ;Clean up and return date/time of last successfull ack
 K @ACKHIST
 Q ACKDATE
 ;
VIDCNT(VSITID,EXCLUDE) ;Determine the number of parent Outpatient
 ; Encounters that have the given Visit ID
 ;
 ;Input  : VSITID - Visit ID to check for (NOT THE POINTER TO 9000010)
 ;         EXCLUDE - Encounter to optionally exclude from count
 ;Output : N - Number of parent encounters found
 ;Notes  : Stand alone add/edits are considered a parent encounter
 ;       : Zero (0) is returned if the Visit ID is not valid
 ;
 ;Check input
 S VSITID=$G(VSITID)
 Q:(VSITID="") 0
 S EXCLUDE=+$G(EXCLUDE)
 S:('$D(^SCE(EXCLUDE,0))) EXCLUDE=0
 ;Declare variables
 N ENCPTR,VSITPTR,COUNT
 ;Get pointer to Visit
 S VSITPTR=$$VID2IEN^VSIT(VSITID)
 Q:(VSITPTR<1) 0
 ;Count parent encounters for visit
 S COUNT=0
 S ENCPTR=0
 F  S ENCPTR=+$O(^SCE("AVSIT",VSITPTR,ENCPTR)) Q:('ENCPTR)  D
 .;Bad entry in x-ref
 .Q:('$D(^SCE(ENCPTR,0)))
 .;Exclude input encounter
 .Q:(ENCPTR=EXCLUDE)
 .;Screen out children
 .Q:(+$P($G(^SCE(ENCPTR,0)),"^",6))
 .;Increment count
 .S COUNT=COUNT+1
 Q COUNT
