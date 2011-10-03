VAQFIL10 ;ALB/JRP - MESSAGE FILING;12-MAY-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
HEADER(MESSNUM,PARSARR) ;FILE HEADER BLOCK
 ;INPUT  : MESSNUM - Message number in transmission (not XMZ)
 ;                   (defaults to 1)
 ;         PARSARR - Parsing array (full global reference)
 ;         (As defined by MailMan)
 ;         XMFROM, XMREC,XMZ
 ;OUTPUT : N^New_Flag - Success
 ;                      N = Transaction the header was filed in
 ;               New_Flag = 1 if a new transaction was created
 ;                        = 0 if an existing transaction was used
 ;         -1^Error_Text - Error
 ;NOTES  : If a new transaction is created and an error occurs, the
 ;         new transaction will be deleted.
 ;       : If an existing transaction is updated and an error occurs,
 ;         it is the responsibility of the calling program to correct
 ;         the transaction.
 ;
 ;CHECK INPUT
 S:($G(MESSNUM)="") MESSNUM=1
 Q:($G(PARSARR)="") "-1^Did not pass reference to parsing array"
 Q:('$D(@PARSARR@(MESSNUM))) "-1^Did not pass valid message number"
 Q:('$D(@PARSARR@(MESSNUM,"HEADER",1))) "-1^Message did not contain a header block"
 ;DECLARE VARIABLES
 N TMP,TYPE,STATUS,VERSION,DATETIME,MESSXMZ,TRANSNUM,ENCMTHD
 N TRANPTR,ERR,NEWTRAN
 S NEWTRAN=0
 ;MAKE SURE IT'S A HEADER BLOCK
 S TMP=$G(@PARSARR@(MESSNUM,"HEADER",1,1))
 S:(TMP=" ") TMP=""
 Q:((TMP="")!(TMP'="$HEADER")) "-1^Not a header block"
 S TMP=$G(@PARSARR@(MESSNUM,"HEADER",1,9))
 S:(TMP=" ") TMP=""
 Q:((TMP="")!(TMP'="$$HEADER")) "-1^Not a valid header block"
 ;GET MESSAGE TYPE
 S TYPE=$G(@PARSARR@(MESSNUM,"HEADER",1,2))
 S:(TYPE=" ") TYPE=""
 Q:(TYPE="") "-1^Header did not contain message type"
 S TMP="^REQ^RES^UNS^ACK^RET^"
 Q:(TMP'[("^"_TYPE_"^")) "-1^Header did not contain valid message type"
 ;GET STATUS
 S STATUS=$G(@PARSARR@(MESSNUM,"HEADER",1,3))
 S:(STATUS=" ") STATUS=""
 Q:(STATUS="") "-1^Header did not contain status"
 S TMP="^VAQ-AMBIG^VAQ-NTFND^VAQ-REJ^VAQ-RQACK^VAQ-RQST^VAQ-RSLT^VAQ-RTRNS^VAQ-UNACK^VAQ-UNSOL^"
 Q:(TMP'[("^"_STATUS_"^")) "-1^Header did not contain valid status"
 ;GET VERSION NUMBER (DEFAULTS TO 1.5)
 S VERSION=$G(@PARSARR@(MESSNUM,"HEADER",1,4))
 S:(VERSION=" ") VERSION=""
 S:(VERSION="") VERSION=1.5
 ;GET DATE/TIME OF TRANSMISSION (DEFAULT TO NOW)
 S DATETIME=$G(@PARSARR@(MESSNUM,"HEADER",1,5))
 S:(DATETIME=" ") DATETIME=""
 I (DATETIME="") S DATETIME=$$NOW^VAQUTL99() Q:($P(DATETIME,"^",1)="-1") "-1^Could not determine transmission time of message"
 ;CHECK DATE/TIME FOR CORRECTNESS
 S DATETIME=$$CHCKDT^VAQUTL95(DATETIME)
 Q:(DATETIME="-1") "-1^Could not determine transmission time of message"
 ;GET MESSXMZ OF MESSAGE (DEFAULTS TO XMZ)
 S MESSXMZ=$G(@PARSARR@(MESSNUM,"HEADER",1,6))
 S:(MESSXMZ=" ") MESSXMZ=""
 S:(MESSXMZ="") MESSXMZ=$G(XMZ)
 ;GET TRANSACTION NUMBER
 S TRANSNUM=$G(@PARSARR@(MESSNUM,"HEADER",1,7))
 S:(TRANSNUM=" ") TRANSNUM=""
 Q:((TRANSNUM="")&(VERSION'=1)) "-1^Transaction number not passed in header block"
 ;GET ENCRYPTION METHOD
 S ENCMTHD=$G(@PARSARR@(MESSNUM,"HEADER",1,8))
 S:(ENCMTHD=" ") ENCMTHD=""
 I (ENCMTHD'="") Q:('$D(^VAT(394.72,"B",ENCMTHD))) "-1^Encryption method used not supported at this facility"
 ;MAKE ENTRY IN TRANSACTION FILE
 I ((TYPE="REQ")!(TYPE="UNS")) D  Q:((+TRANPTR)<0) "-1^Unable to create entry in transaction file"
 .S NEWTRAN=1
 .S TRANPTR=$$NEWTRAN^VAQFILE
 .Q:((+TRANPTR)<0)
 .S TRANPTR=+TRANPTR
 ;FIND ENTRY IN TRANSACTION FILE
 I ((TYPE="RES")!(TYPE="ACK")!(TYPE="RET")) D  Q:('TRANPTR) "-1^Could not find entry in transaction file"
 .S TRANPTR=+$O(^VAT(394.61,"B",TRANSNUM,""))
 Q:('$G(TRANPTR)) "-1^Unable to create/find entry in transaction file"
 ;FILE INFORMATION
 S ERR=0
 D HEADER^VAQFIL11
 Q:(ERR) ERR
 Q TRANPTR_"^"_NEWTRAN
