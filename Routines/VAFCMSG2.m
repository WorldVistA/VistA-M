VAFCMSG2 ;ALB/JRP - ADT/R MESSAGE BUILDING;12-SEP-1996
 ;;5.3;Registration;**91**;Jun 06, 1996
 ;
SNDMSG(EVNTHL7,XMITARRY) ;Entry point to send ADT HL7 messages
 ;
 ;Input  : EVNTHL7 - HL7 ADT event to build message for (Defaults to A08)
 ;                   Currently support event types:
 ;                     A04, A08, A28
 ;         XMITARRY - Array containing HL7 message to transmit
 ;                    (full global reference)
 ;                  - Defaults to ^TMP("HLS",$J)
 ;                  - Must be in format required for interaction
 ;                    with the HL7 package
 ;Output :   Message ID = Success
 ;           ErrorCode^ErrorText = Error
 ;Notes  : The global array ^TMP("HLS",$J) will be KILLed if XMITARRY
 ;         does not use this global location
 ;
 ;Check input
 S EVNTHL7=$G(EVNTHL7)
 S:(EVNTHL7="") EVNTHL7="A08"
 S XMITARRY=$G(XMITARRY)
 S:(XMITARRY="") XMITARRY="^TMP(""HLS"","_$J_")"
 Q:($O(@XMITARRY@(""))="") "-1^Can not send empty message"
 ;Declare variables
 N HLEID,HL,HLFS,HLECH,HLQ,HLMTIEN,HLRESLT,HLP,ARRY4HL7,KILLARRY,OK,TMP
 S ARRY4HL7="^TMP(""HLS"","_$J_")"
 ;Check for supported event
 S OK=0
 F TMP="A04","A08","A28" I TMP=EVNTHL7 S OK=1 Q
 Q:('OK) "-1^Event type not supported"
 ;Get pointer to HL7 Server Protocol
 ;S HLEID=$$GETSRVR^VAFCMSG5(EVNTHL7)
 ;Q:('HLEID) "-1^Server protocol not found"
 ;Initialize HL7 variables
 ;D INIT^HLFNC2(HLEID,.HL)
 ;Q:($O(HL(""))="") "-1^Unable to initialize HL7 variables"
 K HL
 I $G(@EVNTINFO@("SERVER PROTOCOL"))]"" DO
 . D INIT^HLFNC2(@EVNTINFO@("SERVER PROTOCOL"),.HL)
 ;or Get pointer to HL7 Server Protocol
 E  DO  Q:'HLEID "-1^Server Protocol not found"
 .S HLEID=$$GETSRVR^VAFCMSG5(EVNTHL7)
 .Q:('HLEID)
 .;Initialize HL7 variables
 .D INIT^HLFNC2(HLEID,.HL)
 Q:($O(HL(""))="") "-1^Unable to initialize HL7 variables"
 ;
 ;See if XMITARRY is ^TMP("HLS",$J)
 S KILLARRY=0
 I (XMITARRY'=ARRY4HL7) D
 .;Make sure '$J' wasn't used
 .Q:(XMITARRY="^TMP(""HLS"",$J)")
 .;Initialize ^TMP("HLS",$J) and merge XMITARRY into it
 .K @ARRY4HL7
 .M @ARRY4HL7=@XMITARRY
 .S KILLARRY=1
 ;Broadcast message
 ;D GENERATE^HLMA(HLEID,"GM",1,.HLRESLT,"",.HLP)
 ;S:('HLRESLT) HLRESLT=$P(HLRESLT,"^",2,3)
 ;
 I $G(@EVNTINFO@("SERVER PROTOCOL"))]"" DO
 . D GENERATE^HLMA(@EVNTINFO@("SERVER PROTOCOL"),"GM",1,.HLRESLT,"",.HLP)
 E  DO
 . D GENERATE^HLMA(HLEID,"GM",1,.HLRESLT,"",.HLP)
 ;
 S:('HLRESLT) HLRESLT=$P(HLRESLT,"^",2,3)
 ;
 ;Delete ^TMP("HLS",$J) if XMITARRY was different
 K:(KILLARRY) @ARRY4HL7
 ;Done
 Q HLRESLT
