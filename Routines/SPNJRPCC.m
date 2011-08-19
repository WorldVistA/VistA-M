SPNJRPCC ;BP/JAS - Returns SCI Coordinator Providers from New Person file ;JUL 28, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; Reference to file 200 supported by IA #10060
 ;
 ; Parm values:
 ;     RETURN is the sorted data from the earliest date of listing
 ;
 ; Returns: ^TMP($J)
 ;
COL(RETURN,CPSRCH) ;
 ;***************************
 I '$D(CPSRCH) S CPSRCH=""
 S RETURN=$NA(^TMP($J)),RETCNT=1
 K ^TMP($J)
 D LIST^DIC(200,"",.01,"Q","","",CPSRCH,"B")
 S NPDA=""
 F  S NPDA=$O(^TMP("DILIST",$J,1,NPDA)) Q:NPDA=""  D
 . S NPNAM=^TMP("DILIST",$J,1,NPDA)
 . S ^TMP($J,RETCNT)=NPNAM_"^EOL999"
 . S RETCNT=RETCNT+1
 K NPDA,NPNAM,RETCNT,^TMP("DILIST",$J)
 Q
