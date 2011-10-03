VAQCON94 ;ALB/JRP - MESSAGE CONSTRUCTION;22-APR-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
XMIT10(TRANPTR,MESSNUM,ARRAY,OFFSET) ;BUILD A 1.0 MESSAGE
 ;INPUT  : TRANPTR - Pointer to VAQ - TRANSACTION file (full global ref)
 ;         MESSNUM - Message number to place message into
 ;                   (if 0, message will be placed in ARRAY)
 ;         ARRAY - Array to store message in (full global reference)
 ;         OFFSET - Where to begin placing information (defaults to 0)
 ;OUTPUT  : N - Number of lines in message
 ;         -1^Error_Text - Error
 ;NOTES   : If MESSNUM=0, then the message will be placed into
 ;            ARRAY(LineNumber)=Line_of_info
 ;          If MESSNUM>0 then the message will be placed into
 ;            ^XMB(3.9,MESSNUM,2,LineNumber,0)=Line_of_info
 ;        : The first subscript in ROOT must be a pointer to the
 ;          transaction.  The second subscript in ROOT must be the
 ;          segment abbreviation.  This is required to identify the
 ;          segments for the transaction.
 ;            ROOT(TransactionPointer,SegmentAbbreviation)
 ;        : Segments required for a 1.0 message will be extracted by
 ;          this routine.  This is done to ensure that encryption has
 ;          been turned off.
 ;
 ;CHECK INPUT
 Q:('(+$G(TRANPTR))) "-1^Did not pass pointer to VAQ - TRANSACTION file"
 S MESSNUM=+$G(MESSNUM)
 I (('MESSNUM)&($G(ARRAY)="")) Q "-1^Did not pass message number or reference to output array"
 I (MESSNUM) Q:('$D(^XMB(3.9,MESSNUM))) "-1^Valid message number not passed"
 S OFFSET=+$G(OFFSET)
 N TMP,DFN,SEGPTR,LINE,VAQIGNC,ROOT,STATUS,TYPE
 K ^TMP("VAQ-10",$J)
 S LINE=OFFSET
 ;IGNORE ENCRYPTION RULES (1.0 DOES NOT SUPPORT IT)
 S VAQIGNC=1
 ;GET STATUS
 S TMP=$$STATYPE^VAQCON1(TRANPTR)
 S STATUS=$P(TMP,"^",1)
 S TYPE=$P(TMP,"^",2)
 Q:(STATUS="-1") TMP
 Q:((STATUS="VAQ-AUTO")!(STATUS="VAQ-PROC")!(STATUS="VAQ-TUNSL")) "-1^Transaction does not require a PDX message in version 1.0"
 Q:((STATUS="VAQ-RTRNS")!(STATUS="VAQ-UNACK")) "-1^Transmission does not have a version 1.0 equivalent"
 Q:(TYPE="REC") "-1^Transaction is being received, not transmitted"
 ;GET PATIENT
 S DFN=+$P($G(^VAT(394.61,TRANPTR,0)),"^",3)
 I ((STATUS="VAQ-RSLT")!(STATUS="VAQ-UNSOL")) Q:('DFN) "-1^Transaction did not contain pointer to PATIENT file"
 ;EXTRACT INFORMATION (IF NEEDED)
 I ((STATUS="VAQ-RSLT")!(STATUS="VAQ-UNSOL")) D
 .;EXTRACT MINIMUM DATA
 .S ROOT="^TMP(""VAQ-10"",$J,""PDX*MIN"")"
 .S SEGPTR=$O(^VAT(394.71,"C","PDX*MIN",""))
 .S TMP=$$SEGXTRCT^VAQDBI(TRANPTR,"",ROOT,SEGPTR)
 .Q:(TMP<0)
 .;EXTRACT MAS DATA
 .S ROOT="^TMP(""VAQ-10"",$J,""PDX*MAS"")"
 .S SEGPTR=$O(^VAT(394.71,"C","PDX*MAS",""))
 .S TMP=$$SEGXTRCT^VAQDBI(TRANPTR,"",ROOT,SEGPTR)
 .Q:(TMP<0)
 .;EXTRACT PHARMACY DATA
 .S ROOT="^TMP(""VAQ-10"",$J,""PDX*MPL"")"
 .S SEGPTR=$O(^VAT(394.71,"C","PDX*MPL",""))
 .S TMP=$$SEGXTRCT^VAQDBI(TRANPTR,"",ROOT,SEGPTR)
 I (TMP<0) K ^TMP("VAQ-10",$J) Q TMP
 ;BUILD HEADER BLOCK
 S TMP=$$HEAD10^VAQCON99(TRANPTR,MESSNUM,ARRAY,LINE)
 I (TMP<0) K ^TMP("VAQ-10",$J) Q TMP
 S LINE=LINE+TMP
 ;BUILD DATA BLOCKS
 S ROOT="^TMP(""VAQ-10"",$J)"
 I ((STATUS="VAQ-RSLT")!(STATUS="VAQ-UNSOL")) D
 .S TMP=$$DATA10^VAQCON97(TRANPTR,ROOT,MESSNUM,ARRAY,LINE)
 .Q:(TMP<0)
 .S LINE=LINE+TMP
 I (TMP<0) K ^TMP("VAQ-10",$J) Q TMP
 K ^TMP("VAQ-10",$J)
 Q (LINE-OFFSET)
