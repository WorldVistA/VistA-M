IBCNERP5 ;DAOU/BHS - IBCNE eIV PAYER REPORT COMPILE ;03-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,271,300,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; eIV - Insurance Verification Interface
 ;
 ; Input variables from IBCNERP4:
 ;   IBCNERTN = "IBCNERP4"
 ;   IBCNESPC("BEGDT") = Start Date for date range
 ;   IBCNESPC("ENDDT") = End Date for date range
 ;   IBCNESPC("PYR") = Payer IEN for report, if = "", then include all
 ;   IBCNESPC("SORT") = 1 - Payer OR 2 - Total Inquiries
 ;   IBCNESPC("DTL") = 1 - YES OR 0 - NO - include Rejection Detail?
 ; Output variables passed to IBCNERP6:
 ;   ^TMP($J,IBCNERTN,SORT1,SORT2,SORT3)=InqCreatedCount^InqCancelledCt^
 ;                                       InqQueuedCt^1stTransCount^
 ;                                       RetryTransCt^Non-ErrorRespCt^
 ;                                       ErrorRespCount^TotRespTime-days^
 ;                                       CommFailRespCount^PendRespCount^
 ;                                       eIVDeactivatedDt
 ;        IBCNERTN = "IBCNERP4"
 ;        SORT1 = PayerName (SORT=1) or -InquiryCount(SORT=2)
 ;        SORT2 = PayerIEN (SORT=1) or PayerName (SORT=2)
 ;        SORT3 = "*" (SORT=1) or PayerIEN (SORT=2)
 ;   ^TMP($J,IBCNERTN,SORT1,SORT2,SORT3,ERRCD)=RespCount
 ;        (see above)
 ;        ERRCD = Error Condition code (ptr to 365.018) or Error Text
 ;                from the Eligibility Communicator (4.01)
 ;
 ; Must call at EN tag
 Q
 ;
