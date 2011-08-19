SPNJRPC8 ;BP/JAS - Returns Patient addresses for mailing labels ;JUL 28, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; Reference to ^DPT(D0,0 supported by IA #998
 ; Reference to APIs ADD^VADPT & KVAR^VADPT supported by IA #10061
 ; API $$FLIP^SPNRPCIC is part of Spinal Cord Version 3.0
 ;
 ; Parm values:
 ;     RETURN is the sorted data from the earliest date of listing
 ;     ICNLST is the list of patient ICNs to process
 ;
 ; Returns: ^TMP($J)
 ;
COL(RETURN,ICNLST) ;
 ;***************************
 S RETURN=$NA(^TMP($J)),RETCNT=1
 K ^TMP($J),^TMP("SPN",$J)
 F ICNNM=1:1:$L(ICNLST,"^") S ICN=$P(ICNLST,"^",ICNNM) D IN
 D CLNUP
 Q
IN Q:$G(ICN)=""
 S DFN=$$FLIP^SPNRPCIC(ICN)
 Q:$G(DFN)=""
 ;***************************
 S NAME=$P(^DPT(DFN,0),"^",1)
 D ADD^VADPT
 S ADD1=VAPA(1),ADD2=VAPA(2),ADD3=VAPA(3)
 S CITY=VAPA(4),STATE=$P(VAPA(5),"^",2),ZIP=VAPA(6)
 S ^TMP($J,RETCNT)=NAME_"^"_ADD1_"^"_ADD2_"^"_ADD3_"^"_CITY_"^"_STATE_"^"_ZIP_"^EOL999"
 S RETCNT=RETCNT+1
 Q
CLNUP ;
 D KVAR^VADPT
 K VAPA  ;WDE
 K ADD1,ADD2,ADD3,AICN,CITY,DFN,ICN,ICNNM,MADD
 K NAME,PATLIST,RETCNT,SPN,STATE,ZIP
 Q
