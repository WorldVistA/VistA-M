SPNJRPFB ;BP/JAS - Returns list of ICNs who match Fee Basis Criteria ;JUL 28, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; Reference to ^DPT(D0,"B" supported by IA# 10035
 ; Reference to ^DPT(D0,"MPI" supported by IA# 4938
 ; Reference to API $$AUTHL^FBUTL supported by IA# 4396
 ; API $$FLIP^SPNRPCIC is part of Spinal Cord Version 3.0
 ;
 ; Parm values:
 ;     FDATE is the start date for period
 ;     TDATE is the end date for period
 ;     ICNLST is the group of ICNs to search from
 ;     ^TMP($J) is the return value with list of ICNs
 ;
 ; Returns: ^TMP($J)
 ;
COL(RETURN,FDATE,TDATE,ICNLST) ;
 ;***************************
 S RETURN=$NA(^TMP($J)),RETCNT=1
 K ^TMP($J),^TMP("SPN",$J)
 S X=FDATE S %DT="T" D ^%DT S FDATE=Y
 S X=TDATE S %DT="T" D ^%DT S TDATE=Y
 F ICNNM=1:1:$L(ICNLST,"^") S ICN=$P(ICNLST,"^",ICNNM) D IN
 D OUT,CLNUP
 Q
IN ;
 Q:$G(ICN)=""
 S DFN=$$FLIP^SPNRPCIC(ICN)
 Q:$G(DFN)=""
 K SPNARRAY
 S FBCNT=$$AUTHL^FBUTL(DFN,,,"SPNARRAY")
 Q:$P(FBCNT,"^",1)'>0
 S GOOD=0
 F I=1:1:FBCNT D  Q:GOOD
 . F J=0:1 D  Q:GOOD!(X>SPNARRAY(I,"TDT"))
 . . S X=0
 . . S X1=SPNARRAY(I,"FDT"),X2="+"_J
 . . D C^%DTC
 . . I X'<FDATE&(X'>TDATE) D  Q
 . . . S ICN=$P($G(^DPT(DFN,"MPI")),"^",1)
 . . . Q:ICN=""
 . . . S ^TMP("SPN",$J,ICN)=""
 . . . S GOOD=1
 Q
OUT ;
 S ICN=""
 F  S ICN=$O(^TMP("SPN",$J,ICN)) Q:ICN=""  D
 . S ^TMP($J,RETCNT)=ICN_"^EOL999"
 . S RETCNT=RETCNT+1
 Q
CLNUP ;
 K %DT,NAME,DFN,FBCNT,SPNARRAY,GOOD,ICN,RETCNT,X,X1,X2,Y,I,J,ICNNM
 Q
