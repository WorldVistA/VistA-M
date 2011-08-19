MDRPCOW ; HOIFO/DP/NCA - Billing Widget ;10/3/05  12:17
 ;;1.0;CLINICAL PROCEDURES;**6**;Apr 01, 2004;Build 102
 ; Reference IA# 2240 [Supported] ENCRYP^XUSRB1 call
 ;               2241 [Supported] DECRYP^XUSRB1 call
 ;               10017 [Supported] ^DD("DD") reference
 ;               10040 [Supported] Hospital Location File Access
 ;               10045 [Supported] XUSHSHP call
 ;               10060 [Supported] FILE 200 references
 ;
RPC(RESULTS,OPTION,P1,P2,P3,P4,P5,P6,P7) ; [Procedure] Main RPC call
 ; RPC: [MD TMDWIDGET]
 ;
 D CLEAN^DILF
 S RESULTS=$NA(^TMP("MDKUTL",$J)) K @RESULTS
 I $T(@OPTION)="" D  Q
 .S @RESULTS@(0)="-1^Error in RPC: MD TMDWIDGET at "_OPTION_U_$T(+0)
 D @OPTION S:'$D(@RESULTS) @RESULTS@(0)="-1^No return"
 D CLEAN^DILF
 Q
 ;
SUBMIT ; Submit a final report to close out an entry in 702
 ;
 ; P1=702 IEN
 ; P2=Encoded E-Sig
 ; P3=Array containing the text for the note
 ;
 I '$D(^MDD(702,+P1,0)) S @RESULTS@(0)="-1^No such study" Q
 I $P(^MDD(702,+P1,0),U,9)=2 S @RESULTS@(0)="-1^Study is in Error status, cannot use study until the error is fixed." Q
 I "016"[$P(^MDD(702,+P1,0),U,9) S @RESULTS@(0)="-1^Cannot submit - not a Dialysis study." Q
 I $D(P3)<1 S @RESULTS@(0)="-1^No note text" Q
 I P2="" D PCE Q
 K ^TMP("MDTXT",$J)
 S X="",Y=1
 F  S X=$O(P3(X)) Q:X=""  S ^TMP("MDTXT",$J,Y)=P3(X),Y=Y+1
 ; a "1^Note Filed" if everything is ok otherwise an error msg
 I P2'="" S P2=$$DECRYP^XUSRB1(P2),P2=$$ENCRYP^XUSRB1(P2)
 ;S @RESULTS@(0)=$$SUBMIT^MDRPCOT2(+P1,P2,$NA(^TMP("MDTXT",$J)),.P7)
 S @RESULTS@(0)=$$SUBMIT^MDRPCOT2(+P1,P2,$NA(^TMP("MDTXT",$J)))
 I +@RESULTS@(0)>0 S @RESULTS@(0)="1^Approval Message"
 N XX S XX="",XX=$$UPDCONS^MDRPCOT1(+$P($G(^MDD(702,+P1,0)),U,5),+$P($G(^MDD(702,+P1,0)),U,6))
 ;
 K ^TMP("MDTXT",$J) Q
 Q
 ;
ESIG ; [Procedure] Verify users electronic signature
 I $G(P1)="" D  Q
 .S @RESULTS@(0)="-1^Must supply electronic signature code"
 S X=$$DECRYP^XUSRB1(P1)
 D HASH^XUSHSHP
 I X'=$$GET1^DIQ(200,DUZ_",",20.4,"I") S @RESULTS@(0)="-1^E-Sig Invalid^"
 E  S @RESULTS@(0)="1^E-Sig Verifed^"_X
 Q
 ;
GETBILL ; Get Billing Data
 Q
 N MDFLD
 ;D BLDFLD^MDXMLFM(.MDFLD,702,".001;;STUDY_ID^.01;;PATIENT_ID")
 ;D BLDFLD^MDXMLFM(.MDFLD,702,".14;;ICD_01^.15;;ICD_02^.16;;ICD_03^.17;;ICD_04^.18;;CPT_01")
 ;D BLDFLD^MDXMLFM(.MDFLD,702,".19;;SC_CONDITION^.2;;MST^.21;;AO_EXPOSURE^.22;;IR_EXPOSURE^.23;;EV_CONTAMINENTS^.24;;HEAD_NECK_CANCER^.25;;COMBAT_VETERAN")
 ;D BLDFLD^MDXMLFM(.MDFLD,702,".26;;PRIMARY_PROVIDER_ID")
 ;D BLDFLD^MDXMLFM(.MDFLD,702,".26:.01;;PRIMARY_PROVIDER_NAME")
 ;D BLDFLD^MDXMLFM(.MDFLD,702,".27;;ATTENDING_PROVIDER_ID")
 ;D BLDFLD^MDXMLFM(.MDFLD,702,".27:.01;;ATTENDING_PROVIDER_NAME")
 ;D LOADONE^MDXMLFM(P1,702,.MDFLD)
 Q
 ;
SETBILL ; Set Billing Data
 N MDFDA,MDERR
 ;F X=0:1:13 S P2(X)=$G(P2(X)) D
 ;.D VAL^DIE(702,+P1_",",.14+(X*.01),"F",P2(X),.MDERR,"MDFDA")
 ;.Q:MDERR'="^"  ; Validated
 ;.S Y="Bad value: "_$$GET1^DID(702,.14+(X*.01),,"LABEL")_" '"_P2(X)_"'"
 ;.S @RESULTS@($O(@RESULTS@(""),-1)+1)=Y
 ;I $D(@RESULTS) S @RESULTS@(0)="-1^Errors filing data" Q
 ;D FILE^DIE("","MDFDA")
 S @RESULTS@(0)="1^Ok"
 Q
 ;
PCE ; Set PCE Data
 ;
 ; P1=702 IEN
 ; P2=Encoded E-Sig
 ; P3=Array containing the text for the note
 ; P7=Array of Billing information
 ;
 N CTR,DFN,MDCON,MDFDA,MDGST,MDL,MDLOC,MDNOTE,MDPDT,MDPROC,MDRESU,MDTITL,MDTSTR,MDVST,MDVSTR,MDWP S CTR=0,MDGST=+P1,MDRESU=""
 I '$D(^MDD(702,+P1,0)) S @RESULTS@(0)="-1^No such study" Q
 ;
 ; Get data to set PCE data
 S (MDTSTR,MDRESU)=$$GETDATA^MDRPCOT2(MDGST)
 ; File Error message
 I +MDRESU<0 S @RESULTS@(0)=MDRESU Q
 I $G(MDTSTR)="" S @RESULTS@(0)="-1^No Data in study to set PCE data." Q
 F MDL="DFN","MDTITL","MDLOC","MDNOTE","MDCON","MDPROC","MDVSTR","MDNVST" D
 .S CTR=CTR+1,@MDL=$P(MDTSTR,"^",CTR)
 S (MDVST,MDRESU)=""
 I 'MDLOC S @RESULTS@(0)="-1^No Hospital Location." Q
 ; Create new visit, if no vstring
 S MDPDT=$$PDT^MDRPCOT1(MDGST)
 S:'MDPDT MDPDT=$P(MDVSTR,";",2) ; If No D/T Performed grab visit D/T
 ; File PCE Error message
 I MDNVST S MDRESU=$$EN1^MDPCE2(.P7,MDGST,$P(MDVSTR,";",2),MDPROC,$P(MDVSTR,";",3),"P",MDLOC) I +MDRESU S MDVST=+MDRESU
 I 'MDNVST S MDVST=$P($G(^MDD(702,+MDGST,1)),U) S MDRESU=$$EN1^MDPCE2(.P7,MDGST,$P(MDVSTR,";",2),MDPROC,$P(MDVSTR,";",3),"P",MDLOC) I +MDRESU S MDVST=+MDRESU
 I +MDRESU<0 S @RESULTS@(0)=MDRESU Q
 ;
 S @RESULTS@(0)="Approval Message"
 Q
GETLOC ; Get the existing hospital location
 N MDCL,MDPR,MDVV
 S MDPR=$P($G(^MDD(702,+P1,0)),U,4)
 S MDVV=$P($G(^MDD(702,+P1,0)),U,7)
 ;S MDCL=$$GET1^DIQ(702.01,+MDPR_",",.05,"I")
 S MDCL=$P(MDVV,";",3)
 I 'MDCL S MDCL=$$GET1^DIQ(702.01,+MDPR_",",.05,"I")
 I 'MDCL S @RESULTS@(0)="-1^No Hospital Location." Q
 S Y=$P(MDVV,";",2) I Y'="" X ^DD("DD")
 S @RESULTS@(0)=MDCL_U_$$GET1^DIQ(44,MDCL_",",.01,"I")_U_Y
 Q
SETLOC ; Set a new clinic location from GUI if non is found.
 N MDVV
 S MDVV=$P($G(^MDD(702,+P1,0)),U,7)
 I P2="" S @RESULTS@(0)="-1^No Location Selected."
 I $L(MDVV,";")=1 S MDVV=";"_MDVV
 S $P(MDVV,";",3)=P2
 S $P(^MDD(702,P1,0),U,7)=MDVV
 S @RESULTS@(0)="1^Okay Location Updated."
 Q
CHECK ; return TRUE if PCE data filled
 N MDIL,MDOKAY,MDCK,MDECTR
 S (MDECTR,MDIL)=0,MDCK="",MDOKAY("POV")="",MDOKAY("CPT")="",MDOKAY("PRV")=""
 F  S MDIL=$O(@P2@(MDIL)) Q:MDIL=""  S MDCK=$G(@P2@(MDIL)) D
 . I $P(MDCK,U,1)="POV" S:$G(MDOKAY("POV"))="" MDOKAY("POV")=1
 . I $P(MDCK,U,1)="CPT" S:$G(MDOKAY("CPT"))="" MDOKAY("CPT")=1
 . I $P(MDCK,U,1)="PRV" S:$G(MDOKAY("PRV"))="" MDOKAY("PRV")=1
 F MDIL="POV","PRV","CPT" S MDECTR=MDECTR+$G(MDOKAY(MDIL))
 I MDECTR<3 S @RESULTS@(0)="-1^Missing PCE data--Review Data Again." Q
 S @RESULTS@(0)=1
 Q
NAME ; Get the person name
 S @RESULTS@(0)="1^"_$$GET1^DIQ(200,+P2_",",.01,"E")
 Q
STAT ; Get the okay status of the CP study
 N MDST,MDGN S MDGN=""
 S MDST=$$GET1^DIQ(702,+P1,.09,"E") S MDGN=MDST
 I $$GET1^DIQ(702,+P1,.09,"I")=2 S MDGN=MDGN_"^"_$$GET1^DIQ(702,+P1,.08,"E")
 S @RESULTS@(0)=MDGN
 Q
STATUS ; [Procedure] Update transaction status
 N MDFDA
 S MDFDA(702,+P1_",",.09)=P2
 D FILE^DIE("","MDFDA")
 S @RESULTS@(0)="1^Done"
 Q
