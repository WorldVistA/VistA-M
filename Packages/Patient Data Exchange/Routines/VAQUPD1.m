VAQUPD1 ;ALB/JRP - DATA LOOKUP ROUTINES;8-APR-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
TRNEXT(TRANPTR,ROOT) ;RECREATE ALL EXTRACTION ARRAYS FOR A TRANSACTION
 ;INPUT  : TRANPTR - Pointer to VAQ - TRANSACTION file
 ;         ROOT - Where to store the information (full global reference)
 ;                Defaluts to ^TMP("VAQ",$J)
 ;OUTPUT : 0 - Success
 ;        -1^Error_Text - Error
 ;NOTES  : Segments returning Extraction Arrays will be stored in
 ;          ROOT(Segment_Abbreviation,"VALUE",File,Field,Sequence_Number)
 ;          ROOT(Segment_Abbreviation,"ID",File,Field,Sequence_Number)
 ;         Segments returning Display Arrays will be stored in
 ;          ROOT(Segment_Abbreviation,"DISPLAY",Line_Number)
 ;       : Deletion of the outupt array before calling this routine
 ;         is the responsiblity of the calling application.
 ;
 ;CHECK INPUT
 S TRANPTR=+$G(TRANPTR)
 Q:('TRANPTR) "-1^Pointer to VAQ - TRANSACTION file not passed"
 Q:('$D(^VAT(394.61,TRANPTR))) "-1^Transaction did not exist"
 S ROOT=$G(ROOT)
 S:(ROOT="") ROOT="^TMP(""VAQ"","_$J_")"
 ;DECLARE VARIABLES
 N LOOP,SEGABB,ERROR,X,TRANSEG,SEG,TMP,Y,TMPROOT
 Q:('$D(^VAT(394.61,TRANPTR,"SEG"))) "-1^Transaction did not contain any data segments"
 S ERROR=0
 S TRANSEG=0
 ;LOOP THROUGH EACH DATA SEGMENT CONTAINED IN TRANSACTION
 F LOOP=0:0 D  Q:((ERROR)!('TRANSEG))
 .S TRANSEG=$O(^VAT(394.61,TRANPTR,"SEG",TRANSEG))
 .Q:('TRANSEG)
 .S SEG=+$G(^VAT(394.61,TRANPTR,"SEG",TRANSEG,0))
 .Q:('SEG)
 .;GET SEGMENT ABBREVIATION
 .S SEGABB=$P($G(^VAT(394.71,SEG,0)),"^",2)
 .Q:(SEGABB="")
 .;MAKE SEGMENT ABBREVIATION NEXT SUBSCRIPT IN ROOT
 .S TMP=$P(ROOT,"(",1)
 .S X=$P(ROOT,"(",2)
 .S Y=$P(X,")",1)
 .S:(Y="") TMPROOT=TMP_"("_$C(34)_SEGABB_$C(34)_")"
 .S:(Y'="") TMPROOT=TMP_"("_Y_","_$C(34)_SEGABB_$C(34)_")"
 .S X=$$SEGEXT(TRANPTR,SEG,TMPROOT)
 Q 0
SEGEXT(TRANPTR,SEGPTR,ROOT) ;MOVE SEGMENT IN DATA FILE TO EXTRACTION ARRAY
 ;INPUT  : TRANPTR - Pointer to VAQ - TRANSACTION file
 ;         SEGPTR - Pointer to VAQ - DATA SEGMENT file
 ;         ROOT - Where to store the information (full global reference)
 ;OUTPUT : 0 - Success
 ;        -1^Error_Text - Error
 ;
 ;CHECK INPUT
 Q:('$D(^VAT(394.61,+$G(TRANPTR),0))) "-1^Valid pointer to VAQ - TRANSACTION file not passed"
 Q:('$D(^VAT(394.71,+$G(SEGPTR),0))) "-1^Valid pointer to VAQ - DATA SEGMENT file not passed"
 Q:('$D(^VAT(394.62,"A-SEGMENT",TRANPTR,SEGPTR))) "-1^Transaction does not contain wanted information"
 ;DECLARE VARIABLES
 N DSPRDY,FILE,FIELD,SEQ,VALUE,ID,LOOP,TMP,DATAIFN
 ;DETERMINE IF DATA SEGMENT IS DISPLAY READY
 S DATAIFN=$O(^VAT(394.62,"A-SEGMENT",TRANPTR,SEGPTR,""))
 Q:(DATAIFN="") "-1^Transaction does not contain wanted information"
 S DSPRDY=$D(^VAT(394.62,"A-DISPLAY",TRANPTR,SEGPTR))
 ;DISPLAY READY
 I DSPRDY D  Q 0
 .S SEQ=0
 .F  S SEQ=$O(^VAT(394.62,DATAIFN,"DSP",SEQ)) Q:(SEQ="")  D
 ..S @ROOT@("DISPLAY",SEQ,0)=$G(^VAT(394.62,DATAIFN,"DSP",SEQ,0))
 ;NOT DISPLAY READY - MOVE INFO TO AN EXTRACTION ARRAY
 S DATAIFN=""
 F  S DATAIFN=$O(^VAT(394.62,"A-SEGMENT",TRANPTR,SEGPTR,DATAIFN)) Q:(DATAIFN="")  D
 .S TMP=$G(^VAT(394.62,DATAIFN,0))
 .S FILE=$P(TMP,"^",3)
 .Q:(FILE="")
 .S FIELD=$P(TMP,"^",4)
 .Q:(FIELD="")
 .S SEQ=$G(^VAT(394.62,DATAIFN,"SQNCE"))
 .Q:(SEQ="")
 .S VALUE=$G(^VAT(394.62,DATAIFN,"VAL"))
 .S ID=$G(^VAT(394.62,DATAIFN,"IDNT1"))
 .S @ROOT@("ID",FILE,FIELD,SEQ)=ID
 .S @ROOT@("VALUE",FILE,FIELD,SEQ)=VALUE
 Q 0
