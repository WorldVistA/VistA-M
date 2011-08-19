HLTF0 ;AISC/SAW,JRP - File Data in Message Text File ;05/05/2000  09:01
 ;;1.6;HEALTH LEVEL SEVEN;**12,19,64,91,109**;Oct 13, 1995
 ;
STATUS(MTIEN,STATUS,ERR,ERRTEXT,COMDT,NOEVENT) ;Update Status of Entry in Message Text File and log an event for errors
 ;
 ;This is a subroutine call with parameter passing.  No output
 ;parameters are returned
 ;
 ;$D(HLTCP) will determine if you are updating file 773, instead
 ; of file 772.
 ;Required Input Parameters
 ;    MTIEN = IEN of entry in file 772 or 773, to be updated
 ;   STATUS = IEN of new status (pointer to Message Status file)
 ;Optional Parameters
 ;      ERR = IEN of error message (pointer to Error Message file)
 ;  ERRTEXT = An error message of up to 200 characters
 ;    COMDT = 0/1 ; 1=update DATE/TIME PROCESSED, field 100
 ;  NOEVENT = 1 if an event should NOT be logged.  Presumably this signals that the application already logged the event
 ;
 ;Check for required parameters
 I '$G(MTIEN)!('$G(STATUS)) Q
 ;File new status info
 N HLJ,HLOCK,X
 ;if TCP update status in file 773, else status in file 772
 I $D(HLTCP) S X="HLJ(773,",HLOCK="^HLMA("
 E  S X="HLJ(772,",HLOCK="^HL(772,"
 S X=X_""""_MTIEN_","")",HLOCK=HLOCK_MTIEN_")"
 ;20=status, 21=date process
 S @X@(20)=STATUS,@X@(21)=$S(STATUS=1:"@",1:$$NOW^XLFDT)
 ;22=error msg
 S:$G(ERRTEXT)]"" @X@(22)=$E(ERRTEXT,1,200)
 ;23=error type
 S:$G(ERR) @X@(23)=+ERR
 ;100=date/time processed
 S:$G(COMDT) @X@(100)=$$NOW^XLFDT
 ;**109** F  L +@HLOCK:1 Q:$T  H 1
 D FILE^HLDIE("","HLJ","","STATUS","HLTF0") ;HL*1.6*109
 ;**109** L -@HLOCK
 ;
 ;if the status is error, and the event is not being surpressed by the
 ;application, log a new event
 I '$G(NOEVENT),$G(STATUS)=4 D
 .N CODE,HL7MSGID,ERROR,PARENT,EVENT
 .S CODE=$G(ERR)
 .S (HL7MSGID,PARENT)=""
 .I $G(MTIEN) D
 ..N NODE
 ..I $G(HLTCP) D
 ...S NODE=$G(^HLMA(MTIEN,0))
 ...S HL7MSGID=$P(NODE,"^",2)
 ...S PARENT=$P(NODE,"^",6)
 ..E  D
 ...S NODE=$G(^HL(772,MTIEN,0))
 ...S HL7MSGID=$P(NODE,"^",6)
 ...S PARENT=$P(NODE,"^",8)
 .;
 .S EVENT=$$EVENT^HLEME(CODE,"HEALTH LEVEL SEVEN",HL7MSGID,,,.ERROR)
 .;I 'EVENT,'$D(ZTQUEUED) W !,"Failed to create an Event in STATUS^HLTF0: ",$G(ERROR)_" "_$G(ERROR(1))_" "_$G(ERROR(2))
 .;
 .I EVENT D
 ..I $L($G(ERRTEXT)),$$ADDNOTE^HLEME(EVENT,"Application Error Text: "_ERRTEXT)
 ..;If this message was not the initial message in a transaction protocol, then provide some information about the initial message
 ..I PARENT,PARENT'=$G(MTIEN) D
 ...N PLINK,PMSGID,PMSGTYPE,PNODE,PEVENT,PNOTES
 ...I $D(HLTCP) D
 ....S PNODE=$G(^HLMA(PARENT,0))
 ....S PLINK=$P(PNODE,"^",7)
 ....S PMSGID=$P(PNODE,"^",2)
 ....S PMSGTYPE=$P(PNODE,"^",13)
 ....S PEVENT=$P(PNODE,"^",14)
 ...E  D
 ....S PNODE=$G(^HL(772,PARENT,0))
 ....S PLINK=$P(PNODE,"^",11)
 ....S PMSGID=$P(PNODE,"^",6)
 ....S PMSGTYPE=""
 ....S PEVENT=""
 ...S PNOTES(1)="Initial Message in this transaction protocol:"
 ...S PNOTES(2)="  Initial Message ID: "_PMSGID
 ...S PNOTES(3)="  Logical Link of Initial Message: "
 ...S:PLINK PNOTES(3)=PNOTES(3)_$P($G(^HLCS(870,PLINK,0)),"^")
 ...S:PMSGTYPE PNOTES(4)="  Inital Message Type: "_$P($G(^HL(771.2,PMSGTYPE,0)),"^")
 ...S:PEVENT PNOTES(5)="  Inital Message Event: "_$P($G(^HL(779.001,PEVENT,0)),"^")
 ...I $$ADDNOTE^HLEME(EVENT,.PNOTES) ;then notes successfully added
 Q
 ;
STATS(MTIEN,HLCHAR,HLEVN) ;Enter Statistics for an Entry in Message
 ;Text File
 ;
 ;This is a subroutine call with parameter passing.  No output
 ;parameters are returned
 ;
 ;Required Input Parameters
 ;   MTIEN = The IEN from the Message Text file of the entry to be
 ;             updated
 ;  HLCHAR = The number of characters in the message
 ;   HLEVN = The number of HL7 events in the message
 ;
 ;Check for required parameters
 I '$G(MTIEN)!('$D(HLCHAR))!('$D(HLEVN)) Q
 I '$D(^HL(772,MTIEN,0)) Q
 ;File statistical info
 ;**109** F  L +^HL(772,MTIEN):1 H:'$T 1 I $T D  Q
 D
 .  S ^HL(772,MTIEN,"S")=HLCHAR_"^"_$G(HLEVN)
 ;**109** .  L -^HL(772,MTIEN)
 Q
STUFF(HLMT) ;Update Fields on Zero Node of the Message Text File for
 ;Version 1.5 Interface Only
 ;
 ;This is a subroutine call with parameter passing.  No output
 ;parameters are returned
 ;
 ;Required Input Parameter
 ;  HLMT = Message type, O for outgoing or I for incoming
 ;
 ;Check for required parameter
 Q:HLMT']""
 ;File zero node data
 N DA,DIC,DIE,DR
 S (DIC,DIE)="^HL(772,",DA=HLDA
 S DR="4////"_HLMT_$S('$G(HLDAP):"",1:";2////"_HLDAP)_$S('$G(HLXMZ):"",1:";5////"_HLXMZ)_$S('$G(HLDAI):"",1:";7////"_HLDAI)_";Q"_$S('$P($G(HLNDAP0),U,12):"",1:";3////"_$P($G(HLNDAP0),U,12))
 F  L +^HL(772,DA):1 H:'$T 1 I $T D  Q
 .  D ^DIE
 .  L -^HL(772,DA)
 Q
UPDATE(MTIEN,MTIENP,HLMT,EID,CLIENT,SERVER,PRIORITY,REPLYTO,LOGLINK,HLP) ;
 ;Update Fields of the Message Text File #772 or Message Administration
 ; File #773 for Bi-directional TCP
 ;
 ;$D(HLTCP) will determine if you are updating file 773, instead
 ; of file 772.
 ;
 ;This is a subroutine call with parameter passing.  No output
 ;parameters are returned
 ;
 ;Required Input Parameters
 ;   MTIEN = The IEN from file 772 or 773 of the entry to be
 ;             updated
 ;  MTIENP = The IEN from the Message Text file of the parent entry
 ;           to which this entry (MTIEN) should be linked. TCP will
 ;           ignore this parameter.
 ;    HLMT = The type of message, I for Incoming or O for Outgoing
 ;NOTE:  Either Client or Server must be passed.  Both parameters may
 ;         be passed
 ;  CLIENT = The IEN of the client (subscriber) application from
 ;             the Application Parameter file
 ;  SERVER = The IEN of the server (event driver) application from
 ;             the Application Parameter file
 ;Optional parameters
 ;     EID = The IEN from the Protocol file of the event related to this
 ;             Message Text file entry
 ;PRIORITY = I for immediate or D for deferred
 ; REPLYTO = The IEN from the Message Text file of the message being
 ;             acknowledged.  (Only used for acknowledgement messages.)
 ; LOGLINK = The IEN of the logical link from the Logical Link file
 ; HLP("SECURITY")    = A 1 to 40 character string
 ; HLP("CONTPTR")     = Continuation pointer, a 1 to 180 character string
 ; HLP("MSGTYPE")     = M for Single Message or B for Batch of Messages
 ; HLP("EVENT")       = ien of event type
 ; HLP("MTYPE")       = ien of message type
 ; HLP("HLTCPI")      = ien of initial message
 ; HLP("ACKTIME")     = acknowledge timeout override for this message
 ; HLP("NAMESPACE")   = Passed in by application namespace - HL*1.6*91
 ;
 ;Check for required parameters
 I '$G(MTIEN)!($G(HLMT)']"") Q
 ;File new status info
 N HLJ,HLOCK,X,Y
 ;if TCP update status in file 773, else status in file 772
 S Y=$D(HLTCP)
 I Y S X="HLJ(773,",HLOCK="^HLMA("
 E  S X="HLJ(772,",HLOCK="^HL(772,"
 ;transmission type
 S X=X_""""_MTIEN_","")",HLOCK=HLOCK_MTIEN_")",@X@($S(Y:3,1:4))=HLMT
 ;sending or server application
 S:$G(SERVER) @X@($S(Y:13,1:2))=SERVER
 ;receiving or client application
 S:$G(CLIENT) @X@($S(Y:14,1:3))=CLIENT
 ;acknowledgement to
 S:$G(REPLYTO) @X@($S(Y:12,1:7))=REPLYTO
 ;parent message
 S:$G(MTIENP) @X@(8)=MTIENP
 ;priority
 S:$G(PRIORITY)]"" @X@($S(Y:4,1:9))=PRIORITY
 ;related event protocol
 S:$G(EID) @X@($S(Y:8,1:10))=EID
 ;logical link
 S:$G(LOGLINK) @X@($S(Y:7,1:11))=LOGLINK
 ;security
 S:$G(HLP("SECURITY"))]"" @X@($S(Y:9,1:12))=HLP("SECURITY")
 ;namespace - HL*1.6*91
 I HLOCK["HL(772" S:$G(HLP("NAMESPACE"))?1U1.3UN @X@(16)=HLP("NAMESPACE") ;HL*1.6*91
 ;message type
 S:$G(HLP("MSGTYPE"))]"" @X@($S(Y:5,1:14))=HLP("MSGTYPE")
 ;continuation pointer
 S:$G(HLP("CONTPTR"))]"" @X@($S(Y:11,1:13))=HLP("CONTPTR")
 ;ack timeout override
 S:$G(HLP("ACKTIME")) @X@(26)=HLP("ACKTIME")
 ;only for file 773
 I Y D
 . ;initial message
 . S:$G(HLP("HLTCPI")) @X@(6)=HLP("HLTCPI")
 . ;message type
 . S:$G(HLP("MTYPE")) @X@(15)=HLP("MTYPE")
 . ;event type
 . S:$G(HLP("EVENT")) @X@(16)=HLP("EVENT")
 ;**109** F  L +@HLOCK:1 Q:$T  H 1
 D FILE^HLDIE("","HLJ","","UPDATE","HLTF0") ; HL*1.6*109
 ;**109** L -@HLOCK
 Q
