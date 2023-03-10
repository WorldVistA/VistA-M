BPSRPC02 ;AITC/PD - ECME TAS RPC - Extract Txn Data;7/30/2018
 ;;1.0;E CLAIMS MGMT ENGINE;**27,31**;JUN 2004;Build 16
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EXTRACT(RESULT,ARGS) ; RPC: BPS TAS CLAIM DATA EXTRACT
 ; Extract the data for a specific Txn IEN
 ;
 ; EXTRACT requires a single BPS TRANSACTION IEN be passed in. Code
 ; will retrieve data fields for the transaction and return the data
 ; in a JSON formatted array.
 ;
 ; BPS59   - Input (Required)
 ;         - Transaction IEN from BPS TRANSACTION file (#9002313.59)
 ; RESULT - Output 
 ;         - JSON formatted array of data fields
 ;
 N BPS57,BPS59,BPSCNT,BPSDFN,BPSDRG,BPSDRGCLID,BPSDRGCLNM,BPSECME
 N BPSFHIR,BPSFLD,BPSI,BPSLST,BPSPC,BPSPC1,BPSPOS,BPSPR,BPSPRV,BPSPTID,BPSRC
 N BPSRDT,BPSRF,BPSRJC,BPSRJDATA,BPSRJE,BPSRJF,BPSRJN,BPSRX,BPSRXACT
 N BPSRXACT1,BPSSQ,BPSSTATUS,BPSSTR,BPSTMP,BPSTMP1,BPSVASITE,BPSX,RESP1
 ; 
 S RESULT=$NA(^TMP("JSON",$J)) K @RESULT
 I $G(ARGS("LOG")) D LOG("ARGS")  ; create log if requested
 S BPS57=$G(ARGS("BPS59"))
 I BPS57="" Q
 I '$D(^BPSTL(BPS57)) Q
 I BPS57=12345 D EXTRACT^BPSRPC04 G JSON
 S BPS59=$$GET1^DIQ(9002313.57,BPS57,.01,"I")
 ;
 ; ---------------------------------------
 ; Set up variables from BPS LOG OF TRANSACTIONS FILE required for collection
 ; of data fields
 ;
 ; PRESCRIPTION NUMBER - Field 1.11 - Pointer to PRESCRIPTION FILE #52
 S BPSRX=$$GET1^DIQ(9002313.57,BPS57,1.11,"I")
 ;
 ; CLAIM - Field 3 - Pointer to BPS CLAIMS FILE #9002313.02
 S BPSPC=$$GET1^DIQ(9002313.57,BPS57,3,"I")
 ;
 ; RESPONSE - Field 4 - Pointer to BPS RESPONSES FILE #9002313.03
 S BPSRC=$$GET1^DIQ(9002313.57,BPS57,4,"I")
 ;
 ; PATIENT - Field 5 - Pointer to PATIENT FILE #2
 S BPSDFN=$$GET1^DIQ(9002313.57,BPS57,5,"I")
 ;
 ; LAST UPDATE - Field 7 - Date/Time transaction last updated
 S BPSLST=$$GET1^DIQ(9002313.57,BPS57,7,"I")
 ;
 ; FILL NUMBER - Field 9
 S BPSRF=$$GET1^DIQ(9002313.57,BPS57,9,"I")
 ;
 ; POSITION IN CLAIM - Field 14
 S BPSPOS=$$GET1^DIQ(9002313.57,BPS57,14)
 ;
 ; START TIME - Field 15 - Date/Time transaction started
 S BPSSTR=$$GET1^DIQ(9002313.57,BPS57,15,"I")
 ;
 ; REVERSAL CLAIM - Field 401 - Pointer to BPS CLAIMS FILE #9002313.02
 S BPSPR=$$GET1^DIQ(9002313.57,BPS57,401,"I")
 ;
 ; RX ACTION - Field 1201
 S BPSRXACT=$$GET1^DIQ(9002313.57,BPS57,1201)
 ;
 ; COB Indicator (Payer Sequence)
 S BPSSQ=$$GET1^DIQ(9002313.57,BPS57,18,"I")
 ;
 ; Status of the Request
 S BPSSTATUS=$$GET1^DIQ(9002313.57,BPS57,4.0098)
 ;
 ; PROVIDER - Field 4 - Pointer to NEW PERSON FILE #200
 S BPSPRV=$$GET1^DIQ(52,BPSRX,4,"I")
 ;
 ; DRUG - Field 6 - Pointer to DRUG FILE #50
 S BPSDRG=$$GET1^DIQ(9002313.57,BPS57,9999.94)
 S BPSDRGCLID=$$DRUGDIE^BPSUTIL1(BPSDRG,25)
 S BPSDRGCLNM=$$DRGCLNAM^BPSRPT6(BPSDRGCLID,50)
 ;
 S BPSVASITE=$$NS^XUAF4($$KSP^XUPARAM("INST"))
 ;
 ; ---------------------------------------
 ;
 ; Build BPSTMP array
 ;
 I $$GET1^DIQ(9002313.02,BPSPC,901,"I")=1 S BPSTMP("OpenClosed")="C"
 E  S BPSTMP("OpenClosed")="O"
 ;
 I BPSTMP("OpenClosed")="C" D
 . S BPSTMP("ClosedByUser")=$$GET1^DIQ(9002313.02,BPSPC,903)
 . S BPSTMP("ClosedDate")=$$FMTE^XLFDT($$GET1^DIQ(9002313.02,BPSPC,902,"I"),"7DZ")
 . S BPSTMP("ClosedDate")=$TR(BPSTMP("ClosedDate"),"/","-")
 . S BPSTMP("ClosedReason")=$$GET1^DIQ(9002313.02,BPSPC,904)
 E  D
 . S BPSTMP("ClosedByUser")=""
 . S BPSTMP("ClosedDate")=""
 . S BPSTMP("ClosedReason")=""
 ;
 S BPSTMP("BilledAmount")=$$GET1^DIQ(9002313.57,BPS57,505)
 S BPSTMP("BillNumber")=$$BILL^BPSRPT6(BPSRX,BPSRF,BPSSQ)
 S BPSTMP("BIN")=$$GET1^DIQ(9002313.57,BPS57,10101)
 S BPSTMP("ClaimID")=$$GET1^DIQ(9002313.57,BPS57,3)
 I BPSPR'="" S BPSTMP("ClaimID")=$$GET1^DIQ(9002313.57,BPS57,401)
 S BPSTMP("CollectedAmount")=+$$COLLECTD^BPSRPT6(BPSRX,BPSRF,BPSSQ)
 S BPSTMP("CompletedDate")=$$FMTE^XLFDT($$GET1^DIQ(9002313.57,BPS57,7,"I"),"7DZ")
 S BPSTMP("CompletedDate")=$TR(BPSTMP("CompletedDate"),"/","-")
 S BPSTMP("DispensingFee")=$$GET1^DIQ(9002313.57,BPS57,504)
 S BPSTMP("DispensingFeePaid")=$$GET1^DIQ(9002313.57,BPS57,10507)
 S BPSTMP("Division")=$$GET1^DIQ(9002313.57,BPS57,1.07)
 S BPSTMP("DrugClass")=BPSDRGCLNM
 S BPSTMP("DrugName")=$$GET1^DIQ(9002313.57,BPS57,9999.93)
 ;
 S BPSPC1=BPSPC
 ; Check if claim is a reversal
 I BPSPR'="" S BPSPC1=BPSPR
 I BPSPC1=""!(BPSPOS="") S BPSECME=""
 E  S BPSECME=$P($G(^BPSC(BPSPC1,400,BPSPOS,400)),"^",2)
 I BPSECME="" S BPSECME=$$FORMAT^BPSSCRU2("",12," ",1)
 S BPSTMP("ECMENumber")=$E(BPSECME,3,14)
 ;
 S BPSTMP("ElapseTimeInSeconds")=$$GET1^DIQ(9002313.57,BPS57,9999.97)
 S BPSTMP("Eligibility")=$$GET1^DIQ(9002313.57,BPS57,901.04)
 I BPSTMP("Eligibility")="VETERAN" S BPSTMP("Eligibility")="Veteran"
 I (BPSRX&BPSRF) S BPSTMP("FillLocation")=$$MWC^PSOBPSU2(BPSRX,BPSRF)
 ;
 S BPSRXACT1="RT"
 I BPSRXACT="BB" S BPSRXACT1="BB"
 I BPSRXACT="P2"!(BPSRXACT="P2S") S BPSRXACT1="P2"
 I BPSRXACT="ERES"!(BPSRXACT="ERMV")!(BPSRXACT="ERNB") S BPSRXACT1="RS"
 S BPSTMP("FillType")=BPSRXACT1
 ;
 S BPSTMP("GroupID")=$$GET1^DIQ(9002313.57,BPS57,10301)
 S BPSTMP("IngredientCost")=$$GET1^DIQ(9002313.57,BPS57,10409)
 S BPSTMP("IngredientCostPaid")=$$GET1^DIQ(9002313.57,BPS57,10506)
 S BPSTMP("InsuranceName")=$P($$INSNAM^BPSRPT6(BPS59),"^",2)
 ;
 I (BPSPOS&BPSRC) S BPSTMP("InsurancePaidAmount")=+$$INSPAID1^BPSOS03(BPSRC,BPSPOS)
 E  S BPSTMP("InsurancePaidAmount")=0
 ;
 I $$GET1^DIQ(9002313.57,BPS57,10510)>1 S BPSTMP("MultipleRejects")="Y"
 E  S BPSTMP("MultipleRejects")="N"
 I $$GET1^DIQ(9002313.57,BPS57,10510)="" S BPSTMP("MultipleRejects")=""
 ;
 S BPSTMP("NDC")=$$GET1^DIQ(9002313.57,BPS57,10)
 ;
 S BPSPTID=$$GET1^DIQ(2,BPSDFN,.09)
 S BPSPTID=$E(BPSPTID,($L(BPSPTID)-3),$L(BPSPTID))
 S BPSTMP("PatientID")=BPSPTID
 ;
 S BPSTMP("PatientName")=$$GET1^DIQ(9002313.57,BPS57,5)
 S BPSTMP("PatientPayAmount")=$$GET1^DIQ(9002313.57,BPS57,10505)
 S BPSTMP("PayerResponse")=BPSSTATUS
 S BPSTMP("Prescriber")=$$GET1^DIQ(9002313.57,BPS57,10427)
 S BPSTMP("PrescriberID")=$$GET1^DIQ(9002313.57,BPS57,10411)
 S BPSTMP("Quantity")=$$GET1^DIQ(9002313.57,BPS57,501)
 S BPSTMP("Refill")=$$GET1^DIQ(9002313.57,BPS57,9)
 ;
 I BPSSTATUS["REJECTED" S BPSTMP("Rejected")="REJ"
 E  S BPSTMP("Rejected")=""
 ;
 F BPSRJF=10511.01:.01:10511.2 I $$GET1^DIQ(9002313.57,BPS57,BPSRJF)'="" D
 . S BPSRJDATA=$$GET1^DIQ(9002313.57,BPS57,BPSRJF)
 . S BPSRJC=$P(BPSRJDATA," ")
 . S BPSRJE=$P(BPSRJDATA," ",2,99)
 . S BPSRJN=(BPSRJF-10511)*100
 . S BPSTMP("RejectCode"_BPSRJN)=BPSRJC
 . S BPSTMP("RejectExplanation"_BPSRJN)=BPSRJE
 ;
 S BPSTMP("ReleasedDate")=$$FMTE^XLFDT($$GET1^DIQ(9002313.57,BPS57,9999.95,"I"),"7DZ")
 S BPSTMP("ReleasedDate")=$TR(BPSTMP("ReleasedDate"),"/","-")
 ;
 I BPSSTATUS["REVERSAL" D
 . I BPSSTATUS["ACCEPTED" S BPSTMP("ReturnStatus")="ACCEPTED"
 . E  S BPSTMP("ReturnStatus")="REJECTED"
 . ;
 . I +$$GET1^DIQ(9002313.02,BPSPC,.07,"I")=0 S BPSTMP("ReversalMethod")="Regular"
 . E  S BPSTMP("ReversalMethod")="Auto"
 . ;
 . S BPSTMP("ReversalReason")=$$GET1^DIQ(9002313.57,BPS57,404)
 E  D
 . S BPSTMP("ReturnStatus")=""
 . S BPSTMP("ReversalMethod")=""
 . S BPSTMP("ReversalReason")=""
 ;
 S BPSTMP("RxCOB")=""
 I BPSSQ=1 S BPSTMP("RxCOB")="p"
 I BPSSQ=2 S BPSTMP("RxCOB")="s"
 I BPSSQ=3 S BPSTMP("RxCOB")="t"
 ;
 S BPSTMP("RxNumber")=$$GET1^DIQ(9002313.57,BPS57,1.11)
 S BPSTMP("SiteName")=$P(BPSVASITE,"^")
 S BPSTMP("SiteNumber")=$P(BPSVASITE,"^",2)
 S BPSTMP("Touched")=$$TOUCHED^BPSUTIL(BPS57)
 S BPSTMP("TransactionDate")=$$FMTE^XLFDT($$GET1^DIQ(9002313.57,BPS57,6,"I"),"7DZ")
 S BPSTMP("TransactionDate")=$TR(BPSTMP("TransactionDate"),"/","-")
 ;
 I BPSRF=0 S BPSRDT=$$RXRELDT^BPSRPT6(BPSRX)\1
 I BPSRF'=0 S BPSRDT=$$REFRELDT^BPSRPT6(BPSRX,BPSRF)\1
 S BPSX="/N"
 I $P(BPSRDT,"^") S BPSX="/R"
 S BPSTMP("TransactionStatus")=$$RXST^BPSSCRU2(BPS59)_BPSX
 ;
 S RESP1=""
 I BPSSTATUS="E CAPTURED" S RESP1="Captured"
 I BPSSTATUS="E DUPLICATE" S RESP1="Duplicate"
 I BPSSTATUS="E PAYABLE" S RESP1="Payable"
 I BPSSTATUS="E REJECTED" S RESP1="Rejected"
 I BPSSTATUS["REVERSAL" S RESP1="Reversal"
 I BPSSTATUS["UNSTRANDED" D
 . S RESP1="Unstranded"
 . S BPSTMP("Touched")=1
 I RESP1="" S RESP1="Other"
 S BPSTMP("TransactionType")=RESP1
 ;
 D REFORMAT
 ;
JSON ; Prepare JSON file
 ; Transform the BPSTMP1 array into JSON format
 D ENCODE^XLFJSON("BPSTMP1",RESULT,$NA(^TMP("JSERR",$J)))
 I $D(^TMP("JSERR",$J)) D  Q  ; handle encoder error
 . D MSGSET(.RESULT,"Error","JSON encoding error.")
 S @RESULT@(1)="["_@RESULT@(1) ;$P(RESULT(1),":",2,9999)
 S BPSCNT=""
 S BPSCNT=$O(@RESULT@(BPSCNT),-1)
 S @RESULT@(BPSCNT)=$E(@RESULT@(BPSCNT),1,($L(@RESULT@(BPSCNT))-1))_"}]"
 Q
 ;
REFORMAT ; Reformat BPSTMP array
 ; Reformat BPSTMP array into BPSTMP1 to transform to JSON format
 ; BPSTMP1 will regroup fields by FHIR Resource
 S BPSFLD=""
 S BPSCNT=0
 F  S BPSFLD=$O(BPSTMP(BPSFLD)) Q:BPSFLD=""  D
 . ; Exclude field if value is nil
 . I $G(BPSTMP(BPSFLD))="" Q
 . S BPSFHIR1=""
 . F BPSI=1:1 S BPSFHIR=$P($T(FHIR+BPSI),";;",2,99) Q:BPSFHIR=""!(BPSFHIR1'="")  D
 . . I BPSFLD=$P(BPSFHIR,";;") S BPSFHIR1=$P(BPSFHIR,";;",2)
 . I BPSFHIR1="" S BPSFHIR1="Basic"
 . S BPSCNT=BPSCNT+1
 . S BPSTMP1("Bundle",BPSFHIR1,BPSCNT,BPSFLD)=BPSTMP(BPSFLD)
 Q
 ;
MSGSET(TYP,MSG) ;return error or informational message
 ; RSLT - storage location, passed by ref.
 ; TYP - message type
 ; MSG - text
 K @RESULT
 S @RESULT@(1)="[{"_$C(34)_$G(TYP)_$C(34)_" : "_$C(34)_$G(MSG)_$C(34)_"}]"
 Q
LOG(SVARRY) ; create log in ^XTMP('BPSTAS-LOG-'_'+$h')
 ; SVARRY - name of array to save, e.g. "RCVAL" or "ARG"
 N A,C,ND
 S ND="BPSTAS-LOG-"_(+$H)  ; one log node per day
 I '$D(^XTMP(ND,0)) D  ; need a zero node
 . ; expires after 3 days ^ created on ^ desc.
 . S A=$$HTFM^XLFDT($H+3),$P(A,"^",2)=$$NOW^XLFDT,$P(A,"^",3)="routine "_$T(+0)_" log"
 . S ^XTMP(ND,0)=A
 ; C - log counter
 S C=$G(^XTMP(ND,0,"COUNT"))+1,^("COUNT")=C_"^"_$H
 S ^XTMP(ND,C,"$J")=$J,^("$H")=$H,^("$I")=$I
 F A="DUZ","IO" M ^XTMP(ND,C,"var",A)=@A
 ; if SVARRY passed in, log it
 I $L($G(SVARRY)) S A=$NA(@SVARRY) M ^XTMP(ND,C,"log",A)=@A
 Q
 ;
FHIR ; Get FHIR Resource for field
 ;;BilledAmount;;Claim
 ;;BillNumber;;Claim
 ;;BIN;;Organization
 ;;ClaimID;;Claim
 ;;ClosedByUser;;Basic
 ;;ClosedDate;;Basic
 ;;ClosedReason;;Basic
 ;;CollectedAmount;;ClaimResponse
 ;;CompletedDate;;PaymentReconciliation
 ;;DispensingFee;;Claim
 ;;DispensingFeePaid;;ClaimResponse
 ;;Division;;Organization
 ;;DrugClass;;Substance
 ;;DrugName;;Medication
 ;;ECMENumber;;Basic
 ;;ElapseTimeInSeconds;;MedicationDispense
 ;;Eligibility;;Basic
 ;;FillLocation;;Location
 ;;FillType;;MedicationDispense
 ;;GroupID;;Coverage
 ;;IngredientCost;;Claim
 ;;IngredientCostPaid;;ClaimResponse
 ;;InsuranceName;;Organization
 ;;InsurancePaidAmount;;ClaimResponse
 ;;MultipleRejects;;Basic
 ;;NDC;;Medication
 ;;OpenClosed;;Claim
 ;;PatientID;;Patient
 ;;PatientName;;Patient
 ;;PatientPayAmount;;ExplanationOfBenefit
 ;;PayerResponse;;ClaimResponse
 ;;Prescriber;;Practitioner
 ;;PrescriberID;;Practitioner
 ;;Quantity;;MedicationDispense
 ;;Refill;;MedicationDispense
 ;;RejectCode1;;ClaimResponse
 ;;RejectCode2;;ClaimResponse
 ;;RejectCode3;;ClaimResponse
 ;;RejectCode4;;ClaimResponse
 ;;RejectCode5;;ClaimResponse
 ;;RejectCode6;;ClaimResponse
 ;;RejectCode7;;ClaimResponse
 ;;RejectCode8;;ClaimResponse
 ;;RejectCode9;;ClaimResponse
 ;;RejectCode10;;ClaimResponse
 ;;RejectCode11;;ClaimResponse
 ;;RejectCode12;;ClaimResponse
 ;;RejectCode13;;ClaimResponse
 ;;RejectCode14;;ClaimResponse
 ;;RejectCode15;;ClaimResponse
 ;;RejectCode16;;ClaimResponse
 ;;RejectCode17;;ClaimResponse
 ;;RejectCode18;;ClaimResponse
 ;;RejectCode19;;ClaimResponse
 ;;RejectCode20;;ClaimResponse
 ;;RejectCount;;ClaimResponse
 ;;Rejected;;Basic
 ;;RejectExplanation1;;ClaimResponse
 ;;RejectExplanation2;;ClaimResponse
 ;;RejectExplanation3;;ClaimResponse
 ;;RejectExplanation4;;ClaimResponse
 ;;RejectExplanation5;;ClaimResponse
 ;;RejectExplanation6;;ClaimResponse
 ;;RejectExplanation7;;ClaimResponse
 ;;RejectExplanation8;;ClaimResponse
 ;;RejectExplanation9;;ClaimResponse
 ;;RejectExplanation10;;ClaimResponse
 ;;RejectExplanation11;;ClaimResponse
 ;;RejectExplanation12;;ClaimResponse
 ;;RejectExplanation13;;ClaimResponse
 ;;RejectExplanation14;;ClaimResponse
 ;;RejectExplanation15;;ClaimResponse
 ;;RejectExplanation16;;ClaimResponse
 ;;RejectExplanation17;;ClaimResponse
 ;;RejectExplanation18;;ClaimResponse
 ;;RejectExplanation19;;ClaimResponse
 ;;RejectExplanation20;;ClaimResponse
 ;;ReleasedDate;;MedicationDispense
 ;;ReturnStatus;;Basic
 ;;ReversalMethod;;Claim
 ;;ReversalReason;;ClaimResponse
 ;;RxCOB;;Basic
 ;;RxNumber;;MedicationRequest
 ;;SiteName;;Organization
 ;;SiteNumber;;Organization
 ;;Touched;;Claim
 ;;TransactionDate;;MessageHeader
 ;;TransactionStatus;;MessageHeader
 ;;TransactionType;;MessageHeader
 ;
 ;
