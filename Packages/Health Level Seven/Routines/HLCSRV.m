HLCSRV ;AISC/SAW-Server Routine for HL7 Messages Received Through MailMan ;1/26/95  14:20
 ;;1.6;HEALTH LEVEL SEVEN;;Oct 13, 1995
 ;Receive incoming message from MailMan
 D RECEIVE^HLMA0("XM")
 ;Delete message from server mailbox
 S XMSER="S.HL V16 SERVER" D REMSBMSG^XMA1C
 Q
