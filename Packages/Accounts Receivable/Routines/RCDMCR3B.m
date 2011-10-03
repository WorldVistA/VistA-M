RCDMCR3B ;HEC/SBW - DMC Rated Disability Elig Change - Collect Data ;23/OCT/2007
 ;;4.5;Accounts Receivable;**253**;Mar 20, 1995;Build 9
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
COLLECT(STOPIT,BEGDT,RDBEGDT,RDENDDT) ; Get the report data
 ;Input
 ;   STOPIT - Passed Variable to determine if process is to be terminated
 ;   BEGDT  - Beginning Date (in past) to get Episode of Care data for.
 ;            (Required)
 ;   RDBEGDT - Rated Disability Change Beginning date, (Required)
 ;   RDENDDT - Rated Disability Change Ending Date, (Required)
 ;Output
 ;   STOPIT - Passed Variable set to 1 if process is to be terminated
 ;   ^TMP($J,"RCDMCR3") with report data and summary data
 N RCDFN,DEBTOR,IEN,CTR
 ;Quit if passed parameter variables not populated
 I $G(BEGDT)'>0,$G(RDBEGDT)'>0,$G(RDENDDT)'>0 Q
 ;Get Rated Disability Data within passed RD change time frame
 ;*** call API to get all RD data for given date period
 K ^TMP($J,"RDCHG")
 D RDCHG^DGENRDUA("",RDBEGDT,RDENDDT)
 S RCDFN=0
 F  S RCDFN=$O(^TMP($J,"RDCHG",RCDFN)) Q:RCDFN'>0  D  Q:$G(STOPIT)>0
 . ;Get AR Debtor info from file 340
 . S DEBTOR=0
 . F  S DEBTOR=$O(^RCD(340,"B",RCDFN_";DPT(",DEBTOR)) Q:DEBTOR'>0  D  Q:$G(STOPIT)>0
 . . ;Get AR Bill Data that is within the last BEGDT time period
 . . ;for Bill's with a current status of ACTIVE, OPEN, SUSPENDED
 . . S IEN=0
 . . F  S IEN=$O(^PRCA(430,"C",DEBTOR,IEN)) Q:IEN'>0  D  Q:$G(STOPIT)>0
 . . . N STATUS,BADDATA,OPTDT,DISCHDT,RXDT,NAME,SSN,SSNLF,OPTDT,RXDT
 . . . N DISCHDT,OCC,BILLNO,CLOC,CNUM
 . . . S CTR=$G(CTR)+1 ;Counter
 . . . I CTR#500=0 S STOPIT=$$STOPIT^RCDMCUT2() Q:STOPIT
 . . . ;Quit if Veteran is SC 50% to 100% or Receiving VA Pension
 . . . Q:$$DMCELIG^RCDMCUT1(RCDFN)>0
 . . . S STATUS=$$GET1^DIQ(430,IEN_",",8)
 . . . ;Quit if Current Status is not Active, Open or Suspended
 . . . Q:"^ACTIVE^OPEN^SUSPENDED^"'[(U_STATUS_U)
 . . . ;Get Bill Data
 . . . S BADDATA=0
 . . . D GETDATA
 . . . Q:$G(BADDATA)>0
 . . . ;Check that Episode of Care is not older than BEGDT
 . . . ;Quit if there isn't a service date in the last BEGDT days
 . . . Q:OPTDT<BEGDT&(DISCHDT<BEGDT)&(RXDT<BEGDT)
 . . . ;Get Rated Disability Data for this veteran.
 . . . S OCC=0
 . . . F  S OCC=$O(^TMP($J,"RDCHG",RCDFN,OCC)) Q:OCC'>0  D
 . . . . N RDNODE,RDCHGDT,RDNAME,RDSEXTRE,RDLEXTRE,RDORGDT
 . . . . S RDNODE=$G(^TMP($J,"RDCHG",RCDFN,OCC))
 . . . . S RDCHGDT=$P($P(RDNODE,U,1),".",1)
 . . . . S RDNAME=$P(RDNODE,U,3)
 . . . . S RDSEXTRE=$P(RDNODE,U,5)
 . . . . S:RDSEXTRE']"" RDSEXTRE=0
 . . . . S RDLEXTRE=$P(RDNODE,U,6)
 . . . . S RDORGDT=$P(RDNODE,U,7)
 . . . . ;Quit if there isn't a RD Change Date or RD Name
 . . . . I RDCHGDT'>0,RDNAME']"" Q
 . . . . S ^TMP($J,"RCDMCR3","DETAIL",NAME,SSNLF,RDCHGDT,RDNAME,RDSEXTRE,BILLNO)=CNUM_U_$G(CLOC)_U_RDLEXTRE_U_RDORGDT_U_RXDT_U_OPTDT_U_DISCHDT_U_STATUS
 . . . . ;Set total unique veterans
 . . . . I $D(^TMP($J,"RCDMCR3","VETSSN",SSN))'>0 D
 . . . . . S ^TMP($J,"RCDMCR3","SUM-VET")=$G(^TMP($J,"RCDMCR3","SUM-VET"))+1
 . . . . . S ^TMP($J,"RCDMCR3","VETSSN",SSN)=""
 . . . . ;Set total RD Changes
 . . . . I $D(^TMP($J,"RCDMCR3","VETSSN",SSN,RDCHGDT,RDNAME,RDSEXTRE))'>0 D
 . . . . . S ^TMP($J,"RCDMCR3","SUM-RD")=$G(^TMP($J,"RCDMCR3","SUM-RD"))+1
 . . . . . S ^TMP($J,"RCDMCR3","VETSSN",SSN,RDCHGDT,RDNAME,RDSEXTRE)=""
 . . . . ;Set total unique bills
 . . . . I $D(^TMP($J,"RCDMCR3","VETBILL",BILLNO))'>0 D
 . . . . . S ^TMP($J,"RCDMCR3","SUM-BILL")=$G(^TMP($J,"RCDMCR3","SUM-BILL"))+1
 . . . . . S ^TMP($J,"RCDMCR3","VETBILL",BILLNO)=""
 K ^TMP($J,"RDCHG")
 Q
 ;
