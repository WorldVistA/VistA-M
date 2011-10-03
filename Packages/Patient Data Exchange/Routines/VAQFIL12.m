VAQFIL12 ;ALB/JRP - MESSAGE FILING;12-MAY-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
DOMAIN(MESSNUM,PARSARR,TRANPTR) ;FILE DOMAIN BLOCK
 ;INPUT  : MESSNUM - Message number in transmission (not XMZ)
 ;                   (defaults to 1)
 ;         PARSARR - Parsing array (full global reference)
 ;         TRANPTR - Pointer to VAQ - TRANSACTION file
 ;         (As defined by MailMan)
 ;         XMFROM, XMREC,XMZ
 ;OUTPUT : 0 - Success
 ;         -1^Error_Text - Error
 ;NOTES  : It is the responsibility of the calling program to correct
 ;         the transaction being updated if an error occurs.
 ;
 ;CHECK INPUT
 S:($G(MESSNUM)="") MESSNUM=1
 Q:($G(PARSARR)="") "-1^Did not pass reference to parsing array"
 Q:('$D(@PARSARR@(MESSNUM))) "-1^Did not pass valid message number"
 Q:('$D(@PARSARR@(MESSNUM,"DOMAIN",1))) "-1^Message did not contain a domain block"
 S TRANPTR=+$G(TRANPTR)
 Q:(('TRANPTR)!('$D(^VAT(394.61,TRANPTR)))) "-1^Did not pass a valid transaction"
 ;DECLARE VARIABLES
 N TMP,TYPE,SENDER,RECEIVER,ERR
 ;MAKE SURE IT'S A DOMAIN BLOCK
 S TMP=$G(@PARSARR@(MESSNUM,"DOMAIN",1,1))
 S:(TMP=" ") TMP=""
 Q:((TMP="")!(TMP'="$DOMAIN")) "-1^Not a domain block"
 S TMP=$G(@PARSARR@(MESSNUM,"DOMAIN",1,4))
 S:(TMP=" ") TMP=""
 Q:((TMP="")!(TMP'="$$DOMAIN")) "-1^Not a valid domain block"
 ;GET MESSAGE TYPE
 S TMP=$$STATYPE^VAQFIL11(MESSNUM,PARSARR)
 Q:($P(TMP,"^",1)="-1") "-1^Could not determine message type"
 S TYPE=$P(TMP,"^",2)
 ;DONE IF ACK OR RETRANSMIT (DOMAINS NOT FILED)
 Q:((TYPE="ACK")!(TYPE="RET")) 0
 ;GET INFO
 S SENDER=$G(@PARSARR@(MESSNUM,"DOMAIN",1,2))
 S RECEIVER=$G(@PARSARR@(MESSNUM,"DOMAIN",1,3))
 ;FILE INFORMATION
 S ERR=0
 ;FILE SENDER
 S TMP=$S((TYPE="REQ"):31,1:61)
 S ERR=$$FILEINFO^VAQFILE(394.61,TRANPTR,TMP,SENDER)
 Q:(ERR) "-1^Unable to file sending domain of transmission ("_SENDER_")"
 ;FILE RECEIVER
 S TMP=$S((TYPE="REQ"):61,1:31)
 S ERR=$$FILEINFO^VAQFILE(394.61,TRANPTR,TMP,RECEIVER)
 Q:(ERR) "-1^Unable to file receiving domain of transmission ("_RECEIVER_")"
 Q 0
