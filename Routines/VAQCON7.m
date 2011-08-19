VAQCON7 ;ALB/JRP - MESSAGE CONSTRUCTION;13-APR-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
DATA(TRANPTR,SEGABB,DATARR,MESSNUM,ARRAY,OFFSET) ;CONSTRUCT DATA BLOCK
 ;INPUT  : TRANPTR - Pointer to VAQ - TRANSACTION file
 ;         SEGABB - Segment abbreviation for segment
 ;         DATARR - Location of Extraction Array (full global reference)
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
 Q:($G(DATARR)="") "-1^Did not pass location of Extraction Array"
 S MESSNUM=+$G(MESSNUM)
 I (('MESSNUM)&($G(ARRAY)="")) Q "-1^Did not pass message number of reference to array"
 I (MESSNUM) Q:('$D(^XMB(3.9,MESSNUM))) "-1^Valid message number not passed"
 S OFFSET=+$G(OFFSET)
 ;DECLARE VARIABLES
 N TMP,LINE,ID,FILE,FIELD,SEQ,NCRYPTON,X
 S LINE=OFFSET
 ;DETERMINE IF ENCRYPTION WAS TURNED ON
 S NCRYPTON=$$TRANENC^VAQUTL3(TRANPTR,0)
 ;LINE 1
 S TMP="$DATA"
 S:('MESSNUM) @ARRAY@(LINE)=TMP
 S:(MESSNUM) X=$$ADDLINE^VAQCON1(TMP,MESSNUM,LINE)
 S LINE=LINE+1
 ;LINE 2
 S TMP=SEGABB
 S:('MESSNUM) @ARRAY@(LINE)=TMP
 S:(MESSNUM) X=$$ADDLINE^VAQCON1(TMP,MESSNUM,LINE)
 S LINE=LINE+1
 ;LOOP THROUGH EACH FILE
 S FILE=""
 F  S FILE=$O(@DATARR@("VALUE",FILE)) Q:(FILE="")  D
 .;LOOP THROUGH EACH FIELD
 .S FIELD=""
 .F  S FIELD=$O(@DATARR@("VALUE",FILE,FIELD)) Q:(FIELD="")  D
 ..;COUNT NUMBER OF VALUES (IF MORE THAN ONE)
 ..S SEQ=1
 ..I (+$O(@DATARR@("VALUE",FILE,FIELD,0))) D
 ...S SEQ=0
 ...S X=""
 ...F  S X=$O(@DATARR@("VALUE",FILE,FIELD,X)) Q:(X="")  S SEQ=SEQ+1
 ..;STORE NON-REPEATED INFO
 ..;DETERMINE IF FIELD WAS ENCRYPTED
 ..S X=0
 ..S:(NCRYPTON) X=+$$NCRPFLD^VAQUTL2(FILE,FIELD)
 ..S TMP=X_"^"_FILE_"^"_FIELD_"^"_SEQ
 ..S:('MESSNUM) @ARRAY@(LINE)=TMP
 ..S:(MESSNUM) X=$$ADDLINE^VAQCON1(TMP,MESSNUM,LINE)
 ..S LINE=LINE+1
 ..;LOOP THROUGH EACH VALUE
 ..S SEQ=""
 ..F  S SEQ=$O(@DATARR@("VALUE",FILE,FIELD,SEQ)) Q:(SEQ="")  D
 ...S TMP=$G(@DATARR@("VALUE",FILE,FIELD,SEQ))
 ...S:('MESSNUM) @ARRAY@(LINE)=TMP
 ...S:(MESSNUM) X=$$ADDLINE^VAQCON1(TMP,MESSNUM,LINE)
 ...S LINE=LINE+1
 ...S TMP=$G(@DATARR@("ID",FILE,FIELD,SEQ))
 ...S:('MESSNUM) @ARRAY@(LINE)=TMP
 ...S:(MESSNUM) X=$$ADDLINE^VAQCON1(TMP,MESSNUM,LINE)
 ...S LINE=LINE+1
 ;LINE Z
 S TMP="$$DATA"
 S:('MESSNUM) @ARRAY@(LINE)=TMP
 S:(MESSNUM) X=$$ADDLINE^VAQCON1(TMP,MESSNUM,LINE)
 S LINE=LINE+1
 Q (LINE-OFFSET)
