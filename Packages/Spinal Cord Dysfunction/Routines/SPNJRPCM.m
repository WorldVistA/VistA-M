SPNJRPCM ;BP/JAS - Returns Sites where Patient has been treated ;FEB 05, 2007
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; References to ^DGCN(391.91 supported by IA# 4943
 ; Reference to file #4 supported by IA# 10090
 ; API $$FLIP^SPNRPCIC is part of Spinal Cord Version 3.0
 ;
 ; Parm values:
 ;     RETURN  is the sorted data from the earliest date of listing
 ;     ICN     is ICN of the patient to process
 ;
 ; Returns: ^TMP($J)
 ;
COL(RETURN,ICN) ;
 ;
 ;***************************
 K ^TMP($J),^TMP("SPN",$J)
 S RETURN=$NA(^TMP($J)),RETCNT=1
 ;***************************
 Q:$G(ICN)=""
 S DFN=$$FLIP^SPNRPCIC(ICN)
 Q:$G(DFN)=""
 ;***************************
 D IN,OUT
 K DFN,MDATE,RDATE,RETCNT,RSITE,SPNIEN,RDA
 Q
IN I '$D(^DGCN(391.91,"B",DFN)) S ^TMP($J,RETCNT)="Pt has not been treated at any other VA site.^EOL999" Q
 S SPNIEN=0
 F  S SPNIEN=$O(^DGCN(391.91,"B",DFN,SPNIEN)) Q:'+SPNIEN  D
 . S RDA=$P(^DGCN(391.91,SPNIEN,0),U,2)
 . S RSITE=$$GET1^DIQ(4,RDA_",",.01)
 . S MDATE=$P($G(^DGCN(391.91,SPNIEN,0)),U,3)
 . I MDATE="" S MDATE=0
 . S RDATE=$$FMTE^XLFDT($P($G(^DGCN(391.91,SPNIEN,0)),U,3),"5DZ")
 . I RDATE="" S RDATE="DATE IS MISSING"
 . S ^TMP("SPN",$J,MDATE,SPNIEN)=RSITE_"^"_RDATE
 Q
OUT S ^TMP($J,RETCNT)="HDR999^Pt Has Been Treated at^Date Last Treated^EOL999",RETCNT=RETCNT+1
 S MDATE=""
 F  S MDATE=$O(^TMP("SPN",$J,MDATE),-1) Q:MDATE=""  D
 . S SPNIEN=""
 . F  S SPNIEN=$O(^TMP("SPN",$J,MDATE,SPNIEN)) Q:SPNIEN=""  D
 . . S ^TMP($J,RETCNT)=^TMP("SPN",$J,MDATE,SPNIEN)_"^EOL999"
 . . S RETCNT=RETCNT+1
 Q
