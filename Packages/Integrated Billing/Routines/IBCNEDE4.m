IBCNEDE4 ;AITC/DM - EICD (Electronic Insurance Coverage Discovery) extract;24-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,271,416,621**;21-MAR-94;Build 14
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; **Program Description**
 ; The Electronic Insurance Coverage Discovery a.k.a EICD extract (#4)
 ; is called from the nightly job - IBCNEDE.
 ;
 ; Formerly known as "No Insurance", we are reworking the entire logic for 
 ; determining insurance for those who don't have active policies with patch IB*2.0*621.
 ;
 Q
 ;
EN ; EICD extract entry 
 N CLNC,DATA1,DATA2,DATA5,DFN,EACTIVE,ELG,FRESHDT,IBACTV,IBAPPTDT
 N IBBEGDT,IBCSIEN,IBDFNDONE,IBEFF,IBEICDPAY,IBENDDT,IBERR,IBEXP,IBFDA
 N IBFREQ,IBIDX,IBINSNM,IBMSG,IBSDA,IBTASKTOT,IBTOPIEN,IBTQCNT,IBTQIEN
 N IBTQSTAT,IBWK1,IBWK2,IBWKIEN,MAXCNT,OK
 ;
 ;  Get Extract parameters
 S EACTIVE=$$SETTINGS^IBCNEDE7(4)
 I 'EACTIVE G ENQQ ; not active, or required fields missing
 S MAXCNT=$P(EACTIVE,U,4) ; throttle daily extract queries
 S:MAXCNT="" MAXCNT=9999999999
 S IBWK1=$P(EACTIVE,U,6) ; start days
 S IBBEGDT=$$FMADD^XLFDT(DT,IBWK1) ; begin date = today + start days
 S IBENDDT=$$FMADD^XLFDT(DT,IBWK1+$P(EACTIVE,U,7)) ; end date = today + start days + days after start
 S IBFREQ=$P(EACTIVE,U,8) ; frequency
 S FRESHDT=$$FMADD^XLFDT(DT,-IBFREQ)
 S IBCSIEN=$$FIND1^DIC(355.12,,"X","CONTRACT SERVICES","C")
 S IBTQSTAT=$$FIND1^DIC(365.14,,"X","Ready to Transmit","B")
 ;
 ; see if the EICD PAYER site parameter has been populated
 ; and is nationally and locally active, if not, quietly quit 
 S IBEICDPAY=+$$GET1^DIQ(350.9,"1,",51.31,"I") ; "EICD PAYER"
 I 'IBEICDPAY G ENQQ
 I '($$GET1^DIQ(365.121,"1,"_IBEICDPAY_",",.02,"I")) G ENQQ ; "NATIONAL ACTIVE"
 I '($$GET1^DIQ(365.121,"1,"_IBEICDPAY_",",.03,"I")) G ENQQ ; "LOCAL ACTIVE"
 ;
 ; gather the non-active insurance company names
 ; we will strip all blanks from the names, so dashes ('-') are treated properly for a compare 
 F IBIDX=2:1 S IBWK1=$P($T(NAINSCO+IBIDX),";;",2) Q:IBWK1=""  S IBINSNM($TR(IBWK1," ",""))=""
 ;
 ; gather the non-active type of plan iens
 F IBIDX=2:1 S IBWK1=$P($T(NATPLANS+IBIDX),";;",2) Q:IBWK1=""  D
 . S IBWK2=+$$FIND1^DIC(355.1,,"BQX",IBWK1)
 . Q:'IBWK2
 . S IBTOPIEN(IBWK2)=""
 ;
 S IBTASKTOT=0 ; Taskman check
 S IBTQCNT=0 ; TQ entry count 
 K ^TMP($J,"SDAMA301"),^TMP($J,"IBCNEDE4"),IBDFNDONE
 ;
 ; Loop through clinics 
 S CLNC=0 F  S CLNC=$O(^SC(CLNC)) Q:'CLNC  D
 . D CLINICEX^IBCNEDE2 Q:'OK  ; clinic excluded
 . S ^TMP($J,"IBCNEDE4",CLNC)=""
 ;
 ; Set up variables for scheduling api and call
 S IBSDA("FLDS")=8
 S IBSDA(1)=IBBEGDT_";"_IBENDDT
 S IBSDA(2)="^TMP($J,""IBCNEDE4"","
 S IBSDA(3)="R"
 S OK=$$SDAPI^SDAMA301(.IBSDA) I OK<1 D:OK<0 ERRMSG G ENQQ
 ;
 ; loop through returned clinics
 S CLNC=0
 F  S CLNC=$O(^TMP($J,"SDAMA301",CLNC)) Q:'CLNC  D  G ENQQ:$G(ZTSTOP)!(IBTQCNT'<MAXCNT)
 . ;
 . ; Loop through patients returned
 . S DFN=0
 . F  S DFN=$O(^TMP($J,"SDAMA301",CLNC,DFN)) Q:'DFN  D  Q:$G(ZTSTOP)!(IBTQCNT'<MAXCNT)
 .. ;
 .. ; CHECK DFN STUFF
 .. Q:$D(IBDFNDONE(DFN))  ; DFN has been handled
 .. ;
 .. S OK=1
 .. S IBWK1=+$$GET1^DIQ(2,DFN_",",.6,"I") ; "TEST PATIENT INDICATOR"
 .. S:IBWK1 OK=0
 .. ;
 .. S IBWK1=+$$GET1^DIQ(2,DFN_",",2001,"I") ; "DATE LAST EICD RUN" from PATIENT INS node
 .. I IBWK1,(IBWK1>FRESHDT) S OK=0
 .. ; 
 .. S IBWK1=+$$GET1^DIQ(2,DFN_",",.351,"I") ; "DATE OF DEATH" 
 .. S:IBWK1 OK=0
 .. ;
 .. ; any value for CITY is valid, HL7 will replace a "" with "UNKNOWN" 
 .. S IBWK1=$$GET1^DIQ(2,DFN_",",.115) ; "STATE"
 .. S:IBWK1="" OK=0
 .. S IBWK1=$$GET1^DIQ(2,DFN_",",.116) ; "ZIP CODE"
 .. S:IBWK1="" OK=0
 .. ;
 .. I 'OK S IBDFNDONE(DFN)="" Q  ; patient requirements not met 
 .. ;   
 .. ; Loop through dates in range at clinic
 .. S IBAPPTDT=IBBEGDT
 .. F  S IBAPPTDT=$O(^TMP($J,"SDAMA301",CLNC,DFN,IBAPPTDT)) Q:('IBAPPTDT)!((IBAPPTDT\1)>IBENDDT)  D  Q:$G(ZTSTOP)!(IBTQCNT'<MAXCNT)
 ... ;
 ... ; Update count for periodic check
 ... S IBTASKTOT=IBTASKTOT+1
 ... ; Check for request to stop background job, periodically
 ... I $D(ZTQUEUED),IBTASKTOT#100=0,$$S^%ZTLOAD() S ZTSTOP=1 Q
 ... ;
 ... Q:$D(IBDFNDONE(DFN))  ; we've already seen this DFN
 ... ;
 ... S IBWK1=$G(^TMP($J,"SDAMA301",CLNC,DFN,IBAPPTDT))
 ... S ELG=$P(IBWK1,U,8)
 ... S:ELG="" ELG=$$GET1^DIQ(2,DFN_",",.361) ; "PRIMARY ELIGIBILITY CODE" 
 ... D ELG^IBCNEDE2 Q:'OK  ; eligibility exclusion
 ... ;
 ... ; skip any patient with "active" insurance 
 ... S IBACTV=0
 ... S IBIDX=0 ; check policies for "active" insurance 
 ... F  S IBIDX=$O(^DPT(DFN,.312,IBIDX)) Q:('IBIDX)!IBACTV  D
 .... S IBWKIEN=IBIDX_","_DFN_","
 .... S IBEFF=+$$GET1^DIQ(2.312,IBWKIEN,8,"I") ; effective date 
 .... S IBEXP=+$$GET1^DIQ(2.312,IBWKIEN,3,"I") ; expiration date
 .... I 'IBEFF Q  ; non-active
 .... I IBEXP,(IBEXP<(IBAPPTDT\1)) Q  ; non-active
 .... ; 
 .... S IBWK1=$$GET1^DIQ(2.312,IBWKIEN,.01,"E") ; insurance company name 
 .... Q:$D(IBINSNM($TR(IBWK1," ","")))  ; matches non-active insurance
 .... S IBWK1=$$GET1^DIQ(2.312,IBWKIEN,.18,"I")   ; group plan ien 
 .... S IBWK2=$$GET1^DIQ(355.3,IBWK1_",",.09,"I") ; type of plan ien
 .... ; no type of plan is considered active 
 .... I IBWK2'="",$D(IBTOPIEN(IBWK2)) Q  ; matches non-active type of plan
 .... ; 
 .... ; 'IBEXP is considered active at this point 
 .... S IBACTV=1 Q  ; active 
 ... ;
 ... I IBACTV Q  ; next clinic appt 
 ... ; 
 ... ; This DFN is considered non-active, we'll attempt a TQ entry
 ... S IBDFNDONE(DFN)=""  ; ok to flag DFN as handled now 
 ... ; there should be no TQ entry for this DFN, consider it a safety check 
 ... I '$$ADDTQ^IBCNEUT5(DFN,IBEICDPAY,DT,IBFREQ,1) Q
 ... ; SET prepare and file the TQ
 ... ; DFN:Patient IEN
 ... ; IBEICDPAY:EICD payer IEN
 ... ; IBTQSTAT:TQ STATUS IEN - Ready to Transmit 
 ... ; FRESHDT:Freshness date 
 ... ; 4:EICD data extract (#4)
 ... ; I:Identification 
 ... ; DT:Todays date 
 ... ; IBCSIEN:Source of Information IEN - Contract Services    
 ... S DATA1=DFN_U_IBEICDPAY_U_IBTQSTAT_U_""_U_""_U_FRESHDT
 ... S DATA2=4_U_"I"_U_DT
 ... S DATA5=IBCSIEN
 ... S IBTQIEN=$$SETTQ^IBCNEDE7(DATA1,DATA2,,,DATA5) ; Sets in TQ
 ... I IBTQIEN="" K IBDFNDONE(DFN) Q   ; didn't file, unmark DFN 
 ... S IBTQCNT=IBTQCNT+1               ; increment the TQ count
 ... ; place a stub into EIV EICD TRACKING (#365.18)
 ... K IBFDA,IBERR
 ... ; EIV EICD TRACKING, .01:TRANSMISSION .02:DATE CREATED .03:PAYER .05:PATIENT
 ... S IBFDA(365.18,"+1,",.01)=IBTQIEN,IBFDA(365.18,"+1,",.02)=DT
 ... S IBFDA(365.18,"+1,",.03)=IBEICDPAY,IBFDA(365.18,"+1,",.05)=DFN
 ... D UPDATE^DIE(,"IBFDA",,"IBERR")
 ... I $G(IBERR("DIERR",1,"TEXT",1))'="" D  Q
 .... S IBMSG=""
 .... D MSG002^IBCNEMS1(.IBMSG,.IBERR,IBTQIEN)
 .... D MSG^IBCNEUT5($$MGRP^IBCNEUT5(),"eIV Problem: Error writing EIV EICD TRACKING (#365.18)","IBMSG(")
 ... Q  ; next clinic appt
 ... ; 
ENQQ ; clean and quit 
 K ^TMP($J,"SDAMA301"),^TMP($J,"IBCNEDE2")
 Q
 ;
ERRMSG ; Send a message indicating an extract error has occurred
 S IBMSG=""
 D MSG001^IBCNEMS1(.IBMSG,"EICD")
 D MSG^IBCNEUT5($$MGRP^IBCNEUT5(),"eIV Problem: EICD Extract","IBMSG(")
 ;
 Q
 ;
NAINSCO ; Non-active Insurance companies
 ;
 ;;MEDICARE (WNR)
 ;;VACAA-WNR  
 ;;CAMP LEJEUNE - WNR
 ;;IVF - WNR
 ;;VHA DIRECTIVE 1029 WNR
 ;
NATPLANS ; Non-active Type of Plans
 ;
 ;;ACCIDENT AND HEALTH INSURANCE
 ;;AUTOMOBILE
 ;;AVIATION TRIP INSURANCE
 ;;CATASTROPHIC INSURANCE
 ;;CHAMPVA
 ;;COINSURANCE
 ;;DENTAL INSURANCE
 ;;DUAL COVERAGE
 ;;INCOME PROTECTION (INDEMNITY)
 ;;KEY-MAN HEALTH INSURANCE
 ;;LABS, PROCEDURES, X-RAY, ETC. (ONLY)
 ;;MEDI-CAL
 ;;MEDICAID
 ;;MEDICARE (M)
 ;;MEDICARE/MEDICAID (MEDI-CAL)
 ;;MENTAL HEALTH
 ;;NO-FAULT INSURANCE
 ;;PRESCRIPTION
 ;;QUALIFIED IMPAIRMENT INSURANCE
 ;;SPECIAL CLASS INSURANCE
 ;;SPECIAL RISK INSURANCE
 ;;SPECIFIED DISEASE INSURANCE
 ;;Substance abuse only
 ;;TORT FEASOR
 ;;TRICARE
 ;;TRICARE SUPPLEMENTAL
 ;;VA SPECIAL CLASS
 ;;VISION
 ;;WORKERS' COMPENSATION INSURANCE
 ;
 Q
 ;
