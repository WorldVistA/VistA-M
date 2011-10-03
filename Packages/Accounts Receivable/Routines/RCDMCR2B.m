RCDMCR2B ;HEC/SBW - DMC Debt Validity Management Report - Collect Data ;28/SEP/2007
 ;;4.5;Accounts Receivable;**253**;Mar 20, 1995;Build 9
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
COLLECT(STOPIT,BEGDT,DMCVAL) ; Get the report data
 ;   STOPIT - Passed Variable to determine if process is to be terminated
 ;   BEGDT  - Beginning Date (in past) to get data for. Optional, Set
 ;            365 days in past if not passed.
 ;   DMCVAL - DMC Debt Valid values that will be included in this report
 ;            (i.e. DMCVAL("NULL"), DMCVAL("PENDING"), DMCVAL("YES"), 
 ;             or DMCVAL("NO") )
 ;Output
 ;   STOPIT - Passed Variable set to 1 if process is to be terminated
 ;   ^TMP($J,"RCDMCR2") with report data and summary data
 N STAT,RDATE,IEN,CTR,BADDATA
 ;Set BEGDT if valid value not passed
 S:$G(BEGDT)'>0 BEGDT=$$FMADD^XLFDT(DT,-365,0,0,0)
 ;Get AR Bill Data that is within the last 365 days
 ;for Bill's with a current status of ACTIVE, CANCELLATION, SUSPENDED, 
 ;REFUNDED, OPEN, REFUND REVIEW
 F STAT=16,39,40,41,42,44 D  Q:$G(STOPIT)>0
 . S RDATE=BEGDT-1
 . F  S RDATE=$O(^PRCA(430,"ASDT",STAT,RDATE)) Q:RDATE'>0  D  Q:$G(STOPIT)>0
 . . S IEN=0
 . . F  S IEN=$O(^PRCA(430,"ASDT",STAT,RDATE,IEN)) Q:IEN'>0  D  Q:$G(STOPIT)>0
 . . . S CTR=$G(CTR)+1 ;Counter
 . . . I CTR#500=0 S STOPIT=$$STOPIT^RCDMCUT2() Q:STOPIT
 . . . N FIRSTPAR,DMCVALID,DFN,STATUS,NAME,SSN,SSNLF,BILLNO,CNUM,CLOC
 . . . N PRINAMT,STATUS,EDITBY,EDITDT,OPTDT,DISCHDT,RXDT
 . . . ;Quit if bill is not a First Party Bill
 . . . S FIRSTPAR=$$FIRSTPAR^RCDMCUT1(IEN)
 . . . Q:+FIRSTPAR'>0
 . . . ;Get Report Data
 . . . S DMCVALID=$$GET1^DIQ(430,IEN_",",125,"E")
 . . . ;When DMC Debt VAlid is Null set to string value of "NULL"
 . . . S:DMCVALID="" DMCVALID="BLANK/NULL"
 . . . ;Quit if DMC Debt Valid Field not one of the request ones
 . . . Q:+$D(DMCVAL(DMCVALID))'>0
 . . . ;Quit if Veteran is not SC 50% to 100% & not Receiving VA Pension
 . . . S DFN=$$GET1^DIQ(430,IEN_",",7,"I")
 . . . ;If patient field blank get DFN from AR Debtor File
 . . . S:DFN'>0 DFN=$P(FIRSTPAR,U,2)
 . . . Q:$$DMCELIG^RCDMCUT1(DFN)'>0
 . . . S STATUS=$$GET1^DIQ(430,IEN_",",8)
 . . . ;Quit if Current Status is not Active, Open, Suspended, 
 . . . ;Cancellation, Refunded, or Refund Review
 . . . Q:"^ACTIVE^OPEN^SUSPENDED^CANCELLATION^REFUNDED^REFUND REVIEW^"'[(U_STATUS_U)
 . . . ;Get Bill Data
 . . . S BADDATA=0
 . . . D GETDATA
 . . . Q:BADDATA>0
 . . . ;Check that Episode of Care is not older than 365
 . . . ;Quit if there isn't a service date in the last 365 days
 . . . Q:OPTDT<BEGDT&(DISCHDT<BEGDT)&(RXDT<BEGDT)
 . . . S ^TMP($J,"RCDMCR2","DETAIL",DMCVALID,NAME,SSNLF,BILLNO)=CNUM_U_$G(CLOC)_U_PRINAMT_U_STATUS_U_EDITBY_U_EDITDT
 . . . ;Get Summary Data
 . . . ;Set total AR bills
 . . . S ^TMP($J,"RCDMCR2","TOT","BILL")=$G(^TMP($J,"RCDMCR2","TOT","BILL"))+1
 . . . ;Set total AR bills for a given status
 . . . S ^TMP($J,"RCDMCR2","TOT-STAT",STATUS)=$G(^TMP($J,"RCDMCR2","TOT-STAT",STATUS))+1
 . . . ;Set total AR (Principle Amt) dollars
 . . . S ^TMP($J,"RCDMCR2","TOT","$")=$G(^TMP($J,"RCDMCR2","TOT","$"))+PRINAMT
 . . . ;Set totaL unique veterans
 . . . I $D(^TMP($J,"RCDMCR2","TOT","VETSSN",SSN))'>0 D
 . . . . S ^TMP($J,"RCDMCR2","TOT","VET")=$G(^TMP($J,"RCDMCR2","TOT","VET"))+1
 . . . . S ^TMP($J,"RCDMCR2","TOT","VETSSN",SSN)=""
 . . . ;Get Summary data by DMC Debt Valid field
 . . . ;Set total AR bills by DMC Debt Valid field
 . . . S ^TMP($J,"RCDMCR2","SUM",DMCVALID,"BILL")=$G(^TMP($J,"RCDMCR2","SUM",DMCVALID,"BILL"))+1
 . . . ;Set total AR bills by DMC Debt Valid value and status
 . . . S ^TMP($J,"RCDMCR2","SUM-STAT",DMCVALID,STATUS)=$G(^TMP($J,"RCDMCR2","SUM-STAT",DMCVALID,STATUS))+1
 . . . ;Set total AR (Principle Amt) dollars by DMC Debt Valid value
 . . . S ^TMP($J,"RCDMCR2","SUM",DMCVALID,"$")=$G(^TMP($J,"RCDMCR2","SUM",DMCVALID,"$"))+PRINAMT
 . . . ;Set totaL unique veterans by DMC Debt Valid value
 . . . I $D(^TMP($J,"RCDMCR2","SUM",DMCVALID,"VETSSN",SSN))'>0 D
 . . . . S ^TMP($J,"RCDMCR2","SUM",DMCVALID,"VET")=$G(^TMP($J,"RCDMCR2","SUM",DMCVALID,"VET"))+1
 . . . . S ^TMP($J,"RCDMCR2","SUM",DMCVALID,"VETSSN",SSN)=""
 Q
 ;
GETDATA ;Get data for report
 ;Get AR Bill Data - Bill #, Patient, Current Status,
 ;Principal Balance, DMC Debt Valid Edited, DMC Debt Valid Edited Date
 ;Name, SSN, Eligibility Data, Service Dates
 N IENS,ARDATA,ERR,SERDT
 ;Quit if DFN not set
 I DFN'>0 S BADDATA=1 Q
 ;
 ;IEN is from calling routine
 S IENS=IEN_","
 D GETS^DIQ(430,IENS,".01;71;126;127","EIN","ARDATA","ERR")
 ;Bill Number
 S BILLNO=$G(ARDATA(430,IENS,.01,"E"))
 I BILLNO']"" S BADDATA=1 Q
 ;Principle amount
 S PRINAMT=$G(ARDATA(430,IENS,71,"I"))
 ;DMC Debt Valid Edited By
 S EDITBY=$G(ARDATA(430,IENS,126,"E"))
 ;DMC Debt Valid Edited Date
 S EDITDT=$G(ARDATA(430,IENS,127,"I"))
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
