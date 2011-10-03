MDAPI ; HOIFO/DP/NCA - CP API Calls ; [05-05-2003 10:28]
 ;;1.0;CLINICAL PROCEDURES;**6**;Apr 01, 2004;Build 102
 ; Description:
 ; These API's are for use by external packages communicating with CP.
 ;
 ; Integration Agreements:
 ; IA# 3378 [Subscription] Documents the APIs that external packages use to communicate with CP.
 ; IA# 3468 [Subscription] Use GMRCCP APIs.
 ;
EXTDATA(MDPROC) ; [Procedure] 
 ; Returns 0/1 for external data needed
 ; Called by Consults to determine status of consult ordered
 ;
 ; Input parameters
 ;  1. MDPROC [Literal/Required] CP Definition IEN
 ;
 Q:'$D(^MDS(702.01,+$G(MDPROC),0)) 0
 I +$P(^MDS(702.01,+$G(MDPROC),0),U,3)!($O(^(.1,0))) Q 1
 E  Q 0
 ;
ISTAT(MDARR) ; [Procedure] Called by Imaging to update status
 ; Input parameters
 ;  1. MDARR [Literal/Required] Array from Imaging
 ;
 ; Input: MDARR(0)="0^error message" or "1^success message"
 ;        MDARR(1)=TrackID  (CP;Transaction IEN)
 ;        MDARR(2)=Queue Number
 ;        MDARR(3..N)=Warnings
 N MDCON,MDCR,MDIEN,MDIENS,MDLP,MDSTAT,MDSTR,MDTIU,RESULTS
 Q:$G(MDARR(0))=""
 Q:$G(MDARR(1))=""
 Q:$P(MDARR(1),";")'="CP"
 Q:'(+$P(MDARR(1),";",2))
 S MDIEN=+$P(MDARR(1),";",2),MDIENS=MDIEN_","
 S MDSTAT=+$P(MDARR(0),"^")
 S DATA("TRANSACTION")=MDIEN
 ; Is it in error?
 I 'MDSTAT D  Q
 .D STATUS^MDRPCOT(MDIENS,2,$P(MDARR(0),"^",2))
 .S DATA("PKG")="IMAGING"
 .S DATA("MESSAGE")=$P(MDARR(0),"^",2) D RPC^MDRPCOT(.RESULTS,"ADDMSG",.DATA)
 .F MDLP=2:0 S MDLP=$O(MDARR(MDLP)) Q:'MDLP  I $G(MDARR(MDLP))'="" D
 ..S DATA("MESSAGE")=$$TRANS(MDARR(MDLP)) D RPC^MDRPCOT(.RESULTS,"ADDMSG",.DATA)
 .D IMGSTAT^MDRPCOT1(+MDIENS,2) Q
 ; Call Consults that Partial Result ready
 S MDCON=+$P(^MDD(702,MDIEN,0),"^",5),MDTIU=+$P(^(0),"^",6)
 S MDCR=$$UPDCONS^MDRPCOT1(MDCON,MDTIU)
 I +MDCR<0 D  Q
 .D STATUS^MDRPCOT(MDIENS,2,$P(MDCR,"^",2))
 .S DATA("PKG")="CONSULTS",DATA("MESSAGE")=$P(MDCR,"^",2)
 .D RPC^MDRPCOT(.RESULTS,"ADDMSG",.DATA)
 .Q
 ; Closeout the record
 D STATUS^MDRPCOT(MDIENS,3,"")
 ; Update Images Status
 D IMGSTAT^MDRPCOT1(+MDIENS,3)
 Q
 ;
