SDHL7CON ;MS/TG/MS/PB - TMP HL7 Routine;JULY 05, 2018
 ;;5.3;Scheduling;**704,773,812**;May 29, 2018;Build 17
 ;
 ;  Integration Agreements:
 ;
 ;SD*5.3*773 - Removed unused function TMCONV
 ;SD*5.3*812 - Removed code that sent AA for "No consults found" and then quit the process
 Q
 ;
PARSEQ13 ;Process QBP^Q13 messages from the "TMP VISTA" Subscriber protocol
 ;
 ; This routine and subroutines assume that all VistA HL7 environment
 ; variables are properly initialized and will produce a fatal error
 ; if they are missing.
 ;
 ; The message will be checked to see if it is a valid query.
 ; If not a negative acknowledgement will be sent.  If the query is an
 ; immediate mode or synchronous query, the realtime request manager
 ; is called to handle the query.  This means the query will be
 ; processed and a response generated immediately.
 ; In the future deferred mode queries may be filed in a database for
 ; later processing, or transmission.
 ;
 ;  Input:
 ;  HL7 environment variables
 ;
 ; Output:
 ;  Processed query or negative acknowledgement
 ;  If handled real-time the query response is generated
 ;
 ;  Integration Agreements
 ;
 N MSGROOT,DATAROOT,QRY,XMT,ERR,RNAME,IX
 S (MSGROOT,QRY,XMT,ERR,RNAME)=""
 ; Inbound query messages are small enough to be held in a local.
 ; The following lines commented out support use of global and are
 ; left in case use a global becomes necessary.
 ;
 S MSGROOT="SDHL7MSG"
 K @MSGROOT
 N EIN
 S EIN=$$FIND1^DIC(101,,,"TMP QBP-Q13 Event Driver")
 ;
 D LOADXMT(.HL,.XMT) ;Load inbound message information
 S RNAME=XMT("MESSAGE TYPE")_"-"_XMT("EVENT TYPE")_" RECEIVER"
 ;
 N CNT,SEG
 K @MSGROOT
 D LOADMSG(MSGROOT)
 ;
 D PARSEMSG(MSGROOT,.HL)
 ;
 I '$$VALIDMSG(MSGROOT,.QRY,.XMT,.ERR) D  Q
 . D SENDERR(ERR)
 . K @MSGROOT
 . Q
 ;
 N CNT,RDT,HIT,EXTIME,RDF,QPD,QRYDFN,MSGCONID,LST,MYRESULT,HLA,RTCLST
 ;
 S (MSGCONID,QRYDFN)=""
 S CNT=1
 ;
 F  Q:'$D(@MSGROOT@(CNT))  D  S CNT=CNT+1
 . S SEGTYPE=$G(@MSGROOT@(CNT,0))
 . I SEGTYPE="QPD" M QPD=@MSGROOT@(CNT) S QRYDFN=$G(@MSGROOT@(CNT,3)) Q
 . I SEGTYPE="RDF" M RDF=@MSGROOT@(CNT) Q
 . I SEGTYPE="MSH" S MSGCONID=$G(@MSGROOT@(CNT,9)) Q
 . Q
 ;
 I QRYDFN="" D  Q
 . S ERR="QPD^1^^100^AE^No DFN value sent"
 . D SENDERR(ERR)
 . K @MSGROOT
 . Q
 ;
 I '$D(^DPT(QRYDFN,0)) D  Q
 . S ERR="QPD^1^^100^AE^Undefined DFN"
 . D SENDERR(ERR)
 . K @MSGROOT
 . Q
 S DATAROOT=$NA(^TMP("ORQQCN",$J,"CS"))
 K @DATAROOT
 D LIST(.LST,QRYDFN)
 D RTCLIST(.RTCLST,QRYDFN)
 ;
 S HIT=0,EXTIME=""
 ;
 ;****BUILD THE RESPONSE MSG
 K @MSGROOT
 ;
 D INIT^HLFNC2(EIN,.HL)
 S HL("FS")="|",HL("ECH")="^~\&"
 ;
 N ERR,LEN S ERR=""
 N FOUNDCN
 S FOUNDCN=0
 S CNT=1,@MSGROOT@(CNT)=$$MSA^SDTMBUS($G(HL("MID")),ERR,.HL),LEN=$L(@MSGROOT@(CNT))
 S CNT=CNT+1,@MSGROOT@(CNT)=$$QAK^SDTMBUS(.HL,""),LEN=LEN+$L(@MSGROOT@(CNT))
 S CNT=CNT+1,@MSGROOT@(CNT)=$$BLDSEG^SDHL7UL(.QPD,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 S CNT=CNT+1,@MSGROOT@(CNT)=$$BLDSEG^SDHL7UL(.RDF,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 I '$P(ERR,"^",4) D
 . Q:DATAROOT=""
 . D @("RDT^SDTMBUS"_"(MSGROOT,DATAROOT,.CNT,.LEN,.HL,.FOUNDCN)")
 . D RTCRDT^SDTMBUS(MSGROOT,RTCLST,.CNT,.LEN,.HL)
 . Q
 ;
 F IX=1:1:CNT S HLA("HLS",IX)=$G(@MSGROOT@(IX))
 ;
 M HLA("HLA")=HLA("HLS")
 ;
 D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"LM",1,.MYRESULT)
 ;
 D RESET^SDHL7UL ;Clean up TMP used by logging
 K @DATAROOT,@MSGROOT
 ;
 Q
 ;
VALIDMSG(MSGROOT,QRY,XMT,ERR)   ;Validate message
 ;
 ;  Messages handled: QBP^Q13
 ;
 ;  QBP query messages must contain QPD and RCP segments
 ;  Any additional segments are ignored
 ;
 ;  Input:
 ;    MSGROOT - Root of array holding message
 ;        XMT - Transmission parameters
 ;
 ; Output:
 ;        QRY - Query Array
 ;        XMT - Transmission parameters
 ;        ERR - segment^sequence^field^code^ACK type^error text
 ;
 N MSH,QPD,REQID,REQTYPE,QTAG,QNAME,RDF
 N SEGTYPE,CNT
 K QRY,ERR
 S ERR=""
 ;
 ; Set up basics for responding to message.
 ;-----------------------------------------
 S QRY("MID")=XMT("MID")        ;Message ID
 S QRY("QPD")=""
 ;
 ; Validate message is a well-formed QBP query message.
 ;-----------------------------------------------------------
 ; Must have MSH first, followed by QPD,RCP in any order
 ; PID and STF are optional.  All other segments are ignored.
 ;
 I $G(@MSGROOT@(1,0))="MSH" M MSH=@MSGROOT@(1)
 E  S ERR="MSH^1^^100^AE^Missing MSH segment" Q 0
 ;
 S CNT=2
 F  Q:'$D(@MSGROOT@(CNT))  D  S CNT=CNT+1
 . S SEGTYPE=$G(@MSGROOT@(CNT,0))
 . I SEGTYPE="QPD" M QPD=@MSGROOT@(CNT),QRY("QPD")=QPD Q
 . I SEGTYPE="RDF" M RDF=@MSGROOT@(CNT) Q
 . Q
 ;
 I '$D(QPD) S ERR="QPD^1^^100^AE^Missing QPD segment" Q 0
 ;
 S QTAG=$G(QPD(1,1,2))       ;Query Tag
 S REQID=$G(QPD(2))  ;Request ID
 S REQTYPE=$G(QPD(3,1,1))    ;Request Type
 S:REQTYPE="" REQTYPE=$G(QPD(3))     ;Request Type if no other params 
 ;
 ; Validate required fields and query parameters
 ;------------------------------------------------------
 ;
 ; Check for missing/invalid fields
 ;
 I '$D(QPD(1)) S ERR="QPD^1^1^101^AE^Missing Message Query Name" Q 0
 ;
 I QTAG="" S ERR="QPD^1^2^101^AE^Missing Query Tag" Q 0
 I REQID="" S ERR="QPD^1^2^101^AE^Missing Request ID" Q 0
 S (QRY("DCLSNM"),QRY("DFN"))=""
 S QRY("REQID")=REQID
 ;
 I REQTYPE="" S ERR="QPD^1^3^101^AE^Missing Request Type" Q 0
 ;
 Q 1
 ;
LOADXMT(HL,XMT) ;Set HL dependent XMT values
 ;
 ; The HL array and variables are expected to be defined.  If not,
 ; message processing will fail.  These references should not be
 ; wrapped in $G, as null values will simply postpone the failure to
 ; a point that will be harder to diagnose.  Except HL("APAT") which
 ; is not defined on synchronous calls.
 ;
 ;  Integration Agreements:
 ; 1373 : Reference to PROTOCOL file #101
 ;
 N SUBPROT,RESPIEN,RESP0
 S HL("EID")=$$FIND1^DIC(101,,,"TMP QBP-Q13 Event Driver")
 S HL("EIDS")=$$FIND1^DIC(101,,,"TMP QBP-Q13 Subscriber")
 S XMT("MID")=HL("MID")   ;Message ID
 S XMT("MODE")="A"        ;Response mode
 I $G(HL("APAT"))="" S XMT("MODE")="S"    ;Synchronous mode
 S XMT("MESSAGE TYPE")=HL("MTN")  ;Message type
 S XMT("EVENT TYPE")=HL("ETN")    ;Event type
 S XMT("DELIM")=HL("FS")_HL("ECH")        ;HL Delimiters
 ;S XMT("DELIM")="~^\&"
 S XMT("MAX SIZE")=0      ;Default size unlimited
 ;
 ; Map response protocol and builder
 S SUBPROT=$P(^ORD(101,HL("EIDS"),0),"^")
 Q
LIST(SDY,SDPT,SDSDT,SDEDT,SDSERV,SDSTATUS) ; return patient's consult requests between start date and stop date for the service and status indicated:
 N I,J,SITE,SEQ,DIFF,SDSRV,ORLOC,GMRCOER
 S J=1,SEQ="",GMRCOER=2
 S:'$L($G(SDSDT)) SDSDT=""
 S:'$L($G(SDEDT)) SDEDT=""
 S:'$L($G(SDSERV))!(+$G(SDSERV)=0) SDSERV=""
 S:'$L($G(SDSTATUS)) SDSTATUS="" ;ALL STATI
 K ^TMP("GMRCR",$J)
 S SDY=$NA(^TMP("ORQQCN",$J,"CS"))
 D OER^GMRCSLM1(SDPT,SDSERV,SDSDT,SDEDT,SDSTATUS,GMRCOER)
 M @SDY=^TMP("GMRCR",$J,"CS")
 K @SDY@("AD")
 K @SDY@(0)
 K ^TMP("GMRCR",$J)
 Q
RTCLIST(SDY,SDPT,SDSDT,SDEDT) ; return patient's "Return to Clinic" appointment requests
 ;SDY = return global
 ;SDPT = dfn of patient
 ;SDSDT = start date (based on CREATE DATE of request)
 ;SDEDT = end date (based on END DATE of request)
 N IDX,IEN,SDEC0,REQDT,CNT,CLINID,CID,STOP,PRVID,CMTS,MRTC,RTCINT,RTCINT,RTCPAR
 S SDY=$NA(^TMP("SDHL7CON",$J,"RTCLIST")) K @SDY
 S SDSDT=$G(SDSDT,"ALL"),SDEDT=$G(SDEDT),CNT=0
 Q:'$G(SDPT)  ; Return nothing if no patient passed
 S IDX=$NA(^SDEC(409.85,"B",SDPT)),IEN=0
 F  S IEN=$O(@IDX@(IEN)) Q:'$G(IEN)  D
 . K RTCINT,MRTC,RTCPAR,SDEC0,CLINID,CID,PRVID,CMTS,CLINNM,STOP
 . S SDEC0=$G(^SDEC(409.85,IEN,0))
 . I $P(SDEC0,U,5)'="RTC" Q
 . I $P(SDEC0,U,17)'="O" Q
 . S REQDT=$P(SDEC0,U,2) I SDSDT'="ALL",$P(REQDT,".",1)<SDSDT!($P(REQDT,".",1)>SDEDT) Q
 . S CLINID=$P(SDEC0,U,9),CID=$P(SDEC0,U,16),PRVID=$P(SDEC0,U,13),CMTS=$P(SDEC0,U,18),CMTS=$E(CMTS,1,80)
 . S:$P($G(^SDEC(409.85,IEN,3)),"^")=1 MRTC=$P($G(^SDEC(409.85,IEN,3)),"^",3),RTCINT=$P($G(^SDEC(409.85,IEN,3)),"^",2),RTCPAR=$P($G(^SDEC(409.85,IEN,3)),"^",5)
 . S:$G(RTCPAR)="" RTCPAR=IEN
 . S:$G(MRTC)="" MRTC=0 S:$G(RTCINT)="" RTCINT=0
 . I +CLINID D
 . . S CLINNM=$$GET1^DIQ(44,CLINID_",",".01")
 . . S STOP=$$GET1^DIQ(44,CLINID_",",8)_","_$$GET1^DIQ(44,CLINID_",",2503)
 . S CNT=CNT+1,@SDY@(CNT)=IEN_U_REQDT_U_CLINID_U_CID_U_PRVID_U_CMTS_U_$G(MRTC)_U_$G(RTCINT)_U_$G(RTCPAR)
 S @SDY=CNT
 Q
PARSESEG(SEG,DATA,HL) ;Generic segment parser
 ;This procedure parses a single HL7 segment and builds an array
 ;subscripted by the field number containing the data for that field.
 ; Does not handle segments that span nodes
 ;
 ;  Input:
 ;     SEG - HL7 segment to parse
 ;      HL - HL7 environment array
 ;
 ;  Output:
 ;    Function value - field data array [SUB1:field, SUB2:repetition,
 ;        SUB3:component, SUB4:sub-component]
 ;
 N CMP     ;component subscript
 N CMPVAL  ;component value
 N FLD     ;field subscript
 N FLDVAL  ;field value
 N REP     ;repetition subscript
 N REPVAL  ;repetition value
 N SUB     ;sub-component subscript
 N SUBVAL  ;sub-component value
 N FS      ;field separator
 N CS      ;component separator
 N RS      ;repetition separator
 N SS      ;sub-component separator
 ;
 K DATA
 S FS=HL("FS")
 S CS=$E(HL("ECH"))
 S RS=$E(HL("ECH"),2)
 S SS=$E(HL("ECH"),4)
 ;
 S DATA(0)=$P(SEG,FS)
 S SEG=$P(SEG,FS,2,9999)
 ;
 F FLD=1:1:$L(SEG,FS) D
 . S FLDVAL=$P(SEG,FS,FLD)
 . F REP=1:1:$L(FLDVAL,RS) D
 . . S REPVAL=$P(FLDVAL,RS,REP)
 . . I REPVAL[CS F CMP=1:1:$L(REPVAL,CS) D
 . . . S CMPVAL=$P(REPVAL,CS,CMP)
 . . . I CMPVAL[SS F SUB=1:1:$L(CMPVAL,SS) D
 . . . . S SUBVAL=$P(CMPVAL,SS,SUB)
 . . . . I SUBVAL'="" S DATA(FLD,REP,CMP,SUB)=SUBVAL
 . . . I '$D(DATA(FLD,REP,CMP)),CMPVAL'="" S DATA(FLD,REP,CMP)=CMPVAL
 . . I '$D(DATA(FLD,REP)),REPVAL'="",FLDVAL[RS S DATA(FLD,REP)=REPVAL
 . I '$D(DATA(FLD)),FLDVAL'="" S DATA(FLD)=FLDVAL
 Q
 ;
LOADMSG(MSGROOT) ; Load HL7 message into temporary global for processing
 ;
 ;This subroutine assumes that all VistA HL7 environment variables are
 ;properly initialized and will produce a fatal error if they aren't.
 ;
 N CNT,SEG
 K @MSGROOT
 F SEG=1:1 X HLNEXT Q:HLQUIT'>0  D
 . S CNT=0
 . S @MSGROOT@(SEG,CNT)=HLNODE
 . F  S CNT=$O(HLNODE(CNT)) Q:'CNT  S @MSGROOT@(SEG,CNT)=HLNODE(CNT)
 Q
 ;
PARSEMSG(MSGROOT,HL) ; Message Parser
 ; Does not handle segments that span nodes
 ; Does not handle extremely long segments (uses a local)
 ; Does not handle long fields (segment parser doesn't)
 ;
 N SEG,CNT,DATA,MSG
 F CNT=1:1 Q:'$D(@MSGROOT@(CNT))  M SEG=@MSGROOT@(CNT) D
 . D PARSESEG(SEG(0),.DATA,.HL)
 . K @MSGROOT@(CNT)
 . I DATA(0)'="" M @MSGROOT@(CNT)=DATA
 . Q:'$D(SEG(1))
 . ;
 . Q
 Q
SENDERR(ERR)  ; Send for unsuccessful response
 K @MSGROOT
 D INIT^HLFNC2(EIN,.HL)
 S HL("FS")="|",HL("ECH")="^~\&"
 S CNT=1,@MSGROOT@(CNT)=$$MSA^SDTMBUS($G(HL("MID")),ERR,.HL),LEN=$L(@MSGROOT@(CNT))
 S CNT=CNT+1,@MSGROOT@(CNT)=$$QAK^SDTMBUS(.HL,ERR),LEN=LEN+$L(@MSGROOT@(CNT))
 F IX=1:1:CNT S HLA("HLS",IX)=$G(@MSGROOT@(IX))
 M HLA("HLA")=HLA("HLS")
 D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"LM",1,.MYRESULT)
 Q
