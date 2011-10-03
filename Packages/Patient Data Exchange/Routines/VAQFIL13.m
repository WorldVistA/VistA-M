VAQFIL13 ;ALB/JRP - MESSAGE FILING;12-MAY-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
USER(MESSNUM,PARSARR,TRANPTR) ;FILE USER BLOCK
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
 Q:('$D(@PARSARR@(MESSNUM,"USER",1))) "-1^Message did not contain a user block"
 S TRANPTR=+$G(TRANPTR)
 Q:(('TRANPTR)!('$D(^VAT(394.61,TRANPTR)))) "-1^Did not pass a valid transaction"
 ;DECLARE VARIABLES
 N TMP,TYPE,USERNAME,USERSITE,ERR
 ;MAKE SURE IT'S A USER BLOCK
 S TMP=$G(@PARSARR@(MESSNUM,"USER",1,1))
 S:(TMP=" ") TMP=""
 Q:((TMP="")!(TMP'="$USER")) "-1^Not a user block"
 S TMP=$G(@PARSARR@(MESSNUM,"USER",1,5))
 S:(TMP=" ") TMP=""
 Q:((TMP="")!(TMP'="$$USER")) "-1^Not a valid user block"
 ;GET MESSAGE TYPE
 S TMP=$$STATYPE^VAQFIL11(MESSNUM,PARSARR)
 Q:($P(TMP,"^",1)="-1") "-1^Could not determine message type"
 S TYPE=$P(TMP,"^",2)
 ;ACK OR RETRANSMIT DON'T HAVE USER BLOCKS
 Q:((TYPE="ACK")!(TYPE="RET")) "-1^Message type does not require user block"
 ;GET INFO
 S USERNAME=$G(@PARSARR@(MESSNUM,"USER",1,2))
 S:(USERNAME=" ") USERNAME=""
 S USERSITE=$G(@PARSARR@(MESSNUM,"USER",1,4))
 S:(USERSITE=" ") USERSITE=""
 ;FILE INFORMATION
 S ERR=0
 ;FILE NAME
 S TMP=$S((TYPE="REQ"):21,1:51)
 S ERR=$$FILEINFO^VAQFILE(394.61,TRANPTR,TMP,USERNAME)
 Q:(ERR) "-1^Unable to file sender of transmission ("_USERNAME_")"
 ;FILE SITE
 S TMP=$S((TYPE="REQ"):30,1:60)
 S ERR=$$FILEINFO^VAQFILE(394.61,TRANPTR,TMP,USERSITE)
 Q:(ERR) "-1^Unable to file sending facility of transmission ("_USERSITE_")"
 Q 0
 ;
SENDER(MESSNUM,PARSARR) ;RETURN SENDER OF PARSED MESSAGE
 ;INPUT  : MESSNUM - Message number in transmission (not XMZ)
 ;                   (defaults to 1)
 ;         PARSARR - Parsing array (full global reference)
 ;OUTPUT : Name^DUZ - Success
 ;         -1^Error_Text - Error
 ;
 ;CHECK INPUT
 S:($G(MESSNUM)="") MESSNUM=1
 Q:($G(PARSARR)="") "-1^Did not pass reference to parsing array"
 Q:('$D(@PARSARR@(MESSNUM))) "-1^Did not pass valid message number"
 Q:('$D(@PARSARR@(MESSNUM,"USER",1))) "-1^Message did not contain a user block"
 ;DECLARE VARIABLES
 N USERNAME,USERDUZ
 S USERNAME=$G(@PARSARR@(MESSNUM,"USER",1,2))
 S:(USERNAME=" ") USERNAME=""
 Q:(USERNAME="") "-1^Could not determine sender of message"
 S USERDUZ=$G(@PARSARR@(MESSNUM,"USER",1,3))
 S:(USERDUZ=" ") USERDUZ=""
 Q:(USERDUZ="") "-1^Could not determine sender of message"
 Q USERNAME_"^"_USERDUZ
 ;
KEY(MESSNUM,PARSARR,PRIME) ;RETURN SENDER OF PARSED MESSAGE
 ;INPUT  : MESSNUM - Message number in transmission (not XMZ)
 ;                   (defaults to 1)
 ;         PARSARR - Parsing array (full global reference)
 ;         PRIME - Indicates which key to return
 ;           0 = Return secondary key (default)
 ;               Returns NULL on error
 ;           1 = Return primary key
 ;               Returns NULL on error
 ;OUTPUT : See definition of PRIME
 ;
 ;CHECK INPUT
 S:($G(MESSNUM)="") MESSNUM=1
 Q:($G(PARSARR)="") ""
 Q:('$D(@PARSARR@(MESSNUM))) ""
 Q:('$D(@PARSARR@(MESSNUM,"USER",1))) ""
 S PRIME=+$G(PRIME)
 ;DECLARE VARIABLES
 N SENDER
 ;GET SENDER
 S SENDER=$$SENDER(MESSNUM,PARSARR)
 Q:($P(SENDER,"^",1)="-1") ""
 S SENDER=$P(SENDER,"^",1)
 ;RETURN KEY
 Q $$NAMEKEY^VAQUTL3(SENDER,PRIME)
