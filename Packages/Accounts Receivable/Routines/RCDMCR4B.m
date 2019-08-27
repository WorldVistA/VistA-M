RCDMCR4B ;ALB/YG - 0 - 40 Percent SC Change Reconciliation Report - Collect Data; Apr 9, 2019@21:06
 ;;4.5;Accounts Receivable;**347**;Mar 20, 1995;Build 47
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; See RCDMCR4A for detailed description
 ;
COLLECT(STOPIT,RDBEGDT,RDENDDT,VLSBEGDT,VLSENDDT,EOCBEGDT,EOCENDDT,RPTTYPE) ; Get the report data
 ;Input
 ;   STOPIT - Passed Variable to determine if process is to be terminated
 ;   BEGDT  - Beginning Date (in past) to get Episode of Care data for.
 ;            (Required)
 ;   RDBEGDT - Rated Disability Change Beginning date, (Required)
 ;   RDENDDT - Rated Disability Change Ending Date, (Required)
 ;   VLSBEGDT - Vista Last Status Date Beginning date, (Required)
 ;   VLSENDDT - Vista Last Status Date Ending Date, (Required)
 ;   EOCBEGDT - Episodes Of Care Beginning date, (Required)
 ;   EOCENDDT - Episodes Of Care Ending Date, (Required)
 ;   RPTTYPE - Report Type (Summary / Detailed)
 ;Output
 ;   STOPIT - Passed Variable set to 1 if process is to be terminated
 ;   ^TMP($J,"RCDMCR4") with report data and summary data
 N RCDFN,DEBTOR,ARIEN,IBIEN,CTR,IBCNT,EOCDT,DFN,DMCELIG,EFFDT,NAME,SSN,VLSDT,SCPER
 N STATUS,OPTDT,DISCHDT,RXDT,OPTDT,RXDT,CHGAMT,OCC,BILLNO,RXNUM,RXNAM,DSTATUS,IBDATA
 N VAERR,VADM,VAEL,VAIP
 ;Quit if passed parameter variables not populated
 I $G(EOCBEGDT)'>0,$G(EOCENDDT)'>0,$G(VLSBEGDT)'>0,$G(VLSENDDT)'>0,$G(RDBEGDT)'>0,$G(RDENDDT)'>0 Q
 ;Get Rated Disability Data within passed RD change time frame
 ;*** call API to get all RD change data for given date period
 K ^TMP($J,"RDCHG")
 D RDCHG^DGENRDUA("",RDBEGDT,RDENDDT)
 S RCDFN=0
 F  S RCDFN=$O(^TMP($J,"RDCHG",RCDFN)) Q:RCDFN'>0  D  Q:$G(STOPIT)>0
 . ;Get AR Debtor info from file 340
 . S DEBTOR=0
 . F  S DEBTOR=$O(^RCD(340,"B",RCDFN_";DPT(",DEBTOR)) Q:DEBTOR'>0  D  Q:$G(STOPIT)>0
 . . ;Quit if Veteran is SC 50% to 100% or Receiving VA Pension or A&A
 . . S DFN=RCDFN
 . . S DMCELIG=$$DMCELIG^RCDMCUT1(RCDFN)
 . . Q:DMCELIG>0
 . . ; From what I can see, these two dates are not obtainable from VADPT calls - YG
 . . S VLSDT=$$GET1^DIQ(2,DFN_",",.3612,"I")
 . . ; as per customer, we don't want people who have no VLSDT
 . . I VLSDT="" Q
 . . S EFFDT=$$GET1^DIQ(2,DFN_",",.3014,"I")
 . . I $G(VLSDT)<VLSBEGDT Q
 . . I $G(VLSDT)>VLSENDDT Q 
 . . I DFN'>0 D KVAR^VADPT Q
 . . D DEM^VADPT
 . . I $G(VAERR)>0 D KVAR^VADPT Q
 . . S NAME=$G(VADM(1))
 . . I NAME']"" D KVAR^VADPT Q
 . . S SSN=$P(VADM(2),U,1)
 . . ;Get Eligibility Data
 . . D ELIG^VADPT
 . . I $G(VAERR)>0 D KVAR^VADPT Q
 . . S SCPER=$P(VAEL(3),U,2)
 . . D KVAR^VADPT
 . . ;Get AR Bill Data that is within the last BEGDT time period
 . . ;for Bills with a current status of ACTIVE, OPEN, SUSPENDED, WRITE-OFF, COLLECTED/CLOSED, CANCELLATION, or IB Status of ON-HOLD
 . . K ^TMP($J,"RCDMCR4","ARIB")
 . . S ARIEN=0
 . . F  S ARIEN=$O(^PRCA(430,"C",DEBTOR,ARIEN)) Q:ARIEN'>0  D  Q:$G(STOPIT)>0
 . . . K IBDATA S IBDATA=0
 . . . S CTR=$G(CTR)+1 ;Counter
 . . . I CTR#500=0 S STOPIT=$$STOPIT^RCDMCUT2() Q:STOPIT
 . . . ; only look at 1st party bills 
 . . . I '$$FIRSTPAR^RCDMCUT1(ARIEN) Q
 . . . S BILLNO=$$GET1^DIQ(430,ARIEN_",",.01)
 . . . I BILLNO']"" Q
 . . . S STATUS=$$GET1^DIQ(430,ARIEN_",",8,"E")
 . . . I "^ACTIVE^OPEN^SUSPENDED^WRITE-OFF^COLLECTED/CLOSED^CANCELLATION^"'[(U_STATUS_U) Q
 . . . K IBDATA S IBDATA=0
 . . . S IBIEN=""
 . . . F  S IBIEN=$O(^IB("ABIL",BILLNO,IBIEN)) Q:'IBIEN  S OUT=$$GETIB(IBIEN,0) I OUT,$P(OUT,U,5)'=10 S IBDATA=IBDATA+1,IBDATA(IBDATA)=OUT
 . . . I 'IBDATA Q
 . . . M ^TMP($J,"RCDMCR4","ARIB",BILLNO,"IBDATA")=IBDATA
 . . . S ^TMP($J,"RCDMCR4","ARIB",BILLNO,"STATUS")=STATUS
 . . S IBIEN=""
 . . F  S IBIEN=$O(^IB("AH",RCDFN,IBIEN)) Q:IBIEN=""  D  Q:$G(STOPIT)>0
 . . . K IBDATA S IBDATA=0
 . . . S CTR=$G(CTR)+1 ;Counter
 . . . I CTR#500=0 S STOPIT=$$STOPIT^RCDMCUT2() Q:STOPIT
 . . . S BILLNO="/"_IBIEN
 . . . S OUT=$$GETIB(IBIEN,1) Q:'OUT  Q:$P(OUT,U,5)=10
 . . . S IBDATA=1,IBDATA(1)=OUT
 . . . M ^TMP($J,"RCDMCR4","ARIB",BILLNO,"IBDATA")=IBDATA
 . . . S ^TMP($J,"RCDMCR4","ARIB",BILLNO,"STATUS")="ON HOLD"
 . . S BILLNO=""
 . . F  S BILLNO=$O(^TMP($J,"RCDMCR4","ARIB",BILLNO)) Q:BILLNO=""  D
 . . . K IBDATA M IBDATA=^TMP($J,"RCDMCR4","ARIB",BILLNO,"IBDATA")
 . . . S STATUS=^TMP($J,"RCDMCR4","ARIB",BILLNO,"STATUS")
 . . . S OCC=0
 . . . F  S OCC=$O(^TMP($J,"RDCHG",RCDFN,OCC)) Q:OCC'>0  D
 . . . . N RDNODE,RDCHGDT,RDNAME,RDSEXTRE,RDORGDT
 . . . . S RDNODE=$G(^TMP($J,"RDCHG",RCDFN,OCC))
 . . . . S RDCHGDT=$P($P(RDNODE,U,1),".",1)
 . . . . S RDNAME=$P(RDNODE,U,3)
 . . . . S RDSEXTRE=$P(RDNODE,U,5)
 . . . . S:RDSEXTRE']"" RDSEXTRE=" "
 . . . . S RDORGDT=$P(RDNODE,U,7)
 . . . . S EFFDT=RDORGDT
 . . . . I RDNAME']"" Q
 . . . . F IBCNT=1:1:IBDATA D
 . . . . . ;IBDATA - Array of 1 ^ Outpatient Date ^ Discharge Date ^ RX/Refill Date ^ IB Status ^ RX NUM ^ RX Name ^ CHGAMT
 . . . . . S OPTDT=$P(IBDATA(IBCNT),U,2)
 . . . . . S DISCHDT=$P(IBDATA(IBCNT),U,3)
 . . . . . S RXDT=$P(IBDATA(IBCNT),U,4)
 . . . . . S RXNUM=$P(IBDATA(IBCNT),U,6)
 . . . . . S RXNAM=$P(IBDATA(IBCNT),U,7)
 . . . . . S CHGAMT=$P(IBDATA(IBCNT),U,8)
 . . . . . S DSTATUS=STATUS
 . . . . . ; Get EOC date and verify that it is later than Patient Effective Date
 . . . . . S EOCDT=""
 . . . . . I OPTDT>EOCDT S EOCDT=OPTDT
 . . . . . I DISCHDT>EOCDT S EOCDT=DISCHDT
 . . . . . I RXDT>EOCDT S EOCDT=RXDT
 . . . . . I EFFDT,EOCDT'>EFFDT Q
 . . . . . ;Skip is current EOC date for IB (OPTDT, DISCHDT or RXDT) is not within EOC date range
 . . . . . I EOCDT<EOCBEGDT Q
 . . . . . I EOCDT>EOCENDDT Q
 . . . . . ; TBD
 . . . . . I EFFDT="" S ^TMP($J,"RCDMCR4","DETAIL",NAME,SSN," ",RDNAME,RDSEXTRE," ",1)="NODATE"_U_U_U_U_U_SCPER_U_VLSDT Q
 . . . . . S DSTATUS=$S(DSTATUS="CANCELLATION":"ARCXLD",DSTATUS="COLLECTED/CLOSED":"C/C",1:DSTATUS)
 . . . . . S ^TMP($J,"RCDMCR4","DETAIL",NAME,SSN,RDCHGDT,RDNAME,RDSEXTRE,BILLNO,IBCNT)=RDORGDT_U_RXDT_U_OPTDT_U_DISCHDT_U_DSTATUS_U_SCPER_U_VLSDT_U_CHGAMT_U_RXNUM_U_RXNAM
 . . . . . S ^TMP($J,"RCDMCR4","SUMMARY",NAME,SSN)=SCPER
 K ^TMP($J,"RDCHG")
 K ^TMP($J,"RCDMCR4","ARIB")
 Q
 ;
