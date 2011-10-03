MHV7R2 ;WAS/GPM - HL7 RECEIVER FOR OMP^O09 ; [12/31/07 10:38am]
 ;;1.0;My HealtheVet;**1,2**;Aug 23, 2005;Build 22
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
OMPO09 ;Process OMP^O09 messages from the MHV OMP^O09 Subscriber protocol
 ;
 ; This routine and subroutines assume that all VistA HL7 environment
 ; variables are properly initialized and will produce a fatal error
 ; if they are missing.
 ;
 ;  The message will be checked to see if it is a valid OMP^O09 order
 ; message.  If not, a negative acknowledgement will be sent.  The
 ; realtime request manager is called to handle all order messages.
 ; This means the order will be processed and a response generated
 ; immediately whether the message is synchronous or asynchronous.
 ;
 ;  Input:
 ;          HL7 environment variables
 ;
 ; Output:
 ;          Processed query or negative acknowledgement
 ;
 N MSGROOT,REQ,XMT,ERR
 S (REQ,XMT,ERR)=""
 ; Inbound order messages are small enough to be held in a local.
 ; The following lines commented out support use of global and are
 ; left in case use a global becomes necessary.
 ;S MSGROOT="^TMP(""MHV7"",$J)"
 ;K @MSGROOT
 S MSGROOT="MHV7MSG"
 N MHV7MSG
 D LOADXMT^MHV7U(.XMT)         ;Load inbound message information
 D LOG^MHVUL2("OMP-O09 RECEIVER","BEGIN","S","TRACE")
 ;
 D LOADMSG^MHV7U(MSGROOT)
 D LOG^MHVUL2("LOAD",MSGROOT,"I","DEBUG")
 ;
 D PARSEMSG^MHV7U(MSGROOT,.HL)
 D LOG^MHVUL2("PARSE",MSGROOT,"I","DEBUG")
 ;
 I '$$VALIDMSG(MSGROOT,.REQ,.XMT,.ERR) D  Q
 . D LOG^MHVUL2("MSG CHECK","INVALID^"_ERR,"S","ERROR")
 . D XMIT^MHV7T(.REQ,.XMT,ERR,"",.HL)
 D LOG^MHVUL2("MSG CHECK","VALID","S","TRACE")
 ;
 D REALTIME^MHVRQI(.REQ,.XMT,.HL)
 ;
 D LOG^MHVUL2("OMP-O09 RECEIVER","END","S","TRACE")
 D RESET^MHVUL2          ;Clean up TMP used by logging
 ;K @MSGROOT
 ;
 Q
 ;
VALIDMSG(MSGROOT,REQ,XMT,ERR) ;Validate message
 ;
 ;  OMP^O09 messages must contain PID, ORC, and RXE segments
 ;
 ;  The following sequences are required
 ;     PID(3)  - ICN/DFN
 ;     ORC(2)  - Placer Order Number
 ;     RXE(1).4- Order Start Time
 ;     RXE(15) - Prescription Number
 ;
 ;  The following sequences are optional
 ;
 ;  ERR = segment^sequence^field^code^ACK type^error text
 ;
 ;  Input:
 ;    MSGROOT - Root of array holding message
 ;        XMT - Transmission parameters
 ;
 ; Output:
 ;        REQ - Request Array
 ;        XMT - Transmission parameters
 ;        ERR - segment^sequence^field^code^ACK type^error text
 ;
 N MSH,PID,ORC,RXE,CNT,REQTYPE,I,ORDERCTL,PORDERN,ORDERQTY,GIVEID,GIVESYS,GIVEAMT,GIVEUNT,ORDERTM,RXNUM
 K REQ,ERR
 S ERR=""
 ;
 ; Set up message ID for responding to message.
 ;---------------------------------------------
 S REQ("MID")=XMT("MID")        ;Message ID
 ;
 ; Validate message is a well-formed OMP^O09 message
 ;-----------------------------------------------------------
 ; Must have MSH first followed by PID, then one or more ORC/RXE pairs
 ;
 I $G(@MSGROOT@(1,0))="MSH" M MSH=@MSGROOT@(1)
 E  S ERR="MSH^1^^100^AE^Missing MSH segment" Q 0
 ;
 I $G(@MSGROOT@(2,0))="PID" M PID=@MSGROOT@(2),REQ("PID")=PID
 E  S ERR="PID^1^^100^AE^Missing PID segment" Q 0
 ;
 S CNT=3
 F  Q:'$D(@MSGROOT@(CNT))  D  Q:ERR'=""
 . I $G(@MSGROOT@(CNT,0))="ORC" M ORC(CNT\2)=@MSGROOT@(CNT)
 . E  S ERR="ORC^1^^100^AE^Missing ORC segment" Q
 . I $G(@MSGROOT@(CNT+1,0))="RXE" M RXE(CNT\2)=@MSGROOT@(CNT+1)
 . E  S ERR="RXE^1^^100^AE^Missing RXE segment" Q
 . S CNT=CNT+2
 . Q
 Q:ERR'="" 0
 ;
 I '$D(ORC) S ERR="ORC^1^^100^AE^Missing ORC segment" Q 0
 I '$D(RXE) S ERR="RXE^1^^100^AE^Missing RXE segment" Q 0
 ;
 ;
 ; Validate required fields and refill request parameters
 ;-----------------------------------------------------------
 ;
 I '$$VALIDPID^MHV7RUS(.PID,.REQ,.ERR) Q 0
 ;
 F I=1:1 Q:'$D(ORC(I))  D  Q:ERR'=""
 . S ORDERCTL=$G(ORC(I,1))
 . S PORDERN=$G(ORC(I,2))
 . I ORDERCTL="" S ERR="ORC^"_I_"^2^101^AE^Missing Order Control" Q
 . I PORDERN="" S ERR="ORC^"_I_"^2^101^AE^Missing Placer Order#" Q
 . ;
 . S ORDERQTY=$G(RXE(I,1,1,1))
 . S ORDERTM=$G(RXE(I,1,1,4))
 . S GIVEID=$G(RXE(I,2,1,1))
 . S GIVESYS=$G(RXE(I,2,1,3))
 . S GIVEAMT=$G(RXE(I,3))
 . S GIVEUNT=$G(RXE(I,5))
 . S RXNUM=$G(RXE(I,15))
 . I ORDERQTY="" S ERR="RXE^"_I_"^1^101^AE^Missing Order Quantity" Q
 . I ORDERTM="" S ERR="RXE^"_I_"^1^101^AE^Missing Order Start Time" Q
 . I GIVEID="" S ERR="RXE^"_I_"^2^101^AE^Missign Give Code ID" Q
 . I GIVESYS="" S ERR="RXE^"_I_"^2^101^AE^Missing Give Code System" Q
 . I GIVEAMT="" S ERR="RXE^"_I_"^3^101^AE^Missing Give Amount" Q
 . I GIVEUNT="" S ERR="RXE^"_I_"^5^101^AE^Missing Give Units" Q
 . I RXNUM="" S ERR="RXE^"_I_"^15^101^AE^Missing Prescription#" Q
 . I RXNUM'?1N.N0.1A S ERR="RXE^"_I_"^15^102^AE^Invalid Prescription#" Q
 . S REQ("RX",I)=RXNUM_"^"_PORDERN_"^"_ORDERTM
 . Q
 Q:ERR'="" 0
 ;
 I '$$VALRTYPE^MHV7RU("RxRefill",.REQ,.ERR) S ERR="MSH^1^9^"_ERR Q 0
 ;
 Q 1
 ;
