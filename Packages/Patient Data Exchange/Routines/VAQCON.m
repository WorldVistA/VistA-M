VAQCON ;ALB/JRP - MESSAGE CONSTRUCTION;14-APR-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
XMIT(TRANARR,ROOT,MESSNUM,ARRAY,OFFSET) ;BUILD MESSAGE FOR TRANSACTION
 ;INPUT  : TRANARR - Array whose subscripts are pointers to
 ;                   VAQ - TRANSACTION file (full global reference)
 ;         ROOT - Location of Extraction Arrays (full global reference)
 ;         MESSNUM - Message number to place transmisison into
 ;                   (if 0, transmission will be placed in ARRAY)
 ;         ARRAY - Array to store transmission in (full global reference)
 ;         OFFSET - Where to begin placing information (defaults to 0)
 ;OUTPUT : N - Number of lines in transmission
 ;        -1^Error_Text - Error
 ;NOTES  : Transactions pointed to by TRANARR will be placed in the
 ;         same transmission and therefore should have the same domain
 ;         as their destination.
 ;       : If MESSNUM=0, then the transmission will be placed into
 ;           ARRAY(LineNumber)=Line_of_info
 ;         If MESSNUM>0 then the transmission will be placed into
 ;           ^XMB(3.9,MESSNUM,2,LineNumber,0)=Line_of_info
 ;       : The first subscript in ROOT must be a pointer to the
 ;         transaction.  The second subscript in ROOT must be the
 ;         segment abbreviation.  This is required to identify the
 ;         segments for each transaction contained in a DATA or DISPLAY
 ;         block.  ( ROOT(TransactionPointer,SegmentAbbreviation) )
 ;
 ;CHECK INPUT
 Q:($G(TRANARR)="") "-1^Did not pass reference to array of transaction pointers"
 S ROOT=$G(ROOT)
 S MESSNUM=+$G(MESSNUM)
 I (('MESSNUM)&($G(ARRAY)="")) Q "-1^Did not pass message number or reference to output array"
 I (MESSNUM) Q:('$D(^XMB(3.9,MESSNUM))) "-1^Valid message number not passed"
 S OFFSET=+$G(OFFSET)
 ;DECLARE VARIABLES
 N TMP,X,LINE,TRANPTR,Y,TMPROOT
 S LINE=OFFSET
 ;START PDX TRANSMISSION
 S TMP="$TRANSMIT"
 S:('MESSNUM) @ARRAY@(LINE)=TMP
 S:(MESSNUM) X=$$ADDLINE^VAQCON1(TMP,MESSNUM,LINE)
 S LINE=LINE+1
 ;LOOP THROUGH EACH TRANSACTION
 S TRANPTR=""
 F  S TRANPTR=$O(@TRANARR@(TRANPTR)) Q:('TRANPTR)  D  Q:(TMP<0)
 .;PLACE TRANSACTION POINTER INTO ROOT
 .S TMP=$P(ROOT,"(",1)
 .S X=$P(ROOT,"(",2)
 .S Y=$P(X,")",1)
 .S:(Y="") TMPROOT=TMP_"("_TRANPTR_")"
 .S:(Y'="") TMPROOT=TMP_"("_Y_","_TRANPTR_")"
 .S:(ROOT="") TMPROOT=""
 .;PUT IN MESSAGE
 .S TMP=$$MESSAGE^VAQCON0(TRANPTR,TMPROOT,MESSNUM,ARRAY,LINE)
 .Q:(TMP<0)
 .S LINE=LINE+TMP
 Q:(TMP<0) TMP
 ;END PDX TRANSMISSION
 S TMP="$$TRANSMIT"
 S:('MESSNUM) @ARRAY@(LINE)=TMP
 S:(MESSNUM) X=$$ADDLINE^VAQCON1(TMP,MESSNUM,LINE)
 S LINE=LINE+1
 Q (LINE-OFFSET)
