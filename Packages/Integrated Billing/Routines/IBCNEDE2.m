IBCNEDE2 ;DAOU/DAC - eIV PRE REG EXTRACT (APPTS) ;23-SEP-2015
 ;;2.0;INTEGRATED BILLING;**184,271,249,345,416,438,506,549,593,595,621,659**;21-MAR-94;Build 16
 ;;Per VA Directive 6402, this routine should not be modified.
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
 ; IB*2.0*593 - Added EXCLTOC,EXCLTOP now initialized at top. Removed YY.
 ; IB*2.0*549 - Added YY,ZZ, Re-Arranged in alphabetical order
 N ACTINS,APTDT,CLNC,CNT,DATA1,DATA2,DFN,DISYS,ELG,ENDDT,EXCLTOC,EXCLTOP,FOUND1,FOUND2,FRESHDAY
 N FRESHDT,GIEN,IBCNETOT,IBDDI,IBINDT,IBINS,IBSDA,IBSDATA,IBOUTP,INREC,INS,INSIEN,INSNAME
 N MAXCNT,MCAREFLG,MFRESHDAY,NUM,OK,PATID,PAYER,PAYERID,PAYERSTR,PIEN   ;/vd-IB*2*659 - Added the MFRESHDAY variable for Medicare Frequency.
 N SETSTR,SID,SIDACT,SIDARRAY,SIDCNT,SIDDATA,SLCCRIT1,SRVICEDT,SUPPBUFF,SYMBOL
 N TODAYSDT,TQIEN,QURYFLAG,VAIN,VDATE,YY,ZZ
 ;
 S SETSTR=$$SETTINGS^IBCNEDE7(2)     ;  Get setting for pre reg. extract 
 I 'SETSTR Q                         ; Quit if extract is not active
 S SLCCRIT1=$P(SETSTR,U,2)           ; Selection Criteria #1
 S MAXCNT=$P(SETSTR,U,4)             ; Max # of TQ entries to create
 S:MAXCNT="" MAXCNT=9999999999
 S SUPPBUFF=$P(SETSTR,U,5)                   ; Suppress Buffer Flag
 S FRESHDAY=$P($G(^IBE(350.9,1,51)),U,1)     ; Freshness days span
 S MFRESHDAY=$$GET1^DIQ(350.9,"1,",51.32)    ;/vd-IB*2*659 - Medicare Freshness days span
 S CNT=0                                     ; Init. TQ entry counter
 S ENDDT=$$FMADD^XLFDT(DT,SLCCRIT1)   ; End of appt. date selection range
 S IBCNETOT=0               ; Initialize count for periodic TaskMan check
 S EXCLTOC=$$GETELST(355.2) ; Initialize excluded TYPEs OF COVERAGE IB*2.0*593
 S EXCLTOP=$$GETELST(355.1) ; Initialize excluded TYPEs OF PLAN IB*2.0*593
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
 ... ;S FRESHDT=$$FMADD^XLFDT(SRVICEDT,-FRESHDAY)    ;/vd - IB*2.0*659 - moved the setting of FRESHDT to right after the OKFRESH call
 ... ;
 ... S SRVICEDT=APTDT\1 ;Set service date equal to appointment date
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
 ... ; IB*2.0*549 removed the following line
 ... ;I $P($G(^DPT(DFN,.35)),"^",1)'="" Q  ; Exclude if patient is deceased
 ... ;
 ... D ELG Q:'OK     ; Check for eligibility exclusion
 ... ;
 ... K ACTINS
 ... D ALL^IBCNS1(DFN,"ACTINS",2)
 ... ;
 ... I '$D(ACTINS(0)) Q  ; Patient has no active ins
 ... ;
 ... S INREC=0 ; Record IEN
 ... F  S INREC=$O(ACTINS(INREC)) Q:('INREC)!(CNT'<MAXCNT)  D
 ... . N MFLG  ;Initialized in $$OKFRESH  IB*2.0*659/VD
 ... . S INSIEN=$P($G(ACTINS(INREC,0)),U,1) ; Insurance ien
 ... . S INSNAME=$P($G(^DIC(36,INSIEN,0)),U)
 ... . ;
 ... . ; IB*2.0*549 Added next 3 lines to exclude certain Type of Coverages
 ... . ; IB*2.0*593 Moved exclusion list initialization to top execution level.
 ... . S ZZ=$$GET1^DIQ(36,INSIEN_",",.13,"I")    ; Type of Coverage
 ... . ;S YY=$$GETELST(355.2)                    ; Type of Coverages to exclude
 ... . ;Q:YY[("^"_ZZ_"^")                        ; Excluded Type of Coverage
 ... . Q:EXCLTOC[("^"_ZZ_"^")                    ; Excluded Type of Coverage
 ... . ;
 ... . ;/vd-IB*2*659 - Replaced the following lines with the call to OKFRESH
 ... . ;               which properly identify those policies to exclude when
 ... . ;               verified within the "freshness days" for Medicare and
 ... . ;               non-Medicare policies.
 ... . ; Exclude policies that have been verified within "freshness days"
 ... . ;S VDATE=$P($G(ACTINS(INREC,1)),U,3)
 ... . ;I VDATE'="",SRVICEDT'>$$FMADD^XLFDT(VDATE,FRESHDAY) Q
 ... . I '$$OKFRESH(INREC,FRESHDAY,MFRESHDAY,.MFLG) Q
 ... . S FRESHDT=$$FMADD^XLFDT(SRVICEDT,$S(MFLG:-MFRESHDAY,1:-FRESHDAY))
 ... . ;
 ... . ; Allow only one MEDICARE transmission per patient
 ... . I INSNAME["MEDICARE",MCAREFLG Q
 ... . ;
 ... . ; Exclude pharmacy policies IB*2.0*549 - Commented out following line
 ... . ;I $$GET1^DIQ(36,INSIEN_",",.13)="PRESCRIPTION ONLY" Q
 ... . S GIEN=+$P($G(ACTINS(INREC,0)),U,18)
 ... . ;
 ... . ; IB*2.0*549 Added next 3 lines to exclude certain Type of Plans
 ... . ; IB*2.0*593/TAZ Moved exclusion list initialization to top execution level.
 ... . S ZZ=$$GET1^DIQ(355.3,GIEN_",",.09,"I")   ; Type of Plan
 ... . ;S YY=$$GETELST(355.1)                    ; Type of Plans to exclude
 ... . ;Q:YY[("^"_ZZ_"^")                        ; Excluded Type of Plan
 ... . Q:EXCLTOP[("^"_ZZ_"^")                        ; Excluded Type of Plan
 ... . ;
 ... . ;I GIEN,$$GET1^DIQ(355.3,GIEN_",",.09)="PRESCRIPTION" Q  ; IB*2.0*549 - Removed line
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
 ... . ;
 ... . ; If Payer is Nationally Inactive create an Insurance Buffer record w/blank SYMBOL & quit. - IB*2.0*506
 ... . I '$$PYRACTV^IBCNEDE7(PIEN) D  Q
 ... .. S SYMBOL=""
 ... .. I 'SUPPBUFF,'$$BFEXIST^IBCNEUT5(DFN,INSNAME) D PT^IBCNEBF(DFN,INREC,SYMBOL,"",1)
 ... .. Q
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
 ... . ; IB*2.0*659/VD - Added $S for MFLG
 ... . I '$$ADDTQ^IBCNEUT5(DFN,PIEN,SRVICEDT,$S(MFLG:MFRESHDAY,1:FRESHDAY),0) Q  ;IB*2.0*621 add flag, from EICDEXT 
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
 ... . ;
 ... . I SIDACT=4 D
 ... . . D SET("","",PATID)
 ... . . S:INSNAME["MEDICARE" MCAREFLG=1
 ... . Q
 ... Q
ENQ K ^TMP($J,"SDAMA301"),^TMP("IBCNEDE2",$J)
 Q
 ;
GETELST(FILE) ; Returns a '^' delimited list of Type of Plans or Type of
 ; coverages to be excluded with leading and trailing '^'s
 ; IB*2.0*549 Added method
 ; IB*2.0*593 Added NO-FAULT INSURANCE. Refactored.
 ; Input: FILE  - 355.1 - Return a list of Type of Plans to be excluded
 ;                355.2 - Return a list of Type of Coverages to be excluded
 ; Returns: '^' delimited list of Type of Plans or Type of Coverages
 ;          to be excluded
 ;N EXCLIST,IEN,NM,XX
 ;S EXCLIST="",NM("AUTOMOBILE")="",NM("MEDI-CAL")="",NM("TORT FEASOR")=""
 ;S NM("WORKERS' COMPENSATION INSURANCE")="",NM("VA SPECIAL CLASS")=""
 ;S NM("MEDICAID")=""
 ;S XX=""
 ;F  D  Q:XX=""
 ;. S XX=$O(NM(XX))
 ;. Q:XX=""
 ;. S IEN=""
 ;. F  D  Q:IEN=""
 ;. . S IEN=$O(^IBE(FILE,"B",XX,IEN))
 ;. . Q:IEN=""
 ;. . S EXCLIST=$S(EXCLIST="":IEN,1:EXCLIST_"^"_IEN)
 N EXCLIST,TYPE
 S EXCLIST=""
 F TYPE="AUTOMOBILE","MEDICAID","MEDI-CAL","NO-FAULT INSURANCE","TORT FEASOR","WORKERS' COMPENSATION INSURANCE","VA SPECIAL CLASS" D
 . N IEN S IEN=$O(^IBE(FILE,"B",TYPE,""))
 . Q:IEN=""
 . S EXCLIST=$S(EXCLIST="":IEN,1:EXCLIST_"^"_IEN)
 Q "^"_EXCLIST_"^"
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
 ;
 ; IB*2*595/DM add DATA5 to the SETTQ call 
 N DATA5
 ;
 S DATA1=DFN_U_PIEN_U_1_U_""_U_SID_U_FRESHDT ; SETTQ 1st parameter
 S $P(DATA1,U,8)=PATID     ; IB*2*416
 ;
 ; The hardcoded '2' in the 1st piece of DATA2 is the value to tell
 ; the file 365.1 that it is the appointment extract.
 S DATA2=2_U_QURYFLAG_U_SRVICEDT_U_INR    ; SETTQ 2nd parameter
 ;
 S DATA5=$$FIND1^DIC(355.12,,,"eIV","C")  ; Set to IEN of "eIV" Source of Information
 ;
 S TQIEN=$$SETTQ^IBCNEDE7(DATA1,DATA2,,,DATA5) ; Sets in TQ
 I TQIEN'="" S CNT=CNT+1                       ; If filed increment count
 ;
 Q
 ;
ERRMSG ; Send a message indicating an extract error has occurred
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
 ;/vd-IB*2.0*659 - Added the OKFRESH module of code to verify Policies.
OKFRESH(INREC,FRESHDAY,MFRESHDAY,MFLG) ; Identify those policies to exclude when
 ;               verified within the "freshness days" for Medicare and non-Medicare policies.
 ; INPUT:
 ;   INREC     - IEN to current Insurance Plan
 ;   FRESHDAY  - Freshness Days Span
 ;   MFRESHDAY - Medicare Freshness Days Span
 ;   MFLG      - Used to determine if the insurance plan is a Medicare Plan -  1=MEDICARE,  0=non-MEDICARE
 ; OUTPUT:
 ;   OK = 0 - Exclude Policy
 ;      = 1 - Include Policy
 N GIEN,IIEN,OK,VDATE
 S MFLG=0,OK=1,VDATE=$P($G(ACTINS(INREC,1)),U,3)
 S IIEN=$P($G(ACTINS(INREC,0)),U,1) ; Insurance ien
 I $$GET1^DIQ(36,IIEN_",",3.1)=$$GET1^DIQ(350.9,"1,",51.25) S MFLG=1  ; These are Medicare Part A and Part B Policies.
 I 'MFLG D   ;Determine if Group Plan is for Medicare Replacement (Part C) Policies (MEDICARE ADVANTAGE)
 . S GIEN=+$P($G(ACTINS(INREC,0)),U,18)   ; Group Plan ien
 . I GIEN,$$GET1^DIQ(355.3,GIEN_",",.09)="MEDICARE ADVANTAGE" S MFLG=1   ; Type of Policy
 . Q
 I $$GET1^DIQ(36,IIEN_",",.01)="MEDICARE PART D (WNR)" S MFLG=1  ; This is a Medicare Part D (MEDICARE (WNR))
 ;
 I VDATE'="",'MFLG,SRVICEDT'>$$FMADD^XLFDT(VDATE,FRESHDAY) S OK=0     ;Non-Medicare Policy outside of Freshness Day span
 I VDATE'="",MFLG,SRVICEDT'>$$FMADD^XLFDT(VDATE,MFRESHDAY) S OK=0     ;Medicare Policy outside of Medicare Freshness Day span
 Q OK
 ;
EXPIRED(EXPDT) ; check if insurance policy has already expired
 ; EXPDT - expiration date (2.312/3)
 ; returns 1 if expiration date is in the past, 0 otherwise
 N X1,X2
 S X1=+$G(DT),X2=+$G(EXPDT)
 I X1,X2 Q $S($$FMDIFF^XLFDT(DT,EXPDT,1)>0:1,1:0)
 Q 0
