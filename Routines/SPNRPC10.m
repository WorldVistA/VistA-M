SPNRPC10 ;SD/WDE - Returns CPT'S BEFORE onset;JUL 23, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ;
 ;
 ;
COL(ROOT,ICN,UPTODATE) ;
 ;Gets ALL CPTS FOR IMPAIRMENTS TAB
 ;  Input:
 ;  DFN=DFN
 ;  note that I first collect all from spnrpc4 then cut out
 ;  the un-wanted codes and trim the file from the beginning 
 ;  of time to the outcomes date.
 ;exclude this series in the gathering
 K ^TMP($J)
 S ROOT=$NA(^TMP($J))
 S SPNCUTDT=2
 S CNT=0
 S DFN=$$FLIP^SPNRPCIC(ICN)
 Q:DFN=""  ;NO ICN FOR PATIENT
 ;
JUMPTO ;
 D JUMPIN1^SPNRPC4
 ;clean out ICD'S from TMP($J,"UTIL"
 K ^TMP($J,"UTIL","ICD")
 K ^TMP($J,"CPT")
 K ^TMP($J,"ICD")
 S X=UPTODATE D ^%DT S UPTODATE=Y
 I $G(Y)="-1" K ^TMP($J) S ^TMP($J,1)="Invalid Date Error" Q
 ;clean out the un wanted CPT'S
 ;
BUILD ;Build temp with only the ones needed
 S SUBCNT=0
 S X34=0 F  S X34=$O(^TMP($J,"UTIL","CPT",X34)) Q:(X34="")!('+X34)  S X35=0 F  S X35=$O(^TMP($J,"UTIL","CPT",X34,X35)) Q:(X35="")!('+X35)  D
 .S SPNTEST=$P($G(^TMP($J,"UTIL","CPT",X34,X35)),U,3)
 .S SPNTEST=$P(SPNTEST,"@",1)
 .S X=SPNTEST D ^%DT S SPNTEST=Y
 .I SPNTEST>UPTODATE Q
 .S SUBCNT=SUBCNT+1
 .S ^TMP($J,SUBCNT)=$G(^TMP($J,"UTIL","CPT",X34,X35))_U_"EOL999"
 K ^TMP($J,"UTIL")
 K ^TMP($J,"ICD")
 K SPNCUTDT,CNT,DFN,X,Y,G,X34,X35,SPNTEST,SUBCNT,UPTODATE
 Q
