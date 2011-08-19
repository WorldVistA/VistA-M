SCDXFU10 ;ALB/JRP - ACRP TRANSMISSION MANAGEMENT FILE UTILS;03-JUL-97
 ;;5.3;Scheduling;**128**;AUG 13, 1993
 ;
CRTHIST(XMITPTR,XMITDATE,MID4XMIT,BID4XMIT) ;Create entry in ACRP
 ; Transmission History file (#409.77) for entry in Transmitted
 ; Outpatient Encounter file (#409.73)
 ;
 ;Input  : XMITPTR - Pointer to entry in Transmitted Outpatient
 ;                   Encounter file
 ;         XMITDATE - Date/time of transmission (value for field #11)
 ;                  - Pass in FileMan format
 ;                  - Defaults to current date/time (NOW)
 ;         MID4XMIT - Message ID of transmission (value for field #12)
 ;         BID4XMIT - Batch ID of transmission (value for field #13)
 ;Output : HistPtr - Pointer to entry created
 ;         -1^ErrorText - Error/bad input
 ;
 ;Check input
 S XMITPTR=+$G(XMITPTR)
 Q:('$D(^SD(409.73,XMITPTR,0))) "-1^Did not pass valid pointer to TRANSMITTED OUTPATIENT ENCOUNTER file"
 S XMITDATE=+$G(XMITDATE)
 S:('XMITDATE) XMITDATE=$$NOW^XLFDT()
 S MID4XMIT=$G(MID4XMIT)
 Q:(MID4XMIT="") "-1^Did not pass HL7 Message Control ID given to the transmitted encounter"
 S BID4XMIT=$G(BID4XMIT)
 Q:(BID4XMIT="") "-1^Did not pass HL7 Batch Control ID given to the transmitted encounter"
 ;Declare variables
 N SCDXFDA,SCDXIEN,SCDXMSG,HISTPTR,TMP
 ;Build FDA array
 S SCDXFDA(409.77,"+1,",.01)=XMITPTR
 ;Encounter date/time
 S TMP=+$$EDT4XMIT^SCDXFU11(XMITPTR)
 Q:('TMP) "-1^Unable to determine encounter date/time"
 S SCDXFDA(409.77,"+1,",.02)=TMP
 ;Patient
 S TMP=+$$PAT4XMIT^SCDXUTL4(XMITPTR)
 Q:('TMP) "-1^Unable to determine patient"
 S SCDXFDA(409.77,"+1,",.03)=TMP
 ;Clinic
 S TMP=+$$LOC4XMIT^SCDXFU11(XMITPTR)
 Q:('TMP) "-1^Unable to determine encounter's clinic"
 S SCDXFDA(409.77,"+1,",.04)=TMP
 ;Division
 S TMP=+$$DIV4XMIT^SCDXFU11(XMITPTR)
 Q:('TMP) "-1^Unable to determine encounter's division"
 S SCDXFDA(409.77,"+1,",.05)=TMP
 ;Visit ID
 S TMP=$$VID4XMIT^SCDXFU11(XMITPTR)
 Q:(TMP="") "-1^Unable to determine encounter's Unique Visit ID"
 S SCDXFDA(409.77,"+1,",.06)=TMP
 ;Transmission date/time
 S SCDXFDA(409.77,"+1,",11)=XMITDATE
 ;Message ID
 S SCDXFDA(409.77,"+1,",12)=MID4XMIT
 ;Batch ID
 S SCDXFDA(409.77,"+1,",13)=BID4XMIT
 ;Create entry
 D UPDATE^DIE("S","SCDXFDA","SCDXIEN","SCDXMSG")
 ;Get entry number created
 S HISTPTR=+$G(SCDXIEN(1))
 ;Error
 Q:(('HISTPTR)!($D(SCDXMSG("DIERR")))) "-1^Unable to create entry in ACRP TRANSMISSION HISTORY file"
 ;Done
 Q HISTPTR
 ;
XMITHIST(HISTPTR,MID4XMIT,BID4XMIT) ;Store/update transmission information
 ; for entry in ACRP Transmission History file (#409.77)
 ;
 ;Input  : HISTPTR - Pointer to entry in ACRP Transmission History file
 ;         MID4XMIT - Message ID of transmission (value for field #12)
 ;         BID4XMIT - Batch ID of transmission (value for field #13)
 ;Output : None
 ;Note   : This call does not update the Date/time of Transmission
 ;         field (#11)
 ;
 ;Check input
 S HISTPTR=+$G(HISTPTR)
 Q:('$D(^SD(409.77,HISTPTR,0)))
 S MID4XMIT=$G(MID4XMIT)
 Q:(MID4XMIT="")
 S BID4XMIT=$G(BID4XMIT)
 Q:(BID4XMIT="")
 ;Declare variables
 N SCDXFDA,SCDXMSG,SCDXIENS
 ;Set up FDA array
 S SCDXIENS=HISTPTR_","
 S SCDXFDA(409.77,SCDXIENS,12)=MID4XMIT
 S SCDXFDA(409.77,SCDXIENS,13)=BID4XMIT
 ;Store/update transmission info
 D FILE^DIE("S","SCDXFDA","SCDXMSG")
 ;Done
 Q
 ;
ACKHIST(HISTPTR,ACKDATE,ACKCODE) ;Store/update acknowledgement
 ; information for entry in ACRP Transmission History file (#409.77)
 ;
 ;Input  : HISTPTR - Pointer to entry in ACRP Transmission History file
 ;         ACKDATE - Date/time of acknowledgement (value for field #21)
 ;                 - Pass in FileMan format
 ;                 - Defaults to current date/time (NOW)
 ;         ACKCODE - Acknowledgement code (value for field #22)
 ;                 - A = Accepted     R = Rejected     E = Error
 ;                 - Defaults to E (Error)
 ;Output : None
 ;
 ;Check input
 S HISTPTR=+$G(HISTPTR)
 Q:('$D(^SD(409.77,HISTPTR,0)))
 S ACKDATE=+$G(ACKDATE)
 S:('ACKDATE) ACKDATE=$$NOW^XLFDT()
 S ACKCODE=$TR($G(ACKCODE),"are","ARE")
 S:(ACKCODE="") ACKCODE="E"
 S:($L(ACKCODE)>1) ACKCODE="E"
 S:("ARE"'[ACKCODE) ACKCODE="E"
 ;Declare variables
 N SCDXFDA,SCDXMSG,SCDXIENS
 ;Set up FDA array
 S SCDXIENS=HISTPTR_","
 S SCDXFDA(409.77,SCDXIENS,21)=ACKDATE
 S SCDXFDA(409.77,SCDXIENS,22)=ACKCODE
 ;Store/update transmission info
 D FILE^DIE("S","SCDXFDA","SCDXMSG")
 ;Done
 Q
 ;
DELHIST(HISTPTR) ;Delete entry in ACRP Transmission History file
 ; (#409.77)
 ;
 ;Input  : HISTPTR - Pointer to entry in ACRP Transmission History file
 ;Output : None
 ;
 ;Check input
 S HISTPTR=+$G(HISTPTR)
 Q:('HISTPTR)
 ;Declare variables
 N DIK,DA,DIC,DIE,X,Y
 ;Delete
 S DIK="^SD(409.77,"
 S DA=HISTPTR
 D ^DIK
 ;Done
 Q
 ;
DELAHIST(XMITPTR) ;Delete all entries in ACRP Transmission History file
 ; (#409.77) for entry in Transmitted Outpatient Encounter file (#409.73)
 ;
 ;Input  : XMITPTR - Pointer to entry in Transmitted Outpatient
 ;                   Encounter file
 ;Output : None
 ;
 ;Check input
 S XMITPTR=+$G(XMITPTR)
 Q:('$D(^SD(409.73,XMITPTR,0)))
 ;Declare variables
 N HISTPTR
 ;Loop through 'B' x-ref of history file and delete all entries found
 S HISTPTR=0
 F  S HISTPTR=+$O(^SD(409.77,"B",XMITPTR,HISTPTR)) Q:('HISTPTR)  D DELHIST(HISTPTR)
 ;Done
 Q
 ;
WIPEHIST(HISTPTR,WIPEFLAG) ;Delete transmission and acknowledgement
 ; information for entry in ACRP Transmission History file (#409.77)
 ;
 ;Input  : HISTPTR - Pointer to entry in ACRP Transmission History file
 ;         WIPEFLAG - Flag indicating which information to delete
 ;                    0 = Transmission & acknowledgment info (default)
 ;                    1 = Transmission information
 ;                    2 = Acknowledgement information
 ;Output : None
 ;Notes  : This call should be used when the history information needs
 ;         to be deleted and the actual entry can not
 ;       : This call does not delete required fields (.01 - .06 & 11)
 ;
 ;Check input
 S HISTPTR=+$G(HISTPTR)
 Q:('$D(^SD(409.77,HISTPTR,0)))
 S WIPEFLAG=+$G(WIPEFLAG)
 S:((WIPEFLAG<0)!(WIPEFLAG>2)) WIPEFLAG=0
 ;Declare variables
 N SCDXFDA,SCDXMSG,SCDXIENS
 ;Set up FDA array
 S SCDXIENS=HISTPTR_","
 ;Transmission info
 I (WIPEFLAG'=2) D
 .S SCDXFDA(409.77,SCDXIENS,12)=""
 .S SCDXFDA(409.77,SCDXIENS,13)=""
 ;Acknowledgement info
 I (WIPEFLAG'=1) D
 .S SCDXFDA(409.77,SCDXIENS,21)=""
 .S SCDXFDA(409.77,SCDXIENS,22)=""
 ;Delete requested info
 D FILE^DIE("S","SCDXFDA","SCDXMSG")
 ;Done
 Q
