SPNJRPSC ;BP/JAS - Returns list of ICNs who match Service Connection criteria ;JUL 28, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; Reference to ^DTP(D0,"MPI" supported by IA# 4938
 ; Reference to API ELIG^VADPT supported by IA# 10061
 ;
 ; Parm values:
 ;     BPER is the beginning or low range percentage of Service Connection
 ;     EPER is the ending or high range percentage of Service Connection
 ;     ^TMP($J) is the return value with list of ICNs
 ;
 ; Returns: ^TMP($J)
 ;
COL(RETURN,BPER,EPER) ;
 ;***************************
 S RETURN=$NA(^TMP($J)),RETCNT=1
 K ^TMP($J),^TMP("SPN",$J)
 ;JAS - 05/15/08 - DEFECT 1090
 ;S DFN=""
 S DFN=0
 F  S DFN=$O(^DPT(DFN)) Q:DFN=""!(DFN'?1N.N)  D IN
 D OUT
 K DFN,ICN,RETCNT,SPER,VAEL
 Q
IN ;
 D ELIG^VADPT
 I $D(VAEL(3)),$P(VAEL(3),"^",1)=1 D
 . S SPER=$P(VAEL(3),"^",2)
 . Q:SPER=""
 . Q:SPER<BPER
 . Q:SPER>EPER
 . S ICN=$P($G(^DPT(DFN,"MPI")),"^",1)
 . Q:ICN=""
 . S ^TMP("SPN",$J,ICN)=SPER
 K VAEL
 Q
OUT ;
 S ICN=""
 F  S ICN=$O(^TMP("SPN",$J,ICN)) Q:ICN=""  D
 . S SPER=^TMP("SPN",$J,ICN)
 . S ^TMP($J,RETCNT)=ICN_"^"_SPER_"^EOL999"
 . S RETCNT=RETCNT+1
 Q