GETIB(IBIEN,IBMODE) ; Get all Outpatient Dates, Inpatient Dates and RX Dates/drugs
 ; Input:
 ;  IBIEN - IEN of IB entry (File 350, ^IB)
 ;  IBMODE - 0 if we are in AR mode, 1 if we are in IB mode.
 ; Output:
 ;  0 if we don't get anything out of this IB
 ;  Othewise 1 ^ Outpatient Date ^ Discharge Date ^ RX/Refill Date ^ IB Status ^ RX NUM ^ RX Name ^ CHGAMT
 N IBDET,IENS,ACTTYPE,RESULT,DTBILLFR,BILGROUP,OPDT,DISCHARG,RXDT,STATUS,OUT,I0,PARENT,PARENTOK,DFN
 S OUT=0
 S I0=$G(^IB(IBIEN,0))
 S DFN=$P(I0,U,2)
 I 'DFN Q OUT
 S ACTTYPE=$P(I0,U,3)
 S DTBILLFR=$P(I0,U,14)
 S STATUS=$P(I0,U,5)
 S PARENT=$$PARENTC^RCDMCR5B(IBIEN),CHGAMT=$P($G(^IB(PARENT,0)),U,7)
 ;S CHGAMT=$$GET1^DIQ(350,$$PARENTC^RCDMCR5B(IBIEN)_",",.07,"I")
 ; only take parents if running in AR mode?
 S PARENT=$$PARENTE^RCDMCR5B(IBIEN)
 I +$G(IBMODE)=0 S PARENTOK=0 D  I 'PARENTOK Q OUT
 . I IBIEN=PARENT S PARENTOK=1 Q
 . I $P(I0,U,11),$P(I0,U,11)'=$P(^IB(PARENT,0),U,11) S PARENTOK=1 ; it is OK to take a child IB if parent is not part of same bill.
 S RESULT=$P(^IB(PARENT,0),U,4)
 ;Quit if RESULTING FROM field is blank
 Q:RESULT="" OUT
 ;Get Billing Group in the IB Action Type File. If internal Set 
 ;Code value is 4, then this is an Outpatient Visit (From STMT^IBRFN1)
 ;and can use Date Billed From for the Outpatient Visit Date
 S BILGROUP=$P($G(^IBE(350.1,+ACTTYPE,0)),U,11)
 ;Outpatient Event
 I BILGROUP=4!($P(RESULT,":",1)=44)!($P(RESULT,":",1)=409.68) D
 . I $P(RESULT,":",1)=44 S OPDT=$P($P(RESULT,";",2),":",2)
 . I $P(RESULT,":",1)=409.68 S OPDT=$P($G(^SCE(+$P(RESULT,":",2),0)),U)
 . I $G(OPDT)'>0 S OPDT=DTBILLFR
 . I OPDT S OUT=1_U_OPDT
 ;Inpatient Event
 I $P(RESULT,":",1)=405!($P(RESULT,":",1)=45) D
 . D KVAR^VADPT
 . S VAIP("E")=$P($P(RESULT,";",1),":",2)
 . ;Call to get Inpatient data
 . D IN5^VADPT
 . I VAERR>0 D KVAR^VADPT Q
 . S DISCHARG=$P($G(VAIP(17,1)),U,1)
 . I DISCHARG S OUT=1_U_U_DISCHARG
 . D KVAR^VADPT
 ;RX Event
 I $P(RESULT,":",1)=52 D
 . ;Set up for RX Refills
 . I $P(RESULT,";",2)]"" D
 . . N RXIEN,RXFIEN
 . . S RXFIEN=$P($P(RESULT,";",2),":",2),RXIEN=$P($P(RESULT,";",1),":",2)
 . . S RXDT=$P($G(^PSRX(RXIEN,1,RXFIEN,0)),U,18) ; released data
 . . S:RXDT="" RXDT=$P($G(^PSRX(RXIEN,1,RXFIEN,0)),U) ; refill date
 . . S RXNUM=$P($G(^PSRX(RXIEN,0)),U)
 . . S RXNAM=$P($G(^PSRX(RXIEN,0)),U,6) S:RXNAM RXNAM=$P($G(^PSDRUG(RXNAM,0)),U)
 . . I RXDT S OUT=1_U_U_U_RXDT_U_U_RXNUM_U_RXNAM
 . ;Set up for RX Data (No refill)
 . I $P(RESULT,";",2)']"" D
 . . N RXIEN
 . . S RXIEN=$P(RESULT,":",2)
 . . S RXDT=$P($G(^PSRX(RXIEN,2)),U,13) ; released date
 . . S:RXDT="" RXDT=$P($G(^PSRX(RXIEN,2)),U,2) ; fill date
 . . S:RXDT="" RXDT=$P($G(^PSRX(RXIEN,2)),U,5) ; dispensed date
 . . S RXNUM=$P($G(^PSRX(RXIEN,0)),U)
 . . S RXNAM=$P($G(^PSRX(RXIEN,0)),U,6) S:RXNAM RXNAM=$P($G(^PSDRUG(RXNAM,0)),U)
 . . I RXDT S OUT=1_U_U_U_RXDT_U_U_RXNUM_U_RXNAM
 I 'OUT Q OUT
 S $P(OUT,U,5)=STATUS
 S $P(OUT,U,8)=CHGAMT
 Q OUT
