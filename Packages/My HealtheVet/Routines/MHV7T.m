MHV7T ;WAS/GPM - HL7 TRANSMITTER ; 10/25/05 4:10pm [12/24/07 9:45pm]
 ;;1.0;My HealtheVet;**2**;Aug 23, 2005;Build 22
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
XMIT(REQ,XMT,ERR,DATAROOT,HL) ;Build and Transmit HL7 message
 ;   Builds and sends the desired HL7 message based on the mode and
 ; builder passed in XMT.  If the builder requires other information
 ; to build the message, it can be passed as additional subscripts of
 ; XMT or REQ.  REQ is used for request or query related parameters,
 ; XMT for transmission and control related parameters.
 ;
 ;  The message builder sent in XMT("BUILDER") is called to build the
 ; desired message.
 ;
 ;  A synchronous response is indicated by XMT("MODE") of S, and sent
 ; on the current interface as an original mode acknowledgement.
 ;
 ;  An asynchronous response is indicated by XMT("MODE") of A, and
 ; sent on the interface associated with XMT("PROTOCOL") as an
 ; enhanced mode application acknowledgement.  Large messages can be
 ; sent as a bolus (series of messages without batch formatting) by
 ; specifying an XMT("MAX SIZE").
 ;
 ;  A message may be initiated by using the asynchronous mode settings
 ;  Synchronous messages cannot be initiated with this API.
 ;
 ;  Integration Agreements:
 ;         2161 : INIT^HLFNC2
 ;         2164 : GENERATE^HLMA
 ;         2165 : GENACK^HLMA1
 ;
 ;  Input:
 ;         REQ - Request parameters and Message ID of original message
 ;         XMT - Transmission parameters
 ;            XMT("MODE") - Mode of the transmission
 ;            XMT("PROTOCOL") - Protocol for deferred transmissions
 ;            XMT("BUILDER") - Name/tag of message builder routine
 ;            XMT("HLMTIENS") - Original message IEN - Immediate mode
 ;            XMT("MAX SIZE") - Maximum message size (asynch only)
 ;         ERR - Caret delimited error string
 ;               segment^sequence^field^code^ACK type^error text
 ;    DATAROOT - Global root of data array
 ;          HL - HL7 package array variable
 ;
 ;  Output: HL7 Message Transmitted
 ;
 N MSGROOT,HLRSLT,HLP,MSGLEN
 D LOG^MHVUL2("TRANSMIT","BEGIN","S","TRACE")
 I XMT("MODE")="A" D           ;Asynchronous mode
 . D LOG^MHVUL2("TRANSMIT","ASYNCHRONOUS","S","TRACE")
 . K HL
 . D INIT^HLFNC2(XMT("PROTOCOL"),.HL)
 . I $G(HL) S ERR=HL D LOG^MHVUL2("PROTOCOL INIT FAILURE",ERR,"S","ERROR") Q
 . D LOG^MHVUL2("PROTOCOL INIT","DONE "_XMT("MODE"),"S","DEBUG")
 . S MSGROOT="^TMP(""HLS"",$J)"
 . D @(XMT("BUILDER")_"(MSGROOT,.REQ,ERR,DATAROOT,.MSGLEN,.HL)")
 . D LOG^MHVUL2("BUILD "_$P(XMT("BUILDER"),"^"),MSGROOT,"I","DEBUG")
 . I MSGLEN<XMT("MAX SIZE")!'XMT("MAX SIZE") D  Q
 . . D GENERATE^HLMA(XMT("PROTOCOL"),"GM",1,.HLRSLT,"",.HLP)
 . . K @MSGROOT
 . . D LOG^MHVUL2("TRANSMIT "_$P(XMT("BUILDER"),"^"),.HLRSLT,"M","DEBUG")
 . . Q
 . D BOLUS^MHV7TB(MSGROOT,.XMT,.HL)
 . Q
 ;
 I XMT("MODE")="S" D           ;Synchronous mode
 . D LOG^MHVUL2("TRANSMIT","SYNCHRONOUS","S",0)
 . S MSGROOT="^TMP(""HLA"",$J)"
 . D @(XMT("BUILDER")_"(MSGROOT,.REQ,ERR,DATAROOT,.MSGLEN,.HL)")
 . D LOG^MHVUL2("BUILD "_$P(XMT("BUILDER"),"^"),MSGROOT,"I","DEBUG")
 . D GENACK^HLMA1(HL("EID"),XMT("HLMTIENS"),HL("EIDS"),"GM",1,.HLRSLT)
 . K @MSGROOT
 . D LOG^MHVUL2("TRANSMIT "_$P(XMT("BUILDER"),"^"),.HLRSLT,"M","DEBUG")
 . Q
 D LOG^MHVUL2("TRANSMIT","END","S","TRACE")
 Q
 ;
