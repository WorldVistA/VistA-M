VAQPAR60 ;ALB/JRP - MESSAGE PARSING;28-APR-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
MESSAGE(PRSARR,MESSNUM) ;PARSING OF VERSION 1.5 MESSAGE
 ;INPUT  : PRSARR - Parsing array (full global reference)
 ;         MESSNUM - Message number within transmission (not XMZ)
 ;                   (defaults to 1)
 ;         (As defined by MailMan)
 ;         XMFROM, XMREC, XMZ
 ;         (Declared in SERVER^VAQADM2)
 ;         XMER, XMRG, XMPOS
 ;OUTPUT : XMER - Exit condition
 ;           0 = Success
 ;           -1^Error_Text = Error
 ;         XMPOS - Last line [number] read in transmission
 ;                 (if NULL end of transmission reached)
 ;NOTES  : Parsing array will have the following format
 ;           ARRAY(MESSNUM,BlockName,BlockSeq,LineNumber) = Value
 ;          [BlockSeq used to keep blocks of same name from
 ;           overwritting each other.  This will typically be '1'
 ;           except for DATA & DISPLAY blocks.]
 ;       : Calling routine responsible for ARRAY clean up before
 ;         and after call
 ;
 ;CHECK INPUT
 I ($G(PRSARR)="") S XMER="-1^Did not pass reference to parsing array" Q
 S:($G(MESSNUM)="") MESSNUM=1
 ;DECLARE VARIABLES
 N STOP,BLOCK,BLOCKSEQ,TMP,CURRENT,LAST
 S XMER=0
 S STOP=0
 ;PARSE MESSAGE
 F  D  Q:((XMER<0)!(STOP))
 .S LAST=XMPOS
 .X XMREC
 .S CURRENT=XMPOS
 .;END OF MESSAGE REACHED
 .I (XMRG="$$MESSAGE") S XMER=0,STOP=1 Q
 .;REACHED END OF MAILMAN MESSAGE
 .I (XMER<0) S XMER="-1^End of message was not designated"
 .;GET SEQUENCE NUMBER
 .S BLOCK=$P(XMRG,"$",2)
 .S BLOCKSEQ=0
 .S TMP=""
 .F  S TMP=$O(@PRSARR@(MESSNUM,BLOCK,TMP)) Q:(TMP="")  S BLOCKSEQ=TMP
 .S BLOCKSEQ=BLOCKSEQ+1
 .;PARSE VALID BLOCKS
 .S XMPOS=LAST
 .I (BLOCK="HEADER") D BLOCK^VAQPAR61(PRSARR,MESSNUM,BLOCK,BLOCKSEQ) Q
 .I (BLOCK="DOMAIN") D BLOCK^VAQPAR61(PRSARR,MESSNUM,BLOCK,BLOCKSEQ) Q
 .I (BLOCK="USER") D BLOCK^VAQPAR61(PRSARR,MESSNUM,BLOCK,BLOCKSEQ) Q
 .I (BLOCK="PATIENT") D BLOCK^VAQPAR61(PRSARR,MESSNUM,BLOCK,BLOCKSEQ) Q
 .I (BLOCK="SEGMENT") D BLOCK^VAQPAR61(PRSARR,MESSNUM,BLOCK,BLOCKSEQ) Q
 .I (BLOCK="COMMENT") D BLOCK^VAQPAR61(PRSARR,MESSNUM,BLOCK,BLOCKSEQ) Q
 .I (BLOCK="DATA") D BLOCK^VAQPAR61(PRSARR,MESSNUM,BLOCK,BLOCKSEQ) Q
 .I (BLOCK="DISPLAY") D BLOCK^VAQPAR61(PRSARR,MESSNUM,BLOCK,BLOCKSEQ) Q
 .S:(XMPOS=LAST) XMPOS=CURRENT
 .;EVERYTHING ELSE IS IGNORED
 Q