ITIU(RESULTS,DFN,CONSULT,VSTRING) ; [Procedure] API for Vista Imaging
 ; This API enables VistA Imaging to retrieve/create a TIU note for
 ; a consult for attaching images to.
 ; 
 ; RESULTS(0) will equal one of the following
 ;   IEN of the TIU note if successful
 ;   or on failure one of the following status messages
 ;   -1^No patient DFN
 ;   -1^No Consult IEN
 ;   -1^No VString
 ;   -1^Error in CP transaction
 ;   -1^Unable to create CP transaction
 ;   -1^Unable to create the TIU document
 ;   -1^No such consult for this patient.
 ;
 ; Input parameters
 ;  1. RESULTS [Reference/Required] Return array
 ;  2. DFN [Literal/Required] Patient IEN
 ;  3. CONSULT [Literal/Required] Consult IEN
 ;  4. VSTRING [Literal/Optional] VString data for TIU Note (Required to create new TIU note)
 ;
 ; Variables:
 ;  MDIEN: [Private] Returns IEN from UPDATE~DIE call
 ;  MDIENS: [Private] Scratch
 ;  MDNOTE: [Private] Scratch
 ;  MDTRANS: [Private] Contains IEN of CP transaction
 ;
 ; New private variables
 NEW MDIEN,MDIENS,MDNOTE,MDTRANS
 K ^TMP($J),^TMP("MDTIUST",$J)
 N MDD,MDN,MDTIUER,MDTST,MDNEWV,MDTIUD S (MDTIUD,MDTIUER,MDTST)=""
 I '$G(DFN) S RESULTS(0)="-1^No patient DFN" Q
 I '$G(CONSULT) S RESULTS(0)="-1^No Consult IEN" Q
 ; Look for existing transaction
 S MDTIUD=$$PREV^MDRPCOT(+CONSULT,"")
 I +MDTIUD S RESULTS(0)=+MDTIUD Q
 ; No transaction, must create one for this consult
 I $G(VSTRING)="" S RESULTS(0)="-1^No VString" Q
 D CPLIST^GMRCCP(DFN,,$NA(^TMP($J)))
 S MDX="" F  S MDX=$O(^TMP($J,MDX)) Q:'MDX  I $P(^(MDX),U,5)=CONSULT D  Q
 .D NOW^%DTC S MDD=%
 .S:$L(VSTRING,";")=1 VSTRING=";"_VSTRING
 .S MDNEWV=$$GETVSTR^MDRPCOT1(DFN,VSTRING,$P(^TMP($J,MDX),U,6),MDD)
 .S MDFDA(702,"+1,",.01)=DFN
 .S MDFDA(702,"+1,",.02)=MDD
 .S MDFDA(702,"+1,",.03)=DUZ
 .S MDFDA(702,"+1,",.04)=$P(^TMP($J,MDX),U,6)
 .S MDFDA(702,"+1,",.05)=CONSULT
 .S MDFDA(702,"+1,",.07)=$P(MDNEWV,";",3)_";"_$P(MDNEWV,";",2)_";"_$P(MDNEWV,";")
 .S MDFDA(702,"+1,",.09)=0
 .;Create the new transaction
 .D UPDATE^DIE("","MDFDA","MDIEN") I '$G(MDIEN(1)) D  Q
 ..S RESULTS(0)="-1^Unable to create CP transaction"
 .
 .;Create the new TIU Note
 .S MDIENS=MDIEN(1)_","
 .S MDN=$$NEWTIUN^MDRPCOT(+MDIENS)
 .S MDNOTE=$S(MDN:$$GET1^DIQ(702,+MDIENS,.06,"I"),1:0)
 .I 'MDNOTE D  Q
 ..N DA,DIK
 ..S RESULTS(0)="-1^Unable to create the TIU document"
 ..S DA=+MDIENS,DIK="^MDD(702," D ^DIK
 .S RESULTS(0)=MDNOTE
 Q
 ;
TIUCOMP(MDNOTE) ; [Procedure] Post Signature action to complete transaction
 ; Input parameters
 ;  1. MDNOTE [Literal/Required] TIU IEN
 ;
 N MDFDA,MDRES
 S MDRES=$O(^MDD(702,"ATIU",MDNOTE,0))
 I $G(^MDD(702,+MDRES,0))="" Q 0
 I $P($G(^MDD(702,+MDRES,0)),"^",9)=3 Q 1
 S MDFDA(702,MDRES_",",.09)=3
 D FILE^DIE("","MDFDA")
 Q 1
 ;
