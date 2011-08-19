MDRPCOT2 ; HOIFO/NCA - Object RPCs (TMDTransaction) Continued 2;10/29/04  12:20 ;3/12/08  09:18
 ;;1.0;CLINICAL PROCEDURES;**6,21,20**;Apr 01, 2004;Build 9
 ; Integration Agreements:
 ; IA# 2056 [Supported] Call to DIQ.
 ; IA# 2693 [Subscription] TIU Extractions.
 ; IA# 3468 [Subscription] GMRCCP API.
 ; IA# 3535 [Subscription] Calls to TIUSRVP.
 ; IA# 4795 [Subscription] Calls to TIUSRVP2.
 ; IA# 5407 [Subscription] Call routine ORWTPN.
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
SUBMIT(MDDATA,MDESIG,MDG1) ; [Procedure] Process the Image(s) Submission.
 ; Input: MDDATA - Study ID
 ;        MDESIG - Electronic Signature
 ;        MDG1 - ^TMP global with the text of the report
 ; Output: -1^Error Message or
 ;          1^Successful Message
 N MDRESUL,MDSTUDY,MDG2,RES
 S MDSTUDY=+MDDATA,(RES,MDRESUL)=""
 ; Create New TIU Document
 S MDRESUL=$$NEWTIUN(MDSTUDY)
 ;S MDRESUL=$$NEWTIUN(MDSTUDY)
 ; File TIU Error messages
 ;I +MDRESUL<0 D FILEMSG(MDSTUDY,"TIU",2,MDRESUL) Q MDRESUL
 I +MDRESUL<0 D  Q RES
 .D FILEMSG(MDSTUDY,"TIU",2,MDRESUL)
 .S RES=MDRESUL
 ; Update the text of the TIU document
 S MDG2=@($NA(MDG1))
 I +$O(@MDG2@(""),-1) D  Q:RES'="" RES
 .S MDRESUL=$$UPDATE(MDSTUDY,MDESIG,MDG2)
 .I +MDRESUL<0 D  Q
 ..D FILEMSG(MDSTUDY,"TIU",2,MDRESUL)
 ..S RES=MDRESUL
 ; Submit and export the images
 ;S MDRESUL=$$SUBMIT^MDRPCOT1(MDSTUDY)
 ; File message
 ;D FILEMSG(MDSTUDY,"IMAGING",$S(+MDRESUL>0:+MDRESUL,1:2),MDRESUL)
 S RES=MDRESUL
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
 S MDNOTE=""
 I $$GET1^DIQ(702,MDIEN,.06,"I") Q DFN_"^"_MDTITL_"^"_MDLOC_"^"_+$$GET1^DIQ(702,MDIEN,.06,"I")_"^"_MDCON_"^"_MDPROC_"^"_MDVSTR_"^"_MDNVST
 ; Does TIU doc exist for previous transaction of this consult?
 ;I MDCON S MDNOTE=$$PREV(MDCON,MDIEN)
 Q DFN_"^"_MDTITL_"^"_MDLOC_"^"_+MDNOTE_"^"_MDCON_"^"_MDPROC_"^"_MDVSTR_"^"_MDNVST
 ;
