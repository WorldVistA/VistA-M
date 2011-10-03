VAQCON3 ;ALB/JRP - MESSAGE CONSTRUCTION;12-APR-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
USER(TRANPTR,MESSNUM,ARRAY,OFFSET) ;CONSTRUCT USER BLOCK
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
 N TMP,USER,FACNAME,LINE,X,USERDUZ
 S LINE=OFFSET
 ;DETERMINE SENDER
 S TMP=$$SENDER^VAQCON2(TRANPTR)
 Q:(+TMP=-1) "-1^Could not determine sender of message"
 S USER=$P(TMP,"^",1)
 S USERDUZ=$P(TMP,"^",2)
 ;DETERMINE FACILITY NAME (IF NOT IN PARAMETER FILE TRY GETTING FROM
 ;  'STATION NUMBER' FILE)
 S FACNAME=""
 S TMP=+$O(^VAT(394.81,0))
 I (TMP) S X=+$G(^VAT(394.81,TMP,0)) S:(X) FACNAME=$P($G(^DIC(4,X,0)),"^",1)
 S:(FACNAME="") FACNAME=$P($$SITE^VASITE,"^",2)
 Q:(FACNAME="") "-1^Could not determine facility name"
 ;LINE 1
 S TMP="$USER"
 S:('MESSNUM) @ARRAY@(LINE)=TMP
 S:(MESSNUM) X=$$ADDLINE^VAQCON1(TMP,MESSNUM,LINE)
 S LINE=LINE+1
 ;LINE 2
 S TMP=USER
 S:('MESSNUM) @ARRAY@(LINE)=TMP
 S:(MESSNUM) X=$$ADDLINE^VAQCON1(TMP,MESSNUM,LINE)
 S LINE=LINE+1
 ;LINE 3
 S TMP=USERDUZ
 S:('MESSNUM) @ARRAY@(LINE)=TMP
 S:(MESSNUM) X=$$ADDLINE^VAQCON1(TMP,MESSNUM,LINE)
 S LINE=LINE+1
 ;LINE 4
 S TMP=FACNAME
 S:('MESSNUM) @ARRAY@(LINE)=TMP
 S:(MESSNUM) X=$$ADDLINE^VAQCON1(TMP,MESSNUM,LINE)
 S LINE=LINE+1
 ;LINE 5
 S TMP="$$USER"
 S:('MESSNUM) @ARRAY@(LINE)=TMP
 S:(MESSNUM) X=$$ADDLINE^VAQCON1(TMP,MESSNUM,LINE)
 S LINE=LINE+1
 Q (LINE-OFFSET)
