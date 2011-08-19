SCMCHLG ;BP/DJB - PCMM HL7 Generate Message ; 3/2/00 12:39pm
 ;;5.3;Scheduling;**177,210**;AUG 13, 1993
 ;
GENERATE() ;Generate a PCMM Primary Care HL7 message
 ;
 ;Input:
 ;Output:
 ;Return: Number of HL7 array nodes built
 ;
 ;Declare variables
 NEW DATA,ERROR,ID,LINES,NUM,SEG
 NEW HLN,HLRESLT,HLSAN,HLX
 ;
 ;Convert XMITARRY array to HL7 format - ^TMP("HLS",$J,x)
 KILL ^TMP("HLS",$J)
 S NUM=0
 F  S NUM=$O(@XMITARRY@(NUM)) Q:'NUM  D  ;
 . S LINES=0 ;Initialize subscript counter
 . S SEG=""
 . F  S SEG=$O(@XMITARRY@(NUM,SEG)) Q:SEG=""  D  ;
 . . S ID=""
 . . F  S ID=$O(@XMITARRY@(NUM,SEG,ID)) Q:ID=""  D  ;
 . . . ;Convert array to HL7 format
 . . . S DATA=$G(@XMITARRY@(NUM,SEG,ID))
 . . . Q:DATA']""
 . . . S LINES=LINES+1
 . . . S ^TMP("HLS",$J,LINES)=DATA
 . . . ;Convert continuation node
 . . . I $D(@XMITARRY@(NUM,SEG,ID,1)) D  ;
 . . . . S DATA=$G(@XMITARRY@(NUM,SEG,ID,1))
 . . . . I DATA]"" S ^TMP("HLS",$J,LINES,1)=DATA
 . ;
 . ;Generate message.
 . ;  This call returns HLRESLT with 1-3 pieces as follows:
 . ;     MessageID^ErrorCode^ErrorDescription
 . ;  If no error occurs, only first piece is returned equal to unique
 . ;  ID for message. Otherwise, 3 pieces are returned with 1st piece
 . ;  equal to msg ID if one was assigned, otherwise 0.
 . ;
 . S HLP("PRIORITY")="I" ;........Immediate priority
 . D GENERATE^HLMA(HLEID,"GM",1,.HLRESLT,,.HLP)
 . ;
 . ;djb/bp Patch 210. Moved re-initialize code up so it occurs before
 . ;call to LOG^SCMCHLL.
 . ;Re-initialize HL7 message variables
 . KILL HL,HLP
 . S HLEID=$$HLEID^SCMCHL()
 . D INIT^HLFNC2(HLEID,.HL)
 . ;
 . ;If message not generated, log reason & reset LINES to zero.
 . I $P(HLRESLT,"^",2)'="" D  ;
 . . S @XMITERR@(VARPTR)=$P(HLRESLT,"^",3)
 . E  D  ;
 . . S MSGCNT=$G(MSGCNT)+1 ;..Increment message count
 . . ;djb/bp Patch 210 Following line added to log transmission.
 . . I $P(HLRESLT,"^",1) D LOG^SCMCHLL
 . ;
 . ;Re-initialize HL7 message array
 . KILL ^TMP("HLS",$J)
 ;
 ;Done
 Q +$G(MSGCNT)
