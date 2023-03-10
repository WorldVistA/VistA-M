IBCNEDE4 ;AITC/DM - EICD (Electronic Insurance Coverage Discovery) extract; 24-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,271,416,621,602,668,702**;21-MAR-94;Build 53
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
 ;/vd-IB*2*668 - replaced the following 2 lines of code to obtain the internal
 ;               identifier for the Payer Application.
 ;IB*702/TAZ Moved Payer checks to EPAYR^IBCNEUT5 (includes the lines IB*668 fixed)
 S IBEICDPAY=$$EPAYR^IBCNEUT5 I 'IBEICDPAY G ENQQ
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
 .. ;IB*702/TAZ Checks for TEST PATIENT, DATE LAST EICD RUN, DATE OF DEATH, CITY AND ZIP moved to EPAT^IBCNEUT5
 .. I '$$EPAT^IBCNEUT5() S IBDFNDONE(DFN)="" Q  ; patient requirements not met 
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
 ... ;IB*602/TAZ Screen out bad pointers to File 36
 ... ;IB*702/TAZ - Active Insurance check was moved to EACTPOL^IBCNEUT5 
 ... I $$EACTPOL^IBCNEUT5 Q  ; Active policies on patient. (screen out bad ptr's to File 36)
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
 ;NAINSCO ; Non-active Insurance companies and NATPLANS ; Non-active Type of Plans Moved to IBCNEUT5
