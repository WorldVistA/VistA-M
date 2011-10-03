SPNJRPC7 ;BP/JAS - Returns Specialty PTF codes ;JUL 28, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; Reference to ^DIC(42.4,"B" supported by IA #4946
 ;
 ; Parm values:
 ;     RETURN is the sorted data from the earliest date of listing
 ;     SPEC is a dummy field to comply with Java RPC framework
 ;
 ; Returns: ^TMP($J)
 ;
COL(RETURN,SPEC) ;
 ;***************************
 S RETURN=$NA(^TMP($J)),RETCNT=1
 K ^TMP($J)
 S SDA=""
 F  S SDA=$O(^DIC(42.4,"B",SDA)) Q:SDA=""  D
 . S ^TMP($J,RETCNT)=SDA_"^EOL999"
 . S RETCNT=RETCNT+1
 K RETCNT,SDA
 Q
