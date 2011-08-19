VAQUPD2 ;ALB/JRP - EXTRACT SEGMENT FROM DATA FILE;08-APR-1993
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
TRNDSP(TRANPTR,ROOT,OFFSET) ;BUILD DISPLAY FOR ALL SEGMENTS IN A TRANSACTION
 ;INPUT  : TRANPTR - Pointer to VAQ - TRANSACTION file
 ;         ROOT - Where to store the information (full global reference)
 ;                Defaluts to ^TMP("VAQ",$J)
 ;         OFFSET - Where to begin placing information (defaults to 0)
 ;OUTPUT : N - Number of lines in display
 ;        -1^Error_Text - Error
 ;NOTES  : ROOT will be returned in the format
 ;           ROOT("DISPLAY",Line_Number,0)
 ;       : Deletion of the outupt array before calling this routine
 ;         is the responsiblity of the calling application.
 ;
 ;CHECK INPUT
 S TRANPTR=+$G(TRANPTR)
 Q:('TRANPTR) "-1^Pointer to VAQ - TRANSACTION file not passed"
 Q:('$D(^VAT(394.61,TRANPTR))) "-1^Transaction did not exist"
 S ROOT=$G(ROOT)
 S:(ROOT="") ROOT="^TMP(""VAQ"","_$J_")"
 S OFFSET=+$G(OFFSET)
 ;DECLARE VARIABLES
 N SEG,LINE,LINECNT,X
 S LINE=OFFSET
 Q:('$D(^VAT(394.61,TRANPTR,"SEG"))) "-1^Transaction did not contain any data segments"
 S SEG=0
 ;LOOP THROUGH EACH DATA SEGMENT CONTAINED IN TRANSACTION
 F  S SEG=+$O(^VAT(394.61,TRANPTR,"SEG","B",SEG)) Q:('SEG)  D
 .;PUT DISPLAY INTO OUTPUT ARRAY
 .S LINECNT=$$BLDDSP(TRANPTR,SEG,ROOT,LINE)
 .Q:(LINECNT<1)
 .S LINE=LINE+LINECNT
 .;PUT WHITE SPACE AFTER EACH SEGMENT
 .F X=1:1:3 S @ROOT@("DISPLAY",LINE,0)="",LINE=LINE+1
 Q (LINE-OFFSET)
 ;
BLDDSP(TRAN,SEGPTR,ROOT,OFFSET) ;BUILD DISPLAYABLE SEGMENT FROM DATA FILE
 ;INPUT  : TRAN - Pointer to VAQ - TRANSACTION file
 ;         SEGPTR - Pointer to VAQ - DATA SEGMENT file
 ;         ROOT - Where to store the display array (full global ref)
 ;         OFFSET - Where to begin placing information (defaults to 0)
 ;OUTPUT : n - Number of lines in display
 ;        -1^Error_Text - Error
 ;NOTES  : ROOT will contain the display ready segment in the format
 ;           ROOT("DISPLAY",LineNumber,0)=Line of display
 ;       : It is the responsibility of the calling module to delete
 ;         ROOT before and after the call.
 ;
 ;CHECK INPUT
 S TRAN=+$G(TRAN)
 S SEGPTR=+$G(SEGPTR)
 Q:(('TRAN)!('SEGPTR)) "-1^Did not pass pointer to transaction or segment"
 S OFFSET=+$G(OFFSET)
 Q:('$D(^VAT(394.61,TRAN))) "-1^Did not pass valid transaction"
 Q:('$D(^VAT(394.71,SEGPTR))) "-1^Did not pass a valid segment"
 Q:($G(ROOT)="") "-1^Did not pass reference to output array"
 ;DECLARE VARIABLES
 N TMP,XTRCT,MTHD,MINPTR,GETMIN
 S XTRCT="^TMP(""VAQ-SEG"","_$J_","_TRAN_","_SEGPTR_")"
 K @XTRCT
 ;SEGMENT NOT PASSED IN PDX
 Q:('$D(^VAT(394.62,"A-SEGMENT",TRAN,SEGPTR))) "-1^Transaction did not contain information for segment"
 ;DISPLAY READY
 S TMP=$D(^VAT(394.62,"A-DISPLAY",TRAN,SEGPTR))
 Q:(TMP) $$EXTARR^VAQUPD25(TRAN,SEGPTR,ROOT,OFFSET)
 ;GET METHOD TO BUILD DISPLAY ARRAY
 S MTHD=$G(^VAT(394.71,SEGPTR,"DRTN"))
 Q:(MTHD="") "-1^Display method did not exist for segment"
 ;GET EXTRACTION ARRAY
 S TMP=$$EXTARR^VAQUPD25(TRAN,SEGPTR,XTRCT)
 I (TMP) K @XTRCT Q TMP
 ;DETERMINE IF MINIMUM DATA NEEDS TO BE PLACED IN EXTRACTION ARRAY
 ;  THIS IS DONE FOR INFO FROM A 1.0 SITE
 S TMP=$P($G(^VAT(394.71,SEGPTR,0)),"^",2)
 S GETMIN=$S((TMP="PDX*MPL"):1,(TMP="PDX*MPS"):1,1:0)
 I ((GETMIN)&((+$P($G(^VAT(394.61,TRAN,0)),"^",7))=1)) D  I (TMP) K @XTRCT Q TMP
 .;GET POINTER TO MINIMUM SEGMENT
 .S MINPTR=+$O(^VAT(394.71,"C","PDX*MIN",""))
 .I ('MINPTR) S TMP="-1^Version 1.0 transaction did not contain minimum patient information" Q
 .;MIN SEGMENT NOT PASSED IN PDX
 .I ('$D(^VAT(394.62,"A-SEGMENT",TRAN,MINPTR))) S TMP="-1^Version 1.0 transaction did not contain minimum patient information" Q
 .;PUT MINIMUM DATA INTO EXTRACTION ARRAY
 .S TMP=$$EXTARR^VAQUPD25(TRAN,MINPTR,XTRCT)
 .S:(TMP) TMP="-1^Unable to extract minimum patient information from version 1.0 transaction"
 ;BUILD DISPLAY
 X ("S TMP="_MTHD)
 K @XTRCT
 Q TMP