GETDATA ;Get data for report
 ;Get AR Bill Data - Bill #, Patient, Current Status,
 ;Principal Balance, Name SSN, Service Dates
 ;Rated Disability Eligibility Data
 N DFN,SERDT
 S DFN=$G(RCDFN)
 ;Quit if DFN not set
 I DFN'>0 S BADDATA=1 Q
 ;
 ;IEN is from calling routine
 ;Bill Number
 S BILLNO=$$GET1^DIQ(430,IEN_",",.01)
 I BILLNO']"" S BADDATA=1 Q
 ;
 ;Get Demographic Data
 D DEM^VADPT
 I $G(VAERR)>0 S BADDATA=1 D KVAR^VADPT Q
 S NAME=$G(VADM(1))
 I NAME']"" S BADDATA=1 Q
 S SSN=$P(VADM(2),U,1)
 S SSNLF=$G(VA("BID"))
 I SSNLF']"" S BADDATA=1 Q
 ;
 ;Get Eligibility Data
 D ELIG^VADPT
 S CNUM=$G(VAEL(7))
 ;If claim # same as SSN, block first 5 characters
 I CNUM]"",CNUM=SSN S CNUM="#####"_$E(CNUM,6,10)
 D KVAR^VADPT
 ;Get Station Number in file #4 for the Claim Folder Location in file #2
 I CNUM]"" D
 . S CLOC=$$GET1^DIQ(4,+$$GET1^DIQ(2,DFN_",",.314,"I","","ERR")_",",99)
 ;
 ;Get Service Date
 S SERDT=$$GETSERDT^RCDMCUT1(BILLNO)
 ;Get outpatient date
 S OPTDT=$P(SERDT,U,2)
 ;Get Inpatient Discharge date
 S DISCHDT=$P(SERDT,U,3)
 ;Get RX fill/refill date
 S RXDT=$P(SERDT,U,4)
 Q
