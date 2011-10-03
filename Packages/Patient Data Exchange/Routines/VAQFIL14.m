VAQFIL14 ;ALB/JRP - MESSAGE FILING;12-MAY-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
COMMENT(MESSNUM,PARSARR,TRANPTR) ;FILE COMMENT BLOCK
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
 Q:('$D(@PARSARR@(MESSNUM,"COMMENT",1))) "-1^Message did not contain a comment block"
 S TRANPTR=+$G(TRANPTR)
 Q:(('TRANPTR)!('$D(^VAT(394.61,TRANPTR)))) "-1^Did not pass a valid transaction"
 ;DECLARE VARIABLES
 N TMP,TYPE,LINE,ERR,OFFSET
 ;MAKE SURE IT'S A COMMENT BLOCK
 S TMP=$G(@PARSARR@(MESSNUM,"COMMENT",1,1))
 S:(TMP=" ") TMP=""
 Q:((TMP="")!(TMP'="$COMMENT")) "-1^Not a comment block"
 S TMP=$G(@PARSARR@(MESSNUM,"COMMENT",1,2))
 Q:(TMP="$$COMMENT") 0
 ;GET MESSAGE TYPE
 S TMP=$$STATYPE^VAQFIL11(MESSNUM,PARSARR)
 Q:($P(TMP,"^",1)="-1") "-1^Could not determine message type"
 S TYPE=$P(TMP,"^",2)
 ;ACK & RETRANSMIT & REQUEST DON'T HAVE COMMENT BLOCK
 Q:((TYPE="ACK")!(TYPE="RET")!(TYPE="REQ")) "-1^Message type does not require comment block"
 ;DELETE EXISTING COMMENT
 S ERR=0
 I ($D(^VAT(394.61,TRANPTR,"CMNT"))) D
 .S ERR=$$FILEINFO^VAQFILE(394.61,TRANPTR,100,"@")
 Q:(ERR) "-1^Unable to delete existing comment"
 ;PUT BLANK LINE INTO COMMENT (SETS ZERO NODE)
 S ERR=$$FILEINFO^VAQFILE(394.61,TRANPTR,100," ")
 Q:(ERR) "-1^Unable to store comment"
 ;STORE COMMENT
 S LINE=1
 S OFFSET=1
 S TMP=""
 F  S OFFSET=$O(@PARSARR@(MESSNUM,"COMMENT",1,OFFSET)) Q:(OFFSET="")  D  Q:(TMP="$$COMMENT")
 .S TMP=$G(@PARSARR@(MESSNUM,"COMMENT",1,OFFSET))
 .Q:(TMP="$$COMMENT")
 .S ^VAT(394.61,TRANPTR,"CMNT",LINE,0)=TMP
 .S LINE=LINE+1
 I (TMP'="$$COMMENT") S ERR=$$FILEINFO^VAQFILE(394.61,TRANPTR,100,"@") Q "-1^Not a valid comment"
 ;UPDATE ZERO NODE
 S LINE=LINE-1
 S TMP=$G(^VAT(394.61,TRANPTR,"CMNT",0))
 S $P(TMP,"^",3)=LINE
 S $P(TMP,"^",4)=LINE
 S ^VAT(394.61,TRANPTR,"CMNT",0)=TMP
 Q 0
