RCDMCR7B ;ALB/YG - 10-40% SC Medical Care Copayment Exempt Charge Reconciliation Report - Collect Data ;Apr 9, 2019@21:06
 ;;4.5;Accounts Receivable;**347**;Jan 29, 2019;Build 47
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; See RCDMCR7A for detailed description
 ;
COLLECT(STOPIT,ARTYPE) ; Get the report data
 ;Input
 ;   STOPIT - Passed Variable to determine if process is to be terminated
 ;   ARTYPE - AR Type  1:Active;2:Open;3:Suspended;4:Collected/Closed;5:On-Hold;6:Write Off;7:All
 ;Output
 ;   STOPIT - Passed Variable set to 1 if process is to be terminated
 ;   ^TMP($J,"RCDMCR7") with report data and summary data
 ;N RCDFN,DEBTOR,ARIEN,IBIEN,CTR,EOCOK,IBCNT,EOCDT,DFN,DMCELIG,EFFDT,NAME,SSN
 ;N STATUS,OPTDT,DISCHDT,RXDT,OPTDT,RXDT,CHGAMT,OCC,BILLNO,RXNUM,RXNAM,DSTATUS,IBDATA
 ;Get Rated Disability Data within passed RD change time frame
 ;*** call API to get all RD change data for given date period
 N ZR,DEBTPT,WZH,DEBTCNT,DEBTOR,RCDFN,DFN,EXEMPTDT,SZH,VAERR,VADM,ARIEN,CTR
 N BILLNO,IBDATA,IBCNT,IBIEN,NAME,SSN,OUT,STATUS,VAEL,SCPER
 S DEBTPT=0,WZH=$H*86400+$P($H,",",2)+60,SZH=WZH W !
 K ^TMP($J,"RCDMCR7","ARIB")
 F DEBTCNT=0:1 S DEBTPT=$O(^RCD(340,"B",DEBTPT)) Q:DEBTPT=""  I DEBTPT[";DPT(" D
 . ;Get AR Debtor info from file 340
 . S DEBTOR=0,RCDFN=$P(DEBTPT,";")
 . F  S DEBTOR=$O(^RCD(340,"B",DEBTPT,DEBTOR)) Q:DEBTOR'>0  D  Q:$G(STOPIT)>0
 . . S DFN=RCDFN
 . . ;Get Eligibility Data
 . . D ELIG^VADPT
 . . ;Quit if ^DPT(DFN,0) not defined
 . . Q:$G(VAERR)>0
 . . ;Get monetary benefit data
 . . D MB^VADPT
 . . ;SERVICE CONNECTED?  
 . . S SCPER=$P($G(VAEL(3)),U,2)
 . . I SCPER<10!(SCPER>49) Q
 . . S EXEMPTDT=$$GET1^DIQ(2,DFN_",",.3014,"I")
 . . I DFN'>0 D KVAR^VADPT Q
 . . D DEM^VADPT
 . . I $G(VAERR)>0 D KVAR^VADPT Q
 . . S NAME=$G(VADM(1))
 . . I NAME']"" D KVAR^VADPT Q
 . . S SSN=$P(VADM(2),U,1)
 . . D KVAR^VADPT
 . . ;I EXEMPTDT="" S ^TMP($J,"RCDMCR6","DETAIL",NAME,SSN," ",1)=U_U_U_"NODATE" Q
 . . ;Get AR Bill Data that is within the last BEGDT time period
 . . ;for Bill's with a current status of ACTIVE, OPEN, SUSPENDED, WRITE-OFF, COLLECTED/CLOSED, or IB Status of ON-HOLD
 . . K ^TMP($J,"RCDMCR7","ARIB")
 . . I $H*86400+$P($H,",",2)>WZH S WZH=$H*86400+$P($H,",",2)+30,$X=0 W *13,$FN(DEBTCNT*100/$P(^RCD(340,0),U,4),",",2),"% done in ",WZH-SZH," seconds"
 . . S ARIEN=0
 . . I ARTYPE'=5 F  S ARIEN=$O(^PRCA(430,"C",DEBTOR,ARIEN)) Q:'ARIEN  D  Q:$G(STOPIT)>0
 . . . S CTR=$G(CTR)+1 ;Counter
 . . . I CTR#500=0 S STOPIT=$$STOPIT^RCDMCUT2() I STOPIT Q
 . . . S BILLNO=$$GET1^DIQ(430,ARIEN_",",.01)
 . . . I BILLNO']"" Q
 . . . ; only look at 1st party bills - TBD
 . . . I '$$FIRSTPAR^RCDMCUT1(ARIEN) Q
 . . . ;IEN is from calling routine (for file 430)
 . . . S STATUS=$$GET1^DIQ(430,ARIEN_",",8,"E")
 . . . I ARTYPE=1,STATUS'="ACTIVE" Q
 . . . I ARTYPE=2,STATUS'="OPEN" Q
 . . . I ARTYPE=3,STATUS'="SUSPENDED" Q
 . . . I ARTYPE=4,STATUS'="COLLECTED/CLOSED" Q
 . . . I ARTYPE=6,STATUS'="WRITE-OFF" Q
 . . . I ARTYPE=7,"^ACTIVE^OPEN^SUSPENDED^WRITE-OFF^COLLECTED/CLOSED^CANCELLATION^"'[(U_STATUS_U) Q
 . . . ;S SERDT=$$GETIB(BILLNO,.IBDATA)
 . . . K IBDATA S IBDATA=0
 . . . S IBIEN=""
 . . . F  S IBIEN=$O(^IB("ABIL",BILLNO,IBIEN)) Q:'IBIEN  D
 . . . . S OUT=$$GETIB^RCDMCR4B(IBIEN,0)
 . . . . I OUT,$P(OUT,U,5)'=10 S:$P(OUT,U,1,2)'=U IBDATA=IBDATA+1,IBDATA(IBDATA)=OUT
 . . . I 'IBDATA Q
 . . . M ^TMP($J,"RCDMCR7","ARIB",BILLNO,"IBDATA")=IBDATA
 . . . S ^TMP($J,"RCDMCR7","ARIB",BILLNO,"STATUS")=STATUS
 . . S IBIEN=""
 . . I ARTYPE=5!(ARTYPE=7) F  S IBIEN=$O(^IB("AH",RCDFN,IBIEN)) Q:IBIEN=""  D  Q:$G(STOPIT)>0
 . . . K IBDATA S IBDATA=0
 . . . S CTR=$G(CTR)+1 ;Counter
 . . . I CTR#500=0 S STOPIT=$$STOPIT^RCDMCUT2() Q:STOPIT
 . . . S BILLNO="/"_IBIEN
 . . . S OUT=$$GETIB^RCDMCR4B(IBIEN,1)
 . . . I 'OUT Q
 . . . I $P(OUT,U,1,2)=U Q
 . . . S IBDATA=1,IBDATA(1)=OUT
 . . . M ^TMP($J,"RCDMCR7","ARIB",BILLNO,"IBDATA")=IBDATA
 . . . S ^TMP($J,"RCDMCR7","ARIB",BILLNO,"STATUS")="ON HOLD"
 . . S BILLNO=""
 . . F  S BILLNO=$O(^TMP($J,"RCDMCR7","ARIB",BILLNO)) Q:BILLNO=""  D
 . . . K IBDATA M IBDATA=^TMP($J,"RCDMCR7","ARIB",BILLNO,"IBDATA")
 . . . S STATUS=^TMP($J,"RCDMCR7","ARIB",BILLNO,"STATUS")
 . . . F IBCNT=1:1:IBDATA D
 . . . . N DSTATUS,DISCHDT,SERVDT,OPTDT
 . . . . ;IBDATA - Array of 1 ^ Outpatient Date ^ Discharge Date ^ RX/Refill Date ^ IB Status ^ RX NUM ^ RX Name ^ CHGAMT
 . . . . S OPTDT=$P(IBDATA(IBCNT),U,2)
 . . . . S DISCHDT=$P(IBDATA(IBCNT),U,3)
 . . . . S SERVDT=$S(OPTDT>DISCHDT:OPTDT,DISCHDT>OPTDT:DISCHDT,1:"")
 . . . . ;S RXDT=$P(IBDATA(IBCNT),U,4)
 . . . . ;S IBSTATUS=$P(IBDATA(IBCNT),U,5)
 . . . . ;S RXNUM=$P(IBDATA(IBCNT),U,6)
 . . . . ;S RXNAM=$P(IBDATA(IBCNT),U,7)
 . . . . S DSTATUS=STATUS
 . . . . ; this node will be set over and over again, but it is one node per NODATE debtor
 . . . . I EXEMPTDT="" S ^TMP($J,"RCDMCR7","DETAIL",NAME,SSN," ",1)=U_SCPER_U_"NODATE" Q
 . . . . ; Get EOC date and verify that it is later than Patient Effective Date
 . . . . I SERVDT'>EXEMPTDT Q
 . . . . S DSTATUS=$S(DSTATUS="CANCELLATION":"ARCXLD",DSTATUS="COLLECTED/CLOSED":"C/C",1:DSTATUS)
 . . . . S ^TMP($J,"RCDMCR7","DETAIL",NAME,SSN,BILLNO,IBCNT)=SERVDT_U_SCPER_U_EXEMPTDT_U_DSTATUS
 K ^TMP($J,"RCDMCR7","ARIB")
 Q
