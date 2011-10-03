SPNJRPC6 ;BP/JAS - Returns Current Inpatients data ;JUL 28, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; API $$FLIP^SPNRPCIC is part of Spinal Cord Version 3.0
 ; API GATHER^SPNLGICI is part of Spinal Cord version 2.0
 ;
 ; Parm values:
 ;     RETURN is the sorted data from the earliest date of listing
 ;     ICNLST is the list of patient ICNs to process
 ;
 ;Returns: ^TMP($J)
 ;
COL(RETURN,ICNLST) ;
 ;***************************
 S RETURN=$NA(^TMP($J)),RETCNT=1
 K ^TMP($J),^TMP("SPN",$J)
 F ICNNM=1:1:$L(ICNLST,"^") S ICN=$P(ICNLST,"^",ICNNM) D IN
 D FMTRET
 K AICN,DFN,ICN,ICNNM,RETCNT,PATLIST,SPN
 Q
IN Q:$G(ICN)=""
 S DFN=$$FLIP^SPNRPCIC(ICN)
 Q:$G(DFN)=""
 ;***************************
 D GATHER^SPNLGICI(DFN,"")
 Q
FMTRET ;
 N WARD,PAT,ZAD,ADMINFO,CURRLOS,FYTDLOS,ROOMBED,DIAG
 S ^TMP($J,RETCNT)="TOT999^Total Inpatients:  "_+$G(^TMP("SPN",$J,"CI"))_"^EOL999"
 S RETCNT=RETCNT+1
 S ^TMP($J,RETCNT)="HDR999^NAME^LAST FOUR^WARD^ADMISSION DATE^CURR LOS^FYTD LOS^ADM DX^ROOM-BED^EOL999"
 S RETCNT=RETCNT+1
 S WARD=""
 F  S WARD=$O(^TMP("SPN",$J,"CI",WARD)) Q:WARD=""  D
 . S PAT=""
 . F  S PAT=$O(^TMP("SPN",$J,"CI",WARD,PAT)) Q:PAT=""  D
 . . S ADMINFO=^TMP("SPN",$J,"CI",WARD,PAT)
 . . S ZAD=$P(ADMINFO,U,1)
 . . S CURRLOS=$P(ADMINFO,U,2)
 . . S FYTDLOS=$P(ADMINFO,U,3)
 . . S ROOMBED=$P(ADMINFO,U,4)
 . . S DIAG=$P(ADMINFO,U,5)
 . . S ^TMP($J,RETCNT)=$P(PAT,U,1)_"^"_$P(PAT,U,2)_"^"_WARD_"^"_$E(ZAD,4,5)_"/"_$E(ZAD,6,7)_"/"_$E(ZAD,2,3)_"^"_$FN(CURRLOS,",")_"^"_$FN(FYTDLOS,",")_"^"_DIAG_"^"_ROOMBED_"^EOL999"
 . . S RETCNT=RETCNT+1
 . . Q
 . Q
 Q
