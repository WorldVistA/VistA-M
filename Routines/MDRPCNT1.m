MDRPCNT1 ; HOIFO/NCA - Object RPCs (TMDNOTE) Continued 2;10/29/04  12:20 ;2/25/09  16:08
 ;;1.0;CLINICAL PROCEDURES;**6,21**;Apr 01, 2004;Build 30
 ; Integration Agreements:
 ; IA# 2693 [Subscription] TIU Extractions.
 ; IA# 3535 [Subscription] Calls to TIUSRVP.
 ; IA# 4795 [Subscription] Calls to TIUSRVP2.
 ; IA# 5407 [Subscription] Call to GETDCOS^ORWTPN
ADDMSG ; [Procedure] Add message to transaction
 N MDIEN,MDIENS,MDRET
 Q:'$G(DATA("TRANSACTION"))
 Q:$G(DATA("MESSAGE"))=""
 S MDIEN=+DATA("TRANSACTION"),MDIENS="+1,"_MDIEN_","
 D NOW^%DTC S DATA("DATE")=%
 S MDFDA(702.091,MDIENS,.01)=+$O(^MDD(702,+MDIEN,.091,"A"),-1)+1
 S MDFDA(702.091,MDIENS,.02)=DATA("DATE")
 S MDFDA(702.091,MDIENS,.03)=$G(DATA("PKG"),"UNKNOWN")
 S MDFDA(702.091,MDIENS,.09)=DATA("MESSAGE")
 D UPDATE^DIE("","MDFDA","MDRET")
 Q
 ;
FILEMSG(STUDY,MDPKG,MDSTAT,MDMSG) ; [Procedure] File Study Status and Message.
 S DATA("TRANSACTION")=STUDY,DATA("PKG")=MDPKG
 S DATA("MESSAGE")=$P(MDMSG,"^",2)
 D STATUS(STUDY_",",MDSTAT,$P(MDMSG,"^",2)),ADDMSG
 Q
 ;
STATUS(MDIENS,MDSTAT,MDMSG) ; [Procedure] Update transaction status
 S MDFDA(702,MDIENS,.08)=$G(MDMSG)
 S MDFDA(702,MDIENS,.09)=MDSTAT
 D FILE^DIE("","MDFDA")
 Q
 ;
SUBMIT(MDDATA,MDDT,MDAU,MDESIG,MDNTL,MDG1) ; [Procedure] Process the Image(s) Submission.
 ; Input: MDDATA - Study ID
 ;        MDDT-Date/Time of Document
 ;        MDA - Author
 ;        MDESIG - Electronic Signature
 ;        MDNTL - Note title
 ;        MDG1 - ^TMP global with the text of the report
 ; Output: -1^Error Message or
 ;          1^Successful Message
 N MDANS,MDRESUL,MDSTUDY,MDG2,RES,MDN
 S MDSTUDY=+MDDATA,(RES,MDRESUL)=""
 ; Create New TIU Document
 S (MDN,MDRESUL)=$$NEWTIUN(MDSTUDY,MDDT,MDAU,MDNTL)
 ; File TIU Error messages
 I +MDRESUL<0 D  Q RES
 .D FILEMSG(MDSTUDY,"TIU",2,MDRESUL)
 .S RES=MDRESUL
 S MDANS=+MDRESUL
 ; Update the text of the TIU document
 S MDG2=@($NA(MDG1))
 I +$O(@MDG2@(""),-1) D  Q:RES'="" RES
 .S MDRESUL=$$UPDATE(MDSTUDY,MDANS,MDESIG,MDG2)
 .I +MDRESUL<0 D  Q
 ..D FILEMSG(MDSTUDY,"TIU",2,MDRESUL)
 ..S RES=MDRESUL
 S RES=MDANS
 N XX S XX="",XX=$$UPDCONS^MDRPCOT1(+$P($G(^MDD(702,+MDSTUDY,0)),U,5),+MDN)
 Q RES
 ;
