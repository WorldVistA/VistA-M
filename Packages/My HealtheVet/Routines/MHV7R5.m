MHV7R5 ;WAS/DLF - HL7 RECEIVER FOR ADMIN QUERIES ; 9/25/08 4:09pm
 ;;1.0;My HealtheVet;**6**;Aug 23, 2005;Build 82
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
QBPQ11 ;Process QBP^Q11 messages from the MHVSM QBP-Q11 Subscriber protocol
 ;
 ; This routine and subroutines assume that all VistA HL7 environment
 ; variables are properly initialized and will produce a fatal error
 ; if they are missing.
 ;
 ;  The message will be checked to see if it is a valid query.
 ; If not a negative acknowledgement will be sent.  If the query is an
 ; immediate mode or synchronous query, the realtime request manager
 ; is called to handle the query.  This means the query will be
 ; processed and a response generated immediately.
 ; In the future deferred mode queries may be filed in a database for
 ; later processing, or transmission.
 ;
 ;  Input:
 ;          HL7 environment variables
 ;
 ; Output:
 ;          Processed query or negative acknowledgement
 ;          If handled real-time the query response is generated
 ;
 ;  Integration Agreements
 ;
 ;          10104 UP^XLFSTR
 ;
 N MSGROOT,QRY,XMT,ERR,RNAME
 S (QRY,XMT,ERR)=""
 ; Inbound query messages are small enough to be held in a local.
 ; The following lines commented out support use of global and are
 ; left in case use a global becomes necessary.
 ;S MSGROOT="^TMP(""MHV7"",$J)"
 ;K @MSGROOT
 S MSGROOT="MHV7MSG"
 N MHV7MSG
 D LOADXMT^MHV7U(.XMT)         ;Load inbound message information
 ;
 S RNAME=XMT("MESSAGE TYPE")_"-"_XMT("EVENT TYPE")_" RECEIVER"
 D LOG^MHVUL2(RNAME,"BEGIN","S","TRACE")
 ;
 D LOADMSG^MHV7U(MSGROOT)
 D LOG^MHVUL2("LOAD",MSGROOT,"I","DEBUG")
 ;
 D PARSEMSG^MHV7U(MSGROOT,.HL)
 D LOG^MHVUL2("PARSE",MSGROOT,"I","DEBUG")
 ;
 I '$$VALIDMSG(MSGROOT,.QRY,.XMT,.ERR) D  Q
 . D LOG^MHVUL2("MSG CHECK","INVALID^"_ERR,"S","ERROR")
 . D XMIT^MHV7T(.QRY,.XMT,ERR,"",.HL)
 D LOG^MHVUL2("MSG CHECK","VALID","S","TRACE")
 ;
 ; Immediate Mode
 ; Deferred mode queries are not supported at this time
 D REALTIME^MHVRQI(.QRY,.XMT,.HL)
 ;
 D LOG^MHVUL2(RNAME,"END","S","TRACE")
 D RESET^MHVUL2          ;Clean up TMP used by logging
 ;K @MSGROOT
 ;
 Q
 ;
