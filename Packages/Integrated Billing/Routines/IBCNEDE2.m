IBCNEDE2 ;DAOU/DAC - eIV PRE REG EXTRACT (APPTS) ;18-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,271,249,345,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This program finds veterans who are scheduled to be seen within a
 ;  specified date range.
 ;  Periodically check for stop request for background task
 ;
 Q   ; can't be called directly
 ;
EN ; Loop through designated cross-references for updates
 ; Pre reg extract (Appointment extract)
 ;
 N TODAYSDT,FRESHDAY,SLCCRIT1,MAXCNT,CNT,ENDDT,CLNC,FRESHDT,GIEN
 N APTDT,INREC,INSIEN,PAYER,PIEN,PAYERSTR,SYMBOL,SUPPBUFF,PATID
 N DFN,OK,VAIN,INS,DATA1,DATA2,ELG,PAYERID,SETSTR,SRVICEDT,ACTINS
 N TQIEN,IBINDT,IBOUTP,QURYFLAG,INSNAME,FOUND1,FOUND2,IBCNETOT
 N SID,SIDACT,SIDDATA,SIDARRAY,SIDCNT,IBDDI,IBINS,DISYS,NUM,MCAREFLG
 ;
 S SETSTR=$$SETTINGS^IBCNEDE7(2)     ;  Get setting for pre reg. extract 
 I 'SETSTR Q                         ; Quit if extract is not active
 S SLCCRIT1=$P(SETSTR,U,2)           ; Selection Criteria #1
 S MAXCNT=$P(SETSTR,U,4)             ; Max # of TQ entries to create
 S:MAXCNT="" MAXCNT=9999999999
 S SUPPBUFF=$P(SETSTR,U,5)                   ; Suppress Buffer Flag
 S FRESHDAY=$P($G(^IBE(350.9,1,51)),U,1)     ; Freshness days span
 S CNT=0                                     ; Init. TQ entry counter
 S ENDDT=$$FMADD^XLFDT(DT,SLCCRIT1)   ; End of appt. date selection range
 S IBCNETOT=0               ; Initialize count for periodic TaskMan check
 K ^TMP($J,"SDAMA301"),^TMP("IBCNEDE2",$J)   ; Clean TMP globals
 ;
 S CLNC=0 ; Init. clinic
 ; Loop through clinics 
 F  S CLNC=$O(^SC(CLNC)) Q:'CLNC!(CNT'<MAXCNT)  D  Q:$G(ZTSTOP)
 . ;
 . D CLINICEX Q:'OK     ; Check for clinic exclusion
 . ;
 . S ^TMP("IBCNEDE2",$J,CLNC)=""
 ;
 ; Set up variables for scheduling call and call
 S IBSDA("FLDS")=8
 S IBSDA(1)=DT_";"_ENDDT
 S IBSDA(2)="^TMP(""IBCNEDE2"",$J,"
 S IBSDA(3)="R"
 S NUM=$$SDAPI^SDAMA301(.IBSDA) I NUM<1 D:NUM<0 ERRMSG G ENQ
 ;
 ;
 S CLNC=0 ; Init. clinic
 ; Loop through clinics returned
 F  S CLNC=$O(^TMP($J,"SDAMA301",CLNC)) Q:'CLNC  D  Q:$G(ZTSTOP)!(CNT'<MAXCNT)
 . ;
 . ; Loop through patients returned
 . S DFN=0 F  S DFN=$O(^TMP($J,"SDAMA301",CLNC,DFN)) Q:'DFN!(CNT'<MAXCNT)  D  Q:$G(ZTSTOP)
 .. ;
 .. S APTDT=DT           ; Check for appointment date
 .. S MCAREFLG=0
 .. ;
 .. ; Loop through dates in range at clinic
 .. F  S APTDT=$O(^TMP($J,"SDAMA301",CLNC,DFN,APTDT)) Q:('APTDT)!((APTDT\1)>ENDDT)!(CNT'<MAXCNT)  D  Q:$G(ZTSTOP)
 ... ;
 ... S SRVICEDT=APTDT\1 ;Set service date equal to appointment date
 ... S FRESHDT=$$FMADD^XLFDT(SRVICEDT,-FRESHDAY)
 ... ;
 ... ; Update count for periodic check
 ... S IBCNETOT=IBCNETOT+1
 ... ; Check for request to stop background job, periodically
 ... I $D(ZTQUEUED),IBCNETOT#100=0,$$S^%ZTLOAD() S ZTSTOP=1 Q
 ... ;
 ... S IBSDATA=$G(^TMP($J,"SDAMA301",CLNC,DFN,APTDT))
 ... S ELG=$P(IBSDATA,U,8)
 ... S ELG=$S(ELG'="":ELG,1:$P($G(^DPT(DFN,.36)),U,1))
 ... I $P($G(^DPT(DFN,0)),U,21) Q         ; Exclude if test patient
 ... I $P($G(^DPT(DFN,.35)),"^",1)'="" Q  ; Exclude if patient is deceased
 ... ;
 ... D ELG Q:'OK     ; Check for eligibility exclusion
 ... ;
 ... K ACTINS
 ... D ALL^IBCNS1(DFN,"ACTINS",2)
 ... ;
 ... I '$D(ACTINS(0)) Q  ; Patient has no active ins
 ... ;
 ... S INREC=0 ; Record ien
 ... F  S INREC=$O(ACTINS(INREC)) Q:('INREC)!(CNT'<MAXCNT)  D
 ... . S INSIEN=$P($G(ACTINS(INREC,0)),U,1) ; Insurance ien
 ... . S INSNAME=$P($G(^DIC(36,INSIEN,0)),U)
 ... . ; allow only one MEDICARE transmission per patient
 ... . I INSNAME["MEDICARE",MCAREFLG Q
 ... . ; exclude pharmacy policies
 ... . I $$GET1^DIQ(36,INSIEN_",",.13)="PRESCRIPTION ONLY" Q
 ... . S GIEN=+$P($G(ACTINS(INREC,0)),U,18)
 ... . I GIEN,$$GET1^DIQ(355.3,GIEN_",",.09)="PRESCRIPTION" Q
 ... . ; check for ins. to exclude (i.e. Medicaid)
 ... . I $$EXCLUDE^IBCNEUT4(INSNAME) Q
 ... . ; check insurance policy expiration date
 ... . I $$EXPIRED($P($G(ACTINS(INREC,0)),U,4)) Q
 ... . ;
 ... . ; set patient id field   IB*2*416
 ... . S PATID=$P($G(ACTINS(INREC,5)),U,1)    ; 5.01 field
 ... . ;
 ... . S PAYERSTR=$$INSERROR^IBCNEUT3("I",INSIEN) ; Get payer info
 ... . ;
 ... . S SYMBOL=+PAYERSTR ; error symbol
 ... . S PAYERID=$P(PAYERSTR,U,3)               ; (National ID) payer id
 ... . S PIEN=$P(PAYERSTR,U,2)                  ; Payer ien
 ... . I '$$PYRACTV^IBCNEDE7(PIEN) Q            ; Payer is not nationally active
 ... . ;
 ... . ; If error symbol exists, set record in insurance buffer & quit
 ... . I SYMBOL D  Q
 ... . . I 'SUPPBUFF,'$$BFEXIST^IBCNEUT5(DFN,INSNAME) D PT^IBCNEBF(DFN,INREC,SYMBOL,"",1)
 ... . ;
 ... . ; Update service date and freshness date based on payers allowed
 ... . ;  date range
 ... . D UPDDTS^IBCNEDE6(PIEN,.SRVICEDT,.FRESHDT)
 ... . ;
 ... . ; Update service dates for inquiry to be transmitted
 ... . D TQUPDSV^IBCNEUT5(DFN,PIEN,SRVICEDT)
 ... . ;
 ... . ; Quit before filing if outstanding entries in TQ
 ... . I '$$ADDTQ^IBCNEUT5(DFN,PIEN,SRVICEDT,FRESHDAY) Q
 ... . ;
 ... . S QURYFLAG="V"
 ... . K SIDARRAY
 ... . S SIDDATA=$$SIDCHK^IBCNEDE5(PIEN,DFN,,.SIDARRAY,FRESHDT)
 ... . S SIDACT=$P(SIDDATA,U),SIDCNT=$P(SIDDATA,U,2)
 ... . I SIDACT=3,'SUPPBUFF,'$$BFEXIST^IBCNEUT5(DFN,INSNAME) D PT^IBCNEBF(DFN,INREC,18,"",1) Q
 ... . I CNT+SIDCNT>MAXCNT S CNT=MAXCNT Q  ;exceeds MAXCNT
 ... . ;
 ... . S SID=""
 ... . F  S SID=$O(SIDARRAY(SID)) Q:SID=""  D:$P(SID,"_")'="" SET($P(SID,"_"),$P(SID,"_",2),PATID) S:INSNAME["MEDICARE" MCAREFLG=1
 ... . I SIDACT=4 D SET("","",PATID) S:INSNAME["MEDICARE" MCAREFLG=1
 ... . Q
 ... Q
ENQ K ^TMP($J,"SDAMA301"),^TMP("IBCNEDE2",$J)
 Q
 ;
CLINICEX ; Clinic exclusion
 S OK=1
 I $D(^DG(43,1,"DGPREC","B",CLNC)) S OK=0
 Q
 ;
ELG ;  Eligibility exclusion
 I ELG="" S OK=0 Q
 I $D(^DG(43,1,"DGPREE","B",ELG)) S OK=0 Q
 S OK=1
 Q
 ;
INP ;  Inpatient status
 D INP^VADPT
 I $G(VAIN(1))'="" K VAIN S OK=0 Q
 K VAIN
 S OK=1
 Q
 ;
SET(SID,INR,PATID) ; Set data in TQ
 ;
 ; The hard coded '1' in the 3rd piece of DATA1 sets the Transmission
 ; status of file 365.1 to "Ready to Transmit"
 S DATA1=DFN_U_PIEN_U_1_U_""_U_SID_U_FRESHDT ; SETTQ 1st parameter
 S $P(DATA1,U,8)=PATID     ; IB*2*416
 ;
 ; The hardcoded '2' in the 1st piece of DATA2 is the value to tell
 ; the file 365.1 that it is the appointment extract.
 S DATA2=2_U_QURYFLAG_U_SRVICEDT_U_INR    ; SETTQ 2nd parameter
 ;
 S TQIEN=$$SETTQ^IBCNEDE7(DATA1,DATA2)       ; Sets in TQ
 I TQIEN'="" S CNT=CNT+1                    ; If filed increment count
 ;
 Q
 ;
ERRMSG ; Send a message indicating an extract error has occured
 N MGRP,XMSUB,MSG,IBX,IBM
 ;
 ; Set to IB site parameter MAILGROUP
 S MGRP=$$MGRP^IBCNEUT5()
 ;
 S XMSUB="eIV Problem: Appointment Extract"
 S MSG(1)="On "_$$FMTE^XLFDT(DT)_" the Appointment Extract for eIV encountered one or more"
 S MSG(2)="errors while attempting to get Appointment data from the scheduling"
 S MSG(3)="package."
 S MSG(4)=""
 S MSG(5)="Error(s) encountered: "
 S MSG(6)=""
 S MSG(7)="  Error Code   Error Message"
 S MSG(8)="  ----------   -------------"
 S IBM=8,IBX=0 F  S IBX=$O(^TMP($J,"SDAMA301",IBX)) Q:IBX=""  S IBM=IBM+1,MSG(IBM)="  "_$$LJ^XLFSTR(IBX,13)_$G(^TMP($J,"SDAMA301",IBX))
 S IBM=IBM+1,MSG(IBM)=""
 S IBM=IBM+1,MSG(IBM)="As a result of this error the extract was not done.  The extract"
 S IBM=IBM+1,MSG(IBM)="will be attempted again the next night automatically.  If you"
 S IBM=IBM+1,MSG(IBM)="continue to receive error messages you should contact your IRM"
 S IBM=IBM+1,MSG(IBM)="and possibly call the Help Desk for assistance."
 ;
 D MSG^IBCNEUT5(MGRP,XMSUB,"MSG(")
 ;
 Q
 ;
EXPIRED(EXPDT) ; check if insurance policy has already expired
 ; EXPDT - expiration date (2.312/3)
 ; returns 1 if expiration date is in the past, 0 otherwise
 N X1,X2
 S X1=+$G(DT),X2=+$G(EXPDT)
 I X1,X2 Q $S($$FMDIFF^XLFDT(DT,EXPDT,1)>0:1,1:0)
 Q 0
