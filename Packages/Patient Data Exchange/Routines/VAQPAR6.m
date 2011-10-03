VAQPAR6 ;ALB/JRP - MESSAGE PARSING;28-APR-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
PARSE(ARRAY) ;PARSING OF VERSION 1.5 TRANSMISSION
 ;INPUT  : ARRAY - Parsing array (full global reference)
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
 ;           ARRAY(MessageNumber,BlockName,BlockSeq,LineNumber) = Value
 ;          [BlockSeq used to keep blocks of same name from
 ;           overwritting each other.  This will typically be '1'
 ;           except for DATA & DISPLAY blocks.]
 ;          [MessageNumber is not XMZ ... it denotes the message
 ;           number withing the transmission]
 ;       : Calling routine responsible for ARRAY clean up before
 ;         and after call
 ;
 ;CHECK INPUT
 I ($G(ARRAY)="") S XMER="-1^Did not pass reference to parsing array" Q
 ;DECLARE VARIABLES
 N MESSAGE,DONE
 S XMER=0
 ;READ TRANSMISSION
 X XMREC
 I ((XMER<0)!(XMRG="")) S XMER="-1^Transmission did not contain any information" Q
 I (XMRG'="$TRANSMIT") S XMER="-1^Not a valid transmission" Q
 S MESSAGE=0
 S DONE=0
 ;PARSE TRANSMISSION
 F  D  Q:((XMER<0)!(DONE))
 .X XMREC
 .;END OF TRANSMISSION REACHED
 .I (XMRG="$$TRANSMIT") S XMER=0,DONE=1 Q
 .;REACHED END OF MAILMAN MESSAGE
 .I (XMER<0) S XMER="-1^End of transmission was not designated" Q
 .;BEGINNING OF A MESSAGE
 .I (XMRG="$MESSAGE") D  Q
 ..S MESSAGE=MESSAGE+1
 ..;PARSE MESSAGE
 ..D MESSAGE^VAQPAR60(ARRAY,MESSAGE)
 .;EVERYTHING ELSE IS IGNORED
 Q
