SCDXFU12 ;ALB/JRP - ACRP TRANSMISSION MANAGEMENT FILE UTILS;08-JUL-97
 ;;5.3;Scheduling;**128**;AUG 13, 1993
 ;
PTR4MID(MID) ;Find entry in ACRP Transmission History file (#409.77) for
 ; a given HL7 Message Control ID
 ;
 ;Input  : MID - HL7 Message Control ID for the transmitted encounter
 ;Output : HistPtr ^ XmitPtr
 ;           HistPtr = Pointer to ACRP Transmission History file
 ;           XmitPtr = Pointer to related Transmitted Outpatient
 ;                     Encounter file (#409.73) entry
 ;         0 - Entry not found (bad input)
 ;
 ;Check input
 S MID=$G(MID)
 Q:(MID="") 0
 ;Declare variables
 N HISTPTR,XMITPTR
 ;Find entry in history file
 S HISTPTR=+$O(^SD(409.77,"AMID",MID,0))
 ;Bad x-ref entry
 Q:('$D(^SD(409.77,HISTPTR,0))) 0
 ;Get pointer to transmission file (.01 field of history file)
 S XMITPTR=+$G(^SD(409.77,HISTPTR,0))
 ;Done
 Q HISTPTR_"^"_XMITPTR
 ;
PTRS4BID(BID,ARRAY) ;Find all entries in ACRP Transmission History file
 ; (#409.77) for a given HL7 Batch Control ID
 ;
 ;Input  : BID - HL7 Batch Control ID for the transmitted encounters
 ;         ARRAY - Array to place output into (full global reference)
 ;               - Defaults to ^TMP("SCDXFU12",$J,"PTRS4BID")
 ;Output : X - Number of entries found
 ;         ARRAY(HistPtr) = XmitPtr
 ;           HistPtr = Pointer to ACRP Transmission History file
 ;           XmitPtr = Pointer to related Transmitted Outpatient
 ;                     Encounter file (#409.73) entry
 ;Notes  : It is the responsibility of the calling procedure to
 ;         initialize (i.e. KILL) the output array
 ;       : Zero (0) will be returned if no entries are found (bad input)
 ;
 ;Check input
 S BID=$G(BID)
 Q:(BID="") 0
 S ARRAY=$G(ARRAY)
 S:(ARRAY="") ARRAY=$NA(^TMP("SCDXFU12",$J,"PTRS4BID"))
 ;Declare variables
 N HISTPTR,XMITPTR,COUNT
 ;Find/count entries in history file
 S COUNT=0
 S HISTPTR=0
 F  S HISTPTR=+$O(^SD(409.77,"ABID",BID,HISTPTR)) Q:('HISTPTR)  D
 .;Bad x-ref entry (ignore)
 .Q:('$D(^SD(409.77,HISTPTR,0)))
 .;Get pointer to transmission file (.01 field of history file)
 .S XMITPTR=+$G(^SD(409.77,HISTPTR,0))
 .;Put into output array
 .S @ARRAY@(HISTPTR)=XMITPTR
 .;Increment counter
 .S COUNT=COUNT+1
 ;Done
 Q COUNT
 ;
ACKMID(MID,ACKDATE,ACKCODE) ;Store/update acknowledgement information
 ; for entry in ACRP Transmission History file (#409.77) with given
 ; HL7 Message Control ID
 ;
 ;Input  : MID - HL7 Message Control ID for transmitted encounters
 ;         ACKDATE - Date/time of acknowledgement (value for field #21)
 ;                 - Pass in FileMan format
 ;                 - Defaults to current date/time (NOW)
 ;         ACKCODE - Acknowledgemnt code (value for field #22)
 ;                 - A = Accepted     R = Rejected     E = Error
 ;                 - Defaults to E (Error)
 ;Output : None
 ;
 ;Check input
 S MID=$G(MID)
 Q:(MID="")
 S ACKDATE=+$G(ACKDATE)
 S:('ACKDATE) ACKDATE=$$NOW^XLFDT()
 S ACKCODE=$TR($G(ACKCODE),"are","ARE")
 S:(ACKCODE="") ACKCODE="E"
 S:($L(ACKCODE)>1) ACKCODE="E"
 S:("ARE"'[ACKCODE) ACKCODE="E"
 ;Declare variables
 N HISTPTR
 ;Find entry in history file - quit if none found
 S HISTPTR=+$$PTR4MID(MID)
 Q:('HISTPTR)
 ;Store/update ack data
 D ACKHIST^SCDXFU10(HISTPTR,ACKDATE,ACKCODE)
 ;Done
 Q
 ;
ACKBID(BID,ACKDATE,ACKCODE) ;Store/update acknowledgement information
 ; for all entries in ACRP Transmission History file (#409.77) for
 ; given HL7 Batch Control ID
 ;
 ;Input  : BID - HL7 Batch Control ID for transmitted encounters
 ;         ACKDATE - Date/time of acknowledgement (value for field #21)
 ;                 - Pass in FileMan format
 ;                 - Defaults to current date/time (NOW)
 ;         ACKCODE - Acknowledgemnt code (value for field #22)
 ;                 - A = Accepted     R = Rejected     E = Error
 ;                 - Defaults to E (Error)
 ;Output : None
 ;
 ;Check input
 S BID=$G(BID)
 Q:(BID="")
 S ACKDATE=+$G(ACKDATE)
 S:('ACKDATE) ACKDATE=$$NOW^XLFDT()
 S ACKCODE=$TR($G(ACKCODE),"are","ARE")
 S:(ACKCODE="") ACKCODE="E"
 S:($L(ACKCODE)>1) ACKCODE="E"
 S:("ARE"'[ACKCODE) ACKCODE="E"
 ;Declare variables
 N HISTARR,HISTPTR
 S HISTARR=$NA(^TMP("SCDXFU12",$J,"ACKBID"))
 K @HISTARR
 ;Find entries in history file - quit if none found
 Q:('$$PTRS4BID(BID,HISTARR))
 ;Loop through list of entries and store/update ack data
 S HISTPTR=0
 F  S HISTPTR=+$O(@HISTARR@(HISTPTR)) Q:('HISTPTR)  D ACKHIST^SCDXFU10(HISTPTR,ACKDATE,ACKCODE)
 ;Done - clean up and quit
 K @HISTARR
 Q
