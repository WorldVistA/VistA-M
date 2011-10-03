VAQBUL07 ;ALB/JRP - BULLETINS;26-JUL-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
PURGE(ERRARR) ;SEND PURGING ERROR BULLETIN
 ;INPUT  : ERRARR - Array of errors subscripted by entry number in
 ;                  transaction file (full global ref)
 ;OUTPUT : 0 - Bulletin sent
 ;        -1^ErrorText - Bulletin not sent
 ;NOTES  : ERRARR should be in the format
 ;           ERRARR(Transaction's IFN)=Error text
 ;
 ;CHECK INPUT
 Q:($G(ERRARR)="") "-1^Did not pass reference to error array"
 Q:('$D(@ERRARR)) 0
 ;DECLARE VARIABLES
 N SUBJ,SENTBY,FWRDBY,XMY,TMPARR,TRANPTR,X,STOPPED,LINE
 S TMPARR="^TMP(""VAQ-BUL"","_$J_")"
 K @TMPARR
 S LINE=1
 ;DETERMINE IF PURGER WAS STOPPED
 S STOPPED=$D(@ERRARR@("STOPPED"))
 I (STOPPED) D
 .S @TMPARR@(LINE,0)="** Purger was stopped before completion **"
 .S LINE=LINE+1
 .S @TMPARR@(LINE,0)=""
 .S LINE=LINE+1
 .S @TMPARR@(LINE,0)=""
 .S LINE=LINE+1
 ;BUILD MESSAGE
 S @TMPARR@(LINE,0)="The following PDX Transaction(s) could not be purged ..."
 S LINE=LINE+1
 S @TMPARR@(LINE,0)=""
 S LINE=LINE+1
 S TRANPTR=""
 F  S TRANPTR=$O(@ERRARR@(TRANPTR)) Q:(TRANPTR="")  D
 .Q:(TRANPTR="STOPPED")
 .S @TMPARR@(LINE,0)=""
 .S LINE=LINE+1
 .S X=$G(@ERRARR@(TRANPTR))
 .S @TMPARR@(LINE,0)="Entry #: "_TRANPTR
 .S LINE=LINE+1
 .S @TMPARR@(LINE,0)=" Global: ^VAT(394.61,"_TRANPTR_")"
 .S LINE=LINE+1
 .S @TMPARR@(LINE,0)=" Reason: "_X
 .S LINE=LINE+1
 S @TMPARR@(LINE,0)=""
 S LINE=LINE+1
 S @TMPARR@(LINE,0)=""
 S LINE=LINE+1
 S @TMPARR@(LINE,0)="**  Please remember that PDX Transactions may also   **"
 S LINE=LINE+1
 S @TMPARR@(LINE,0)="** have associated data stored in file number 394.62 **"
 S LINE=LINE+1
 S @TMPARR@(LINE,0)=""
 S LINE=LINE+1
 ;SET UP CALL TO SEND BULLETIN
 S SUBJ="PDX TRANSACTIONS COULD NOT BE PURGED"
 S SENTBY="PDX"
 S FWRDBY="Patient Data eXchange"
 S XMY("G.VAQ PDX ERRORS")=""
 ;SEND BULLETIN
 S X=$$SENDBULL^VAQBUL(SUBJ,SENTBY,FWRDBY,TMPARR)
 S:(X>0) X=0
 ;CLEAN UP
 K @TMPARR
 Q X
