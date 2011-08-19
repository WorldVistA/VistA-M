VAQCON8 ;ALB/JRP - MESSAGE CONSTRUCTION;2-SEP-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
DISPLAY(TRANPTR,SEGABB,DSPARR,STARTOFF,DSPSIZE,MESSNUM,ARRAY,OFFSET) ;CONSTRUCT DISPLAY BLOCK
 ;INPUT  : TRANPTR - Pointer to VAQ - TRANSACTION file
 ;         SEGABB - Segment abbreviation for segment
 ;         DSPARR - Location of displayable Extraction Array
 ;                  (full global reference)
 ;         STARTOFF - Where information in DSPARR begins (defaults to 0)
 ;         DSPSIZE - Number of lines in DSPARR to move (defaults to all)
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
 Q:($G(SEGABB)="") "-1^Did not pass segment abbreviation"
 Q:($G(DSPARR)="") "-1^Did not pass location of Extraction Array"
 S STARTOFF=+$G(STARTOFF)
 S DSPSIZE=$G(DSPSIZE)
 S MESSNUM=+$G(MESSNUM)
 I (('MESSNUM)&($G(ARRAY)="")) Q "-1^Did not pass message number of reference to array"
 I (MESSNUM) Q:('$D(^XMB(3.9,MESSNUM))) "-1^Valid message number not passed"
 S OFFSET=+$G(OFFSET)
 ;DECLARE VARIABLES
 N TMP,LINE,STOP,NCRYPTON,START,X
 S LINE=OFFSET
 ;DETERMINE IF ENCRYPTION WAS TURNED ON
 S NCRYPTON=$$TRANENC^VAQUTL3(TRANPTR,0)
 ;DETERMINE NUMBER OF LINES IN DISPLAY (IF NOT PASSED)
 I (DSPSIZE="") D
 .S DSPSIZE=0
 .S START=STARTOFF-.999999999
 .F  S START=$O(@DSPARR@("DISPLAY",START)) Q:(START="")  S DSPSIZE=DSPSIZE+1
 ;LINE 1
 S TMP="$DISPLAY"
 S:('MESSNUM) @ARRAY@(LINE)=TMP
 S:(MESSNUM) X=$$ADDLINE^VAQCON1(TMP,MESSNUM,LINE)
 S LINE=LINE+1
 ;LINE 2
 S TMP=SEGABB
 S:('MESSNUM) @ARRAY@(LINE)=TMP
 S:(MESSNUM) X=$$ADDLINE^VAQCON1(TMP,MESSNUM,LINE)
 S LINE=LINE+1
 ;LINE 3
 S TMP=NCRYPTON_"^"_DSPSIZE
 S:('MESSNUM) @ARRAY@(LINE)=TMP
 S:(MESSNUM) X=$$ADDLINE^VAQCON1(TMP,MESSNUM,LINE)
 S LINE=LINE+1
 ;LINES IN SEGMENT
 S STOP=0
 I (DSPSIZE) D
 .S START=STARTOFF-.999999999
 .F  S START=$O(@DSPARR@("DISPLAY",START)) Q:((START="")!(STOP>(DSPSIZE-1)))  D
 ..S TMP=$G(@DSPARR@("DISPLAY",START,0))
 ..S:('MESSNUM) @ARRAY@(LINE)=TMP
 ..S:(MESSNUM) X=$$ADDLINE^VAQCON1(TMP,MESSNUM,LINE)
 ..S LINE=LINE+1
 ..S STOP=STOP+1
 ;ADJUST DISPLAY SIZE IN LINE 3 (IF NEEDED)
 I (STOP<DSPSIZE) D
 .S TMP=NCRYPTON_"^"_STOP
 .S:('MESSNUM) @ARRAY@(OFFSET+2)=TMP
 .S:(MESSNUM) X=$$ADDLINE^VAQCON1(TMP,MESSNUM,(OFFSET+2))
 ;LINE Z
 S TMP="$$DISPLAY"
 S:('MESSNUM) @ARRAY@(LINE)=TMP
 S:(MESSNUM) X=$$ADDLINE^VAQCON1(TMP,MESSNUM,LINE)
 S LINE=LINE+1
 Q (LINE-OFFSET)