TIUDEL(MDNOTE) ; [Procedure] TIU Note deletion Update
 ; Input parameters
 ;  1. MDNOTE [Literal/Required] TIU IEN
 ;
 N MDGBL,MDRES,MDFDA,MDTRAN,RESULTS
 S MDRES="" F  S MDRES=$O(^MDD(702,"ATIU",MDNOTE,MDRES)) Q:'MDRES  D
 .Q:$G(^MDD(702,+MDRES,0))=""
 .;S MDFDA(702,MDRES_",",.05)=""
 .S MDFDA(702,MDRES_",",.06)=""
 .D FILE^DIE("","MDFDA")
 .S MDTRAN=$O(^MDD(702.001,"ASTUDY",MDRES,MDNOTE,0)) I +MDTRAN N DA,DIK S DA=+MDTRAN,DIK="^MDD(702.001," D ^DIK
 .D STATUS^MDRPCOT(MDRES_",",2,"TIU note deleted.")
 .S DATA("TRANSACTION")=MDRES,DATA("PKG")="TIU"
 .S DATA("MESSAGE")="TIU note deleted." D RPC^MDRPCOT(.RESULTS,"ADDMSG",.DATA)
 S MDGBL=$NA(^MDD(702.001,"PK",MDNOTE)) F  S MDGBL=$Q(@MDGBL) Q:MDGBL=""  Q:$QS(MDGBL,2)'="PK"!($QS(MDGBL,3)'=MDNOTE)  S MDTRAN=$QS(MDGBL,6) N DA,DIK S DA=+MDTRAN,DIK="^MDD(702.001," D ^DIK
 Q 1
 ;
TIUREAS(MDFN,MDOLDC,MDANOTE,MDNDFN,MDNEWC,MDNEWV,MDNTIU) ; [Function] This is an API to clean up and update TIU note re-assignment.
 ; Input parameters
 ;  1. MDFN [Literal/Required] The Patient DFN whose TIU document is being re-assigned.
 ;  2. MDOLDC [Literal/Required] The Consult that the note is being re-assigned from.
 ;  3. MDANOTE [Literal/Required] The TIU Document IEN that is being re-assigned.
 ;  4. MDNDFN [Literal/Required] The Patient DFN who will be re-assigned the TIU document.
 ;  5. MDNEWC [Literal/Required] The consult number that will be assignment the TIU document.
 ;  6. MDNEWV [Literal/Required] The new visit for the TIU document assignment.
 ;  7. MDNTIU [Literal/Required] The new reassigned TIU document IEN.
 ;
 N MDD,MDGBL,MDTRAN,MDCHK,MDLP,MDMULN,MDN,MDPPR,MDREAS,MDTRANI,MDX
 I '$G(MDFN) Q "0^No DFN for the TIU note re-assignment."
 I '$G(MDOLDC) Q "0^No Old Consult # for the note re-assignment."
 I '$G(MDANOTE) Q "0^No TIU Note IEN."
 I '$G(MDNDFN) Q "0^No New DFN for the note assignment."
 I '$G(MDNEWC) Q "0^No New Consult # for the note assignment."
 I '$G(MDNTIU) Q "0^No New Reassigned TIU IEN."
 S (MDD,MDCHK,MDREAS,MDTRAN)="",MDPPR=0 K ^TMP("MDTMP",$J)
 S MDTRAN=$O(^MDD(702,"ATIU",MDANOTE,0)) I +MDTRAN S MDCHK=$G(^MDD(702,MDTRAN,0)),MDTRANI=MDTRAN_"," D
 .I $P(MDCHK,U,5)=MDOLDC&($P(MDCHK,U,6)=MDANOTE) D
 ..S MDFDA(702,+MDTRAN_",",.06)=""
 ..D FILE^DIE("","MDFDA") K MDFDA
 S MDGBL=$NA(^MDD(702.001,"PK",MDANOTE))
 F  S MDGBL=$Q(@MDGBL) Q:MDGBL=""  Q:$QS(MDGBL,2)'="PK"!($QS(MDGBL,3)'=MDANOTE)  S MDN=$QS(MDGBL,6) N DA,DIK S DA=+MDN,DIK="^MDD(702.001," D ^DIK
 S MDMULN=+$O(^MDD(702.001,"ASTUDY",+MDTRAN,0))
 I '+MDMULN I +MDTRAN N DA,DIK S DA=+MDTRAN,DIK="^MDD(702," D ^DIK
 D NOW^%DTC S MDD=% S MDTRANI=$O(^MDD(702,"ACON",MDNEWC,0))
 S MDREAS=$P(MDNEWV,";",3)_";"_$P(MDNEWV,";",2)_";"_$P(MDNEWV,";")
 I +MDTRANI&(MDNDFN=+$G(^MDD(702,+MDTRANI,0))) D
 .S MDPPR=$P($G(^MDD(702,+MDTRANI,0)),"^",4) Q:'MDPPR
 .S MDNEWV=$$GETVSTR^MDRPCOT1(MDNDFN,MDREAS,MDPPR,MDD)
 .S MDFDA(702,+MDTRANI_",",.06)=MDNTIU
 .S MDFDA(702,"+1,",.07)=$P(MDNEWV,";",3)_";"_$P(MDNEWV,";",2)_";"_$P(MDNEWV,";")
 .D FILE^DIE("","MDFDA") K MDFDA
 I 'MDPPR D
 .D CPLIST^GMRCCP(MDNDFN,,$NA(^TMP("MDTMP",$J)))
 .S MDX=""
 .F  S MDX=$O(^TMP("MDTMP",$J,MDX)) Q:'MDX  S:$P(^(MDX),U,5)=MDNEWC MDPPR=$P(^(MDX),U,6)
 K ^TMP("MDTMP",$J)
 I +MDPPR Q 1
 S MDNEWV=$$GETVSTR^MDRPCOT1(MDNDFN,MDREAS,MDPPR,MDD)
 S MDFDA(702,"+1,",.01)=MDNDFN
 S MDFDA(702,"+1,",.02)=MDD
 S MDFDA(702,"+1,",.03)=DUZ
 S MDFDA(702,"+1,",.04)=MDPPR
 S MDFDA(702,"+1,",.05)=MDNEWC
 S MDFDA(702,"+1,",.06)=MDNTIU
 S MDFDA(702,"+1,",.07)=$P(MDNEWV,";",3)_";"_$P(MDNEWV,";",2)_";"_$P(MDNEWV,";")
 S MDFDA(702,"+1,",.09)=0
 D UPDATE^DIE("","MDFDA")
 Q 1
 ;
