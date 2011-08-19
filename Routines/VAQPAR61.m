VAQPAR61 ;ALB/JRP - MESSAGE PARSING;28-APR-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
BLOCK(PRSARR,MESSNUM,BLOCK,BLOCKNUM) ;PARSING OF VERSION 1.5 MESSAGE BLOCKS
 ;INPUT  : PRSARR - Parsing array (full global reference)
 ;         MESSNUM - Message number within transmission (not XMZ)
 ;                   (defaults to 1)
 ;         BLOCK - Block name
 ;         BLOCKNUM - Block number with message (defaults to 1)
 ;         (As defined by MailMan)
 ;         XMFROM, XMREC, XMZ
 ;         (Declared in SERVER^VAQADM2)
 ;         XMER, XMRG, XMPOS
 ;OUTPUT : XMER - Exit condition
 ;           0 = Success
 ;           -1^Error_Text = Error
 ;         XMPOS - Last line [number] read in transmission
 ;                 (if NULL end of transmission reached)
 ;
 ;NOTES  : Parsing array will have the following format
 ;          ARRAY(MESSNUM,BLOCK,BLOCKNUM,LineNumber) = Value
 ;       : Calling routine responsible for ARRAY clean up before
 ;         and after call
 ;
 ;CHECK INPUT
 I ($G(PRSARR)="") S XMER="-1^Did not pass reference to parsing array" Q
 S:($G(MESSNUM)="") MESSNUM=1
 I ($G(BLOCK)="") S XMER="-1^Did not pass block name" Q
 S:($G(BLOCKNUM)="") BLOCKNUM=1
 S XMER="-1^Block not supported"
 Q:((BLOCK'="HEADER")&(BLOCK'="DOMAIN")&(BLOCK'="USER")&(BLOCK'="PATIENT")&(BLOCK'="SEGMENT")&(BLOCK'="COMMENT")&(BLOCK'="DATA")&(BLOCK'="DISPLAY"))
 ;DECLARE VARIABLES
 N END,BLOCKEND,LINE
 S XMER=0
 S END=0
 S BLOCKEND="$$"_BLOCK
 ;PARSE BLOCK
 F LINE=1:1 D  Q:((XMER<0)!(END))
 .X XMREC
 .;END OF BLOCK REACHED
 .I (XMRG=BLOCKEND) S XMER=0,END=1 Q
 .;REACHED END OF MAILMAN MESSAGE
 .I (XMER<0) S XMER="-1^End of block was not designated"
 .;STORE INFO IN PARSE ARRAY
 .S @PRSARR@(MESSNUM,BLOCK,BLOCKNUM,LINE)=XMRG
 S @PRSARR@(MESSNUM,BLOCK,BLOCKNUM,LINE)=XMRG
 Q
