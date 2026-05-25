PSOERXI1 ;ALB/BWF - eRx Utilities/RPC's ; Aug 01, 2025@11:00
 ;;7.0;OUTPATIENT PHARMACY;**581,617,692,706,700,743,746,783,770,800**;DEC 1997;Build 1
 ;
 ;Reference to MAKEADD^TIUSRVP2 in ICR #4795
 Q
 ; File incoming XML into appropriate file
 ; XML - xml text
 ; PRCHK - provider check information
 ; PACHK - patient check information
 ; DACHK - drug auto check
 ; STATION - station #
 ; DIV - institution name^NPI
 ; ERXHID - eRx processing hub id^CANCEL/CHANGE REQUEST DENIED BY HUB (1=YES)^relates to hub ID
 ; ERXVALS - code values for NIST codes (potency unit code^form code^strength code^prohibit renewals - change response (y/n))
 ; XML2 - structured sig from the medication prescribed segment
 ; VADAT - DUZ^RXIEN
 ; XML3 - third stream of XML
INCERX(RES,XML,PRCHK,PACHK,DACHK,STATION,DIV,ERXHID,ERXVALS,XML2,VADAT,XML3) ;
 N MBMSITE,CURREC,FDA,EIEN,ERRTXT,ERRSEQ,PACNT,PASCNT,PAICN,PAIEN,VAINST,NPI,VAOI,VPATINST,PRVAUTOV,VISTARX,VADRUG,DFN,ERXNDC,XMsgPos,XMsgEnd,XMsgSav,XVAR
 ; This error handling prevents delays at the eRx Hub because it always returns a result
 N $ESTACK,$ETRAP S $ETRAP="D ERROR^PSOERXI1"
 S MBMSITE=$S($$GET1^DIQ(59.7,1,102,"I")="MBM":1,1:0)
 ; PSO,800 carry forward xlsns definition if needed for xsi:type in subsequent split message blocks.
 I XML["xmlns:xsi" S XMsgPos=$F(XML,"<Message ") I XMsgPos D
 . S XMsgEnd=$F(XML,">",XMsgPos) I 'XMsgEnd Q
 . S XMsgSav=$E(XML,XMsgPos-1,XMsgEnd-1)
 . F XVAR="XML2","XML3" I (@XVAR["<Message>")&(@XVAR["xsi:") S $E(@XVAR,($F(@XVAR,"<Message>")-1))=XMsgSav
 S NPI=$P($G(DIV),U,2),CURREC=$$PARSE^PSOERXI2(.XML,.ERXVALS,NPI,.XML2,.XML3)
 I $P(CURREC,U)<1 D  Q
 . I $L($P(CURREC,U,2)) S RES=CURREC Q
 . S RES="0^XML received. Error creating or finding associated record in the ERX Holding queue." Q
 S EIEN=CURREC
 S CURREC=CURREC_","
 ;If this is an outbound message, file the users DUZ and quit back the response. No drug, patient, or provider auto checks will occur
 I $G(VADAT)]"" D  Q
 . I $P($G(VADAT),U)>1 D
 . . S FDA(52.49,CURREC,51.1)=DUZ D FILE^DIE(,"FDA") K FDA
 . I $P(VADAT,U,2) D
 . . S FDA(52.49,CURREC,.13)=$P(VADAT,U,2) D FILE^DIE(,"FDA") K FDA
 . S RES="1^Erx Received."
 ;Process auto-validation results. Only log positive results for now
 K FDA
 I $P($G(VADAT),U) S RES="1^Message Filed." Q
 ;
 ;Drug Auto-Match (Moved from Hub to VistA - P-692)
 ;Attempting auto-match based on VistA Drug Suggestions (Uses the lastest one)
 N DRUGHASH,MTCHDRUG
 S MTCHDRUG=$$MTCHDRUG(),DRUGHASH=$$DRUGHASH^PSOERUT(+CURREC)
 I MTCHDRUG,DRUGHASH D
 . I $$GET1^DIQ(52.49,CURREC,.08,"I")="RE",$$GET1^DIQ(52.49,CURREC,52.1,"I")'="R" Q
 . I $$GET1^DIQ(52.49,CURREC,.08,"I")="CX",$$GET1^DIQ(52.49,CURREC,52.1,"I")'="A",$$GET1^DIQ(52.49,CURREC,52.1,"I")'="AWC" Q
 . S ERXNDC=$TR($TR($$GET1^DIQ(52.49311,"1,"_CURREC_",",1.1,"I")," "),"-")
 . S VISTARX="" F  S VISTARX=$O(^PS(52.49,"ADRGVRX",DRUGHASH,VISTARX),-1) Q:'VISTARX  D  I $$GET1^DIQ(52.49,+CURREC,3.2,"I") Q
 . . S VADRUG=+$$GET1^DIQ(52,VISTARX,6,"I") I 'VADRUG Q
 . . I $$GET1^DIQ(50,VADRUG,100,"I") D  Q
 . . . K ^PS(52.49,"ADRGVRX",DRUGHASH,VISTARX)
 . . ; For pre-populating all drug fields, the incoming NDC/Name should match VistA DRUG/NDF files
 . . I VADRUG'=MTCHDRUG Q
 . . D SAVEDRUG^PSOERUT2(+CURREC,VISTARX)
 . . I $$GET1^DIQ(52.49,+CURREC,3.2,"I") D
 . . . K DACHK S DACHK("success")="true",FDA(52.49,CURREC,1.4)=1
 ;Auto-matching the Dispense Drug only
 I '$$GET1^DIQ(52.49,+CURREC,3.2,"I"),+$G(MTCHDRUG) D
 . K DACHK S DACHK("success")="true"
 .;Saving the eRx Audit Log For Auto-Matched Drug
 . S NEWVAL(1)=$$GET1^DIQ(50,MTCHDRUG,.01)_" (NDC#: "_$$GETNDC^PSSNDCUT(MTCHDRUG)_")"
 . D AUDLOG^PSOERXUT(+CURREC,"DRUG",$$PROXYDUZ^PSOERXUT(),.NEWVAL)
 .;Setting Matched Drug and Auto Match info
 . S FDA(52.49,CURREC,3.2)=MTCHDRUG
 . S FDA(52.49,CURREC,44)=1
 . S VAOI=$$GET1^DIQ(50,MTCHDRUG,2.1,"I")
 . S VPATINST=$$GET1^DIQ(50.7,VAOI,7,"E")
 . I $L(VPATINST) D
 . . S (NEWVAL(1),FDA(52.49,CURREC,27))=VPATINST
 . . D AUDLOG^PSOERXUT(+CURREC,"PATIENT INSTRUCTIONS",$$PROXYDUZ^PSOERXUT(),.NEWVAL)
 . ; Adjusting the # of refills field if over the maximum allowed
 . I $$GET1^DIQ(52.49,+CURREC,20.5)>$$MAXNUMRF^PSOUTIL(MTCHDRUG,$$GET1^DIQ(52.49,+CURREC,20.2)) D
 . . S FDA(52.49,+CURREC_",",20.5)=$$MAXNUMRF^PSOUTIL(MTCHDRUG,$$GET1^DIQ(52.49,+CURREC,20.2))
 ;
 I $G(DACHK("success"))'="true" D
 . S ERRTXT=$G(DACHK("error"))
 . S ERRSEQ=$$ERRSEQ^PSOERXU1(EIEN) Q:'ERRSEQ
 . D FILERR^PSOERXU1(CURREC,ERRSEQ,"D","E",ERRTXT)
 ;
 ;Provider Auto-Match (Moved from Hub to VistA - P-692)
 I $G(PRCHK("success"))="false" D
 . N TMP,MSGTYPE,MTCHPROV,TMP,NPI,DEA,CS
 . S MSGTYPE=$O(^TMP($J,"PSOERXO1","Message",0,"Body",0,"")) I MSGTYPE="" Q
 . S DEA=$G(^TMP($J,"PSOERXO1","Message",0,"Body",0,MSGTYPE,0,"Prescriber",0,"NonVeterinarian",0,"Identification",0,"DEANumber",0))
 . S NPI=$G(^TMP($J,"PSOERXO1","Message",0,"Body",0,MSGTYPE,0,"Prescriber",0,"NonVeterinarian",0,"Identification",0,"NPI",0))
 . S CS=($G(^TMP($J,"PSOERXO1","Message",0,"Header",0,"DigitalSignature",0,"SignatureValue",0))'="")
 . D PRVMTCH^PSOERXA0(.MTCHPROV,NPI,DEA,CS)
 . I +$G(MTCHPROV) D
 . . K PRCHK S PRCHK("success")="true",PRCHK("IEN")=+MTCHPROV
 ;Attempting auto-match based on VistA Provider Suggestions (Uses the lastest one)
 I '$G(PRCHK("IEN")) D
 . N EPRV,VPRV,SUGVPRV,MTCHDT S EPRV=+$$GET1^DIQ(52.49,+CURREC,2.1,"I"),(VPRV,SUGVPRV,MTCHDT)=0
 . F  S VPRV=$O(^PS(52.49,"APRVVPRV",EPRV,VPRV)) Q:'VPRV  D
 . . I $$GET1^DIQ(200,VPRV,53.4,"I") K ^PS(52.49,"APRVVPRV",EPRV,VPRV) Q   ; VistA Provider is Inactive
 . . I $O(^PS(52.49,"APRVVPRV",EPRV,VPRV,""),-1)>MTCHDT D
 . . . S SUGVPRV=VPRV,MTCHDT=$O(^PS(52.49,"APRVVPRV",EPRV,VPRV,""),-1)
 . I SUGVPRV D
 . . K PRCHK S PRCHK("success")="true",FDA(52.49,CURREC,1.2)=1,(FDA(52.49,CURREC,2.3),PRCHK("IEN"))=SUGVPRV
 ;Auto-Validating Provider
 S PRVAUTOV=0
 I $G(PRCHK("success"))="true",$G(PRCHK("IEN")) D
 . S FDA(52.49,CURREC,1.2)=1
 . S FDA(52.49,CURREC,2.3)=PRCHK("IEN")
 . ;Auto-Validating Provider if auto-match was successful
 . ;Condition: Non-CS eRx only & Last name, first letter of first name and zip code 5 digits must match
 . N EPRVIEN,EPRVNAM,EPRVZC,EPRVDEA,VPRVIEN,VPRVNAM,VPRVZC
 . S EPRVIEN=$$GET1^DIQ(52.49,+CURREC,2.1,"I")
 . S EPRVNAM=$$UP^XLFSTR($TR($$GET1^DIQ(52.48,EPRVIEN,.01)," "))
 . S EPRVZC=$P($$GET1^DIQ(52.48,EPRVIEN,4.5),"-")
 . S EPRVDEA=$$UP^XLFSTR($$GET1^DIQ(52.48,EPRVIEN,1.6))
 . S VPRVIEN=PRCHK("IEN") I '$$CHKPRV2^PSOERX1A(VPRVIEN) Q
 . S VPRVNAM=$$UP^XLFSTR($TR($$GET1^DIQ(200,VPRVIEN,.01)," "))
 . S VPRVZC=$P($$GET1^DIQ(200,VPRVIEN,.116),"-")
 . I $E(EPRVNAM,1,$F(EPRVNAM,","))'=$E(VPRVNAM,1,$F(VPRVNAM,",")) Q
 . I $E(EPRVZC,1,5)'=$E(VPRVZC,1,5) Q
 . I $$GET1^DIQ(52.49,+CURREC,95.1,"I"),'$$DEAFOUND^PSOERXU8(EPRVDEA,VPRVIEN) Q
 . S FDA(52.49,CURREC,1.3)=1
 . S FDA(52.49,CURREC,1.8)=$$PROXYDUZ^PSOERXUT()
 . S FDA(52.49,CURREC,1.9)=$$NOW^XLFDT()
 . S FDA(52.49,CURREC,2.7)=1
 . S PRVAUTOV=1
 I $G(PRCHK("success"))="true",$G(PRCHK("IEN")) D
 . ;Saving the eRx Audit Log for the Auto-Matched Provider
 . S NEWVAL(1)=$$GET1^DIQ(200,PRCHK("IEN"),.01)_" (DEA#: "_$P($$VADEA^PSOERXU8(PRCHK("IEN"),+CURREC),"^",2)_")"_$S($G(PRVAUTOV):" - AUTO-VALIDATED",1:"")
 . D AUDLOG^PSOERXUT(+CURREC,"PROVIDER",$$PROXYDUZ^PSOERXUT(),.NEWVAL)
 ;
 I $G(PRCHK("success"))="false" D
 . S ERRTXT=$G(PRCHK("error"))
 . S ERRSEQ=$$ERRSEQ^PSOERXU1(EIEN) Q:'ERRSEQ
 . D FILERR^PSOERXU1(CURREC,ERRSEQ,"PR","E",ERRTXT)
 ;
 I $G(PACHK("MVIerror"))']"" D
 . S PAICN=+$P($G(PACHK("ICN")),"V")
 . I PAICN D
 . . S (PAIEN,PACNT)=0 F  S PAIEN=$O(^DPT("AICN",PAICN,PAIEN)) Q:'PAIEN  D
 . . . S PACNT=PACNT+1
 . . . ;revisit in future build - if we find more than one match in the local system, do we log some sort of an error?
 . I $G(PACNT)=1 D  Q
 . . S FDA(52.49,CURREC,1.6)=1
 . . S FDA(52.49,CURREC,.05)=$O(^DPT("AICN",PAICN,0))
 . I $L(PACHK("ssn")) D
 . . S (PASCNT,PAIEN)=0 F  S PAIEN=$O(^DPT("SSN",$TR(PACHK("ssn"),"-",""),PAIEN)) Q:'PAIEN  D
 . . . S PASCNT=PASCNT+1
 . I $G(PASCNT)=1 D  Q
 . . S FDA(52.49,CURREC,1.6)=1
 . . S FDA(52.49,CURREC,.05)=$O(^DPT("SSN",$TR(PACHK("ssn"),"-",""),0))
 ;Attempting auto-match based on VistA Patient Suggestions (Uses the lastest one)
 I '$G(FDA(52.49,CURREC,.05)) D
 . N EPAT,VPAT,SUGVPAT,MTCHDT S EPAT=+$$GET1^DIQ(52.49,+CURREC,.04,"I"),(VPAT,SUGVPAT,MTCHDT)=0
 . F  S VPAT=$O(^PS(52.49,"APATVPAT",EPAT,VPAT)) Q:'VPAT  D
 . . I $O(^PS(52.49,"APATVPAT",EPAT,VPAT,""),-1)>MTCHDT D
 . . . S SUGVPAT=VPAT,MTCHDT=$O(^PS(52.49,"APATVPAT",EPAT,VPAT,""),-1)
 . I SUGVPAT S FDA(52.49,CURREC,1.6)=1,FDA(52.49,CURREC,.05)=SUGVPAT
 ;
 ;Saving the eRx Audit Log For Auto-Matched Patient
 S DFN=+$G(FDA(52.49,CURREC,.05))
 I DFN  D
 . N VADM D DEM^VADPT
 . S NEWVAL(1)=$$GET1^DIQ(2,DFN,.01)_" (L4SSN: "_$P($P(VADM(2),"^",2),"-",3)_" | DOB: "_$P(VADM(3),"^",2)_")"
 . D AUDLOG^PSOERXUT(+CURREC,"PATIENT",$$PROXYDUZ^PSOERXUT(),.NEWVAL)
 ;
 I $D(FDA) D FILE^DIE(,"FDA") K FDA
 ;
 ; Auto-holds for MbM
 I $G(MBMSITE),DFN D
 . I ",N,I,W,RXI,RXN,RXW,RXR,CXI,CXN,CXW,"'[(","_$$GET1^DIQ(52.49,CURREC,1,"I")_",") Q
 . I '$$CHVAELIG^PSOERXU9(DFN) D  Q
 . . D UPDSTAT^PSOERXU1(CURREC,"HEL","Hold due to Eligibility Issue")
 . N GMRA,GMRAL
 . S GMRA="0^0^111" D EN1^GMRADPT I $G(GMRAL)'="" Q
 . D UPDSTAT^PSOERXU1(CURREC,"HAL","Hold for Allergy Assessment")
 ;
 I $G(PACHK("success"))="false" D
 .; file e&e error
 . S ERRTXT=$G(PACHK("EandEerror")) I ERRTXT]"" D
 . . S ERRSEQ=$$ERRSEQ^PSOERXU1(EIEN) Q:'ERRSEQ
 . . D FILERR^PSOERXU1(CURREC,ERRSEQ,"PA","E",ERRTXT)
 .; file mvi error
 . S ERRTXT=$G(PACHK("MVIerror")) I ERRTXT]"" D
 . . S ERRSEQ=$$ERRSEQ^PSOERXU1(EIEN) Q:'ERRSEQ
 . . D FILERR^PSOERXU1(CURREC,ERRSEQ,"PA","E",ERRTXT)
 ;
 S RES="1^Erx Received."
 ;
 ;Create an Addendum for eRx Change Response Progress Note
 I $G(EIEN)'="",$$GET1^DIQ(52.49,EIEN,.08,"I")="CX" D CREATEADD(ERXHID,EIEN)
 Q
 ;
CREATEADD(ERXHID,EIEN) ;Create CPRS Progress Notes Addendum for this eRx Change Response
 ;Input: ERXHID - eRx processing hub id^CANCEL/CHANGE REQUEST DENIED BY HUB (1=YES)^relates to hub ID
 ;       EIEN   - The eRx Change Response IEN, Pointer to ERX HOLDING QUEUE file (#52.49)
 ;Output: Create an Addendum and attach it to the parent eRx Change Request
 ;
 I ($G(ERXHID)="")!($G(EIEN)="") Q
 N CNT,CRERXIEN,ORGERXIEN,ERXDRUG,CRMEDS,CNT,CXTARGET,ERXDRUG,PSOTIUIEN,TIUDADD,ERXTIUX
 ;
 S CRERXIEN=$O(^PS(52.49,"B",$P(ERXHID,"^",3),0))
 S ORGERXIEN=$P($G(^PS(52.49,CRERXIEN,0)),"^",14)
 S ORGERXIEN=$O(^PS(52.49,"B",ORGERXIEN,0))
 ;
 ;get the parent reference IEN TIU Document
 S PSOTIUIEN=$$GET1^DIQ(52.49,CRERXIEN,320.1)
 I '$G(PSOTIUIEN) D  Q
 . N TIUTITLE S TIUTITLE="PHARMACY ERX RX CHANGE REQUEST NOTE"
 . I '+$$FIND1^DIC(8925.1,"","X",TIUTITLE,"B") S TIUTITLE="ERX RX CHANGE REQUEST NOTE"
 . D BLDCRMEDS(ERXHID,+$G(MTCHDRUG),TIUTITLE)
 ;
 S CXTARGET=$NA(^TMP("TIUP",$J)) K @CXTARGET
 D BUILDLST^PSOERSE4(CXTARGET,EIEN)
 Q:'$D(@CXTARGET)
 K ERXTIUX M ERXTIUX("TEXT")=@CXTARGET
 D MAKEADD^TIUSRVP2(.TIUDADD,PSOTIUIEN,.ERXTIUX) ;PSOTIUIEN is the parent IEN from The TIU Document Definition name in File #8925.1
 D UPDATEPN^PSOERX1H(.TIUDADD,$G(ORGERXIEN)) ;TIUDADD is the Addendum IEN
 Q
 ;
BLDCRMEDS(ERXHID,VDRUG,TIUTITLE) ;Build eRx Change Response Medication array
 ;get the original eRx
 Q:$G(ERXHID)=""
 N CRERXIEN,ORGERXIEN,ERXDRUG,CRMEDS
 ;
 S CRERXIEN=$O(^PS(52.49,"B",$P(ERXHID,"^",3),0))
 S ORGERXIEN=$P($G(^PS(52.49,CRERXIEN,0)),"^",14)
 S ORGERXIEN=$O(^PS(52.49,"B",ORGERXIEN,0))
 S CNT=0
 I $G(VDRUG) D
 . S ERXDRUG=$$GET1^DIQ(50,$G(VDRUG),.01)
 . S CNT=CNT+1,CRMEDS(CNT)="^"_ERXDRUG
 ;
 D CREATEPN^PSOERX1H(ORGERXIEN,EIEN,,.CRMEDS,TIUTITLE) ;create eRx Change Response PN
 ;
 Q
 ; VAL - value to resolve
 ; TYPE - This is the code type, which will tell which 'C' index type to get the code from
PRESOLV(VAL,TYPE) ;
 N MATCH
 S MATCH=""
 Q:'$L(TYPE)!('$L(VAL)) "" ; avoid null subscript
 S MATCH=$O(^PS(52.45,"C",TYPE,VAL,0))
 ; return the match found, null if no match
 Q MATCH
CONVDTTM(VAL) ;
 N EDATE,ETIME,X,ETZ,Y,%DT,%
 I '$L(VAL) Q ""
 S EDATE=$P(VAL,"T"),ETIME=$P(VAL,"T",2)
 ; split off time zone
 S ETZ=$P(ETIME,".",2)
 S ETIME=$P(ETIME,".")
 S X=EDATE D ^%DT I 'Y Q ""
 S VAL=Y_$S($L(ETIME):"."_$TR(ETIME,":",""),1:"")
 Q VAL
 ;
MTCHDRUG() ; Returns the Matched Dispensed Drug based on the NDF files
 ;Output: MTCHDRUG - VistA Dispense Drug associated with the Name/NDC from outside (Pointer to file #50)
 N MSGTYPE,MEDSEG,MTCHDRUG,PRDCODE,PRDCOQL,DRGNAME
 S MTCHDRUG=0
 S MSGTYPE=$O(^TMP($J,"PSOERXO1","Message",0,"Body",0,"")) I MSGTYPE="" Q 0
 S MEDSEG="MedicationPrescribed"
 I '$D(^TMP($J,"PSOERXO1","Message",0,"Body",0,MSGTYPE,0,MEDSEG)) D
 . S MEDSEG="MedicationResponse"
 S PRDCODE=$G(^TMP($J,"PSOERXO1","Message",0,"Body",0,MSGTYPE,0,MEDSEG,0,"DrugCoded",0,"ProductCode",0,"Code",0)) I PRDCODE="" Q 0
 S PRDCOQL=$E($G(^TMP($J,"PSOERXO1","Message",0,"Body",0,MSGTYPE,0,MEDSEG,0,"DrugCoded",0,"ProductCode",0,"Qualifier",0)),1)
 I PRDCOQL'="N",PRDCOQL'="U" Q 0
 S DRGNAME=$G(^TMP($J,"PSOERXO1","Message",0,"Body",0,MSGTYPE,0,MEDSEG,0,"DrugDescription",0))
 D DRGMTCH^PSOERXA0(.MTCHDRUG,PRDCOQL_"^"_PRDCODE,DRGNAME)
 Q +$G(MTCHDRUG)
 ;
ERROR ; Error Handling
 D ^%ZTER
 S RES="1^eRx received but there was an error. See error trap at "_$P($TR($$SITE^VASITE(),"^","-"),"-",1,2) Q
 Q
