VAQCON4 ;ALB/JRP - MESSAGE CONSTRUCTION;12-APR-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
DOMAIN(TRANPTR,MESSNUM,ARRAY,OFFSET) ;CONSTRUCT DOMAIN BLOCK
 ;INPUT  : TRANPTR - Pointer to VAQ - TRANSACTION file
 ;         MESSNUM - Message number to place block into
 ;                   (if 0, block will be placed in ARRAY)
 ;         ARRAY - Array to store block in (full global reference)
 ;         OFFSET - Where to begin placing information (defaults to 0)
 ;OUTPUT : N - Number of lines in block
 ;        -1^Error_Text - Error
 ;NOTES  : If MESSNUM=0, then the block will be placed into
 ;           ARRAY(LineNumber)=Line_of_info
 ;         If MESSNUM>0 then the block will be placed into
 ;           ^XMB(3.9,MESSNUM,2,LineNumber,0)=Line_of_info
 ;
 ;CHECK INPUT
 S TRANPTR=+$G(TRANPTR)
 Q:(('TRANPTR)!('$D(^VAT(394.61,TRANPTR)))) "-1^Did not pass a valid pointer to VAQ - TRANSACTION file"
 S MESSNUM=+$G(MESSNUM)
 I (('MESSNUM)&($G(ARRAY)="")) Q "-1^Did not pass message number of reference to array"
 I (MESSNUM) Q:('$D(^XMB(3.9,MESSNUM))) "-1^Valid message number not passed"
 S OFFSET=+$G(OFFSET)
 ;DECLARE VARIABLES
 N TMP,TYPE,LINE,X,SENDTO,SENTFRM,STATUS
 S LINE=OFFSET
 ;DETERMINE MESSAGE STATUS & TYPE (USED TO DETERMINE RECEIVER OF MESSAGE)
 S TMP=$$STATYPE^VAQCON1(TRANPTR)
 S STATUS=$P(TMP,"^",1)
 S TYPE=$P(TMP,"^",2)
 Q:(STATUS="-1") "-1^Could not determine message status or type"
 Q:(TYPE="REC") "-1^Transaction is being received, not transmitted"
 ;DETERMINE RETURN ADDRESS
 S TMP=+$O(^VAT(394.81,0))
 Q:('TMP) "-1^Could not determine return address"
 S X=+$P($G(^VAT(394.81,TMP,0)),"^",2)
 Q:('X) "-1^Could not determine return address"
 S SENTFRM=$P($G(^DIC(4.2,X,0)),"^",1)
 Q:(SENTFRM="") "-1^Could not determine return address"
 ;DETERMINE DESTINATION FOR MESSAGE
 S SENDTO=""
 S:((TYPE="REQ")!(TYPE="RET")) SENDTO=$P($G(^VAT(394.61,TRANPTR,"ATHR2")),"^",2)
 S:(TYPE="RES")!(TYPE="UNS") SENDTO=$P($G(^VAT(394.61,TRANPTR,"RQST2")),"^",2)
 S:((TYPE="ACK")&(STATUS="VAQ-UNACK")) SENDTO=$P($G(^VAT(394.61,TRANPTR,"ATHR2")),"^",2)
 S:((TYPE="ACK")&(STATUS="VAQ-RQACK")) SENDTO=$P($G(^VAT(394.61,TRANPTR,"RQST2")),"^",2)
 Q:(SENDTO="") "-1^Could not determine destination of message"
 ;LINE 1
 S TMP="$DOMAIN"
 S:('MESSNUM) @ARRAY@(LINE)=TMP
 S:(MESSNUM) X=$$ADDLINE^VAQCON1(TMP,MESSNUM,LINE)
 S LINE=LINE+1
 ;LINE 2
 S TMP=SENTFRM
 S:('MESSNUM) @ARRAY@(LINE)=TMP
 S:(MESSNUM) X=$$ADDLINE^VAQCON1(TMP,MESSNUM,LINE)
 S LINE=LINE+1
 ;LINE 3
 S TMP=SENDTO
 S:('MESSNUM) @ARRAY@(LINE)=TMP
 S:(MESSNUM) X=$$ADDLINE^VAQCON1(TMP,MESSNUM,LINE)
 S LINE=LINE+1
 ;LINE 4
 S TMP="$$DOMAIN"
 S:('MESSNUM) @ARRAY@(LINE)=TMP
 S:(MESSNUM) X=$$ADDLINE^VAQCON1(TMP,MESSNUM,LINE)
 S LINE=LINE+1
 Q (LINE-OFFSET)
 ;
COMMENT(TRANPTR,MESSNUM,ARRAY,OFFSET) ;CONSTRUCT COMMENT BLOCK
 ;INPUT  : TRANPTR - Pointer to VAQ - TRANSACTION file
 ;         MESSNUM - Message number to place block into
 ;                   (if 0, block will be placed in ARRAY)
 ;         ARRAY - Array to store block in (full global reference)
 ;         OFFSET - Where to begin placing information (defaults to 0)
 ;OUTPUT : N - Number of lines in block
 ;        -1^Error_Text - Error
 ;NOTES  : If MESSNUM=0, then the block will be placed into
 ;           ARRAY(LineNumber)=Line_of_info
 ;         If MESSNUM>0 then the block will be placed into
 ;           ^XMB(3.9,MESSNUM,2,LineNumber,0)=Line_of_info
 ;
 ;CHECK INPUT
 S TRANPTR=+$G(TRANPTR)
 Q:(('TRANPTR)!('$D(^VAT(394.61,TRANPTR)))) "-1^Did not pass a valid pointer to VAQ - TRANSACTION file"
 S MESSNUM=+$G(MESSNUM)
 I (('MESSNUM)&($G(ARRAY)="")) Q "-1^Did not pass message number of reference to array"
 I (MESSNUM) Q:('$D(^XMB(3.9,MESSNUM))) "-1^Valid message number not passed"
 S OFFSET=+$G(OFFSET)
 ;DECLARE VARIABLES
 N TMP,LINE,COMLINE,TYPE,X
 S LINE=OFFSET
 ;DETERMINE MESSAGE TYPE
 S TMP=$$STATYPE^VAQCON1(TRANPTR)
 Q:($P(TMP,"^",1)="-1") "-1^Could not determine message type"
 S TYPE=$P(TMP,"^",2)
 Q:(TYPE="REC") "-1^Transaction is being received, not transmitted"
 ;LINE 1
 S TMP="$COMMENT"
 S:('MESSNUM) @ARRAY@(LINE)=TMP
 S:(MESSNUM) X=$$ADDLINE^VAQCON1(TMP,MESSNUM,LINE)
 S LINE=LINE+1
 ;COMMENT LINES
 I ((TYPE="RES")!(TYPE="UNS")) D
 .S COMLINE=0
 .F  S COMLINE=$O(^VAT(394.61,TRANPTR,"CMNT",COMLINE)) Q:('COMLINE)  D
 ..S TMP=$G(^VAT(394.61,TRANPTR,"CMNT",COMLINE,0))
 ..S:('MESSNUM) @ARRAY@(LINE)=TMP
 ..S:(MESSNUM) X=$$ADDLINE^VAQCON1(TMP,MESSNUM,LINE)
 ..S LINE=LINE+1
 ;LINE Z
 S TMP="$$COMMENT"
 S:('MESSNUM) @ARRAY@(LINE)=TMP
 S:(MESSNUM) X=$$ADDLINE^VAQCON1(TMP,MESSNUM,LINE)
 S LINE=LINE+1
 Q (LINE-OFFSET)