NEWTIUN(STUDY) ; [Function] Create a new TIU for transaction
 ; Input: STUDY - IENS of CP study entry
 ; Return: TIU Document IEN
 N CTR,DFN,MDCON,MDCONRS,MDFDA,MDGST,MDL,MDLOC,MDNOTE,MDPDT,MDPROC,MDPT,MDRESU,MDTITL,MDTSTR,MDVST,MDVSTR,MDWP S CTR=0,MDGST=+STUDY,MDRESU=""
 ; Get data for TIU Note Creation
 S (MDTSTR,MDRESU)=$$GETDATA(MDGST)
 ; File Error message
 I +MDRESU<0 D FILEMSG(MDGST,"CP",2,MDRESU) Q MDRESU
 I $G(MDTSTR)="" Q "-1^No Data to Create TIU Document"
 F MDL="DFN","MDTITL","MDLOC","MDNOTE","MDCON","MDPROC","MDVSTR","MDNVST" D
 .S CTR=CTR+1,@MDL=$P(MDTSTR,"^",CTR)
 S (MDVST,MDRESU)=""
 ; If previous TIU document exists, quit
 I 'MDLOC Q "-1^No Hospital Location."
 I MDNOTE Q MDNOTE
 ; Create new visit, if no vstring
 S MDPDT=$$PDT^MDRPCOT1(MDGST)
 I 'MDPDT S MDPT=$O(^MDD(703.1,"ASTUDYID",+MDGST,""),-1),MDPDT=$P($G(^MDD(703.1,+MDPT,0)),U,3)
 S:'MDPDT MDPDT=$P(MDVSTR,";",2) ; If No D/T Performed grab visit D/T
 ; Build variables for TIU Call
 S MDWP(.05)=1 ; Undictated Status
 S MDWP(1405)=+MDCON_";GMR(123," ; Package Reference
 S MDWP(70201)=5 ; Default Procedure Summary Code "Machine Resulted"
 I MDPDT S MDWP(70202)=MDPDT ; Date/Time Performed
 ; File PCE Error message
 S MDRESU=$$EN1^MDPCE(MDGST,$P(MDVSTR,";",2),(MDPROC_"^"_MDLOC),$P(MDVSTR,";",3),"P") I +MDRESU S MDVST=+MDRESU,MDVSTR=$P(MDRESU,"^",2)
 ;I MDNVST S MDRESU=$$EN1^MDPCE1(MDGST,MDPDT,MDPROC,$P(MDVSTR,";",3),"P") I +MDRESU S MDVST=+MDRESU,MDVSTR=$P(MDRESU,"^",2)
 ;I 'MDNVST S MDVST=$P($G(^MDD(702,+MDGST,1)),U) I 'MDVST S MDRESU=$$EN1^MDPCE(MDGST,MDPDT,(MDPROC_"^"_MDLOC),$P(MDVSTR,";",3),"P") I +MDRESU S MDVST=+MDRESU
 ;I 'MDNVST&$$CHK^MDPCE1(MDGST) S MDRESU=$$EN1^MDPCE1(MDGST,MDPDT,MDPROC,$P(MDVSTR,";",3),"P") I +MDRESU S MDVST=+MDRESU
 I +MDRESU<0 D FILEMSG(MDGST,"PCE",2,$P(MDRESU,"^",2)) Q MDRESU
 ; Create the TIU note stub
 S MDVST="" S MDVST=+$G(^MDD(702,MDGST,1))
 S MDNOTE="" D MAKE^TIUSRVP(.MDNOTE,DFN,MDTITL,$P(MDVSTR,";",2),MDLOC,$S(MDVST:MDVST,1:""),.MDWP,MDVSTR,1,1)
 I '(+MDNOTE) S $P(MDNOTE,"^")=-1 Q MDNOTE
 ; Finalize the transaction
 S MDFDA(702,STUDY_",",.06)=+MDNOTE
 S MDFDA(702,STUDY_",",.08)=""
 D FILE^DIE("","MDFDA") K MDFDA
 D UPD^MDKUTLR(STUDY,+MDNOTE)
 ;S MDCONRS=$$CPDOC^GMRCCP(+MDCON,+MDNOTE,2)
 Q 1
 ;
UPDATE(STUDY,SIGN,MDGLB) ; Update the TIU document with the text
 N MDK,MDNOTE,MDPPR,MDRESU,MDS,MDTI,MDTIUER,MDWP,MDV,MDV1,MDVAU S (MDNOTE,MDTIUER)="" K MDWP,^TMP("MDTIUST",$J)
 F MDK=0:0 S MDK=$O(@MDGLB@(MDK)) Q:'MDK  S MDWP("TEXT",MDK,0)=$G(@MDGLB@(MDK))
 S MDTI=$$GET1^DIQ(702,STUDY_",",.06,"I") Q:'MDTI "-1^No Note."
 S MDWP(.05)=5
 S MDWP(1202)=DUZ
 D GETDCOS^ORWTPN(.MDVAU,DUZ)
 I +MDVAU S MDWP(1506)=1,MDWP(1208)=+MDVAU
 D UPDATE^TIUSRVP(.MDNOTE,+MDTI,.MDWP,1)
 I '+MDNOTE S MDNOTE="-1^"_$P(MDNOTE,"^",2) Q MDNOTE
 ; Sign TIU Document
 S MDS=$$SIGN(MDTI,SIGN) I MDS<0 Q MDS
 ;N MDFDA S MDFDA(704.202,STUDY_",",.09)=0
 S $P(^MDK(704.202,STUDY,0),"^",9)=0
 ;D FILE^DIE("","MDFDA")
 N MDFDA S MDFDA(702,STUDY_",",.09)=3
 D FILE^DIE("","MDFDA")
 K ^MDK(704.202,"AS",1,STUDY)
 S ^MDK(704.202,"AS",0,STUDY)=""
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
