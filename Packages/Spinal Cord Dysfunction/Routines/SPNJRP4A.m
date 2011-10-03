SPNJRP4A ;BP/JAS - Returns Clinic Stops ;JUL 28, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; Reference to ^DIC(40.7,"B" supported by IA# 4929
 ; Additional references to ^DIC(40.7 supported by IA# 557
 ;
 ; Parm values:
 ;     RETURN is the sorted data based on clinic stop name
 ;
 ; Returns: ^TMP($J)
 ;
COL(RETURN) ;
 ;***************************
 S RETURN=$NA(^TMP($J)),RETCNT=1
 K ^TMP($J)
 S CSNAM=""
 F  S CSNAM=$O(^DIC(40.7,"B",CSNAM)) Q:CSNAM=""  D
 . ;JAS - 05/14/08 - DEFECT 1090
 . ;S CSDA=""
 . S CSDA=0
 . F  S CSDA=$O(^DIC(40.7,"B",CSNAM,CSDA)) Q:CSDA=""  D
 . . Q:'$D(^DIC(40.7,CSDA,0))
 . . S CLNM=$P(^DIC(40.7,CSDA,0),"^",2)
 . . S STAT="ACTIVE"
 . . S TERMDT=$P(^DIC(40.7,CSDA,0),"^",3)
 . . I +TERMDT S STAT="INACTIVE"
 . . S ^TMP($J,RETCNT)=CSNAM_"^"_CLNM_"^"_STAT_"^EOL999"
 . . S RETCNT=RETCNT+1
 K CLNM,CSDA,CSNAM,RETCNT,STAT,TERMDT
 Q
