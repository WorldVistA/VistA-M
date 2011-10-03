DGRUHL1 ;ALB/SCK - RAI/MDS HL7 MESSAGING ACKNOWLEDGEMENT ROUTINES ; 7-9-1999
 ;;5.3;Registration;**190,354,419**;Aug 13, 1993
 ;
ACK ; Receives the ACK messages
 ; Input  : All variables set by the HL7 package
 ; Output : None
 ;
 N DGI,DGX,DGMSG,DGACK,DGPARAM,HLNODE,I,X
 ;
 ;Get message text
 S ^TMP("DGRUACK",$H)="START PROCESS"
 F I=1:1 X HLNEXT Q:(HLQUIT'>0)  D
 . S DGMSG(I,1)=HLNODE
 . ; Check for segment length greater than 245
 . S X=0 F  S X=+$O(HLNODE(X)) Q:('X)  S DGMSG(I,(X+1))=HLNODE(X)
 ;
 M ^TMP("DGRUACK",$H,"HL")=DGMSG
 ; analyze the message and take appropriate response
 ; Quit if there is no valid message header
 Q:$P(DGMSG(1,1),"^")'="MSH"
 ;
 S X=1,DGPARAM=""
 F  S X=+$O(DGMSG(X)) Q:('X)  D
 . I $P(DGMSG(X,1),"^")="MSA" D
 .. D PROCESS(DGMSG(X,1),.DGPARAM)
 .. D NOTIFY
 Q
 ;
NOTIFY ; TAsk sending of response notification
 ;
 Q:$O(DGPARAM(""))=""      ;added p-354
 D SENDIT
 Q
 ;
SENDIT ; Notify mail group that a response message was received from the RAI/MDS COTS system
 ;  Input   : MSGARY()  - Array containing HL7 message received
 ;  Output  : None
 ;
 N MSGTXT,XMY,XMTEXT,XMY,XMDUZ,XMDT,XMZ,LINE,XMB,XMCHAN,XMSUB
 ;
 S XMCHAN=1
 S XMSUB="RAI/MDS Message Receipt for "_DGPARAM(1)
 S (XMDUZ,XMDUZ)="RAI/MDS APPLICATION"
 ;
 M XMB=DGPARAM
 S XMB="DGRU REJECT"
 S XMDT=DT
 D ^XMB
 Q
 ;
PROCESS(DGMSG,DGPARAM) ;
 N ACK,MSGID
 ;
 Q:$G(DGMSG)']""
 ;
 S ACK=$P(DGMSG,"^",2) ; Get acknowledgement code
 ; If the acknowledgement code is AA, then do not send notification
 Q:ACK="AA"  ;changed p-354
 ;
 ; Get outgoing message ID
 S MSGID=$P(DGMSG,"^",3)
 ;
 ; Retrieve outgoing message information from file #773 for message ID
 D EXTRACT(MSGID,.DGPARAM)
 ;
 ;; ===================================================================
 ;;  The current HL7 package does not process acknowledgements other than
 ;;  "accepted" through the process routine at the current time.  This line
 ;;  should be removed once the HL7 package is patched to process AR and AE messages.
 ;S:ACK="AA" DGPARAM(4)=""  ;changed p-354
 ;; ===================================================================
 ;
 ; Retrieve rejection message from COTS acknowledgement message
 S:'(ACK="AA") DGPARAM(4)=$P(DGMSG,"^",4)
 S ^TMP("DGRUACK",$H,"ACK")=DGPARAM(4)
 Q
 ;
EXTRACT(MSGID,DGPARAM) ; Extract patient and related message information for
 ; error bulletin to be sent
 ;
 N DGIEN,DGOIEN,DGQUIT,DGTXT,NDX
 ;
 S DGIEN=0
 ; Retrieve ien of outgoing message administration entry, file #773
 F  S DGIEN=+$O(^HLMA("C",MSGID,DGIEN)) Q:'DGIEN  D  Q:$G(DGQUIT)
 . ; Retrieve ien of outgoing message text
 . S DGOIEN=+$$GET1^DIQ(773,DGIEN,.01,"I")
 . S DGPARAM(7)=$$GET1^DIQ(773,DGIEN,16,"E") ;changed p-419
 . S DGPARAM(5)=$$GET1^DIQ(773,DGIEN,2,"I")  ;added p-354
 . Q:(DGOIEN<0)
 . ; Retrieve information from message file
 . ;S DGPARAM(5)=+$$GET1^DIQ(772,DGOIEN,6)   ;changed p-354
 . S X=$$GET1^DIQ(772,DGOIEN,200,"","DGTXT")
 . I $D(DGTXT) D
 .. S NDX=0
 .. F  S NDX=$O(DGTXT(NDX)) Q:'NDX  D
 ... I $P(DGTXT(NDX),"^")="PID" D
 .... S DGPARAM(1)=$$FMNAME^HLFNC($P(DGTXT(NDX),"^",6),"~")
 .... S DGPARAM(2)=$P(DGTXT(NDX),"^",20)
 ... I $P(DGTXT(NDX),"^")="EVN" D
 .... S DGPARAM(3)=$P(DGTXT(NDX),"^",2)
 .... S DGPARAM(6)=$$FMTE^XLFDT($$FMDATE^HLFNC($P(DGTXT(NDX),"^",3)))
 Q