VALIDMSG(MSGROOT,QRY,XMT,ERR)   ;Validate message
 ;
 ;  Messages handled: QBP^Q11
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
 N MSH,PID,STF,QPD,RCP,REQFLDS,REQID,REQTYPE,FROMDT,TODT,PRI,QTAG,QNAME
 N SEGTYPE,CNT,OCNT,RXNUM,QTY,UNIT,REQFLDS,CHKSEG
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
 S CNT=2,OCNT=0
 F  Q:'$D(@MSGROOT@(CNT))  D  S CNT=CNT+1
 . S SEGTYPE=$G(@MSGROOT@(CNT,0))
 . I SEGTYPE="PID" M PID=@MSGROOT@(CNT),QRY("PID")=PID Q
 . I SEGTYPE="STF" M STF=@MSGROOT@(CNT),QRY("STF")=STF Q
 . I SEGTYPE="QPD" M QPD=@MSGROOT@(CNT),QRY("QPD")=QPD Q
 . I SEGTYPE="RCP" M RCP=@MSGROOT@(CNT),QRY("RCP")=RCP Q
 . Q
 ;
 I '$D(QPD) S ERR="QPD^1^^100^AE^Missing QPD segment" Q 0
 ;
 S QTAG=$G(QPD(1,1,2))               ;Query Tag
 S REQID=$G(QPD(2))                  ;Request ID
 S REQTYPE=$G(QPD(3,1,1))            ;Request Type
 S PRI=$G(RCP(1))                    ;Query Priority
 S QTY=$G(RCP(2,1,1))                ;Quantity Limited
 S UNIT=$G(RCP(2,1,2))               ;Quantity units
 S:REQTYPE="" REQTYPE=$G(QPD(3))     ;Request Type if no other params
 ;
 ; Validate required fields and query parameters
 ;------------------------------------------------------
 ;
 ; Check for missing/invalid fields
 ;
 I '$D(QPD(1)) S ERR="QPD^1^1^101^AE^Missing Message Query Name" Q 0
 M QNAME=QPD(1)  ;Message Query Name
 ;
 I QTAG="" S ERR="QPD^1^2^101^AE^Missing Query Tag" Q 0
 I REQID="" S ERR="QPD^1^2^101^AE^Missing Request ID" Q 0
 S (QRY("IEN"),QRY("LNAME"),QRY("FNAME"),QRY("DFN"))=""
 S QRY("REQID")=REQID
 ;
 I REQTYPE="" S ERR="QPD^1^3^101^AE^Missing Request Type" Q 0
 I '$$VALRTYPE^MHV7RU(REQTYPE,.QRY,.ERR) S ERR="QPD^1^3^"_ERR Q 0
 ;
 ; If we have a PID, validate it and populate query parameters
 ; from the PID.
 ;
 I $D(PID) D VALIDPID
 ;
 ; If we have a STF, validate it and populate query parameters
 ; from the STF.  
 ;
 I $D(STF) D VALIDSTF
 ;
 I ERR Q 0
 ;
 ; If no PID or STF segment sent, Populate parameters 1-3 with the
 ; QPD segment data
 ;
 I '$D(PID),'$D(STF)  D
 .S QRY("IEN")=$G(QPD(3,1,2))          ;ien
 .S QRY("LNAME")=$$UP^XLFSTR($G(QPD(3,1,3)))        ;Last Name
 .S QRY("FNAME")=$$UP^XLFSTR($G(QPD(3,1,4)))        ;First Name
 S FROMDT=$G(QPD(3,1,5))        ;From Date
 S TODT=$G(QPD(3,1,6))          ;To Date
 ;
 ; Validate from and to date if present
 ;
 I FROMDT]""  D
 .I '$$VALIDDT^MHV7RU(.FROMDT) S ERR="QPD^1^7^102^AE^Invalid From Date"
 I TODT]""  D
 .I '$$VALIDDT^MHV7RU(.TODT) S ERR="QPD^1^8^102^AE^Invalid To Date"
 .I TODT'="",TODT<FROMDT  D
 ..S ERR="QPD^1^6^102^AE^To Date precedes From Date"
 S QRY("FROMDT")=FROMDT,QRY("TODT")=TODT
 I ERR'="" Q 0
 ;
 I PRI="" S ERR="RCP^1^1^101^AE^Missing Query Priority" Q 0
 I ",D,I,"'[(","_PRI_",") S ERR="RCP^1^1^102^AE^Invalid Query Priority" Q 0
 S QRY("PRI")=PRI
 Q:ERR'="" 0
 ;
 Q 1
 ;
VALIDPID ;
 ;
 ; If the IEN was sent, call the validation utility for
 ; PID segments
 ;
 I $D(PID(3,1,1))  D
 .S CHKSEG=$$VALIDPID^MHV7RUS(.PID,.QRY,.ERR)
 .S QRY("IEN")=QRY("DFN")
 ;
 ; If no IEN, populate parameters for name
 ;
 I QRY("IEN")="",ERR=""  D
 .S QRY("LNAME")=$$UP^XLFSTR(PID(5,1,1))
 .S:$D(PID(5,1,2)) QRY("FNAME")=$$UP^XLFSTR(PID(5,1,2))
 Q
VALIDSTF        ;
 ;
 ; If the IEN was sent, call the validation utility for
 ; STF segments
 ;
 I $D(STF(2))  D  Q
 .S QRY("IEN")=STF(2,1,1)
 ;
 ; If no IEN, populate parameters for name
 ;
 I $G(STF(3))]"" S QRY("LNAME")=$$UP^XLFSTR($TR(STF(3),"^",""))
 S:$D(STF(3,1,1)) QRY("LNAME")=$$UP^XLFSTR(STF(3,1,1))
 S:$D(STF(3,1,2)) QRY("FNAME")=$$UP^XLFSTR(STF(3,1,2))
 Q
