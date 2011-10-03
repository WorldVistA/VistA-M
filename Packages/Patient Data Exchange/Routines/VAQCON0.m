VAQCON0 ;ALB/JRP - MESSAGE CONSTRUCTION;14-APR-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
MESSAGE(TRANPTR,ROOT,MESSNUM,ARRAY,OFFSET) ;BUILD MESSAGE FOR TRANSACTION
 ;INPUT  : TRANPTR - Pointer to VAQ - TRANSACTION file
 ;         ROOT - Location of Extraction Arrays (full global reference)
 ;         MESSNUM - Message number to place message into
 ;                   (if 0, message will be placed in ARRAY)
 ;         ARRAY - Array to store message in (full global reference)
 ;         OFFSET - Where to begin placing information (defaults to 0)
 ;OUTPUT : N - Number of lines in message
 ;        -1^Error_Text - Error
 ;NOTES  : If MESSNUM=0, then the message will be placed into
 ;           ARRAY(LineNumber)=Line_of_info
 ;         If MESSNUM>0 then the message will be placed into
 ;           ^XMB(3.9,MESSNUM,2,LineNumber,0)=Line_of_info
 ;       : The first subscript in ROOT must be the segment abbreviation
 ;         (i.e. ROOT(SegmentAbbreviation)).  This is required to
 ;         identify the segment contained in a DATA or DISPLAY block.
 ;
 ;CHECK INPUT
 S TRANPTR=+$G(TRANPTR)
 Q:(('TRANPTR)!('$D(^VAT(394.61,TRANPTR)))) "-1^Did not pass a valid pointer to VAQ - TRANSACTION file"
 S ROOT=$G(ROOT)
 S MESSNUM=+$G(MESSNUM)
 I (('MESSNUM)&($G(ARRAY)="")) Q "-1^Did not pass message number or reference to array"
 I (MESSNUM) Q:('$D(^XMB(3.9,MESSNUM))) "-1^Valid message number not passed"
 S OFFSET=+$G(OFFSET)
 ;DECLARE VARIABLES
 N TMP,X,Y,TMPROOT,LINE,TYPE,SEG,STATUS
 S LINE=OFFSET
 ;GET MESSAGE STATUS & TYPE
 S TMP=$$STATYPE^VAQCON1(TRANPTR)
 Q:($P(TMP,"^",1)="-1") TMP
 S STATUS=$P(TMP,"^",1)
 S TYPE=$P(TMP,"^",2)
 Q:(TYPE="REC") "-1^Transaction is being received, not transmitted"
 ;START PDX MESSAGE
 S TMP="$MESSAGE"
 S:('MESSNUM) @ARRAY@(LINE)=TMP
 S:(MESSNUM) X=$$ADDLINE^VAQCON1(TMP,MESSNUM,LINE)
 S LINE=LINE+1
 ;HEADER BLOCK
 S TMP=$$HEADER^VAQCON2(TRANPTR,MESSNUM,ARRAY,LINE)
 Q:(+TMP=-1) TMP
 S LINE=LINE+TMP
 ;DOMAIN BLOCK
 S TMP=$$DOMAIN^VAQCON4(TRANPTR,MESSNUM,ARRAY,LINE)
 Q:(+TMP=-1) TMP
 S LINE=LINE+TMP
 ;ACK & RE-TRANSMIT COMPLETED
 G:((TYPE="ACK")!(TYPE="RET")) MESSDONE
 ;USER BLOCK
 S TMP=$$USER^VAQCON3(TRANPTR,MESSNUM,ARRAY,LINE)
 Q:(+TMP=-1) TMP
 S LINE=LINE+TMP
 ;PATIENT BLOCK
 S TMP=$$PATIENT^VAQCON6(TRANPTR,MESSNUM,ARRAY,LINE)
 Q:(+TMP=-1) TMP
 S LINE=LINE+TMP
 ;SEGMENT BLOCK
 S TMP=$$SEGMENT^VAQCON5(TRANPTR,MESSNUM,ARRAY,LINE)
 Q:(+TMP=-1) TMP
 S LINE=LINE+TMP
 ;REQUEST COMPLETED
 G:(TYPE="REQ") MESSDONE
 ;COMMENT BLOCK
 S TMP=$$COMMENT^VAQCON4(TRANPTR,MESSNUM,ARRAY,LINE)
 Q:(+TMP=-1) TMP
 S LINE=LINE+TMP
 ;PROCESSED REQUEST WITH NO DATA COMPLETED
 I (TYPE="RES") G:((STATUS="VAQ-AMBIG")!(STATUS="VAQ-NTFND")!(STATUS="VAQ-REJ")) MESSDONE
 ;DATA BLOCKS
 S SEG=""
 I (ROOT'="") F  S SEG=$O(@ROOT@(SEG)) Q:(SEG="")  I $D(@ROOT@(SEG,"VALUE")) D  Q:(+TMP=-1)
 .;PLACE SEGMENT ABBREVIATION INTO ROOT
 .S TMP=$P(ROOT,"(",1)
 .S X=$P(ROOT,"(",2)
 .S Y=$P(X,")",1)
 .S:(Y="") TMPROOT=TMP_"("_$C(34)_SEG_$C(34)_")"
 .S:(Y'="") TMPROOT=TMP_"("_Y_","_$C(34)_SEG_$C(34)_")"
 .S:(ROOT="") TMPROOT=""
 .S TMP=$$DATA^VAQCON7(TRANPTR,SEG,TMPROOT,MESSNUM,ARRAY,LINE)
 .Q:(+TMP=-1)
 .S LINE=LINE+TMP
 Q:(+TMP=-1) TMP
 ;DISPLAY BLOCKS
 S SEG=""
 I (ROOT'="") F  S SEG=$O(@ROOT@(SEG)) Q:(SEG="")  I $D(@ROOT@(SEG,"DISPLAY")) D  Q:(+TMP=-1)
 .;PLACE SEGMENT ABBREVIATION INTO ROOT
 .S TMP=$P(ROOT,"(",1)
 .S X=$P(ROOT,"(",2)
 .S Y=$P(X,")",1)
 .S:(Y="") TMPROOT=TMP_"("_$C(34)_SEG_$C(34)_")"
 .S:(Y'="") TMPROOT=TMP_"("_Y_","_$C(34)_SEG_$C(34)_")"
 .S:(ROOT="") TMPROOT=""
 .S TMP=$$DISPLAY^VAQCON8(TRANPTR,SEG,TMPROOT,0,"",MESSNUM,ARRAY,LINE)
 .Q:(+TMP=-1)
 .S LINE=LINE+TMP
 Q:(+TMP=-1) TMP
MESSDONE ;END PDX MESSAGE
 S TMP="$$MESSAGE"
 S:('MESSNUM) @ARRAY@(LINE)=TMP
 S:(MESSNUM) X=$$ADDLINE^VAQCON1(TMP,MESSNUM,LINE)
 S LINE=LINE+1
 Q (LINE-OFFSET)
