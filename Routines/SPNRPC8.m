SPNRPC8 ;SD/WDE -Returns ICD'S excluding SCI. No cut date;JUL 23, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
COL(ROOT,ICN) ;Gets ALL ICDS FOR IMPAIRMENTS TAB EXECPT THE LISTED ONES
 ;  Input:
 ;  ICN=ICN
 ;  NO DATE RANGE ALL ICD9'S EXCEPT THE ONES IN THE ARRAY SPNECCLD
 ;exclude this series in the gathering
 K ^TMP($J)
 S ROOT=$NA(^TMP($J))
 S SPNCUTDT=2
 S CNT=0
 S SPNEXCLD(806)=""
 S SPNEXCLD(952)=""
 S SPNEXCLD(344)=""
 S SPNEXCLD(907)=""
 ;S SPNEXCLD(784)=""  ;REMOVE THIS ONE THIS IS FOR TESTING
 ;
JUMPTO ;JUMP IN WITH TODAY AS THE CUTDATE
 ;***********************************
 Q:$G(ICN)=""
 S DFN=$$FLIP^SPNRPCIC(ICN)
 Q:$G(DFN)=""
 ;**********************************
 D JUMPIN1^SPNRPC4
 ;clean out cpt's from tmp($j,"util"
 K ^TMP($J,"UTIL","CPT")
 ;clean out the unwanted CPT codes that are in array spnexcld
 ;
BUILD ;Build temp with only the ones needed
 S SUBCNT=0
 S X34=0 F  S X34=$O(^TMP($J,"ICD",X34)) Q:(X34="")!('+X34)  D
 .S SPNTEST=$P($G(^TMP($J,"ICD",X34)),U,2)
 .S SPNTEST=$P(SPNTEST,".",1)
 .I $D(SPNEXCLD(SPNTEST))=1 K ^TMP($J,"ICD",X34) Q
 .S SUBCNT=SUBCNT+1
 .S ^TMP($J,SUBCNT)=$G(^TMP($J,"ICD",X34))_"EOL999"
 K ^TMP($J,"UTIL")  ;MAY 31 05
 K ^TMP($J,"CPT")  ;MAY 31 05
 K ^TMP($J,"ICD")  ;MAY 31 05
 K CNT,DFN,ICN,SPNCUTDT,SPNEXCLD,SPNTEST,SUBCNT,X34
 Q
