MHV7R1 ;WAS/GPM - HL7 RECEIVER FOR QBP QUERIES ; [12/31/07 3:11pm]
 ;;1.0;My HealtheVet;**1,2**;Aug 23, 2005;Build 22
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
QBPQ13 ;Process QBP^Q13 messages from the MHV QBP-Q13 Subscriber protocol
 ;
QBPQ11 ;Process QBP^Q11 messages from the MHV QBP-Q11 Subscriber protocol
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
VALIDMSG(MSGROOT,QRY,XMT,ERR) ;Validate message
 ;
 ;  Messages handled: QBP^Q13
 ;                    QBP^Q11
 ;
 ;  QBP query messages must contain PID, QPD and RCP segments
 ;  RXE segments are processed on Q13 prescription queries
 ;  Any additional segments are ignored
 ;
 ;  The following sequences are required
 ;     PID(3)  - Patient ID
 ;     PID(5)* - Patient Name
 ;     QPD(1)* - Message Query Name
 ;     QPD(2)* - Query Tag
 ;     QPD(3)  - Request ID
 ;     QPD(4)  - Subject Area
 ;     RCP(1)  - Query Priority
 ;               * required by HL7 standard but not used by MHV
 ;
 ;  The following sequences are optional
 ;     QPD(5)  - From Date
 ;     QPD(6)  - To Date
 ;     RCP(2)  - Quantity Limited
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
 N MSH,PID,RDF,RXE,QPD,RCP,REQID,REQTYPE,FROMDT,TODT,PRI,QTAG,QNAME,SEGTYPE,CNT,OCNT,RXNUM,QTY,UNIT
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
 ; Must have MSH first, followed by QPD,PID,RXE,RDF,RCP in any order
 ; RXE is processed on Q13 prescriptions queries
 ; RDF is not required
 ; Any other segments are ignored.
 ;
 I $G(@MSGROOT@(1,0))="MSH" M MSH=@MSGROOT@(1)
 E  S ERR="MSH^1^^100^AE^Missing MSH segment" Q 0
 ;
 S CNT=2,OCNT=0
 F  Q:'$D(@MSGROOT@(CNT))  D  S CNT=CNT+1
 . S SEGTYPE=$G(@MSGROOT@(CNT,0))
 . I SEGTYPE="PID" M PID=@MSGROOT@(CNT),QRY("PID")=PID Q
 . I SEGTYPE="QPD" M QPD=@MSGROOT@(CNT),QRY("QPD")=QPD Q
 . I SEGTYPE="RDF" M RDF=@MSGROOT@(CNT) Q
 . I SEGTYPE="RCP" M RCP=@MSGROOT@(CNT) Q
 . I SEGTYPE="RXE" S OCNT=OCNT+1 M RXE(OCNT)=@MSGROOT@(CNT) Q
 . Q
 ;
 I '$D(PID) S ERR="PID^1^^100^AE^Missing PID segment" Q 0
 I '$D(QPD) S ERR="QPD^1^^100^AE^Missing QPD segment" Q 0
 I '$D(RCP) S ERR="RCP^1^^100^AE^Missing RCP segment" Q 0
 ;
 ; Validate required fields and query parameters
 ;------------------------------------------------------
 S QTAG=$G(QPD(2))            ;Query Tag
 S REQID=$G(QPD(3))           ;Request ID
 S REQTYPE=$G(QPD(4))         ;Request Type
 S FROMDT=$G(QPD(5))          ;From Date
 S TODT=$G(QPD(6))            ;To Date
 S PRI=$G(RCP(1))             ;Query Priority
 S QTY=$G(RCP(2,1,1))         ;Quantity Limited
 S UNIT=$G(RCP(2,1,2))        ;Quantity units
 ;
 I '$D(QPD(1)) S ERR="QPD^1^1^101^AE^Missing Message Query Name" Q 0
 M QNAME=QPD(1)  ;Message Query Name
 ;
 I QTAG="" S ERR="QPD^1^2^101^AE^Missing Query Tag" Q 0
 ;
 I REQID="" S ERR="QPD^1^3^101^AE^Missing Request ID" Q 0
 S QRY("REQID")=REQID
 ;
 I REQTYPE="" S ERR="QPD^1^4^101^AE^Missing Request Type" Q 0
 I '$$VALRTYPE^MHV7RU(REQTYPE,.QRY,.ERR) S ERR="QPD^1^4^"_ERR Q 0
 ;
 I '$$VALIDDT^MHV7RU(.FROMDT) S ERR="QPD^1^5^102^AE^Invalid From Date" Q 0
 S QRY("FROM")=FROMDT
 I '$$VALIDDT^MHV7RU(.TODT) S ERR="QPD^1^6^102^AE^Invalid To Date" Q 0
 I TODT'="",TODT<FROMDT S ERR="QPD^1^6^102^AE^To Date precedes From Date" Q 0
 S QRY("TO")=TODT
 ;
 I '$$VALIDPID^MHV7RUS(.PID,.QRY,.ERR) Q 0
 ;
 I PRI="" S ERR="RCP^1^1^101^AE^Missing Query Priority" Q 0
 I ",D,I,"'[(","_PRI_",") S ERR="RCP^1^1^102^AE^Invalid Query Priority" Q 0
 S QRY("PRI")=PRI
 ;
 I QTY'?0.N S ERR="RCP^1^2^102^AE^Invalid Quantity" Q 0
 S QRY("QTY")=+QTY
 S XMT("MAX SIZE")=+QTY
 ;
 I QTY,UNIT'="CH" S ERR="RCP^1^2^102^AE^Invalid Units" Q 0
 ;
 ; Setup prescription list (if passed)
 ;------------------------------------
 F CNT=1:1 Q:'$D(RXE(CNT))  D  Q:ERR'=""
 . S RXNUM=$G(RXE(CNT,15))
 . I RXNUM="" S ERR="RXE^"_CNT_"^15^101^AE^Missing Prescription#" Q
 . I RXNUM'?1.N0.A S ERR="RXE^"_CNT_"^15^102^AE^Invalid Prescription#" Q
 . S QRY("RXLIST",RXNUM)=""
 . Q
 Q:ERR'="" 0
 ;
 Q 1
 ;
