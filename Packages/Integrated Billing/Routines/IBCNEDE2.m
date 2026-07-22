IBCNEDE2 ;DAOU/DAC - eIV Appointment Extract ; 23-SEP-2015
 ;;2.0;INTEGRATED BILLING;**184,271,249,345,416,438,506,549,593,595,621,659,743,778,827**;21-MAR-94;Build 24
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to ^SDAMA301  in ICR #4433
 ; Reference to ^XLFDT  in ICR #10103
 ; Reference to ^XLFSTR  in ICR #10104
 ;
 ;IB*778/CKB - rewrote the eIV Appointment Extract from scratch, reusing the routine IBCNEDE2.
 ;             Any modifications based on patches prior to 778 are no longer applicable for this
 ;             routine, due to the rewrite.
 ;
 ;**Program Description**
 ;  This program finds patients who have upcoming appointments within a
 ;  specified date range. The date range is parameter driven.
 ;  Periodically check for stop request as this is a background task.
 ;
 Q   ; can't be called directly
 ;
EN ; Loop through designated cross-references for updates
 N APTDT,CLNC,CNT,DFN,DTRANGE,ENDDT,EXCLTOC,EXCLTOP,FRESHDAY,IBCNETOT,IBFNDTQ,IBPQ,IBSDA,INREC,INSIEN,INSNAME
 N MAXCNT,MFLG,MFRESHDAY,NUM,OK,PATID,PAYERSTR,PIEN,PTINS,PYRAPP,QURYFLAG,SETSTR,SRVICEDT
 N SYMBOL,TQIEN,VDATE,ZTQUEUED,ZTSTOP,ZZ
 ;
 S SETSTR=$$SETTINGS^IBCNEDE7(2)     ; Get setting for pre reg. extract 
 I 'SETSTR Q                         ; Quit if extract is not active
 S DTRANGE=$P(SETSTR,U,2)            ; Selection Criteria #1 - how far in the future do I look for appts
 S MAXCNT=$P(SETSTR,U,4)             ; Max # of TQ entries to create & send to FSC
 S:MAXCNT="" MAXCNT=9999999999
 S FRESHDAY=$P($G(^IBE(350.9,1,51)),U,1)     ; Freshness days span
 S MFRESHDAY=$$GET1^DIQ(350.9,"1,",51.32)    ; Medicare Freshness days span
 S ENDDT=$$FMADD^XLFDT(DT,DTRANGE)           ; End of appt. date selection range
 S CNT=0                                     ; Init. entries created in TQ and send to FSC
 S IBCNETOT=0               ; Initialize count for periodic TaskMan check
 S EXCLTOC=$$GETELST(355.2) ; Initialize excluded TYPEs OF COVERAGE
 S EXCLTOP=$$GETELST(355.1) ; Initialize excluded TYPEs OF PLAN
 ; Clean TMP globals
 K ^TMP($J,"SDAMA301"),^TMP($J,"IBCNEDE2DFN")
 ;
 ; Set up variables for scheduling call and call
 S IBSDA("FLDS")=8
 S IBSDA(1)=DT_";"_ENDDT
 S IBSDA(3)="R"
 S NUM=$$SDAPI^SDAMA301(.IBSDA) I NUM<1 D:NUM<0 ERRMSG G ENQ
 ;
 ;
 S CLNC=0 ; Init. clinic
 ; Loop through clinics returned
 F  S CLNC=$O(^TMP($J,"SDAMA301",CLNC)) Q:'CLNC  D  Q:$G(ZTSTOP)
 . ;
 . ; Loop through patients returned
 . S DFN=0 F  S DFN=$O(^TMP($J,"SDAMA301",CLNC,DFN)) Q:'DFN  D  Q:$G(ZTSTOP)
 .. ;
 .. S APTDT=DT           ; Check for appointment date
 .. ;
 .. ; Loop through dates in range at clinic
 .. F  S APTDT=$O(^TMP($J,"SDAMA301",CLNC,DFN,APTDT)) Q:('APTDT)!((APTDT\1)>ENDDT)  D  Q:$G(ZTSTOP)
 ... ;
 ... S SRVICEDT=APTDT\1 ;Set service date equal to appointment date
 ... ;
 ... ; Update count for periodic check
 ... S IBCNETOT=IBCNETOT+1
 ... ; Check for request to stop background job, periodically
 ... I $D(ZTQUEUED),IBCNETOT#100=0,$$S^%ZTLOAD() S ZTSTOP=1 Q
 ... ;
 ... I $P($G(^DPT(DFN,0)),U,21) Q         ; Exclude if test patient
 ... ;
 ... ; Build temp array for allowed DFN's
 ... S ^TMP($J,"IBCNEDE2DFN",DFN,(+$G(SRVICEDT)))=""
 ;
100 ;
 ; Check the insurance for the selected DFNs based on future appointments
 S DFN=0
 F  S DFN=$O(^TMP($J,"IBCNEDE2DFN",DFN)) Q:'DFN  D
 . ;
 . K IBFNDTQ
 . K PTINS D ALL^IBCNEDE3(DFN,"PTINS")
 . I '$D(PTINS(0)) Q  ; Patient has no insurance to be evaluated
 . ;
 . ; Find the service date that is closest to TODAY (DT), do not look for past dates.
 . S SRVICEDT=$O(^TMP($J,"IBCNEDE2DFN",DFN,(DT-1)))
 . I SRVICEDT="" Q       ; No future appointments are found for the patient
 . ;
 . ;Loop through Patient policies and check MAXCNT
 . S INREC=0 F  S INREC=$O(PTINS(INREC)) Q:('INREC)!(CNT'<MAXCNT)  D
 .. N ADDTQ,FSCSEND,GIEN,GRPNAM,GRPNUM,PATID
 .. N SENDNOW,SUBID,TQENT,TQFOUND,XXGN
 .. S MFLG=0
 .. ; Repull Service Date for each Policy
 .. S SRVICEDT=$O(^TMP($J,"IBCNEDE2DFN",DFN,(DT-1)))
 .. ; Get Payer, Insurance and Group Plan info
 .. S INSIEN=$P($G(PTINS(INREC,0)),U,1)
 .. S INSNAME=$$GET1^DIQ(36,INSIEN_",",.01,"E")
 .. S GIEN=$$GET1^DIQ(2.312,INREC_","_DFN_",",.18,"I")
 .. S GRPNAM=$$GET1^DIQ(355.3,GIEN_",",2.01,"E")
 .. S GRPNUM=$$GET1^DIQ(355.3,GIEN_",",2.02,"E")
 .. S SUBID=$$GET1^DIQ(2.312,INREC_","_DFN_",",7.02,"E")
 .. S PATID=$$GET1^DIQ(2.312,INREC_","_DFN_",",5.01,"E")
 .. ; Remove any non-alpha numeric characters
 .. I SUBID'="" S SUBID=$$STRIP^IBCNEDE3(SUBID)
 .. I PATID'="" S PATID=$$STRIP^IBCNEDE3(PATID)
 .. ;
 .. ; Type of Plan
 .. S ZZ=$$GET1^DIQ(355.3,GIEN_",",.09,"I")
 .. Q:EXCLTOP[("^"_ZZ_"^")                   ; Excluded Types of Plan
 .. ;
 .. ; Type of Coverage
 .. S ZZ=$$GET1^DIQ(36,INSIEN_",",.13,"I")
 .. Q:EXCLTOC[("^"_ZZ_"^")                   ; Excluded Type of Coverage 
 .. ;
 .. ; OKFRESH properly identifies the policies to exclude when verified
 .. ; within the "freshness days" for Medicare and non-Medicare policies (MFLG)
 .. I '$$OKFRESH(INREC,FRESHDAY,MFRESHDAY,.MFLG) Q
 .. ;
 .. ; $$INSERROR, when passing in "I", gets Insurance company and Payer info and performs the following checks:
 .. ;  - Insurance company must be active, linked to a eIV payer AND not marked for deletion
 .. ;  - Insurance company name must not contain "MEDICAID"
 .. ;  - Payer must be Nationally and Locally enabled for eIV AND not deactivated
 .. ;  - Payer must have a VA National ID 
 .. S IBPQ=0
 .. S PAYERSTR=$$INSERROR^IBCNEUT3("I",INSIEN)
 .. S SYMBOL=+PAYERSTR                       ; error symbol
 .. S PIEN=$P(PAYERSTR,U,2)                  ; Payer IEN
 .. ;
 .. I +PIEN D
 ... ; Determine Payer App IEN
 ... S PYRAPP=$$PYRAPP^IBCNEUT5("EIV",PIEN)
 ... ; If Payer requires a Subscriber ID and the policy does not have one on file, drop to buffer
 ... I $$GET1^DIQ(365.121,PYRAPP_","_PIEN_",",4.02,"I") I SUBID="" S IBPQ=1
 .. ;
 .. ; If Payer IEN is not defined or Payer is Nationally Inactive, drop to buffer
 .. I ('+PIEN)!('$$PYRACTV^IBCNEDE7(PIEN)) S IBPQ=1
 .. ;
 .. ; Drop to the Buffer and quit, had an issue with Insurance Co or Payer or Policy
 .. I (SYMBOL)!(IBPQ=1) D  Q
 ... ;IB*827/CKB - If IEN for Payer AND if there is a TQ entry (within Freshness days) Quit, do NOT save to Buffer
 ... I +PIEN I $$TQEXIST^IBCNEDE3(DFN,PIEN,SUBID,GRPNUM,$S(MFLG:MFRESHDAY,1:FRESHDAY)) Q
 ... ; If there isn't an existing Buffer entry, drop to the Buffer
 ... I '$$BFEXIST^IBCNEDE3(DFN,INSNAME,SUBID,GRPNUM) D PT^IBCNEBF(DFN,INREC,SYMBOL,"",1)
 .. ;
 .. ; If MEDICARE (MFLG) and GRPNUM="PART A" or "PART B", check for the existence in array IBFNDTQ
 .. ; Only allow ONE occurrence in the TQ for Medicare Part A and Medicare Part B, never both
 .. I MFLG&((GRPNUM="PART A")!(GRPNUM="PART B")) I $D(IBFNDTQ(PIEN,$S(SUBID="":" ",1:SUBID),"PART A"))!$D(IBFNDTQ(PIEN,$S(SUBID="":" ",1:SUBID),"PART B")) Q
 .. ;
 .. ; Check for the existence in array IBFNDTQ, DO NOT continue
 .. I $D(IBFNDTQ(PIEN,$S(SUBID="":" ",1:SUBID),$S(GRPNUM="":" ",1:GRPNUM))) Q
 .. ; 
 .. ; Update service date based on Payers allowed date range
 .. D UPDSD^IBCNEDE3(PIEN,PYRAPP,.SRVICEDT)
 .. ;
 .. ; Initialize variables for TQUPDSV and TQCHKS
 .. S ADDTQ=1,(FSCSEND,TQFOUND)=0,TQENT=""
 .. ;
 .. ; Update service dates for inquiry to be transmitted
 .. D TQUPDSV^IBCNEDE3(DFN,PIEN,SRVICEDT,SUBID,GRPNUM)
 .. ; Check to see if a new entry can be added to the TQ file
 .. ;   sets ADDTQ
 .. D TQCHKS^IBCNEDE3(DFN,PIEN,SRVICEDT,SUBID,GRPNUM,$S(MFLG:MFRESHDAY,1:FRESHDAY))
 .. ;
 .. ; to handle Medicare Part A and Medicare Part B, only allow one occurrence 
 .. I ADDTQ&'TQFOUND&MFLG&((GRPNUM="PART A")!(GRPNUM="PART B")) D
 ... S XXGN=$S(GRPNUM="PART A":"PART B",1:"PART A")
 ... D TQUPDSV^IBCNEDE3(DFN,PIEN,SRVICEDT,SUBID,XXGN)
 ... D TQCHKS^IBCNEDE3(DFN,PIEN,SRVICEDT,SUBID,XXGN,$S(MFLG:MFRESHDAY,1:FRESHDAY))
 .. ;
 .. ; If a valid entry was found in the TQ file (TQFOUND=1) AND the send to FSC now flag
 .. ;  (FSCSEND) is set to '1', transmit to FSC and increment counter
 .. ; DO NOT create a new entry if TQFOUND is true
 .. I TQFOUND  D  Q
 ... I FSCSEND,TQENT I CNT'>MAXCNT D XMIT1^IBCNEDEP(TQENT) S CNT=CNT+1      ; Increment counter of entries sent to FSC
 .. ; If ADDTQ is set to '0', DO NOT create a new entry (safety valve)
 .. I 'ADDTQ Q
 .. ;
 .. ;IB*827/CKB - before adding to the TQ, if entry doesn't pass the Buffer entry checks
 .. ;              set ADDTQ=0 and Quit
 .. I ADDTQ I '$$BFCHECK^IBCNEDE3(DFN,INSNAME,SUBID,GRPNUM) S ADDTQ=0 Q
 .. ;
 .. ;   Determine if the Subscriber ID should be included/saved to the TQ
 .. ; The policy has a subscriber ID on file - include subscriber ID
 .. S QURYFLAG="V"
 .. I SUBID'="" D SET(SUBID,INREC,PATID)
 .. ; If the policy does NOT have subscriber ID on file - don't include subscriber ID
 .. I SUBID="" D SET("",INREC,PATID)
 .. ; Set local array of patient's added to the TQ file
 .. S IBFNDTQ(PIEN,$S(SUBID="":" ",1:SUBID),$S(GRPNUM="":" ",1:GRPNUM))=1
 ;
ENQ ;
 K ^TMP($J,"SDAMA301")
 K ^TMP($J,"IBCNEDE2DFN")
 Q
 ;========================================================================
GETELST(FILE) ; Returns a '^' delimited list of IENs Type of Plans or Type of
 ; coverages to be excluded with leading and trailing '^'s
 ;Input:
 ; FILE = 355.1 - Type of Plans
 ;      = 355.2 - Type of Coverages
 ;Returns: 
 ; EXCLIST - '^' delimited list of IENs for Type of Plans or Type of Coverages
 ;           to be excluded (ie., ^10^6^22^)
 ;
 N EXCLIST,IEN,LINE,TYPE
 S EXCLIST=""
 I FILE="355.1" F LINE=1:1 S TYPE=$P($T(TOP+LINE),";;",2) Q:TYPE=""  D
 . I '$D(^IBE(FILE,"B",TYPE)) Q
 . N IEN S IEN=$O(^IBE(FILE,"B",TYPE,""))
 . S EXCLIST=$S(EXCLIST="":IEN,1:EXCLIST_"^"_IEN)
 ;
 I FILE="355.2" F LINE=1:1 S TYPE=$P($T(TOC+LINE),";;",2) Q:TYPE=""  D
 . I '$D(^IBE(FILE,"B",TYPE)) Q
 . N IEN S IEN=$O(^IBE(FILE,"B",TYPE,""))
 . S EXCLIST=$S(EXCLIST="":IEN,1:EXCLIST_"^"_IEN)
 ;
 Q "^"_EXCLIST_"^"
 ;----------------------------------
TOP ; Type of Plans (#355.1) to exclude
 ;;AUTOMOBILE
 ;;MEDICAID
 ;;MEDI-CAL
 ;;TORT FEASOR
 ;;WORKERS' COMPENSATION INSURANCE
 ;;VA SPECIAL CLASS
 ;;ACCIDENT AND HEALTH INSURANCE
 ;;AVIATION TRIP INSURANCE
 ;;CATASTROPHIC INSURANCE
 ;;COINSURANCE
 ;;INCOME PROTECTION (INDEMNITY)
 ;;MEDICARE/MEDICAID (MEDI-CAL)
 ;;QUALIFIED IMPAIRMENT INSURANCE
 ;;SPECIAL CLASS INSURANCE
 ;;SPECIAL RISK INSURANCE
 ;----------------------------------
TOC ; Type of Coverages (#355.2) to exclude 
 ;;MEDICAID
 ;;MEDI-CAL
 ;;TORT/FEASOR 
 ;;WORKERS' COMPENSATION
 ;;VA SPECIAL CLASS
 ;;DISABILITY INCOME INSURANCE
 ;;INDEMNITY
 ;;SUBSTANCE ABUSE ONLY
 ;----------------------------------
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
 S MFLG=0,OK=1,VDATE=$P($G(PTINS(INREC,1)),U,3)
 S IIEN=$P($G(PTINS(INREC,0)),U,1)       ; Insurance ien
 ; Is the Insurance company PAYER (#36,3.1) the same as MEDICARE PAYER (#350.9,51.25) 
 I $$GET1^DIQ(36,IIEN_",",3.1)=$$GET1^DIQ(350.9,"1,",51.25) S MFLG=1   ;Medicare Part A and Part B Policies
 ; Determine if Type of Plan (#355.3,.09) for the Group Plan is MEDICARE ADVANTAGE
 I 'MFLG D
 . S GIEN=+$P($G(PTINS(INREC,0)),U,18)   ; Group Plan ien
 . I GIEN,$$GET1^DIQ(355.3,GIEN_",",.09)="MEDICARE ADVANTAGE" S MFLG=1 ;Medicare Part C
 I $$GET1^DIQ(36,IIEN_",",.01)="MEDICARE PART D (WNR)" S MFLG=1        ;Medicare Part D (WNR)
 ;
 I VDATE'="",'MFLG,SRVICEDT'>$$FMADD^XLFDT(VDATE,FRESHDAY) S OK=0      ;Non-Medicare Policy outside of Freshness Day span
 I VDATE'="",MFLG,SRVICEDT'>$$FMADD^XLFDT(VDATE,MFRESHDAY) S OK=0      ;Medicare Policy outside of Medicare Freshness Day span
 Q OK
 ;----------------------------------
SET(SID,INR,PATID) ; Set data in TQ and send to FSC
 ;
 N DATA1,DATA2,DATA5,ORIG
 ;
 ; The hard coded '1' in the 3rd piece of DATA1 sets the Transmission
 ; status of file 365.1 to "Ready to Transmit"
 ;   10/2023: FRESHDT is no longer being included in DATA1
 S DATA1=DFN_U_PIEN_U_1_U_""_U_SID                 ; SETTQ 1st parameter
 S $P(DATA1,U,8)=PATID
 ;
 ; The hardcoded '2' in the 1st piece of DATA2 is the value to tell
 ; the file 365.1 that it is the appointment extract.
 S DATA2=2_U_QURYFLAG_U_SRVICEDT_U_INR             ; SETTQ 2nd parameter
 ;
 S ORIG=U_$S(GRPNUM=" ":"",1:GRPNUM)_U_$S(GRPNAM=" ":"",1:GRPNAM)
 ;
 S DATA5=$$FIND1^DIC(355.12,,,"eIV","C")           ; Set to IEN of "eIV" Source of Information
 ;
 S TQIEN=$$SETTQ^IBCNEDE7(DATA1,DATA2,ORIG,,DATA5) ; Sets entry into the TQ
 ; Send entry to FSC
 I TQIEN I CNT'>MAXCNT D XMIT1^IBCNEDEP(TQIEN) S CNT=CNT+1      ; Increment the counter of entries sent to FSC
 Q
 ;----------------------------------
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
 Q
