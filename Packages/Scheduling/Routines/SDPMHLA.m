SDPMHLA ; BPFO/JRC - HL 7 ACKNOWLEDGEMENT HANDLER ; 3/30/04 11:20am
 ;;5.3;SCHEDULING;**313**;AUG 13, 1993
 ;
 ;====================================================================
 ;Additional Performance Monitors process acknowledgement routine
 ;
 ;This routine takes and enhanced mode acknowledgement message
 ;from Austin passes it to HL7 and it matches it to the originating
 ;message from the information contained in the message ID.
 ;
 ;Input
 ;       Acknowledgment message from AAC
 ;Output
 ;       Bulletin to 'SD PM NOTIFICATION TIU' when a rejection message
 ;       is found
 ;====================================================================
ACKR01 ; Receives the ACK messages
 ; Input : All variables set by the HL7 package
 N SDACK,SDPARAM,HLNODE,I,X
 ;Get message text
 S ^TMP("SDPRUACK",$H)="START PROCESS"
 F I=1:1 X HLNEXT Q:(HLQUIT'>0)  D
 . S SDMSG(I,1)=HLNODE
 . ; Check for segment length greater than 245
 . S X=0 F  S X=+$O(HLNODE(X)) Q:('X)  S SDMSG(I,(X+1))=HLNODE(X)
 ;
 M ^TMP("SDPRUACK",$H,"HL")=SDMSG
 ; Analyze the message and take appropriate response
 ; Quit if there is no valid message header
 Q:$P(SDMSG(1,1),"^")'="MSH"
 ;
 S X=1,SDPARAM=""
 F  S X=+$O(SDMSG(X)) Q:('X)  D
 . I $P(SDMSG(X,1),"^")="MSA" D
 .. D PROCESS(SDMSG(X,1),.SDPARAM)
 Q
 ;
NOTIFY ; Task sending of response notification
 Q:$O(SDPARAM(""))=""
 D SENDIT
 Q
SENDIT ; Notify mail group that a error message was received
 ; Input : MSGARY() - Array containing HL7 Message received
 ; Ouput : None
 N MSGTXT,XMY,XMTEXT,XMDUZ,XMDT,XMZ,LINE,XMB,XMCHAN,XMSUB
 ;
 S MSGTEXT(1)=" "
 S MSGTEXT(2)="TIU's Performance Indicator National Rollup encountered an error while"
 S MSGTEXT(3)="processing HL7 message '"_MSGID_"'. If necessary, use option 'Performance"
 S MSGTEXT(4)="Monitor Retransmit Report (AAC)' to retransmit it."
 S MSGTEXT(5)=" "
 S MSGTEXT(6)="Encounter date range: "_$$FMTE^XLFDT(STADATE,1)_" to "_$$FMTE^XLFDT(ENDDATE,1)
 S MSGTEXT(7)=" "
 S MSGTEXT(8)="Please contact Austin Automation Center's help desk."
 S XMSUB="SD ENC PERF MON Error Message"
 S XMTEXT="MSGTEXT("
 S XMY("G.SD PM NOTIFICATION TIU")=""
 S XMCHAN=1
 S XMDUZ="Performance Indicator"
 ;S XMB="SDPM REJECT"
 S XMDT=DT
 D ^XMD
 Q
 ;
PROCESS(SDMSG,SDPARAM) ;Process incoming acknowledgment
 ;
 N ACK,MSGID,PMSG,MNODE,STADATE,ENDDATE
 ;
 Q:$G(SDMSG)']""
 ;
 S ACK=$P(SDMSG,HL("FS"),2)   ; Get acknowledgment code
 ; If the acknowledgementcode is AA, then do not send notification
 Q:ACK="AA"
 ; Get outgoing message ID
 S MSGID=$P(SDMSG,HL("FS"),3)
 S MSGID=$E(MSGID,4,$L(MSGID))
 ; Set rejection message for SDPM acknowledgement message
 S:'(ACK="AA") SDPARAM(4)=$S(ACK="AE":"Application Error",ACK="AR":"Application Reject",1:"Unknown Error")
 ; Retrieve HL7 parent message ID
 S PMSG=$P($G(^HL(772,MSGID,0)),HL("FS"),8) ;IA # 4069
 ; Retrieve HL7 message 'OBR' node
 S MNODE=^HL(772,MSGID,"IN",1,0) ;IA # 4069
 ; Retrieve date range
 S RANGE=$P($G(^HL(772,MSGID,"IN",1,0)),HL("FS"),28) ;IA # 4069
 S STADATE=$P($G(RANGE),"~",4),ENDDATE=$P($G(RANGE),"~",5)
 ; Convert date from HL7 to FM format
 S STADATE=$$HL7TFM^XLFDT(STADATE),ENDDATE=$$HL7TFM^XLFDT(ENDDATE)
 D NOTIFY
 Q