TRANS(STR) ; [Function] Translate the upper arrows to blanks
 ; Input parameters
 ;  1. STR [Literal/Required] Input: Text with upper arrows that needs to be removed
 ;
 I STR["^" Q $TR(STR,"^"," ")
 Q STR
 ;
GETCP(RESULTS,MDCSLT) ; API to return CP Study data
 ; Input Parameters:
 ;   1. RESULTS [Literal/Required] Return Array
 ;   2. MDCSLT [Literal/Required] Consult number
 ;
 ; Output:
 ;   RESULTS(0)=-1^Error Message or 1 for success
 ;          (N,1)=CP Study Number
 ;          (N,2)=Patient DFN
 ;          (N,3)=Created Date/Time
 ;          (N,4)=Created By
 ;          (N,5)=CP Definition (External Name)
 ;          (N,6)=Consult Number
 ;          (N,7)=TIU Note IEN
 ;          (N,8)=VSTR
 ;          (N,9)=Transaction Status
 ;
 ; Where N = 1..n entries
 ;
 N MDCT,MDX,MDY
 I '$G(MDCSLT) S @RESULTS@(0)="-1^No Consult Number passed" Q
 S MDX=$O(^MDD(702,"ACON",MDCSLT,0)) I 'MDX S @RESULTS@(0)="-1^No CP Study Entry." Q
 S @RESULTS@(0)=1
 S MDCT=0,MDX="" F  S MDX=$O(^MDD(702,"ACON",MDCSLT,MDX)) Q:MDX<1  D
 .S MDCT=MDCT+1,@RESULTS@(MDCT,1)=MDX
 .S MDY=$G(^MDD(702,+MDX,0)),@RESULTS@(MDCT,2)=$P(MDY,U),@RESULTS@(MDCT,3)=$P(MDY,U,2),@RESULTS@(MDCT,4)=$P(MDY,U,3),@RESULTS@(MDCT,5)=$$GET1^DIQ(702,+MDX,.04,"E")
 .S @RESULTS@(MDCT,6)=$P(MDY,U,5),@RESULTS@(MDCT,7)=$P(MDY,U,6),@RESULTS@(MDCT,8)=$P(MDY,U,7),@RESULTS@(MDCT,9)=$$GET1^DIQ(702,+MDX,.09,"E")
 Q