EN(IBCNERTN,IBCNESPC) ; Entry point
 ;
 ; Initialize variables
 NEW IBCNEDT,IBCNEDT1,IBCNEDT2,IBCNEPY,IBCNEPYR,IBCNEPTR
 NEW IBCNETOT,IBCNESRT,IBCNEDTL,RPTDATA,PYRIEN,INQS,IEN
 NEW IBPNM,IBPIEN,ERR,PC,PYR
 ;
 I '$D(ZTQUEUED),$G(IOST)["C-" W !!,"Compiling report data ..."
 ;
 ; Total responses selected
 S IBCNETOT=0
 ;
 ; Kill scratch globals
 KILL ^TMP($J,IBCNERTN),^TMP($J,IBCNERTN_"X")
 ;
 ; Initialize looping variables
 S IBCNEDT2=$G(IBCNESPC("ENDDT"))
 S IBCNEDT1=$G(IBCNESPC("BEGDT"))
 S IBCNEPY=$G(IBCNESPC("PYR"))
 S IBCNESRT=$G(IBCNESPC("SORT"))
 S IBCNEDTL=$G(IBCNESPC("DTL"))
 ;
 ; Loop through the eIV Transmission Queue File (#365.1) 
 ;  by Date/Time Created Cross-Reference
 S IBCNEDT=$O(^IBCN(365.1,"AE",IBCNEDT1),-1)
 F  S IBCNEDT=$O(^IBCN(365.1,"AE",IBCNEDT)) Q:IBCNEDT=""!($P(IBCNEDT,".",1)>IBCNEDT2)  D  Q:$G(ZTSTOP)
 . S IBCNEPTR=0
 . F  S IBCNEPTR=$O(^IBCN(365.1,"AE",IBCNEDT,IBCNEPTR)) Q:'IBCNEPTR  D  Q:$G(ZTSTOP)
 . . ; Update selected count
 . . S IBCNETOT=IBCNETOT+1
 . . I $D(ZTQUEUED),IBCNETOT#100=0,$$S^%ZTLOAD() S ZTSTOP=1 QUIT
 . . ; Determine Payer name from Payer File (#365.12)
 . . S PYRIEN=$P($G(^IBCN(365.1,IBCNEPTR,0)),U,3)
 . . I 'PYRIEN Q
 . . ; Check payer filter
 . . I IBCNEPY'="",PYRIEN'=IBCNEPY Q
 . . S IBCNEPYR=$P($G(^IBE(365.12,PYRIEN,0)),U)
 . . I IBCNEPYR="" Q
 . . ; Now get the data for the report - build RPTDATA
 . . KILL RPTDATA
 . . D GETDATA(IBCNEPTR,.RPTDATA,IBCNEDTL,IBCNEPYR,PYRIEN,IBCNEPY)
 . . ; Loop through results by Payer Name, Payer IEN
 . . S IBPNM=""
 . . F  S IBPNM=$O(RPTDATA(IBPNM)) Q:IBPNM=""  D
 . . . S IBPIEN=0
 . . . F  S IBPIEN=$O(RPTDATA(IBPNM,IBPIEN)) Q:'IBPIEN  D
 . . . . ; Store totals in global
 . . . . F PC=1:1:10 S $P(^TMP($J,IBCNERTN,IBPNM,IBPIEN,"*"),U,PC)=$P($G(^TMP($J,IBCNERTN,IBPNM,IBPIEN,"*")),U,PC)+$P(RPTDATA(IBPNM,IBPIEN),U,PC)
 . . . . ; Store deactivation date/time
 . . . . S $P(^TMP($J,IBCNERTN,IBPNM,IBPIEN,"*"),U,11)=$P(RPTDATA(IBPNM,IBPIEN),U,11)
 . . . . I 'IBCNEDTL Q
 . . . . ; Store rejection detail
 . . . . S ERR=""
 . . . . F  S ERR=$O(RPTDATA(IBPNM,IBPIEN,ERR)) Q:ERR=""  D
 . . . . .  S ^TMP($J,IBCNERTN,IBPNM,IBPIEN,"*",ERR)=$G(^TMP($J,IBCNERTN,IBPNM,IBPIEN,"*",ERR))+$G(RPTDATA(IBPNM,IBPIEN,ERR))
 . . Q
 . Q
 ;
 ; Call tag to find good/bad/rejection detail data from response file
 D DATA^IBCNERP4
 ;
 I $G(ZTSTOP)!(IBCNESRT=1) G EXIT
 ;
 ; Resort if sorted by Total Inquiries
 M ^TMP($J,IBCNERTN_"X")=^TMP($J,IBCNERTN)
 KILL ^TMP($J,IBCNERTN)
 S PYR=""
 F  S PYR=$O(^TMP($J,IBCNERTN_"X",PYR)) Q:PYR=""  D
 .  S IEN=0
 .  F  S IEN=$O(^TMP($J,IBCNERTN_"X",PYR,IEN)) Q:'IEN  D
 .  .  S INQS=-$G(^TMP($J,IBCNERTN_"X",PYR,IEN,"*"))
 .  .  M ^TMP($J,IBCNERTN,INQS,PYR,IEN)=^TMP($J,IBCNERTN_"X",PYR,IEN,"*")
 .  .  QUIT
 .  QUIT
 ; KILL temporary report global - used to resort
 KILL ^TMP($J,IBCNERTN_"X")
 ;
EXIT ; EN Exit point
 Q
 ;
 ;
GETDATA(IEN,RPTDATA,DTL,PYNM,PYIEN,PYR) ; Retrieve data for this inquiry and response(s)
 ; Output: 
 ;  RPTDATA(PayerName,PayerIEN) = Created(1)^Cancelled(0/1)^Queued(0/1)^
 ;   #1stTrans^#Retries^#Non-ErrorResponses^#ErrorResponses^
 ;   #ofDaysforResponses^#Timeouts^#Pending^DeactivationDTM
 ;  RPTDATA(PayerName,PayerIEN,ErrCond OR ErrText) = #ErrorResps subtotal
 ; Initialize variables
 NEW HLIEN,HLID,RIEN,RDATA0,RPYIEN,RPYNM,RDATA1,ERRTXT,X1,X2,FIRST,APIEN
 ;
 S RPTDATA(PYNM,PYIEN)=1
 ; Determine Deactivation DTM for eIV application
 S APIEN=$$PYRAPP^IBCNEUT5("IIV",PYIEN)
 I APIEN,$P($G(^IBE(365.12,PYIEN,1,APIEN,0)),U,11) S $P(RPTDATA(PYNM,PYIEN),U,11)=$P($G(^IBE(365.12,PYIEN,1,APIEN,0)),U,12)
 ; Logic by Transmission Status
 ;  Cancelled (7) - Payer deactivated
 I $P($G(^IBCN(365.1,IEN,0)),U,4)=7 S $P(RPTDATA(PYNM,PYIEN),U,2)=1 Q
 ;  Queued - no HL7 messages (# Transmissions = 0) - no multiples exist
 I '$P($G(^IBCN(365.1,IEN,2,0)),U,3) S $P(RPTDATA(PYNM,PYIEN),U,3)=1 Q
 ;  Sent processing - HL7 messages associated (# Transmissions > 0)
 S HLIEN=0,FIRST=1
 F  S HLIEN=$O(^IBCN(365.1,IEN,2,HLIEN)) Q:'HLIEN  D
 .  I 'FIRST S $P(RPTDATA(PYNM,PYIEN),U,5)=$P(RPTDATA(PYNM,PYIEN),U,5)+1
 .  I FIRST S $P(RPTDATA(PYNM,PYIEN),U,4)=$P(RPTDATA(PYNM,PYIEN),U,4)+1,FIRST=0
 .  ; Process response based on HL7 Message ID
 .  S HLID=$P($G(^IBCN(365.1,IEN,2,HLIEN,0)),U,2) I HLID="" Q
 .  ; Lookup responses by HL7 Message ID
 .  S RIEN=0
 .  F  S RIEN=$O(^IBCN(365,"B",HLID,RIEN)) Q:'RIEN  D
 .  .  S RDATA0=$G(^IBCN(365,RIEN,0))
 .  .  S RPYIEN=$P(RDATA0,U,3) I RPYIEN="" Q
 .  .  S RPYNM=$P($G(^IBE(365.12,RPYIEN,0)),U,1) I RPYNM="" Q
 .  .  ; Apply payer filter here, too!
 .  .  ; If there is a Payer filter, check against the IEN
 .  .  I PYR'="",RPYIEN'=PYR Q
 .  .  ; Determine Deactivation DTM for eIV application
 .  .  S APIEN=$$PYRAPP^IBCNEUT5("IIV",RPYIEN)
 .  .  I APIEN,$P($G(^IBE(365.12,RPYIEN,1,APIEN,0)),U,11) S $P(RPTDATA(RPYNM,RPYIEN),U,11)=$P($G(^IBE(365.12,RPYIEN,1,APIEN,0)),U,12)
 .  .  S RDATA1=$G(^IBCN(365,RIEN,1))
 .  .  S ERRTXT=$G(^IBCN(365,RIEN,4))
 .  .  ; Transmitted (Pending)
 .  .  I $P(RDATA0,U,6)=2 D  Q
 .  .  . ; Increment for response pending 
 .  .  . S $P(RPTDATA(RPYNM,RPYIEN),U,10)=$P($G(RPTDATA(RPYNM,RPYIEN)),U,10)+1
 .  .  ; Timeout (Communication Failure)
 .  .  I $P(RDATA0,U,6)=5 D  Q
 .  .  . ; Increment for response timeout 
 .  .  . S $P(RPTDATA(RPYNM,RPYIEN),U,9)=$P($G(RPTDATA(RPYNM,RPYIEN)),U,9)+1
 .  .  ; Response Received - gather additional information
 .  .  I $P(RDATA0,U,6)=3 D  Q
 .  .  . ; Determine response time (in days) as difference between 
 .  .  . ;  eIV Response File - Date/Time Response Received and
 .  .  . ;                      Date/Time Response Created (based on HL7)
 .  .  . S X1=$P(RDATA0,U,8)
 .  .  . S X2=$P(RDATA0,U,7)
 .  .  . ; Determine date difference in days
 .  .  . S $P(RPTDATA(RPYNM,RPYIEN),U,8)=$P($G(RPTDATA(RPYNM,RPYIEN)),U,8)+$$FMDIFF^XLFDT(X2,X1,1)
 ;
GETDATX ; GETDATA exit point
 Q
 ;
 ;
