RCDMCR8B ;ALB/LB - Pension Report Exempt Charge Reconciliation Report - Input/output; Jun 16, 2021@14:23
 ;;4.5;Accounts Receivable;**384**;JUN 16, 2021;Build 29
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to PATIENT in ICR #7277
 ; Reference to INTEGRATED BILLING ACTION in ICR #4541
 ;
 ; See RCDMCR8A for detailed description
 ;
COLLECT(STOPIT,ARTYPE) ; Get the report data
 ;Input
 ;   STOPIT - Passed Variable to determine if process is to be terminated
 ;   ARTYPE - AR Type  1:Active;2:Open;3:Suspended;4:Collected/Closed;5:On-Hold;6:Write Off;7:All
 ;Output
 ;   STOPIT - Passed Variable set to 1 if process is to be terminated
 ;   ^TMP($J,"RCDMCR8") with report data and summary data
 ;Get Rated Disability Data within passed RD change time frame
 ;*** call API to get all RD change data for given date period
 N ZR,DEBTPT,WZH,DEBTCNT,DEBTOR,RCDFN,DFN,DMCELIG,ELIG,EXEMPTDT,SZH,VAEL,VAERR,VADM,ARIEN,CTR
 N BILLNO,IBDATA,IBCNT,IBIEN,NAME,SSN,OUT,STATUS,ELIGTYP,PARENT,ADMDT,RESULT,IPSTART,PNTERMDT
 S DEBTPT=0,WZH=$H*86400+$P($H,",",2)+60,SZH=WZH W !
 F DEBTCNT=0:1 S DEBTPT=$O(^RCD(340,"B",DEBTPT)) Q:DEBTPT=""  I DEBTPT[";DPT(" D
 . ;Get AR Debtor info from file 340
 . S DEBTOR=0,RCDFN=$P(DEBTPT,";")
 . F  S DEBTOR=$O(^RCD(340,"B",DEBTPT,DEBTOR)) Q:DEBTOR'>0  D  Q:$G(STOPIT)>0
 . . S DFN=RCDFN
 . . S DMCELIG=$$DMCELIG^RCDMCUT1(RCDFN)
 . . Q:'DMCELIG
 . . S ELIG=$S($P(DMCELIG,U,2)'="":"SC"_$P(DMCELIG,U,2),$P(DMCELIG,U,3)'="":"Pension",$P(DMCELIG,U,4)'="":"A&A",$P(DMCELIG,U,5)'="":"HouseBnd",1:"")
 . . Q:ELIG?1"SC".E
 . . S ELIGTYP=$S(ELIG="Pension":"PEN",ELIG="A&A":ELIG,ELIG="HouseBnd":"HSB",1:"")
 . . Q:ELIGTYP'="PEN"  ; 8/11/2021 only include primary Eligibility type of Pension
 . . D ELIG^VADPT I $P(VAEL(8),U,1)'="V" Q  ;Quit if Eligibility status is not Verified
 . . D KVAR^VADPT
 . . ; Business decision: For Pension use PENSION AWARD EFFECTIVE DATE, File #2 field .3851 as the ECRMPTDT
 . . I ELIGTYP="PEN" S EXEMPTDT=$$GET1^DIQ(2,DFN_",",.3851,"I") ;8/11/2021
 . . I ELIGTYP="PEN" S PNTERMDT=$$GET1^DIQ(2,DFN_",",.3853,"I") ;9/28/2021
 . . I DFN'>0 D KVAR^VADPT Q
 . . D DEM^VADPT
 . . I $G(VAERR)>0 D KVAR^VADPT Q
 . . S NAME=$G(VADM(1))
 . . I NAME']"" D KVAR^VADPT Q
 . . S SSN=$P(VADM(2),U,1)
 . . D KVAR^VADPT
 . . ;Get AR Bill Data that is within the last BEGDT time period
 . . ;for Bill's with a current status of ACTIVE, OPEN, SUSPENDED, WRITE-OFF, COLLECTED/CLOSED, CANCELLATION or IB Status of ON-HOLD
 . . K ^TMP($J,"RCDMCR8","ARIB")
 . . I $H*86400+$P($H,",",2)>WZH S WZH=$H*86400+$P($H,",",2)+30,$X=0 W *13,$FN(DEBTCNT*100/$P(^RCD(340,0),U,4),",",2),"% done in ",WZH-SZH," seconds"
 . . S ARIEN=0
 . . I ARTYPE'=5 F  S ARIEN=$O(^PRCA(430,"C",DEBTOR,ARIEN)) Q:ARIEN'>0  D  Q:$G(STOPIT)>0
 . . . N ARCAT
 . . . S ARCAT=$$GET1^DIQ(430,ARIEN_",",2,"E") Q:ARCAT="CC URGENT CARE" 
 . . . S CTR=$G(CTR)+1 ;Counter
 . . . I CTR#500=0 S STOPIT=$$STOPIT^RCDMCUT2() Q:STOPIT
 . . . ; only look at 1st party bills
 . . . I '$$FIRSTPAR^RCDMCUT1(ARIEN) Q
 . . . ;Bill Number
 . . . S BILLNO=$$GET1^DIQ(430,ARIEN_",",.01)
 . . . I BILLNO']""!($TR(BILLNO," ","")="") Q  ;This line quits if no Bill Number in AR
 . . . S STATUS=$$GET1^DIQ(430,ARIEN_",",8,"E") ; Need to check IB status from 350 for "On-Hold"
 . . . I STATUS="ACTIVE",ARTYPE'["1",ARTYPE'[7 Q
 . . . I STATUS="OPEN",ARTYPE'["2",ARTYPE'[7 Q
 . . . I STATUS="SUSPENDED",ARTYPE'["3",ARTYPE'[7 Q
 . . . I STATUS="COLLECTED/CLOSED",ARTYPE'["4",ARTYPE'[7 Q
 . . . I STATUS="WRITE-OFF",ARTYPE'["6",ARTYPE'[7 Q
 . . . I STATUS="CANCELLATION",ARTYPE'=7 Q
 . . . I ARTYPE[7,"^ACTIVE^OPEN^SUSPENDED^WRITE-OFF^COLLECTED/CLOSED^CANCELLATION^"'[(U_STATUS_U) Q
 . . . ;if ARTYPE=5 or 7 need to check IB status of "ON HOLD"
 . . . K IBDATA S IBDATA=0 S OUT=""
 . . . S IBIEN=""
 . . . F  S IBIEN=$O(^IB("ABIL",BILLNO,IBIEN)) Q:'IBIEN  S OUT=$$GETIB^RCDMCR8C(IBIEN,0) I OUT D
 . . . . S IPSTART=$$GETSTRT(IBIEN) S $P(OUT,U,10)=IPSTART ;Add inpatient bill start date to OUT
 . . . . I $P(OUT,U,5)'=10 S IBDATA=IBDATA+1,IBDATA(IBDATA)=OUT
 . . . . I 'IBDATA Q
 . . . . M ^TMP($J,"RCDMCR8","ARIB",BILLNO,"IBDATA")=IBDATA
 . . . . S ^TMP($J,"RCDMCR8","ARIB",BILLNO,"STATUS")=STATUS
 . . S IBIEN=""
 . . I ARTYPE[5!(ARTYPE[7) F  S IBIEN=$O(^IB("AH",RCDFN,IBIEN)) Q:IBIEN=""  D  Q:$G(STOPIT)>0
 . . . K IBDATA S IBDATA=0
 . . . S CTR=$G(CTR)+1 ;Counter
 . . . I CTR#500=0 S STOPIT=$$STOPIT^RCDMCUT2() Q:STOPIT
 . . . S BILLNO="/"_IBIEN
 . . . S OUT=$$GETIB^RCDMCR8C(IBIEN,1) Q:'OUT  I OUT D
 . . . . S IPSTART=$$GETSTRT(IBIEN) S $P(OUT,U,10)=IPSTART ;Add inpatient bill start date to OUT
 . . . S IBDATA=1,IBDATA(1)=OUT
 . . . M ^TMP($J,"RCDMCR8","ARIB",BILLNO,"IBDATA")=IBDATA
 . . . S ^TMP($J,"RCDMCR8","ARIB",BILLNO,"STATUS")="ON HOLD"
 . . S BILLNO=""
 . . F  S BILLNO=$O(^TMP($J,"RCDMCR8","ARIB",BILLNO)) Q:BILLNO=""  D  ;Quits if no billno number eliminating IB that have not been billed
 . . . K IBDATA M IBDATA=^TMP($J,"RCDMCR8","ARIB",BILLNO,"IBDATA")
 . . . S STATUS=^TMP($J,"RCDMCR8","ARIB",BILLNO,"STATUS")
 . . . F IBCNT=1:1:IBDATA D
 . . . . N OPTDT,DISCHDT,SERVDT,RXDT,RXNUM,RXNAM,DSTATUS,EOCDT,IPFRMDT
 . . . . ;IBDATA - Array of 1 ^ Outpatient Date ^ Discharge Date ^ RX/Refill Date ^ IB Status ^ RX NUM ^ RX Name ^ CHGAMT^^In Patient Date Billed From
 . . . . S OPTDT=$P(IBDATA(IBCNT),U,2)
 . . . . S DISCHDT=$P(IBDATA(IBCNT),U,3)
 . . . . S IPFRMDT=$P(IBDATA(IBCNT),U,10)
 . . . . S SERVDT=$S(IPFRMDT'="":IPFRMDT,OPTDT'="":OPTDT,1:"")
 . . . . S RXDT=$P(IBDATA(IBCNT),U,4)
 . . . . S RXNUM=$P(IBDATA(IBCNT),U,6)
 . . . . S RXNAM=$P(IBDATA(IBCNT),U,7)
 . . . . S DSTATUS=STATUS
 . . . . ; Get EOC date and verify that it is later than Patient Effective Date
 . . . . S EOCDT=""
 . . . . I OPTDT>EOCDT S EOCDT=OPTDT
 . . . . I DISCHDT>EOCDT S EOCDT=DISCHDT
 . . . . I RXDT>EOCDT S EOCDT=RXDT
 . . . . I EXEMPTDT="" S ^TMP($J,"RCDMCR8","DETAIL",NAME,SSN," ",1)=U_U_ELIG_U_"NODATE"_U_U_U_U_ELIGTYP Q
 . . . . S EOCDT=EOCDT\1
 . . . . I EOCDT<EXEMPTDT Q
 . . . . S DSTATUS=$S(DSTATUS="CANCELLATION":"ARCXLD",DSTATUS="COLLECTED/CLOSED":"C/C",1:DSTATUS)
 . . . . S ^TMP($J,"RCDMCR8","DETAIL",NAME,SSN,BILLNO,IBCNT)=SERVDT_U_RXDT_U_ELIG_U_EXEMPTDT_U_RXNUM_U_RXNAM_U_DSTATUS_U_ELIGTYP_U_PNTERMDT_U_IPFRMDT_U_DISCHDT
 K ^TMP($J,"RCDMCR8","ARIB")
 Q
 ;
GETSTRT(IBIEN) ; Get start date for InPatient / LTC
 N IBSDT,RESULT S IBSDT="",RESULT=""
 S RESULT=$P(^IB(IBIEN,0),U,4)
 I +RESULT=405!(+RESULT=45) S IBSDT=$$GET1^DIQ(350,IBIEN_",",.14,"I")
 Q IBSDT
 ;
