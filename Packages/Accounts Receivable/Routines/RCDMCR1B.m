RCDMCR1B ;HEC/SBW - DMC Debt Validity Report - Collect Data ;28/SEP/2007
 ;;4.5;Accounts Receivable;**253**;Mar 20, 1995;Build 9
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
COLLECT(STOPIT,BEGDT) ; Get the report data
 ;Input
 ;   STOPIT - Passed Variable to determine if process is to be terminated
 ;   BEGDT  - Beginning Date (in past) to get data for. Optional, Set
 ;             365 days in past if not passed.
 ;Output
 ;   STOPIT - Passed Variable set to 1 if process is to be terminated
 ;   ^TMP($J,"RCDMCR1") with report data and summary data
 N STAT,RDATE,IEN,CTR
 S:$G(BEGDT)'>0 BEGDT=$$FMADD^XLFDT(DT,-365,0,0,0)
 ;Get AR Bill Data that is within the last 365 days
 ;for Bill's with a current status of ACTIVE, OPENED, SUSPENDED
 F STAT=16,40,42 D  Q:$G(STOPIT)>0
 . S RDATE=BEGDT-1
 . F  S RDATE=$O(^PRCA(430,"ASDT",STAT,RDATE)) Q:RDATE'>0  D  Q:$G(STOPIT)>0
 . . S IEN=0
 . . F  S IEN=$O(^PRCA(430,"ASDT",STAT,RDATE,IEN)) Q:IEN'>0  D  Q:$G(STOPIT)>0
 . . . N FIRSTPAR,BADDATA,DMCVALID,DFN,STATUS,NAME,SSNLF,BILLNO,CNUM,CLOC
 . . . N ELIG1,ELIGDT,RXDT,OPTDT,DISCHDT,DMCREFDT,DMCVALID,SSN,PRINAMT
 . . . S CTR=$G(CTR)+1 ;Counter
 . . . I CTR#500=0 S STOPIT=$$STOPIT^RCDMCUT2() Q:STOPIT
 . . . ;Quit if bill is not a First Party Bill
 . . . S FIRSTPAR=$$FIRSTPAR^RCDMCUT1(IEN)
 . . . Q:+FIRSTPAR'>0
 . . . ;Get Report Data
 . . . S DMCVALID=$$GET1^DIQ(430,IEN_",",125,"E")
 . . . ;Quit if DMC Debt Valid Field equal "YES" or "NO"
 . . . Q:DMCVALID="YES"!(DMCVALID="NO")
 . . . ;Quit if Veteran is not SC 50% to 100% & not Receiving VA Pension
 . . . S DFN=$$GET1^DIQ(430,IEN_",",7,"I")
 . . . ;If patient field blank get DFN from AR Debtor File
 . . . S:DFN'>0 DFN=$P(FIRSTPAR,U,2)
 . . . Q:$$DMCELIG^RCDMCUT1(DFN)'>0
 . . . S STATUS=$$GET1^DIQ(430,IEN_",",8)
 . . . ;Quit if Current Status is not Active, Open or Suspended
 . . . Q:"^ACTIVE^OPEN^SUSPENDED^"'[(U_STATUS_U)
 . . . ;Get Bill Data
 . . . S BADDATA=0
 . . . D GETDATA
 . . . Q:$G(BADDATA)>0
 . . . ;Check that Episode of Care is not older than 365
 . . . ;Quit if there isn't a service date in the last 365 days
 . . . Q:OPTDT<BEGDT&(DISCHDT<BEGDT)&(RXDT<BEGDT)
 . . . S ^TMP($J,"RCDMCR1","DETAIL",NAME,SSNLF,BILLNO)=CNUM_U_$G(CLOC)_U_$G(ELIG1)_U_$G(ELIGDT)_U_RXDT_U_OPTDT_U_DISCHDT_U_DMCREFDT_U_DMCVALID_U_STATUS
 . . . ;Get Summary DMC Referred Data
 . . . I DMCREFDT>0 D
 . . . . ;Set total DMC referred bills
 . . . . S ^TMP($J,"RCDMCR1","SUM-BILL")=$G(^TMP($J,"RCDMCR1","SUM-BILL"))+1
 . . . . ;Set total DMC referred AR dollars
 . . . . S ^TMP($J,"RCDMCR1","SUM-$")=$G(^TMP($J,"RCDMCR1","SUM-$"))+PRINAMT
 . . . . ;Set total DMC referred unique veterans
 . . . . I $D(^TMP($J,"RCDMCR1","VETSSN",SSN))'>0 D
 . . . . . S ^TMP($J,"RCDMCR1","SUM-VET")=$G(^TMP($J,"RCDMCR1","SUM-VET"))+1
 . . . . . S ^TMP($J,"RCDMCR1","VETSSN",SSN)=""
 . . . ;Get Summary for all records
 . . . ;Set total bills
 . . . S ^TMP($J,"RCDMCR1","TOT-BILL")=$G(^TMP($J,"RCDMCR1","TOT-BILL"))+1
 . . . ;Set total AR dollars
 . . . S ^TMP($J,"RCDMCR1","TOT-$")=$G(^TMP($J,"RCDMCR1","TOT-$"))+PRINAMT
 . . . ;Set total unique veterans
 . . . I $D(^TMP($J,"RCDMCR1","TOTVETSSN",SSN))'>0 D
 . . . . S ^TMP($J,"RCDMCR1","TOT-VET")=$G(^TMP($J,"RCDMCR1","TOT-VET"))+1
 . . . . S ^TMP($J,"RCDMCR1","TOTVETSSN",SSN)=""
 Q
 ;
GETDATA ;Get data for report
 ;Get AR Bill Data - Bill #, Patient, Current Status,
 ;Principal Balance, Date Sent to DMC, DMC Debt Valid, Name
 ;SSN, Eligibility data, Service Dates
 N IENS,ARDATA,ERR,ELIG,SCPER,VAPEN,SERDT
 ;Quit if DFN not set
 I DFN'>0 S BADDATA=1 Q
 ;
 ;IEN is from calling routine
 S IENS=IEN_","
 D GETS^DIQ(430,IENS,".01;71;121","EIN","ARDATA","ERR")
 ;Bill Number
 S BILLNO=$G(ARDATA(430,IENS,.01,"E"))
 I BILLNO']"" S BADDATA=1 Q
 ;Principle amount
 S PRINAMT=$G(ARDATA(430,IENS,71,"I"))
 ; DMC Referral Date
 S DMCREFDT=$G(ARDATA(430,IENS,121,"I"))
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
 S ELIG=$$DMCELIG^RCDMCUT1(DFN)
 ;Get SC percentage data
 S SCPER=$P(ELIG,U,2)
 ;Get VA Pension data
 S VAPEN=$P(ELIG,U,3)
 ;Check if Receiving A&A Benefits or Housebound Benefits, This also 
 ;indicates that the veteran is Receiving a VA Pension
 I $P(ELIG,U,4)>0!($P(ELIG,U,5)>0) S VAPEN=1
 ;Format SC and VA Pension data
 I SCPER>49 S ELIG1="SC"_SCPER_"%" D
 . ;If SC 50% to 100% the get Eff. Date Combined SC% Eval.
 . S ELIGDT=$$GET1^DIQ(2,DFN_",",.3014,"I")
 I VAPEN>0 D
 . ;Put "/" between SC & VA Pension data  
 . I $G(ELIG1)]"" S ELIG1=ELIG1_"/"
 . S ELIG1=$G(ELIG1)_"Pension"
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