GETDATA(STUDY) ; [Function] Return the Necessary data for creating a TIU note.
 ; Return: Patient DFN_"^"_TIU title_"^"_Hospital Location_"^"_TIU Note
 ;         IEN_"^"_Consult #_"^"_CP Definition IEN_"^"_Visit String_"^"
 ;         New Visit Flag
 ;         or
 ;         -1^Error Message
 N DFN,MDCON,MDFN,MDIEN,MDIENS,MDLOC,MDNEWV,MDNOTE,MDNVST,MDPROC,MDVSTR,MDTITL,MDX,MDTST
 S MDIEN=+STUDY,MDIENS=MDIEN_",",MDNVST=0
 I $$GET1^DIQ(702,MDIENS,.01)="" Q "-1^No such study entry."
 ; Get DFN
 S DFN=$$GET1^DIQ(702,MDIEN,.01,"I")
 I 'DFN Q "-1^No DFN."
 ; Get CP Def
 S MDPROC=$$GET1^DIQ(702,MDIEN,.04,"I")
 I 'MDPROC Q "-1^No CP Def."
 ; Get Consult
 S MDCON=$$GET1^DIQ(702,MDIEN,.05,"I")
 I 'MDCON Q "-1^No Consult #."
 ; Get TIU Note Title
 S MDTITL=$$GET1^DIQ(702.01,+MDPROC_",",.04,"I")
 I 'MDTITL Q "-1^No TIU Note Title."
 S MDVSTR=$$GET1^DIQ(702,MDIEN,.07)
 I MDVSTR=""  Q "-1^No Visit String."
 I $L(MDVSTR,";")=1 S MDNVST=1,MDVSTR=";"_MDVSTR ; If new visit is selected
 ; MDLOC is Hospital Location
 I MDVSTR'="" D
 .S MDVSTR=$$GETVSTR^MDRPCOT1(DFN,MDVSTR,MDPROC,$$GET1^DIQ(702,MDIEN,.02,"I"))
 .S MDLOC=$P(MDVSTR,";",1)
 ; Does TIU doc already exist?
 ;I $$GET1^DIQ(702,MDIEN,.06,"I") Q DFN_"^"_MDTITL_"^"_MDLOC_"^"_+$$GET1^DIQ(702,MDIEN,.06,"I")_"^"_MDCON_"^"_MDPROC_"^"_MDVSTR_"^"_MDNVST
 ; Does TIU doc exist for previous transaction of this consult?
 ;I MDCON S MDNOTE=$$PREV(MDCON,MDIEN)
 S MDNOTE=""
 Q DFN_"^"_MDTITL_"^"_MDLOC_"^"_+MDNOTE_"^"_MDCON_"^"_MDPROC_"^"_MDVSTR_"^"_MDNVST
 ;
NEWTIUN(STUDY,MDDT,MDA,MDNT) ; [Function] Create a new TIU for transaction
 ; Input: STUDY - IENS of CP study entry
 ;        MDDT - Date of Note
 ;        MDA - Author
 ;        MDNT - Note Title
 ; Return: TIU Document IEN
 N CTR,DFN,MDCON,MDFDA,MDGST,MDL,MDLOC,MDNOTE,MDPDT,MDPROC,MDPT,MDRESU,MDDTTL,MDTITL,MDTSTR,MDVST,MDVSTR,MDWP S CTR=0,MDGST=+STUDY,MDRESU="" N MDFIL S MDFIL=8925.1
 ; Get data for TIU Note Creation
 S (MDTSTR,MDRESU)=$$GETDATA(MDGST),MDDTTL=0
 ; File Error message
 I +MDRESU<0 D FILEMSG(MDGST,"CP",2,MDRESU) Q MDRESU
 I $G(MDTSTR)="" Q "-1^No Data to Create TIU Document"
 F MDL="DFN","MDTITL","MDLOC","MDNOTE","MDCON","MDPROC","MDVSTR","MDNVST" D
 .S CTR=CTR+1,@MDL=$P(MDTSTR,"^",CTR)
 S (MDVST,MDRESU)=""
 ; If previous TIU document exists, quit
 ;I MDNOTE Q MDNOTE
 I 'MDLOC Q "-1^No Hospital Location."
 ; Create new visit, if no vstring
 S MDDTTL=+$$FIND1^DIC(MDFIL,"","BOX",MDNT,"B","","MDERR")
 S MDTITL=$S(+MDDTTL>0:+MDDTTL,1:MDTITL)
 S MDPDT=$$PDT^MDRPCOT1(MDGST)
 I 'MDPDT S MDPT=$O(^MDD(703.1,"ASTUDYID",+MDGST,0)),MDPDT=$P($G(^MDD(703.1,+MDPT,0)),U,3)
 S:'MDPDT MDPDT=$P(MDVSTR,";",2) ; If No D/T Performed grab visit D/T
 ; Build variables for TIU Call
 S MDWP(.05)=1 ; Undicated Status
 S MDWP(1201)=MDDT ; Date/Time Note Created
 S MDWP(1202)=MDA ; Author of Note
 S MDWP(1302)=MDA ; Entered By
 S MDWP(1405)=+MDCON_";GMR(123," ; Package Reference
 S MDWP(70201)=5 ; Default Procedure Summary Code "Machine Resulted"
 I MDPDT S MDWP(70202)=MDPDT ; Date/Time Performed
 ; File PCE Error message
 I MDNVST S MDRESU=$$EN1^MDPCE(MDGST,MDPDT,MDPROC,$P(MDVSTR,";",3),"P") I +MDRESU S MDVST=+MDRESU,MDVSTR=$P(MDRESU,"^",2)
 I +MDRESU<0 D FILEMSG(MDGST,"PCE",2,$P(MDRESU,"^",2)) Q MDRESU
 ; Create the TIU note stub
 I MDVST="" S MDVST=+$G(^MDD(702,MDGST,1))
 S MDNOTE="" D MAKE^TIUSRVP(.MDNOTE,DFN,MDTITL,$P(MDVSTR,";",2),MDLOC,$S(MDVST:MDVST,1:""),.MDWP,MDVSTR,1,1)
 I '(+MDNOTE) S $P(MDNOTE,"^")=-1 Q MDNOTE
 ;S MDFDA(702,STUDY_",",.06)=+MDNOTE
 S MDFDA(702,STUDY_",",.08)=""
 D FILE^DIE("","MDFDA")
 D UPD^MDKUTLR(STUDY,+MDNOTE)
 Q MDNOTE
 ;
