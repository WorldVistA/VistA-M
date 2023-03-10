BPSRPC04 ;AITC/PD - ECME TAS RPC - Test Extract Fields;01/15/2020
 ;;1.0;E CLAIMS MGMT ENGINE;**27**;JUN 2004;Build 15
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EXTRACT ;
 ; ---------------------------------------
 ;
 N BPSCNT,BPSDATA,BPSFHIR,BPSFHIR1,BPSFLD,BPSI,BPSIEN
 ;
 ; Build BPSTMP array to include all fields
 ;
 S BPSTMP("BilledAmount")=225.99
 S BPSTMP("BillNumber")="KB12345"
 S BPSTMP("BIN")=111111
 S BPSTMP("ClaimID")="VA2019=2222222222=333333=4444444"
 S BPSTMP("ClosedByUser")="User,Closed By"
 S BPSTMP("ClosedDate")="2019-03-10"
 S BPSTMP("ClosedReason")="NON COVERED DRUG PER PLAN"
 S BPSTMP("CollectedAmount")=25.75
 S BPSTMP("CompletedDate")="2019-03-11"
 S BPSTMP("DispensingFee")=20.50
 S BPSTMP("DispensingFeePaid")=15.25
 S BPSTMP("Division")="CHEYENNE VAMC"
 S BPSTMP("DrugClass")="PENICILLINS,AMINO DERIVATIVES"
 S BPSTMP("DrugName")="AMOXICILLIN 250/CLAV K 125MG TAB"
 S BPSTMP("ECMENumber")="000003333333"
 S BPSTMP("ElapseTimeInSeconds")="4 sec"
 S BPSTMP("Eligibility")="TRICARE"
 S BPSTMP("FillLocation")="W"
 S BPSTMP("FillType")="BB"
 S BPSTMP("GroupID")="C1GRP NUM MCCF"
 S BPSTMP("IngredientCost")=99.99
 S BPSTMP("IngredientCostPaid")=75.65
 S BPSTMP("InsuranceName")="AETNA US"
 S BPSTMP("InsurancePaidAmount")=50.30
 S BPSTMP("MultipleRejects")="Y"
 S BPSTMP("NDC")="43598-0218-30"
 S BPSTMP("OpenClosed")="C"
 S BPSTMP("PatientID")="9999"
 S BPSTMP("PatientName")="Name, Patient"
 S BPSTMP("PatientPayAmount")=10.95
 S BPSTMP("PayerResponse")="E REJECTED"
 S BPSTMP("Prescriber")="LOCKET"
 S BPSTMP("PrescriberID")="DB1316092638"
 S BPSTMP("Quantity")=180
 S BPSTMP("Refill")=0
 S BPSTMP("Rejected")="REJ"
 S BPSIEN=69
 F BPSI=1:1:20 S BPSIEN=$O(^BPSF(9002313.93,BPSIEN)) S BPSDATA=^BPSF(9002313.93,BPSIEN,0) D
 . S BPSTMP("RejectCode"_BPSI)=$P(BPSDATA,"^")
 . S BPSTMP("RejectExplanation"_BPSI)=$P(BPSDATA,"^",2)
 S BPSTMP("ReleasedDate")="2019-02-28"
 S BPSTMP("ReturnStatus")="REJECTED"
 S BPSTMP("ReversalMethod")="Auto"
 S BPSTMP("ReversalReason")="RX DISCONTINUED"
 S BPSTMP("RxCOB")="p"
 S BPSTMP("RxNumber")=7777777
 S BPSTMP("SiteName")="CHEYENNE VAH&ROC"
 S BPSTMP("SiteNumber")="442"
 S BPSTMP("Touched")=0
 S BPSTMP("TransactionDate")="2019-02-27"
 S BPSTMP("TransactionStatus")="DS/N"
 S BPSTMP("TransactionType")="Rejected"
 ;
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
 ;
 Q
 ;
