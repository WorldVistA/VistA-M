MHV7R4 ;WAS/GPM - HL7 RECEIVER FOR SECURE MESSAGING QRY^A19 ; [3/23/08 9:32pm]
 ;;1.0;My HealtheVet;**5**;Aug 23, 2005;Build 24
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
QRYA19 ;Process QRY^A19 messages from the MHVSM QRY-A19 Subscriber protocol
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
 S RNAME="SM "_XMT("MESSAGE TYPE")_"-"_XMT("EVENT TYPE")_" RECEIVER"
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
 ;  Messages handled: QRY^A19 - Demographics
 ;
 ;  Old style query messages must contain QRD and QRF segments.
 ;  Any additional segments are ignored.
 ;
 ;  The following sequences are required
 ;     QRD(1)* - Query Date/Time
 ;     QRD(2)* - Query Format Code
 ;     QRD(3)  - Query Priority
 ;     QRD(4)  - Query ID
 ;     QRD(8)  - Who Subject Filter
 ;     QRD(9)* - What Subject Filter
 ;     QRD(10) - What Dept. Data Code
 ;     QRF(1)* - Where Subject Filter
 ;               * required by HL7 standard but not used by MHV
 ;                 Name fields in Who Subject Filter also not used
 ;
 ;  The following sequences are optional
 ;     QRD(7) - Quantity Limited Request
 ;     QRF(2) - When Data Start Date/Time
 ;     QRF(3) - When Data End Date/Time
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
 N MSH,QRD,QRF,ICN,DFN,SSN,I,ID,REQTYPE,PRI,REQID,TYPE,FROMDT,TODT,SEGTYPE,CNT,FAMILY,GIVEN,MIDDLE,SUFFIX,FORMAT,WHAT,WHERE,OCNT,QTY,QDATE,UNIT
 K QRY,ERR
 S ERR=""
 ;
 ; Set up basics for responding to message.
 ;-----------------------------------------
 S QRY("MID")=XMT("MID")        ;Message ID
 S QRY("QRD")=""
 S QRY("QRF")=""
 ;
 ; Validate message is a well-formed old style query message.
 ;-----------------------------------------------------------
 ; Must have MSH first followed by QRD, and QRF in any order.
 ; Any other segments are ignored.
 ;
 I $G(@MSGROOT@(1,0))="MSH" M MSH=@MSGROOT@(1)
 E  S ERR="MSH^1^^100^AE^Missing MSH segment" Q 0
 ;
 S CNT=2,OCNT=0
 F  Q:'$D(@MSGROOT@(CNT))  D  S CNT=CNT+1
 . S SEGTYPE=$G(@MSGROOT@(CNT,0))
 . I SEGTYPE="QRD" M QRD=@MSGROOT@(CNT),QRY("QRD")=QRD Q
 . I SEGTYPE="QRF" M QRF=@MSGROOT@(CNT),QRY("QRF")=QRF Q
 . Q
 ;
 I '$D(QRD) S ERR="QRD^1^^100^AE^Missing QRD segment" Q 0
 I '$D(QRF) S ERR="QRF^1^^100^AE^Missing QRF segment" Q 0
 ;
 ; Validate required fields and query parameters
 ;------------------------------------------------------
 S QDATE=$G(QRD(1))             ;Query Date/Time
 S FORMAT=$G(QRD(2))            ;Query Format Code
 S PRI=$G(QRD(3))               ;Query Priority
 S REQID=$G(QRD(4))             ;Query ID - Request ID
 S QTY=$G(QRD(7,1,1))           ;Quantity Limited Request
 S UNIT=$G(QRD(7,1,2))          ;Quantity Units
 S WHAT=$G(QRD(9,1,1))          ;What Subject Filter
 S REQTYPE=$G(QRD(10))          ;What Dept. Data Code - Request Type
 S WHERE=$G(QRF(1))             ;Where Subject Filter
 S FROMDT=$G(QRF(2))            ;When Data Start Date/Time - From Date
 S TODT=$G(QRF(3))              ;When Data End Date/Time - To Date
 ;
 I QDATE="" S ERR="QRD^1^1^101^AE^Missing Query Date/Time" Q 0
 I '$$VALIDDT^MHV7RU(.QDATE) S ERR="QRD^1^1^102^AE^Invalid Query Date/Time" Q 0
 ;
 I FORMAT="" S ERR="QRD^1^2^101^AE^Missing Query Format Code" Q 0
 I FORMAT'="R" S ERR="QRD^1^2^102^AE^Invalid Query Format Code" Q 0
 ;
 I PRI="" S ERR="QRD^1^3^101^AE^Missing Query Priority" Q 0
 I ",D,I,"'[(","_PRI_",") S ERR="QRD^1^3^102^AE^Invalid Query Priority" Q 0
 S QRY("PRI")=PRI
 ;
 I REQID="" S ERR="QRD^1^4^101^AE^Missing Request ID" Q 0
 S QRY("REQID")=REQID
 ;
 I QTY'?0.N S ERR="QRD^1^7^102^AE^Invalid Quantity" Q 0
 S QRY("QTY")=+QTY
 S XMT("MAX SIZE")=+QTY
 ;
 I QTY,UNIT'="CH" S ERR="QRD^1^7^102^AE^Invalid Units" Q 0
 ;
 I WHAT="" S ERR="QRD^1^9^101^AE^Missing What Subject Filter" Q 0
 ;
 I REQTYPE="" S ERR="QRD^1^10^101^AE^Missing Request Type" Q 0
 I '$$VALRTYPE^MHV7RU(REQTYPE,.QRY,.ERR) S ERR="QRD^1^10^"_ERR Q 0
 ;
 I '$$VALIDWHO^MHV7RUS(.QRD,.QRY,.ERR) Q 0
 ;
 I WHERE="" S ERR="QRF^1^1^101^AE^Missing Where Subject Filter" Q 0
 ;
 I '$$VALIDDT^MHV7RU(.FROMDT) S ERR="QRF^1^2^102^AE^Invalid From Date" Q 0
 S QRY("FROM")=FROMDT
 I '$$VALIDDT^MHV7RU(.TODT) S ERR="QRF^1^3^102^AE^Invalid To Date" Q 0
 I TODT'="",TODT<FROMDT S ERR="QRF^1^3^102^AE^To Date precedes From Date" Q 0
 S QRY("TO")=TODT
 ;
 ; Get HL7 delimiters to be used in the response message
 ; Some extractors call APIs that require delimiters to be passed
 S QRY("DELIM")=XMT("DELIM")
 I XMT("MODE")="A" S QRY("DELIM")=$$DELIM^MHV7U(XMT("PROTOCOL"))
 ;
 Q 1
 ;
