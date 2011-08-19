MDRPCOT ; HOIFO/DP/NCA - Object RPCs (TMDTransaction) ;10/26/09  10:23
 ;;1.0;CLINICAL PROCEDURES;**5,6,11,21**;Apr 01, 2004;Build 30
 ; Integration Agreements:
 ; IA# 2693 [Subscription] TIU Extractions.
 ; IA# 2944 [Subscription] Calls to TIUSRVR1.
 ; IA# 3535 [Subscription] Calls to TIUSRVP.
 ; IA# 10103 [Supported] Call to XLFDT
 ; IA# 10104 [Supported] Routine XLFSTR calls
ADDMSG ; [Procedure] Add message to transaction
 N MDIEN,MDIENS,MDRET
 Q:'$G(DATA("TRANSACTION"))
 Q:$G(DATA("MESSAGE"))=""
 S MDIEN=+DATA("TRANSACTION"),MDIENS="+1,"_MDIEN_","
 D NOW^%DTC S DATA("DATE")=% K %
 S MDFDA(702.091,MDIENS,.01)=+$O(^MDD(702,+MDIEN,.091,"A"),-1)+1
 S MDFDA(702.091,MDIENS,.02)=DATA("DATE")
 S MDFDA(702.091,MDIENS,.03)=$G(DATA("PKG"),"UNKNOWN")
 S MDFDA(702.091,MDIENS,.09)=DATA("MESSAGE")
 D UPDATE^DIE("","MDFDA","MDRET")
 Q
 ;
