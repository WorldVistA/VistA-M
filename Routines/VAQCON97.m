VAQCON97 ;ALB/JRP - MESSAGE CONSTRUCTION;19-APR-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
DATA10(TRANPTR,ROOT,MESSNUM,ARRAY,OFFSET) ;BUILD DATA BLOCK FOR VERSION 1.0
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
 ;         identify the segments.
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
 N TMP,X,LINE,STATUS,TYPE,SEGABB,FILE,FIELD,SEQ,INFO,VALUE,SEQFIELD
 S LINE=OFFSET
 ;DETERMINE STATUS & TYPE
 S TMP=$$STATYPE^VAQCON1(TRANPTR)
 Q:($P(TMP,"^",1)="-1") TMP
 S STATUS=$P(TMP,"^",1)
 S TYPE=$P(TMP,"^",2)
 ;MAKE SURE MESSAGE SHOULD CONTAIN DATA
 Q:((TYPE'="RES")&(TYPE'="UNS")) "-1^Message type does not return data"
 Q:((STATUS'="VAQ-RSLT")&(STATUS'="VAQ-UNSOL")) "-1^Message type does not return data"
 Q:(TYPE="REC") "-1^Transaction is being received, not transmitted"
 ;PLACE MINIMUM INFORMATION INTO MESSAGE
 D MIN10^VAQCON98
 ;PLACE MAS INFORMATION INTO MESSAGE
 D MAS10^VAQCON96
 ;PLACE PHARMACY INFORMATION INTO MESSAGE
 D PHA10^VAQCON95
 Q (LINE-OFFSET)
