MHV7R6 ;KUM - HL7 RECEIVER FOR TIU TITLES QUERY ; 1/5/13 10:34am
 ;;1.0;My HealtheVet;**10,11**;Aug 23, 2005;Build 61
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;  Integration Agreements:
 ;        10104 : $$UP^XLFSTR
 Q
 ;
QBPQ13 ;Process QBP^Q13 messages from the MHVSM QBP-Q13 Subscriber protocol
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
 N MSH,PID,STF,QPD,RCP,REQFLDS,REQID,REQTYPE,FROMDT,TODT,PRI,QTAG,QNAME,MHVDCIEN
 N SEGTYPE,CNT,OCNT,RXNUM,QTY,UNIT,REQFLDS,CHKSEG
 K QRY,ERR
 S MHVDCIEN=0
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
 . I SEGTYPE="QPD" M QPD=@MSGROOT@(CNT),QRY("QPD")=QPD Q
 . I SEGTYPE="RDF" M RDF=@MSGROOT@(CNT) Q
 . Q
 ;
 I '$D(QPD) S ERR="QPD^1^^100^AE^Missing QPD segment" Q 0
 ;
 S QTAG=$G(QPD(1,1,2))               ;Query Tag
 S REQID=$G(QPD(2))                  ;Request ID
 S REQTYPE=$G(QPD(3,1,1))            ;Request Type
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
 S (QRY("DCLSNM"),QRY("DFN"))=""
 S QRY("REQID")=REQID
 ;
 I REQTYPE="" S ERR="QPD^1^3^101^AE^Missing Request Type" Q 0
 I '$$VALRTYPE^MHV7RU(REQTYPE,.QRY,.ERR) S ERR="QPD^1^3^"_ERR Q 0
 ;
 I ERR Q 0
 ;
 ; Populate parameters 1-3 with the QPD segment data
 ;
 S QRY("DCLSNM")=$G(QPD(3,1,3))        ;Document Class Name
 I (REQTYPE="TIUTitlesByDocumentClass")&($D(QPD))  D
 . I $G(QRY("DCLSNM"))="" S ERR="QPD^1^6^101^AE^Document Class Name cannot be null" Q
 . S MHVDCIEN=$$DOCDEF^MHVXTIU($G(QRY("DCLSNM")))
 . I $G(MHVDCIEN)=0 S ERR="QPD^1^6^102^AE^Document Class Name "_$G(QRY("DCLSNM"))_" Unknown."
 ;
 ;Added for MHV*1.0*11 - Validations for SMDSSUnitsByProviderAndAClinic query Input parameters
 S QRY("ACLN")=$G(QPD(3,1,2))
 S QRY("PDUZ")=$G(QPD(3,1,3))
 I (REQTYPE="SMDSSUnitsByProviderAndClinic")&($D(QPD))  D
 . I $G(QRY("ACLN"))="" S ERR="QPD^1^6^101^AE^DSS6-Associated Clinic cannot be null" Q
 . I $G(QRY("PDUZ"))="" S ERR="QPD^1^6^102^AE^DSS5-Provider DUZ cannot be null" Q
 I ERR Q 0
 ;
 ;Added for MHV*1.0*11 - Validations for SMECSProcedures query Input parameters
 S QRY("DSSI")=$G(QPD(3,1,2))
 S QRY("LOCI")=$G(QPD(3,1,3))
 I (REQTYPE="SMECSProcedures")&($D(QPD))  D
 . I $G(QRY("DSSI"))="" S ERR="QPD^1^6^101^AE^DSS Unit IEN cannot be null" Q
 . I $G(QRY("LOCI"))="" S ERR="QPD^1^6^102^AE^Location IEN cannot be null" Q
 I ERR Q 0
 ;
 I ERR'="" Q 0
 ;
 Q 1
 ;
