VAQCON5 ;ALB/JRP - MESSAGE CONSTRUCTION;2-SEP-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
SEGMENT(TRANPTR,MESSNUM,ARRAY,OFFSET) ;CONSTRUCT SEGMENT BLOCK
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
 N TMP,LINE,SEGABB,SEGPTR,TYPE,X,SEGMNT,TIMLIM,OCCLIM,LOOP
 S LINE=OFFSET
 ;LINE 1
 S TMP="$SEGMENT"
 S:('MESSNUM) @ARRAY@(LINE)=TMP
 S:(MESSNUM) X=$$ADDLINE^VAQCON1(TMP,MESSNUM,LINE)
 S LINE=LINE+1
 ;SEGMENTS
 S SEGMNT=0
 F  S SEGMNT=$O(^VAT(394.61,TRANPTR,"SEG",SEGMNT)) Q:('SEGMNT)  D
 .S TMP=$G(^VAT(394.61,TRANPTR,"SEG",SEGMNT,0))
 .S SEGPTR=+TMP
 .S TIMLIM=$P(TMP,"^",2)
 .S OCCLIM=$P(TMP,"^",3)
 .Q:('SEGPTR)
 .S SEGABB=$P($G(^VAT(394.71,SEGPTR,0)),"^",2)
 .Q:(SEGABB="")
 .F LOOP=SEGABB,TIMLIM,OCCLIM D
 ..S:('MESSNUM) @ARRAY@(LINE)=LOOP
 ..S:(MESSNUM) X=$$ADDLINE^VAQCON1(LOOP,MESSNUM,LINE)
 ..S LINE=LINE+1
 ;LINE Z
 S TMP="$$SEGMENT"
 S:('MESSNUM) @ARRAY@(LINE)=TMP
 S:(MESSNUM) X=$$ADDLINE^VAQCON1(TMP,MESSNUM,LINE)
 S LINE=LINE+1
 Q (LINE-OFFSET)
