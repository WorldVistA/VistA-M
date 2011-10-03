VDEFQM ;INTEGIC/AM & BPOIFO/JG - VDEF API ; 21 Dec 2005  11:38 AM
 ;;1.0;VDEF;**3**;Dec 28, 2004
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; IA's: #4271 - Lookup to file #771.2
 ;       #4321 - Lookup to file #779.001
 ;
 Q  ; No bozos
 ;
 ; Validates and places a request in the VDEF queue
QUEUE(EVENT,PAIR,MSTEXT,REQIEN,DYNAMIC) ;
 ; EVENT =  HL7 event in the form Event Type^Message Type (e.g. ADT^A28)
 ; PAIR =   Name/value pairs uniquely identifying the IEN
 ;          (e.g. SUBTYPE="CHEM"^IEN=1234)
 ; MSTEXT = Returned text message, passed by reference
 ; REQIEN = Requestor IEN in file 579.1, only valued for solicited
 ;          requests
 ; DYNAMIC = Dynamic Addressing array in nodes DYNAMIC("LINKS",1-n)
 ;
 N CNT,CUSTIEN,DATA,DESTIEN,ERR,EVENTIEN,EVTY,EVTYIEN,FDA,VDI,IENROOT
 N MESIEN,MSTY,OUTPUT,QUEIEN,RQIEN,SUBTYPE,SUBIEN,NVPIEN
 N D0,DA,DH,DI,DIC,DIE,DIK,DIKRFIL,DIN,DIROOT,DR,X,Y
 S MSTEXT="",REQIEN=$G(REQIEN) S:$G(U)="" U="^"
 ;
 ; Check for the existence of the HL7 event
 I $G(EVENT)="" S MSTEXT="HL7 event is required" G EXBAD
 ;
 ; Check for the existence of the name/value pair
 I $G(PAIR)="" S MSTEXT="Name/value pair(s) is required" G EXBAD
 ;
 ; Retrieve the HL7 Message Type and the HL7 Event Type
 S MSTY=$P($G(EVENT),U,1),EVTY=$P($G(EVENT),U,2)
 ;
 ; Validate the HL7 Message type
 I MSTY="" S MSTEXT="HL7 Message Type is required" G EXBAD
 ;
 ; Validate the HL7 Event type
 I EVTY="" S MSTEXT="HL7 Event Type is required" G EXBAD
 ;
 ; Get the default Requestor IEN or '1' if not set up
 S REQIEN=$O(^VDEFHL7(579.1,"C","Y",0)) S:REQIEN="" REQIEN=1
 ;
 ; Retrieve Requestor data and see if Requestor is enabled
 S DATA=$G(^VDEFHL7(579.1,REQIEN,0)) I $P(DATA,U,5)="I" D  G EXBAD
 . S MSTEXT="VDEF HL7 messaging disabled for this Requestor"
 ;
 ; Get the Request Queue IEN for this Requestor
 S QUEIEN=$P(DATA,U,4) I 'QUEIEN S MSTEXT="Could not get a valid Request Queue" G EXBAD
 ;
 ; Get the Destination IEN for this Requestor
 S DESTIEN=$P(DATA,U,3) I 'DESTIEN S MSTEXT="No Destination for this Requestor" G EXBAD
 ;
 ; Validate Name/Value Pair
 I $P($P(PAIR,U),"=",1)'="SUBTYPE"!($P($P(PAIR,U,2),"=",1)'="IEN") D  G EXBAD
 . S MSTEXT="Invalid Name/Value Pair"
 S SUBTYPE=$P($P(PAIR,U),"=",2),NVPIEN=$P($P(PAIR,U,2),"=",2)
 ;
 ; Validate the Subtype
 S SUBIEN=$$FIND1^DIC(577.4,"","BX",SUBTYPE)
 I 'SUBIEN S MSTEXT="Invalid VDEF Subtype" G EXBAD
 ;
 ; Validate the HL7 Message and Event Types
 S MESIEN=$$FIND1^DIC(771.2,"","BX",MSTY)
 I 'MESIEN S MSTEXT="Invalid HL7 Message Type" G EXBAD
 S EVTYIEN=$$FIND1^DIC(779.001,,"BX",EVTY)
 I 'EVTYIEN S MSTEXT="Invalid HL7 Event Type" G EXBAD
 ;
 ; Validate the VDEF Event
 S EVENTIEN=$O(^VDEFHL7(577,"BB",MESIEN,EVTYIEN,SUBIEN,""))
 I 'EVENTIEN S MSTEXT="Invalid 'Message Type-Event Type-Subtype'" G EXBAD
 ;
 ; Check if this Request is for a disabled custodial package
 S X=$G(^VDEFHL7(577,EVENTIEN,0)),CUSTIEN=$P(X,U,9)
 I $P($G(^VDEFHL7(579.6,+CUSTIEN,0)),U,2)="I" D  G EXBAD
 . S MSTEXT="Custodial package disabled for this event"
 ;
 ; Check if this VDEF API is disabled
 I $P(X,U,11)'="A" D  G EXBAD
 . S MSTEXT="VDEF API "_$P(X,U,1)_" is turned off"
 ;
 ; Start filing request into ^VDEFHL7(579.3
 ; Lock the queue to prevent other requests from being added to it
 ; doesn't affect the processing of existing requests
 L +^VDEFHL7(579.3,QUEIEN,"ADD"):10
 E  S MSTEXT="VDEF queuing is currently unavailable" G EXBAD
 ;
 ; Populate the Request data (579.31) for this queue
 S FDA(1,579.31,"+1,"_QUEIEN_",",.01)=9999 ; DINUM placeholder
 S FDA(1,579.31,"+1,"_QUEIEN_",",.02)="Q"  ; Request status - "Q"ueued
 S FDA(1,579.31,"+1,"_QUEIEN_",",.03)=MSTY ; Message Type
 S FDA(1,579.31,"+1,"_QUEIEN_",",.04)=EVTY ; Event Type
 S FDA(1,579.31,"+1,"_QUEIEN_",",.06)=REQIEN ; Requestor
 S FDA(1,579.31,"+1,"_QUEIEN_",",.07)=DESTIEN ; Destination
 D NOW^%DTC S FDA(1,579.31,"+1,"_QUEIEN_",",.08)=% ; DTS when request was added
 S FDA(1,579.31,"+1,"_QUEIEN_",",.18)=EVENTIEN ; VDEF Event IEN
 D UPDATE^DIE("","FDA(1)","IENROOT","ERR")
 S RQIEN=$G(IENROOT(1)) ; Get the assigned Request entry IEN
 ;
 ; Lock this queue entry to prevent the Request Processor from
 ; retrieving an incomplete Request
 L +^VDEFHL7(579.3,QUEIEN,RQIEN)
 L -^VDEFHL7(579.3,QUEIEN,"ADD") ; Release the queue "ADD" lock
 ;
 ; Update the DINUM field with the IEN value for this Request
 S FDA(1,579.31,RQIEN_","_QUEIEN_",",.01)=RQIEN D FILE^DIE("","FDA(1)","ERR(2)")
 ;
 ; Set up the name value pairs multiple (579.311)
 F VDI=1,2 D
 . S FDA(1,579.311,"+"_VDI_","_RQIEN_","_QUEIEN_",",.01)=VDI
 . S FDA(1,579.311,"+"_VDI_","_RQIEN_","_QUEIEN_",",.02)=$P(PAIR,U,VDI)
 D UPDATE^DIE("","FDA(1)","","ERR")
 ;
 ; Set up the Dynamic Adressing multiple, if passed in
 S (VDI,DATA)="",CNT=0 F  S VDI=$O(DYNAMIC("LINKS",VDI)) Q:'VDI  D
 . ; CNT and VDI may be different since the "LINKS" array may be sparse
 . S DATA=$G(DYNAMIC("LINKS",VDI)),CNT=CNT+1
 . S FDA(1,579.313,"+"_CNT_","_RQIEN_","_QUEIEN_",",.01)=VDI
 . S FDA(1,579.313,"+"_CNT_","_RQIEN_","_QUEIEN_",",.02)=DATA
 ;
 ; File Dynamic Addressing information
 I $D(FDA) D UPDATE^DIE("","FDA(1)","","ERR")
 L -^VDEFHL7(579.3,QUEIEN,RQIEN) ; Release the lock on this Request
 S MSTEXT="Message "_MSTY_", Event "_EVTY_", Subtype "_SUBTYPE_" queued for processing"
EXIT Q 1  ; Good exit
EXBAD Q 0  ; Bad, bad exit
 ;
 ; Function to set up a Request Processor Scheduling Rule
SCHEDULE(Q,H) ;
 N HT,SIEN,NZ,DOW,STM,ETM
 I $G(Q)="" Q ""
 I $G(H)="" S H=$H
 S DOW=H-2#7,SIEN=0,HT=0
 F  S SIEN=$O(^VDEFHL7(579.3,Q,2,SIEN)) Q:'SIEN  D  Q:HT'=0
 . S NZ=^VDEFHL7(579.3,Q,2,SIEN,0)
 . Q:$P(NZ,U,2)'=DOW
 . S STM=$P(NZ,U,4),ETM=$P(NZ,U,5)
 . S STM=$TR(STM,":- "),STM=$E(STM,1,2)*60+$E(STM,3,4)*60+$E(STM,5,6)
 . S ETM=$TR(ETM,":- "),ETM=$E(ETM,1,2)*60+$E(ETM,3,4)*60+$E(ETM,5,6)
 . I $P(H,",",2)'<STM,$P(H,",",2)'>ETM S HT=$P(NZ,U,3)
 I HT'=0 Q HT_U_(ETM-$P(H,",",2))
 Q ""
 ;
TIMECK(T) N H,M,S I T?4.6N S H=+$E(T,1,2),M=+$E(T,3,4),S=+$E(T,5,6)
 E  I T[":" S H=+$P(T,":"),M=+$P(T,":",2),S=+$P(T,":",3)
 E  I T["-" S H=+$P(T,"-"),M=+$P(T,"-",2),S=+$P(T,"-",3)
 E  I T[" " S H=+$P(T," "),M=+$P(T," ",2),S=+$P(T," ",3)
 E  Q 0
 I H<24,M<60,S<60 Q 1
 Q 0
 ;
REQUEUE(Q,X) ; Requeue Checked Out requests.
 ; Change the status of all "C" entries in a Request Queue to "Q".
 ; If ZTQUEUED not set, run this interactively.
 ; Input  - Request Queue IEN
 ; Output - 0 = no requests requeued
 ;          1 = requests weere requeued
 S X=0
 I $G(Q)="" W:'$D(ZTQUEUED) !,"Invalid queue IEN" Q
 ;
 ; Quit if no requests are Checked Out
 I $O(^VDEFHL7(579.3,"C","C",0))="" W:'$D(ZTQUEUED) !,"No Requests in Checked Out status" Q
 ;
 ; Get Queue
 N QUE S QUE=$P($G(^VDEFHL7(579.3,Q,0)),U)
 I QUE="" W:'$D(ZTQUEUED) !,"Invalid queue" Q
 G REQUEUE1:$D(ZTQUEUED)
 K DIR S DIR(0)="Y",DIR("A")="Are you sure you want to continue",DIR("B")="No"
 W !,"This action will reset all entries in the '"_QUE_"' queue to 'Q'ueued."
 D ^DIR I Y=0 W !,"Entries not reset." Q
REQUEUE1 N FDA,IEN,MSG S IEN=""
 F  S IEN=$O(^VDEFHL7(579.3,"C","C",Q,IEN)) Q:'IEN  D
 . ;
 . ; If request has not had an alert yet or can't be locked,
 . ; don't requeue it.
 . Q:$$GET1^DIQ(579.31,IEN_","_Q_",",.15,"I")=""
 . L +^VDEFHL7(579.3,Q,IEN):1 Q:'$T
 . ;
 . ; Change status to "Q" (queued up) and delete
 . ; the old check out date/time and alert date/time
 . ; and error message
 . K FDA,MSG S FDA(579.31,IEN_","_Q_",",.02)="Q"
 . S FDA(579.31,IEN_","_Q_",",.15)="@"
 . S FDA(579.31,IEN_","_Q_",",.09)="@"
 . D FILE^DIE(,"FDA","MSG")
 . K ^VDEFHL7(579.3,Q,1,IEN,"ERRMSG")
 . L -^VDEFHL7(579.3,Q,IEN)
 . S X=1
 W:'$D(ZTQUEUED) !,"Entries reset to 'Q'ueued status for "_QUE_"."
 Q
 ;
 ; Requeue Errored Out requests.
 ; Change the status of all "E" entries in a Request Queue to "Q".
 ; If ZTQUEUED not set, run this interactively.
RQERR(Q,X) ;
 S X=0
 I $G(Q)="" W:'$D(ZTQUEUED) !,"Invalid queue IEN" Q
 ;
 ; Quit if no requests are Errored Out
 I $O(^VDEFHL7(579.3,"C","E",0))="" W:'$D(ZTQUEUED) !,"No Requests in Errored Out status" Q
 ;
 ; Get Queue
 N QUE S QUE=$P($G(^VDEFHL7(579.3,Q,0)),U)
 I QUE="" W:'$D(ZTQUEUED) !,"Invalid queue" Q
 G RQERR1:$D(ZTQUEUED)
 K DIR S DIR(0)="Y",DIR("A")="Are you sure you want to continue",DIR("B")="No"
 W !,"This action resets all Errored Out entries in the '"_QUE_"' queue to 'Q'ueued."
 D ^DIR I Y=0 W !,"Entries not reset." Q
RQERR1 N FDA,IEN,MSG S IEN=""
 F  S IEN=$O(^VDEFHL7(579.3,"C","E",Q,IEN)) Q:'IEN  D
 . L +^VDEFHL7(579.3,Q,IEN):1 Q:'$T
 . ;
 . ; Fix the actual status in the record if it's not "E".
 . I $$GET1^DIQ(579.31,IEN_","_Q_",",.02,"I")'="E" D
 .. K FDA,MSG S FDA(579.31,IEN_","_Q_",",.02)="E"
 .. D FILE^DIE(,"FDA","MSG")
 . ;
 . ; Change status to "Q" (queued up) and delete
 . ; the old check out date/time and alert date/time
 . ; and error message
 . K FDA,MSG S FDA(579.31,IEN_","_Q_",",.02)="Q"
 . S FDA(579.31,IEN_","_Q_",",.15)="@"
 . S FDA(579.31,IEN_","_Q_",",.09)="@"
 . D FILE^DIE(,"FDA","MSG")
 . K ^VDEFHL7(579.3,Q,1,IEN,"ERRMSG")
 . L -^VDEFHL7(579.3,Q,IEN)
 . S X=1
 W:'$D(ZTQUEUED) !,"Entries reset to 'Q'ueued status for "_QUE_"."
 Q
