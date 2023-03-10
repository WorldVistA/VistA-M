IBCNEQU1 ;AITC/TAZ - eIV REQUEST ELECTRONIC INSURANCE INQUIRY CONT'D; 20-MAY-2021
 ;;2.0;INTEGRATED BILLING;**702**;21-MAR-94;Build 53
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; eIV - Insurance Verification Interface
 ;
 ; Continuation of IBCNEQU
 Q
 ;
EICDREQ ; User requested an EICD Discovery
 ;
 N DATA1,DATA2,DATA5,DIRUT,DUOUT,EACTIVE,ELG,FRESHDT,IBCNETOT,IBCSIEN,IBFREQ,IBMSG
 N IBTQIEN,IBTQSTAT,IHCNT,MSG,OK,PIEN,PRIORITY,SVDFN,VNUM,Y
 D FULL^VALM1
 S VALMBCK="Q"
 K DIR
 ;
 K ^TMP("IBQUERY",$J)
 ;
 S MSG=1
 S MSG(1)="Sorry the patient does not qualify for this action."
 S MSG(2)="An EICD request was submitted recently. It is too soon to submit another one."
 S MSG(3)="Sorry, but you do not have the required key for an EICD Request."
 S MSG(4)="An EICD request has been sent. If active insurance is found for this patient"
 S MSG(5)="results will be displayed in the buffer within 30 days."
 ;
 I '$D(^XUSEC("IBCNE EICD REQUEST",DUZ)) S MSG=3 G EICDREQX
 ;
 S EACTIVE=$$SETTINGS^IBCNEDE7(4)
 I 'EACTIVE G EICDREQX ; not active, or required fields missing
 S IBFREQ=$P(EACTIVE,U,8) ; frequency
 S FRESHDT=$$FMADD^XLFDT(DT,-IBFREQ) ;Fresh Date
 ;
 ;Check Payer
 S PIEN=$$EPAYR^IBCNEUT5() I 'PIEN G EICDREQX  ;Invalid EICD Payer
 ;
 ;Patient Eligibility requirements
 I '$$EPAT^IBCNEUT5(.MSG) G EICDREQX
 S ELG=$$GET1^DIQ(2,DFN_",",.361) ; "PRIMARY ELIGIBILITY CODE"
 D ELG^IBCNEDE2 I 'OK G EICDREQX  ;Eligibility Exclusion
 ;
 ; Cannot have Active Insurance
 I $$EACTPOL^IBCNEUT5() G EICDREQX
 ;
 ; there should be no TQ entry for this DFN, consider it a safety check
 I '$$ADDTQ^IBCNEUT5(DFN,PIEN,DT,IBFREQ,1) G EICDREQX
 ;
 S DIR(0)="Y"
 S DIR("A")="Are you sure you want to request a search for this patient's insurance"
 S DIR("B")="YES"
 S DIR("?",1)="  If yes, a EICD request will be initiated immediately."
 S DIR("?")="  If no, the EICD request will be cancelled."
 D ^DIR K DIR
 I $D(DIRUT)!$D(DUOUT)!('Y) S MSG=0 G EICDX
 ;
 ;Note:  We need to preserve the DFN.  It is getting killed somewhere in the message creation.
 S MSG=4,SVDFN=DFN
 ;
 ;Set up variables needed to send the request.
 ; SET prepare and file the TQ
 ; DFN:Patient IEN
 ; PIEN: EICD payer IEN
 ; IBTQSTAT: TQ STATUS IEN - Ready to Transmit
 ; FRESHDT: Freshness date 
 ; 4: EICD data extract (#4)
 ; I: Identification 
 ; DT: Todays date 
 ; IBCSIEN: Source of Information IEN - Contract Services    
 S IBCSIEN=$$FIND1^DIC(355.12,,"X","CONTRACT SERVICES","C")
 S IBTQSTAT=$$FIND1^DIC(365.14,,"X","Ready to Transmit","B")
 S DATA1=DFN_U_PIEN_U_IBTQSTAT_U_""_U_""_U_FRESHDT
 S DATA2=4_U_"I"_U_DT
 S DATA5=IBCSIEN
 S IBTQIEN=$$SETTQ^IBCNEDE7(DATA1,DATA2,,,DATA5) ; Sets in TQ
 I IBTQIEN="" G EICDREQX   ; didn't file 
 ;
 ; place a stub into EIV EICD TRACKING (#365.18)
 K IBFDA,IBERR
 ; EIV EICD TRACKING, .01:TRANSMISSION .02:DATE CREATED .03:PAYER .05:PATIENT
 S IBFDA(365.18,"+1,",.01)=IBTQIEN
 S IBFDA(365.18,"+1,",.02)=DT
 S IBFDA(365.18,"+1,",.03)=PIEN
 S IBFDA(365.18,"+1,",.05)=DFN
 D UPDATE^DIE(,"IBFDA",,"IBERR")
 I $G(IBERR("DIERR",1,"TEXT",1))'="" D  Q
 . S IBMSG=""
 . D MSG002^IBCNEMS1(.IBMSG,.IBERR,IBTQIEN)
 . D MSG^IBCNEUT5($$MGRP^IBCNEUT5(),"eIV Problem: Error writing EIV EICD TRACKING (#365.18)","IBMSG(")
 ; Note:  VNUM is required by the downstream code.  We must keep it until such time as 
 ; VNUM is changed to PRIORITY throughout the system.
 S (PRIORITY,VNUM)=4,(IBCNETOT,IHCNT)=0   ;Priority is determined by FIN^IBCNEDEP which uses variable "VNUM"
 S ^TMP("IBQUERY",$J,PRIORITY,DFN,IBTQIEN)=""
 D ID^IBCNEDEP
 S DFN=SVDFN
 K ^TMP("IBQUERY",$J)
 ;
EICDREQX ;
 I MSG D
 . W !!,*7,MSG(MSG)
 . I MSG=4 W !,MSG(5)
 . K DIR
 . D PAUSE^VALM1
 S VALMBCK="Q"
 Q
 ;
EICDX ; Return user to the screen, curser is at the Select Action prompt (like MBI action)
 S VALMBCK="R"
 Q
