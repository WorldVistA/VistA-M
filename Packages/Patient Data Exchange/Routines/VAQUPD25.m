VAQUPD25 ;ALB/JRP - EXTRACT SEGMENT FROM DATA FILE;08-APR-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
EXTARR(TRAN,SEG,ROOT,OFFSET) ;PULL EXTRACTION ARRAY OUT OF DATA FILE
 ;INPUT  : TRAN - Pointer to VAQ - TRANSACTION file
 ;         SEG - Pointer to VAQ - DATA SEGMENT file
 ;         ROOT - Where to store the extraction array (full global ref)
 ;         OFFSET - Where to begin placing information (defaults to 0)
 ;                  (Only valid for extractions that are in Display
 ;                   Ready format)
 ;OUTPUT : 0 - Success (non-display ready)
 ;         n - Number of lines in display (display ready format)
 ;        -1^Error_Text - Error
 ;NOTES  : If the segment is not in display ready format
 ;           ROOT("VALUE",File,Field,Seq)=Data
 ;           ROOT("ID",File,Field,Seq)=Identifier
 ;         If the segment is in display ready format
 ;           ROOT("DISPLAY",LineNumber,0)=Line of display
 ;
 ;CHECK INPUT
 S TRAN=+$G(TRAN)
 S SEG=+$G(SEG)
 Q:(('TRAN)!('SEG)) "-1^Did not pass pointer transaction or segment"
 S OFFSET=+$G(OFFSET)
 Q:('$D(^VAT(394.61,TRAN))) "-1^Did not pass valid transaction"
 Q:('$D(^VAT(394.71,SEG))) "-1^Did not pass a valid segment"
 Q:($G(ROOT)="") "-1^Did not pass reference to output array"
 ;DON'T EXTRACT IF PURGE FLAG IS SET
 Q:($D(^VAT(394.61,"PURGE",1,TRAN))) "-1^Transaction has been flagged for purging"
 ;DECLARE VARIABLES
 N LINE,IFN,TMP,SEQ,FILE,FIELD,VALUE,ID,DISPLAY
 S LINE=OFFSET
 ;DETERMINE IF SEGMENT HAS DATA
 Q:('$D(^VAT(394.62,"A-SEGMENT",TRAN,SEG))) "-1^Segment did not contain any data"
 ;DETERMINE IF SEGMENT IS DISPLAY READY
 S DISPLAY=$D(^VAT(394.62,"A-DISPLAY",TRAN,SEG))
 ;DISPLAY READY
 I (DISPLAY) D  Q LINE-OFFSET
 .;GET IFN (USED FOR DIPSLAY READY)
 .S IFN=+$O(^VAT(394.62,"A-SEGMENT",TRAN,SEG,""))
 .Q:('IFN)
 .S SEQ=0
 .F  S SEQ=$O(^VAT(394.62,IFN,"DSP",SEQ)) Q:('SEQ)  D
 ..S VALUE=$G(^VAT(394.62,IFN,"DSP",SEQ,0))
 ..S @ROOT@("DISPLAY",LINE,0)=VALUE
 ..S LINE=LINE+1
 ;EXTRACTION ARRAY
 S IFN=""
 F  S IFN=$O(^VAT(394.62,"A-SEGMENT",TRAN,SEG,IFN)) Q:('IFN)  D
 .S TMP=$G(^VAT(394.62,IFN,0))
 .S FILE=+$P(TMP,"^",3)
 .Q:('FILE)
 .S FIELD=+$P(TMP,"^",4)
 .Q:('FIELD)
 .S SEQ=+$G(^VAT(394.62,IFN,"SQNCE"))
 .S VALUE=$G(^VAT(394.62,IFN,"VAL"))
 .S ID=$G(^VAT(394.62,IFN,"IDNT1"))
 .S @ROOT@("VALUE",FILE,FIELD,SEQ)=VALUE
 .S @ROOT@("ID",FILE,FIELD,SEQ)=ID
 Q 0
