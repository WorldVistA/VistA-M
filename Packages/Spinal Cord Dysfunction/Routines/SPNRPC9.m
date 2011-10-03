SPNRPC9 ;SD/WDE -Returns ICD'S BEFORE onset;Mar 07, 2007
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
COL(ROOT,ICN,UPTODATE) ;Gets ALL ICDS FOR IMPAIRMENTS TAB EXECPT THE LISTED ONES
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
 ;
JUMPTO ;
 ;****************************************
 Q:$G(ICN)=""
 S DFN=$$FLIP^SPNRPCIC(ICN)
 I DFN="" S ^TMP($J,1)="No ICN on file" Q
 ;*****************************************
 D JUMPIN1^SPNRPC4
 ;clean out cpt's from tmp($j,"util"
 K ^TMP($J,"UTIL","CPT")
 S X=UPTODATE D ^%DT S UPTODATE=Y
 I $G(Y)="-1" K ^TMP($J) S ^TMP($J,1)="Invalid Date Error" Q
 S UPTODATE=9999999-UPTODATE
 ;clean out the un wanted CPT'S
 ;
BUILD ;Build temp with only the ones needed
 S SUBCNT=0
 S X34=0 F  S X34=$O(^TMP($J,"UTIL","ICD",X34)) Q:(X34="")!('+X34)  S X35=0 F  S X35=$O(^TMP($J,"UTIL","ICD",X34,X35)) Q:(X35="")!('+X35)  D
 .S SPNTEST=$P($G(^TMP($J,"UTIL","ICD",X34,X35)),U,2)
 .S SPNTEST=$P(SPNTEST,".",1)
 .I X34<UPTODATE Q
 .S SUBCNT=SUBCNT+1
 .S ^TMP($J,SUBCNT)=$G(^TMP($J,"UTIL","ICD",X34,X35))_"EOL999"
 K ^TMP($J,"CPT")  ;6/1/2005
 K ^TMP($J,"ICD")  ;6/1/2005
 K ^TMP($J,"UTIL")  ;REMOVE TEMP SUB GLOBAL
KILL ;10/10/2006
 K CNT,DFN,SPNCUTDT,SPNTEST,SUBCNT,X,X34,X35,Y
