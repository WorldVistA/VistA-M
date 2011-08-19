SPNJRPCE ;BP/JAS - Returns most recent Eligibility Enrollment Application ;JUL 28, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; References to ^DGEN supported by IA# 4947
 ; API $$FLIP^SPNRPCIC is part of Spinal Cord Version 3.0
 ;
 ; Parm values:
 ;     RETURN is the eligibility priority for a given patient
 ;
 ; Returns: ^TMP($J)
 ;
COL(RETURN,ICN) ;
 ;***************************
 K RETURN
 Q:$G(ICN)=""
 S DFN=$$FLIP^SPNRPCIC(ICN)
 Q:$G(DFN)=""
 ;***************************
 Q:'$D(^DGEN(27.11,"C",DFN))
 S EDA="",EDA=$O(^DGEN(27.11,"C",DFN,EDA),-1)
 Q:'$D(^DGEN(27.11,EDA,0))
 S PRIO=$P(^DGEN(27.11,EDA,0),"^",7)
 I PRIO'="" S PRIO="GROUP "_PRIO
 S SUBG=$P(^DGEN(27.11,EDA,0),"^",12)
 S SUBG=$S(SUBG=1:"a",SUBG=3:"c",SUBG=5:"e",SUBG=7:"g",1:"")
 S RETURN($J)=PRIO_"^"_SUBG_"^EOL999"
 K DFN,EDA,PRIO,SUBG
 Q
