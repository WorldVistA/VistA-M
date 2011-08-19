SPNJRPC0 ;BP/JAS - Returns list of ICD/CPT LONG DESCRIPTIONS ;JUN 16, 2009
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; References to ^ICD9 supported by IA# 5388
 ; Reference to API ICDDX^ICDCODE supported by IA# 3990
 ; Reference to API ICDD^ICDCODE supported by IA# 3990
 ; References to ^ICPT supported by IA# 2815
 ; Reference to API CPTD^ICPTCOD supported by IA# 1995
 ;
 ; Parm values:
 ;       TYPE will be either ICD or CPT.
 ;
 ; Returns: ^TMP($J)
 ;
COL(RETURN,TYPE) ;
 ;
 K ^TMP($J)
 S RETURN=$NA(^TMP($J)),RETCNT=1
 I TYPE="CPT" D CPT
 I TYPE="ICD" D ICD
 K CODE,IEN,LINE,RETCNT,TXT,DIAG
 Q
 ;
 ;
ICD ;
 S CODE=""
 F  S CODE=$O(^ICD9("AB",CODE)) Q:CODE=""  D
 . ;JAS - 05/14/08 - DEFECT 1090
 . ;S IEN="",IEN=$O(^ICD9("AB",CODE,IEN))
 . ;JAS 6/16/09 - DEFECT 1137 - Removed direct reads of CPT/ICD files to API usage
 . ;S IEN=0,IEN=$O(^ICD9("AB",CODE,IEN))
 . ;Q:IEN=""
 . ;S DIAG=$P($G(^ICD9(IEN,0)),"^",3)
 . S SPNYAPI=$$ICDDX^ICDCODE(CODE,"","","")
 . Q:$P(SPNYAPI,"^")=-1
 . S DIAG=$P(SPNYAPI,"^",4)
 . ;S TXT=$G(^ICD9(IEN,1))
 . ;I TXT="" S TXT="No description on file"
 . S ICDD=$$ICDD^ICDCODE(CODE,"SPNARY","")
 . I SPNARY(1)="" S TXT="No description on file"
 . S TXT=SPNARY(1)
 . S ^TMP($J,RETCNT)=CODE_"^"_TXT_"^"_DIAG_"^EOL999"
 . S RETCNT=RETCNT+1
 K SPNYAPI,ICDD,SPNARY
 Q
CPT ;
 ;JAS - 05/14/08 - DEFECT 1090
 ;S CODE=""
 S CODE=0
 F  S CODE=$O(^ICPT("B",CODE)) Q:CODE=""  D
 . S ^TMP($J,RETCNT)="CPT999^"_CODE_"^EOL999",RETCNT=RETCNT+1
 . D CPTD^ICPTCOD(CODE,"SPNARRAY")
 . I '$D(SPNARRAY) D  Q
 . . S ^TMP($J,RETCNT)="No description on file^EOL999"
 . . S RETCNT=RETCNT+1
 . S LINE=""
 . F  S LINE=$O(SPNARRAY(LINE)) Q:LINE=""  D
 . . S TXT=SPNARRAY(LINE)
 . . Q:TXT=""!(TXT=" ")
 . . S ^TMP($J,RETCNT)=TXT_"^EOL999"
 . . S RETCNT=RETCNT+1
 . . Q
 . K SPNARRAY
 Q
