IBACCRPT ;EDE/JWS - RPC FOR IENS, ENCOUNTER DATA, and WRITEBACK FOR TAS ACC CLAIMS RECONCILIATION REPORT;
 ;;2.0;INTEGRATED BILLING;**770**;21-MAR-94;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to ENCODE^XLFJSON in ICR #6682
 Q
 ;
GET(RESULT,ARG) ;RPC ; ACC Reconciliation - get list of encounter iens to extract
 ;
 N IBIEN,CT,STOP,IBSTT,IBSAVE,STOPCT
 K RESULT
 D DTNOLF^DICRW
 ; STOPCT is ienLimit if needed
 S STOPCT=+$G(ARG("IENLIMIT"))
 ;set IBSTT = time stamp to check, needs to complete in < 30 seconds due to TAS-API express timeout
 S IBSTT=$P($H,",",2)
 S IBSAVE("site")=$P($$SITE^VASITE(),"^",3)
 ; "E" index in file 364.9 contains X12 file entries that are flagged READY FOR POWER BI EXTRACT, field .21 - this field is reset in WriteBack
 S IBIEN="",STOP=0 F  S IBIEN=$O(^IBA(364.9,"E",1,IBIEN)) Q:IBIEN=""  D  Q:STOP  I STOPCT,CT>(STOPCT-1) Q
 . S CT=$G(CT)+1
 . S IBSAVE("ACCiens",CT,"ien")=IBIEN
 . I ($P($H,",",2)-IBSTT)>25 S STOP=1
 . Q
 D ENCODE^XLFJSON("IBSAVE","RESULT")   ;ICR #6682 (Supported)
 D FINISH
 Q
 ;
 ;
FINISH ; enclose message in '[ ]' when a Bundle
 N X
 I $G(RESULT(1))=""!($G(RESULT(1))="{}") S RESULT(1)="[{}]" Q
 S RESULT(1)="["_RESULT(1)
 S X=$O(RESULT("A"),-1)
 S RESULT(X)=RESULT(X)_"]"
 Q
 ;
GET1(RESULT,ARG) ;get claim data for ACC Power BI report
 ;
 N IBSAVE,IBDATA,X,IBDATA2
 K RESULT
 D DTNOLF^DICRW
 ; Get IEN for ACC X12 CLAIMS file 364.9
 S IBIEN=$G(ARG("IEN364.9"))
 I IBIEN="" S IBIEN=$G(ARG("IEN3649"))
 I IBIEN="" D FINISH Q
 I '$D(^IBA(364.9,IBIEN,0)) D FINISH Q
 ; Collect Information
 S IBDATA=$G(^IBA(364.9,IBIEN,0)),IBDATA2=$G(^(2))
 S X=$$GET1^DIQ(364.9,IBIEN_",",.01,"I") I X'="" S IBSAVE("DateReceived")=$S($E(X)=3:20,1:19)_$E(X,2,3)_"-"_$E(X,4,5)_"-"_$E(X,6,7)
 S IBSAVE("Site")=$P($$SITE^VASITE(),"^",3)
 S IBSAVE("Division")=$P(IBDATA,"^",20)
 S IBSAVE("VistaClaim")=$$GET1^DIQ(364.9,IBIEN_",",2.02)
 S IBSAVE("PayerEDIclaimNum")=$P(IBDATA,"^",15)
 S IBSAVE("FormType")=$P(IBDATA,"^",5)_"-"_$S($P(IBDATA,"^",6)=2:"P",$P(IBDATA,"^",6)=3:"I",$P(IBDATA,"^",6)=7:"D",1:"")
 S IBSAVE("Insurance")=$$GET1^DIQ(364.9,IBIEN_",",.17)
 ; total charges field 201 from file 399
 S IBSAVE("AmountBilled")=$S(IBSAVE("VistaClaim")="":"",1:$$GET1^DIQ(399,$P(IBDATA2,"^",2)_",",201))
 S IBSAVE("Authorized")=$$GET1^DIQ(399,$P(IBDATA2,"^",2)_",",11)
 S X=$$GET1^DIQ(399,$P(IBDATA2,"^",2)_",",10,"I") I X'="" S IBSAVE("AuthorizedDate")=$S($E(X)=3:20,1:19)_$E(X,2,3)_"-"_$E(X,4,5)_"-"_$E(X,6,7)
 S IBSAVE("WorklistGroup")=$$GET1^DIQ(364.9,IBIEN_",",3.02,"I")
 D ENCODE^XLFJSON("IBSAVE","RESULT")   ;ICR #6682 (Supported)
 D FINISH
 Q
 ;
PUT(RESULT,ARG) ; successful posting of ACC X12 encounter data to Sql database for PowerBI ACC Reconciliation report
 ;; update data field in file 364.9
 N IBIEN,RES
 K RESULT
 D DTNOLF^DICRW
 ; Get IEN for Claim File 399
 S IBIEN=$G(ARG("IEN364.9")) ;$G not necessary for VistaLink provides the parameters defined
 I IBIEN="" S IBIEN=$G(ARG("IEN3649"))
 ; execute code to set claim status as received at FSC
 S RES=1
 I IBIEN="" S RES=0
 I '$D(^IBA(364.9,IBIEN,0)) S RES=0
 I RES=1 D
 . N DA,D0,DR,DIE,DIC
 . S DA=IBIEN
 . S DR=".21////0"
 . S DIE="^IBA(364.9,"
 . D ^DIE
 . Q
 S RES("site")=$P($$SITE^VASITE(),"^",3)
 S RES("ien")=IBIEN
 S RES("status")=RES  ;result of update
 D ENCODE^XLFJSONE("RES","RESULT")   ;ICR #6682 (Supported)
 D FINISH
 Q
 ;