EMAIL(REQ,XMT,ERR,DATAROOT,HL) ;Build and Transmit HL7 message
 ;   Builds and sends the desired HL7 message via email.
 ; This will only be used until the MHV server can establish normal
 ; HL7 receivers.
 ;
 ;  If the builder requires other information to build the message, it
 ; can be passed as additional subscripts of XMT or REQ.  REQ is used
 ; for request or query related parameters, XMT for transmission and
 ; control related parameters.
 ;
 ;  The message builder sent in XMT("BUILDER") is called to build the
 ; desired message.
 ;
 ;  Integration Agreements:
 ;         2161 : INIT^HLFNC2
 ;                 MSH^HLFNC2
 ;        10070 : ^XMD
 ;
 ;  Input:
 ;         REQ - Request parameters and Message ID of original message
 ;         XMT - Transmission parameters
 ;            XMT("PROTOCOL") - Protocol for deferred transmissions
 ;            XMT("BUILDER") - Name/tag of message builder routine
 ;            XMT("SAF") - Sending Facility
 ;            XMT("EMAIL") - Email Address to use
 ;         ERR - Caret delimited error string
 ;               segment^sequence^field^code^ACK type^error text
 ;    DATAROOT - Global root of data array
 ;          HL - HL7 package array variable
 ;
 ;  Output: HL7 Message Transmitted
 ;
 N MSGROOT,MID,MSH,CNT,MSGLEN
 N TEXT,XMDUN,XMDUZ,XMTEXT,XMROU,XMSTRIP,XMSUB,XMY,XMZ,XMDF,XMMG
 D LOG^MHVUL2("TRANSMIT","EMAIL","S","TRACE")
 K HL
 D INIT^HLFNC2(XMT("PROTOCOL"),.HL)
 I $G(HL) S ERR=HL D LOG^MHVUL2("PROTOCOL INIT FAIL",ERR,"S","ERROR") Q
 D LOG^MHVUL2("PROTOCOL INIT","DONE EMAIL","S","DEBUG")
 S MSGROOT="^TMP(""MHV7TEM"",$J)"
 D @(XMT("BUILDER")_"(MSGROOT,.REQ,ERR,DATAROOT,.MSGLEN,.HL)")
 D LOG^MHVUL2("BUILD "_$P(XMT("BUILDER"),"^"),MSGROOT,"I","DEBUG")
 S MID=+$H_"-"_$P($H,",",2)
 S HL("SAF")=XMT("SAF")
 D MSH^HLFNC2(.HL,MID,.MSH)
 S XMDF="",(XMDUN,XMDUZ)="My HealtheVet Package"
 S XMY(XMT("EMAIL"))=""
 S XMSUB=XMT("SAF")_" MHV PACKAGE MESSAGE"
 S XMTEXT="TEXT("
 S TEXT(1)=MSH
 F CNT=1:1 Q:'$D(@MSGROOT@(CNT))  S TEXT(CNT+1)=@MSGROOT@(CNT)
 D ^XMD
 K @MSGROOT
 I $D(XMMG) D LOG^MHVUL2("EMAIL TRANSMIT","FAILURE: "_XMMG,"S","ERROR") Q
 D LOG^MHVUL2("EMAIL TRANSMIT","SUCCESS: "_XMZ,"S","TRACE")
 Q