DELETE ; [Procedure] Delete Study
 ; Sets @RESULTS@(0)="-1^Reason for not deleting" or "1^Study Deleted"
 ;
 N MDAST,MDHOLD,MDNOTE,MDRES,MDSIEN,BODY,SUBJECT,DEVIEN
 S (MDHOLD,MDSIEN)=+DATA,MDRES=0,MDNOTE=""
 D ALERT^MDHL7U3(MDSIEN) ; Builds the body of the mail message
 I $G(^MDD(702,+MDSIEN,0))="" S @RESULTS@(0)="1^Study Deleted." D NOTICE^MDHL7U3(SUBJECT,.BODY,DEVIEN,DUZ) Q  ;deleting message
 S:+$P(^MDD(702,MDSIEN,0),U,6) MDNOTE=$P(^MDD(702,MDSIEN,0),U,6)
 I "13"[$P(^MDD(702,MDSIEN,0),U,9) S @RESULTS@(0)="-1^Can't Delete TIU Note from a "_$$GET1^DIQ(702,MDSIEN,.09,"E")_" Study." Q
 I "5"[$P(^MDD(702,MDSIEN,0),U,9) S MDCANR=$$CANCEL^MDHL7B(MDHOLD) I +MDCANR<0 S @RESULTS@(0)="-1^"_$P(MDCANR,"^",2) Q
 I +MDNOTE S MDRES="" D DELETE^TIUSRVP(.MDRES,MDNOTE)
 I MDRES D  Q
 .D STATUS(MDSIEN_",",2,$P(MDRES,"^",2))
 .S DATA("TRANSACTION")=MDSIEN,DATA("PKG")="TIU"
 .S DATA("MESSAGE")=$P(MDRES,"^",2) D ADDMSG
 .S @RESULTS@(0)="-1^"_$P(MDRES,"^",2)
 .Q
 E  D
 .I $D(^MDD(702.001,"ASTUDY",MDSIEN)) S @RESULTS@(0)="-1^Note associated with study, can not delete." Q
 .S MDAST=$$HL7CHK^MDHL7U3(+MDSIEN) I +MDAST<1 S @RESULTS@(0)=MDAST Q
 .D NOTICE^MDHL7U3(SUBJECT,.BODY,DEVIEN,DUZ) ; delete message
 .S MDFDA(702,DATA_",",.01)=""
 .; Check for renal study to delete as well
 .S:$D(^MDK(704.202,DATA)) MDFDA(704.202,DATA_",",.01)=""
 .D FILE^DIE("","MDFDA")
 .N DA,DIK S DA=+MDSIEN,DIK="^MDD(702," D ^DIK
 .S @RESULTS@(0)="1^Study Deleted."
 .Q
 Q
 ;
FILEMSG(STUDY,MDPKG,MDSTAT,MDMSG) ; [Procedure] File Study Status and Message.
 S DATA("TRANSACTION")=STUDY,DATA("PKG")=MDPKG
 S DATA("MESSAGE")=$P(MDMSG,"^",2)
 D STATUS(STUDY_",",MDSTAT,$P(MDMSG,"^",2)),ADDMSG
 Q
 ;
FILES ; [Procedure] Add/remove an attachment to this transaction
 NEW MDFDA,MDIEN,MDIENS,MDRET,MDT,MDT1,P1,P2,P3,P4
 S P1=$P(DATA,U,1),P2=$P(DATA,U,2),P3=$P(DATA,U,3),P4=$P(DATA,U,4)
 S MDIEN=0 I $G(^MDD(702,+P1,0))="" Q
 S MDT=+P1,MDT1=$$MULT^MDRPCOT1(MDT),MDT=$S('MDT1:1,MDT1=1:1,1:0)
 ;I +MDT,$P($G(^MDD(702,+P1,0)),"^",9)=3 S @RESULTS@(0)="1^Study is already complete" Q
 I $P($G(^MDD(702,+P1,0)),"^",9)=6 S @RESULTS@(0)="1^Study is already cancelled" Q
 ; Look for file (All comparisons done on lower case values)
 F  S MDIEN=$O(^MDD(702,P1,.1,MDIEN)) Q:'MDIEN  D  Q:X=P3
 .S X=$$LOW^XLFSTR($G(^MDD(702,P1,.1,MDIEN,.1)))
 I +MDT,MDIEN,P4 S @RESULTS@(0)="1^File already assigned" Q
 I 'MDIEN&'P4 S @RESULTS@(0)="1^File not assigned" Q
 I P4 D  Q  ; Add a file
 .S MDIENS="+1,"_P1_","
 .S MDFDA(702.1,MDIENS,.01)=$O(^MDD(702,P1,.1,"B",""),-1)+1
 .S MDFDA(702.1,MDIENS,.02)=$S(P2:"I",1:"U")
 .I P2 S MDFDA(702.1,MDIENS,.03)=P2
 .S MDFDA(702.1,MDIENS,.1)=P3
 .D UPDATE^DIE("","MDFDA","MDIEN")
 .S @RESULTS@(0)=+$G(MDIEN(1),-1)
 I 'P4 D  Q  ; Remove the file
 .S MDFDA(702.1,MDIEN_","_P1_",",.01)="@"
 .D FILE^DIE("","MDFDA","MDRET")
 .S @RESULTS@(0)=$S($D(MDRET):-1,1:1)
 Q
 ;
GETATT ; [Procedure] Get Attachments
 F X=0:0 S X=$O(^MDD(702,DATA,.1,X)) Q:'X  D
 .S Y=$O(@RESULTS@(""),-1)+1
 .S @RESULTS@(Y)=$P(^MDD(702,DATA,.1,X,0),U,1,3)
 .S $P(@RESULTS@(Y),U,4)=$G(^MDD(702,DATA,.1,X,.1))
 S @RESULTS@(0)=+$O(@RESULTS@(""),-1)
 Q
 ;
GETERR ; [Procedure] Return list of Imaging Errors
 ; DATA = Transaction IEN
 F MDX=0:0 S MDX=$O(^MDD(702,DATA,.091,MDX)) Q:'MDX  D
 .S MDY=+^MDD(702,DATA,.091,MDX,0)_U,Y=$P(^(0),U,2)
 .D D^DIQ S MDY=MDY_Y_U
 .S MDY=MDY_$P(^MDD(702,DATA,.091,MDX,0),U,3)_U_$P(^(0),U,9)
 .S ^TMP($J,$O(^TMP($J,""),-1)+1)=MDY
 S ^TMP($J,0)=+$O(^TMP($J,""),-1)
 Q
 ;
NEWSTAT ; [Procedure] RPC Call to set status
 S MDFDA(702,DATA,.09)=TYPE
 D FILE^DIE("","MDFDA")
 I TYPE=3&($G(^MDK(704.202,+DATA,0))'="") K MDFDA S MDFDA(704.202,DATA,.09)=0 D FILE^DIE("","MDFDA") K MDFDA
 I TYPE=5 D
 .N MDHL7,MDERR S MDHL7=$$SUB^MDHL7B(+DATA)
 .I +MDHL7=-1 S MDFDA(702,DATA,.09)=2,MDFDA(702,DATA,.08)=$P(MDHL7,U,2)
 .I +MDHL7=1 S MDFDA(702,DATA,.09)=5,MDFDA(702,DATA,.08)=""
 .I $L($P($G(^MDD(702,+DATA,0)),"^",7),";")=1 S MDFDA(702,DATA,.07)=$$NOW^XLFDT(),MDFDA(702,DATA,.14)=$$NOW^XLFDT()
 .D:$D(MDFDA) FILE^DIE("","MDFDA","MDERR")
 Q
 ;
RPC(RESULTS,OPTION,DATA,TYPE,FILE,RESREP) ; [Procedure] Main RPC call
 N MDCANR,MDCON,MDDOC,MDFDA,MDFN,MDGST,MDHOLD,MDIEN,MDIENS,MDL,MDLOC,MDMSG,MDNEWV,MDNOTE,MDNVST,MDPDT,MDPKG,MDPROC,MDRES,MDRESU,MDRESUL,MDRET,MDS,MDSIEN,MDSTAT,MDSTUDY,MDTITL,MDTIUER,MDTRAN,MDTST,MDTSTR,MDVST,MDVSTR,MDWP,MDX,MDY
 S RESULTS=$NA(^TMP($J)) K @RESULTS
 D:$T(@OPTION)]"" @OPTION
 D:'$D(@RESULTS) BADRPC^MDRPCU("MD TMDTRANSACTION","MDRPCOT",OPTION)
 D CLEAN^DILF
 Q
 ;
STATUS(MDIENS,MDSTAT,MDMSG) ; [Procedure] Update transaction status
 S MDFDA(702,MDIENS,.08)=$G(MDMSG)
 S MDFDA(702,MDIENS,.09)=MDSTAT
 D FILE^DIE("","MDFDA") K MDFDA
 Q
 ;
SUBMIT ; [Procedure] Process the Image(s) Submission.
 ; Output: -1^Error Message or
 ;          1^Successful Message
 N MDRESUL,MDSTUDY
 S MDSTUDY=+DATA,MDRESUL=""
 ; Create New TIU Document
 S MDRESUL=$$NEWTIUN(MDSTUDY)
 ; File TIU Error messages
 I +MDRESUL<0 D  Q
 .D FILEMSG(MDSTUDY,"TIU",2,MDRESUL)
 .S @RESULTS@(0)=MDRESUL
 ; Submit and export the images
 S MDRESUL=$$SUBMIT^MDRPCOT1(MDSTUDY)
 ; File message
 D FILEMSG(MDSTUDY,"IMAGING",$S(+MDRESUL>0:+MDRESUL,1:2),MDRESUL)
 S @RESULTS@(0)=MDRESUL
 Q
 ;
VIEWTIU ; [Procedure] VIew the associated tiu document
 I '$P(^MDD(702,+DATA,0),U,6) D  Q
 .S @RESULTS@(0)="NO TIU NOTE FOR THIS STUDY"
 D TGET^TIUSRVR1(.RESULTS,+$P(^MDD(702,+DATA,0),U,6))
 Q
 ;
GETDATA(STUDY) ; [Function] Return the Necessary data for creating a TIU note.
 ; Return: Patient DFN_"^"_TIU title_"^"_Hospital Location_"^"_TIU Note
 ;         IEN_"^"_Consult #_"^"_CP Definition IEN_"^"_Visit String_"^"
 ;         New Visit Flag
 ;         or
 ;         -1^Error Message
 N DFN,MDCON,MDFN,MDIEN,MDDPT,MDIENS,MDLOC,MDNEWV,MDNOTE,MDNVST,MDPROC,MDVSTR,MDTITL,MDX,MDTST
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
 I $L(MDVSTR,";")=1 S MDNVST=1,MDDPT=$$PDT^MDRPCOT1(MDIEN),MDVSTR=";"_MDVSTR ; If new visit is selected
 ; MDLOC is Hospital Location
 I MDVSTR'="" D
 .S MDVSTR=$$GETVSTR^MDRPCOT1(DFN,MDVSTR,MDPROC,$$GET1^DIQ(702,MDIEN,.02,"I"))
 .S MDLOC=$P(MDVSTR,";",1)
 I $$GET1^DIQ(702.01,+MDPROC_",",.12,"I")=1 Q DFN_"^"_MDTITL_"^"_MDLOC_"^^"_MDCON_"^"_MDPROC_"^"_MDVSTR_"^"_MDNVST
 ; Does TIU doc already exist?
 I $$GET1^DIQ(702,MDIEN,.06,"I") Q DFN_"^"_MDTITL_"^"_MDLOC_"^"_+$$GET1^DIQ(702,MDIEN,.06,"I")_"^"_MDCON_"^"_MDPROC_"^"_MDVSTR_"^"_MDNVST
 ; Does TIU doc exist for previous transaction of this consult?
 I MDCON S MDNOTE=$$PREV(MDCON,MDIEN)
 Q DFN_"^"_MDTITL_"^"_MDLOC_"^"_+MDNOTE_"^"_MDCON_"^"_MDPROC_"^"_MDVSTR_"^"_MDNVST
 ;
NEWTIUN(STUDY) ; [Function] Create a new TIU for transaction
 ; Input: STUDY - IENS of CP study entry
 ; Return: TIU Document IEN
 N CTR,DFN,MDCON,MDFDA,MDGST,MDL,MDLOC,MDNOTE,MDPDT,MDPROC,MDRESU,MDTITL,MDTSTR,MDVST,MDVSTR,MDWP,MDPT S CTR=0,MDGST=+STUDY,MDRESU=""
 ; Get data for TIU Note Creation
 S (MDTSTR,MDRESU)=$$GETDATA(MDGST)
 ; File Error message
 I +MDRESU<0 D FILEMSG(MDGST,"CP",2,MDRESU) Q MDRESU
 I $G(MDTSTR)="" Q "-1^No Data to Create TIU Document"
 F MDL="DFN","MDTITL","MDLOC","MDNOTE","MDCON","MDPROC","MDVSTR","MDNVST" D
 .S CTR=CTR+1,@MDL=$P(MDTSTR,"^",CTR)
 S MDVST=""
 ; If previous TIU document exists, quit
 I MDNOTE Q MDNOTE
 I $$GET^XPAR("SYS","MD GET HIGH VOLUME",MDPROC,"I")'=""&(+$P(^MDD(702,+MDGST,0),"^",6)) Q $P(^MDD(702,+MDGST,0),"^",6)
 I 'MDLOC Q "-1^No Hospital Location."
 ; Create new visit, if no vstring
 S MDPDT=$$PDT^MDRPCOT1(MDGST)
 I 'MDPDT S MDPT=$O(^MDD(703.1,"ASTUDYID",+MDGST,0)),MDPDT=$P($G(^MDD(703.1,+MDPT,0)),U,3)
 S:'MDPDT MDPDT=$P(MDVSTR,";",2) ; If No D/T Performed grab visit D/T
 I $P(MDVSTR,";",3)="V" S $P(MDVSTR,";",3)="A"
 ; Build variables for TIU Call
 S MDWP(.05)=1 ; Undicated Status
 S MDWP(1405)=+MDCON_";GMR(123," ; Package Reference
 S MDWP(70201)=5 ; Default Procedure Summary Code "Machine Resulted"
 I MDPDT S MDWP(70202)=MDPDT ; Date/Time Performed
 ; File PCE Error message
 I MDNVST S MDRESU=$$EN1^MDPCE(MDGST,$P(MDVSTR,";",2),MDPROC,$P(MDVSTR,";",3),"P") I +MDRESU S MDVST=+MDRESU,MDVSTR=$P(MDRESU,"^",2)
 I MDNVST&(+MDRESU<0) D FILEMSG(MDGST,"PCE",2,$P(MDRESU,"^",2)) Q MDRESU
 ; Create the TIU note stub
 S MDNOTE="" D MAKE^TIUSRVP(.MDNOTE,DFN,MDTITL,$P(MDVSTR,";",2),MDLOC,$S(MDVST:MDVST,1:""),.MDWP,MDVSTR,1,1)
 I '(+MDNOTE) S $P(MDNOTE,"^")=-1 Q MDNOTE
 ; Finalize the transaction
 S MDFDA(702,STUDY_",",.06)=+MDNOTE
 S MDFDA(702,STUDY_",",.08)=""
 S:MDVST>0 MDFDA(702,STUDY_",",.13)=MDVST
 D FILE^DIE("","MDFDA")
 D UPD^MDKUTLR(STUDY,+MDNOTE)
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
 ;
