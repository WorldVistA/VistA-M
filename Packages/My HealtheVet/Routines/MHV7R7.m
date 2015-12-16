MHV7R7 ;KUM - HL7 RECEIVER FOR ADMIN QUERIES ; 6/7/10 10:34am
 ;;1.0;My HealtheVet;**11**;Aug 23, 2005;Build 61
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;  Integration Agreements:
 ;        10104 : $$UP^XLFSTR
 ;        10104 : $$REPLACE^XLFSTR
 Q
 ;
DFTP03 ;Process DFT^P03 messages from the MHVSM DFT-P03 Subscriber protocol
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
 ;  Messages handled: DFT^P03
 ;
 ;  QBP query messages must contain FT1, EVN, PID, PV1, ZEL segments
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
 N MSH,PID,STF,QPD,RCP,REQFLDS,REQID,REQTYPE,FROMDT,TODT,PRI,QTAG,QNAME,MHVCSIE
 N SEGTYPE,CNT,OCNT,RXNUM,QTY,UNIT,REQFLDS,CHKSEG
 K QRY,ERR
 S MHVCSIE=""
 S ERR=""
 ;
 ; Set up basics for responding to message.
 ;-----------------------------------------
 S QRY("MID")=XMT("MID")        ;Message ID
 S QRY("QPD")=""
 ;
 ; Validate message is a well-formed DFT query message.
 ;-----------------------------------------------------------
 ; Must have MSH first, followed by FT1,EVN,PID,PV1,ZEL in any order
 ;  are optional.  All other segments are ignored.
 ;
 I $G(@MSGROOT@(1,0))="MSH" M MSH=@MSGROOT@(1)
 E  S ERR="MSH^1^^100^AE^Missing MSH segment" Q 0
 ;
 S CNT=2,OCNT=0
 F  Q:'$D(@MSGROOT@(CNT))  D  S CNT=CNT+1
 . S SEGTYPE=$G(@MSGROOT@(CNT,0))
 . I SEGTYPE="FT1" M FT1=@MSGROOT@(CNT),QRY("FT1")=FT1 Q
 . I SEGTYPE="EVN" M EVN=@MSGROOT@(CNT),QRY("EVN")=EVN Q
 . I SEGTYPE="PID" M PID=@MSGROOT@(CNT),QRY("PID")=PID Q
 . I SEGTYPE="PV1" M PV1=@MSGROOT@(CNT),QRY("PV1")=PV1 Q
 . I SEGTYPE="ZEL" M ZEL=@MSGROOT@(CNT),QRY("ZEL")=ZEL Q
 . Q
 ;
 I '$D(FT1) S ERR="FT1^1^^100^AE^Missing FT1 segment" Q 0
 I '$D(EVN) S ERR="EVN^1^^100^AE^Missing EVN segment" Q 0
 I '$D(PID) S ERR="PID^1^^100^AE^Missing PID segment" Q 0
 I '$D(PV1) S ERR="PV1^1^^100^AE^Missing PV1 segment" Q 0
 I '$D(ZEL) S ERR="ZEL^1^^100^AE^Missing ZEL segment" Q 0
 ;
 S (QRY("ECFILE"),QRY("ECL"),QRY("ECD"),QRY("ECC"),QRY("ECDT"),QRY("ECP"),QRY("ECICN"),QRY("ECMN"),QRY("ECDUZ"))=""
 S (QRY("ECPTSTAT"),QRY("ECP"),QRY("ECDX"),QRY("EC4"),QRY("ECELCL"))=""
 ;
 S REQTYPE="SMFiler"
 I REQTYPE="" S ERR="MSH^1^3^101^AE^Missing Request Type" Q 0
 I '$$VALRTYPE^MHV7RU(REQTYPE,.QRY,.ERR) S ERR="FT1^1^3^"_ERR Q 0
 ;
 I ERR Q 0
 ;
 I $D(FT1)  D
 .S QRY("ECFILE")=$G(FT1(6))       ;File Number
 .S QRY("ECD")=$G(FT1(13))         ; DSS Unit IEN
 .S QRY("ECP")=$G(FT1(25,1,2))     ;Procedure
 .; Diagnosis codes are seperated by ^.  make change from ^ to ;
 .S MHVSPEC("^")=";"
 .S QRY("ECDX")=$$REPLACE^XLFSTR($G(FT1(19)),.MHVSPEC)
 I $D(EVN)  D
 .S QRY("ECL")=$G(EVN(7,1,2))      ;Location IEN
 .S QRY("ECDT")=$G(EVN(2))         ;Procedure Date and Time
 .S QRY("ECDUZ")=$G(EVN(5))        ;Enter/Edited By
 I $D(PID)  D
 .S QRY("ECICN")=$G(PID(3))        ;Patient ICN
 I $D(PV1)  D
 .S QRY("ECMN")=$G(PV1(10))        ;Ordering Section
 .; Providers are seperated by ^.  Please make change from ^ to ;.
 .S MHVSPEC("^")=";"
 .S QRY("ECU")=$$REPLACE^XLFSTR($G(PV1(7)),.MHVSPEC)
 .S QRY("EC4")=$G(PV1(3,1,4,2))    ;Associated Clinic
 I $D(ZEL)  D
 .S QRY("ECPTSTAT")=$G(ZEL(9))     ;Patient Status
 .; File classification AO^IR^SC^EC^MST^HNC^C^Project SHAD
 .S QRY("ECELCL")=$G(ZEL(2))_";"_$G(ZEL(18))_";"_$G(ZEL(19))_";"_$G(ZEL(31))_";"_$G(ZEL(20))_";"_$G(ZEL(23))_";"
 .S QRY("ECELCL")=QRY("ECELCL")_$G(ZEL(42))_";"_$G(ZEL(37))_";"_$G(ZEL(44))
 S QRY("ECC")=0
 ; All validations should be in Validation routine.  
 S MHVSTR=$G(QRY("ECFILE"))_"^"_$G(QRY("ECL"))_"^"_$G(QRY("ECD"))_"^"_$G(QRY("ECC"))_"^"_$G(QRY("ECDT"))_"^"
 S MHVSTR=MHVSTR_$G(QRY("ECP"))_"^"_$G(QRY("ECICN"))_"^"_$G(QRY("ECMN"))_"^"_$G(QRY("ECDUZ"))_"^"_$G(QRY("ECPTSTAT"))_"^"
 S MHVSTR=MHVSTR_$G(QRY("ECU"))_"^"_$G(QRY("ECDX"))_"^"_$G(QRY("EC4"))_"^"_$G(QRY("ECELCL"))
 ;
 ;Validations for SMFiler input parameters are in ECFLRPC as they are complex and more
 ;
 I ERR'="" Q 0
 ;
 Q 1
 ;