UPDATE(STUDY,MDA,SIGN,MDGLB) ; Update the TIU document with the text
 N MDK,MDNOTE,MDPPR,MDRESU,MDS,MDTI,MDTIUER,MDWP,MDV,MDV1,MDVAU S (MDNOTE,MDTIUER)="" K MDWP,^TMP("MDTIUST",$J)
 F MDK=0:0 S MDK=$O(@MDGLB@(MDK)) Q:'MDK  S MDWP("TEXT",MDK,0)=$G(@MDGLB@(MDK))
 S MDTI=MDA
 S MDWP(.05)=5
 D GETDCOS^ORWTPN(.MDVAU,DUZ)
 I +MDVAU S MDWP(1506)=1,MDWP(1208)=+MDVAU
 D UPDATE^TIUSRVP(.MDNOTE,+MDTI,.MDWP,1)
 I '+MDNOTE S MDNOTE="-1^"_$P(MDNOTE,"^",2) Q MDNOTE
 ; Sign TIU Document
 S MDS=$$SIGN(MDTI,SIGN) I MDS<0 Q MDS
 Q 1
SIGN(MDTIUIN,MDSIGN) ; Sign the TIU Document
 ; [Function] TIU SIGN RECORD
 ;Input Parameters:
 ;   1.  TIUIEN [Literal/Required] TIU internal Entry Number
 ;   2.  MDSIGN [Literal/Required] User Signature
 N MDSRES,X
 S MDSRES=""
 D SIGN^TIUSRVP2(.MDSRES,MDTIUIN,MDSIGN)
 I +MDSRES>0 Q "-1^"_$P(MDSRES,"^",2)
 Q 1
 ;
PREV(MDC,MDS) ; [Function] Return the Previous TIU document.
 N MDNEWV,MDDOC,MDTRAN,MDTIUER,MDTST
 S (MDDOC,MDNEWV,MDTRAN,MDTIUER,MDTST)="" K ^TMP("MDTIUST",$J)
 F  S MDTRAN=$O(^MDD(702,"ACON",MDC,MDTRAN)) Q:'MDTRAN  D  Q:'MDTRAN
 .I $P(^MDD(702,MDTRAN,0),U,6) D
 ..D EXTRACT^TIULQ($P(^MDD(702,MDTRAN,0),U,6),"^TMP(""MDTIUST"",$J)",MDTIUER,".01;.05;1406") Q:+MDTIUER
 ..S MDTST=$G(^TMP("MDTIUST",$J,$P(^MDD(702,MDTRAN,0),U,6),.05,"E"))
 ..I MDTST'="UNDICTATED"&(MDTST'="UNSIGNED") K ^TMP("MDTIUST",$J) Q
 ..I MDTST="UNSIGNED"&'($G(^TMP("MDTIUST",$J,$P(^MDD(702,MDTRAN,0),U,6),1406,"I"))) K ^TMP("MDTIUST",$J) Q
 ..S MDDOC=$P(^MDD(702,MDTRAN,0),U,6),MDNEWV=$P(^MDD(702,MDTRAN,0),U,7)
 ..Q:'MDS
 ..S MDFDA(702,MDS_",",.06)=MDDOC
 ..S MDFDA(702,MDS_",",.07)=MDNEWV
 ..D FILE^DIE("","MDFDA")
 ..S MDTRAN=""
 Q MDDOC
