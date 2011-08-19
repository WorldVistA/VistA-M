SPNJRPE2 ;BP/JAS - Returns most recent Means and Eligibility info for all patients ;JUL 28, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; References to ^DGEN(27.11 supported by IA# 4947
 ; Reference to ^DG(408.32 supported by IA# 4941
 ; API $$FLIP^SPNRPCIC is part of Spinal Cord Version 3.0
 ;
 ; Parm values:
 ;     ICNLST is the list of patient ICNs to process
 ;     RETURN is the eligibility priority and means for a given patient
 ;
 ; Returns: ^TMP($J)
 ;
COL(RETURN,ICNLST) ;
 ;***************************
 K ^TMP($J)
 S RETURN=$NA(^TMP($J)),RETCNT=0
 F ICNNM=1:1:$L(ICNLST,"^") S ICN=$P(ICNLST,"^",ICNNM) D IN
 D CLNUP
 Q
IN ;
 Q:$G(ICN)=""
 S DFN=$$FLIP^SPNRPCIC(ICN)
 Q:$G(DFN)=""
 ;***************************
 Q:'$D(^DGEN(27.11,"C",DFN))
 S EDA="",EDA=$O(^DGEN(27.11,"C",DFN,EDA),-1)
 Q:'$D(^DGEN(27.11,EDA,0))
 S PRIO=$P(^DGEN(27.11,EDA,0),"^",7)
 I PRIO'="" S PRIO="GROUP "_PRIO
 S MTS=""
 I $D(^DGEN(27.11,EDA,"E")) D
 . S MTSDA=$P(^DGEN(27.11,EDA,"E"),"^",14)
 . I MTSDA'="" D
 . . S MTS=$P($G(^DG(408.32,MTSDA,0)),"^",1)
 S ^TMP($J,RETCNT)=PRIO_"^"_MTS_"^"_ICN_"^EOL999"
 S RETCNT=RETCNT+1
 Q
CLNUP ;
 K AICN,DFN,EDA,ICN,ICNNM,MTS,MTSDA,PATLIST,PRIO,RETCNT,SPN
 Q
