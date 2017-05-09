IBFBNP1 ;ALB/RED- EDI-CPAC build 1st and 3rd party copayments ;10/01/15
 ;;2.0;INTEGRATED BILLING;**554**;21-MAR-94;Build 81
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
NRUN ; main entry point - nightly run job to look at existing FB payments and add/edit entries in file #360
 ;Start by looking for recent FB payments
 ; 
 N FBSITE,IBVEN,IBSERVDT,IBCATC,IBSITE,IBMTC,FBARRLTC,IBDTPD,IBDUZ,IBREC,IBRECZ,IBDOS,IBTYP,IBADMDT,OTPTBIL,IBSTDT
 N IBBILL,IBCLAIM,IBFBDT,IBIENS,IBLOG,IENROOT,IENS,IBSERV,FRSTPRT,IBFBINS,IBDOST,FBA,FBC,IBCARETY,DFN,%,FBSITE
 S FBARRLTC="" D MKARRLTC^FBPCR4  ;build array needed later for POV in LTC co-pay
 S (IBCATC,IBMTC,FRSTPRT)=0  ;(CAT C FLAG and IBMTC = Determine if patient is pending adjudication or category C and has agreed to pay the deductible
 ;
 D SITE^FBAACO S IBSITE=$P(FBSITE(1),U,3)
 ;S IBN=$$PT^IBEFUNC(IBDFN) D UTIL^IBCA3,UTIL^IBOA32  ;   check for all outstanding bills, build ^UTILITY($J
 S IBSTDT=$P(^IBE(350.9,1,7),U,2)\1-1   ;       set to last time Autobiller was ran -1 day (MOVED TO NODE 7, PIECE 2)
 I IBSTDT<1 S IBSTDT=$$FMADD^XLFDT(DT,-5) ;default to today-5 if not set
 F  S IBSTDT=$O(^FBAAC("AK",IBSTDT)) Q:'IBSTDT  D PAYMT
 Q
PAYMT ;
 N DFN,IBAUTH,IBPOV,IBINV
 S (DFN,IBPOV,IBINV,IBDOS,IBCARETY)=0 F  S DFN=$O(^FBAAC("AK",IBSTDT,DFN)) Q:'DFN  D
 . S IBVEN=0 F  S IBVEN=$O(^FBAAC("AK",IBSTDT,DFN,IBVEN)) Q:'IBVEN  D
 .. S IBSERVDT=0 F  S IBSERVDT=$O(^FBAAC("AK",IBSTDT,DFN,IBVEN,IBSERVDT)) Q:'IBSERVDT  D
 ... S IBSERV=0 F  S IBSERV=$O(^FBAAC("AK",IBSTDT,DFN,IBVEN,IBSERVDT,IBSERV)) Q:'IBSERV  D
 .... ; Set the temporary payment array to service date and the zero node (IBFB=patient;vendor;service prov IEN;service date IEN), Auth, Invoice and POV
 .... Q:$G(^FBAAC(DFN,1,IBVEN,1,IBSERVDT,1,IBSERV,0))=""  ;          quit if the zero node of the payment is undefined
 .... Q:$G(^FBAAC(DFN,1,IBVEN,1,IBSERVDT,1,IBSERV,"FBREJ"))]""  ;payment was rejected
 .... S IBDTPD=$$GET1^DIQ(162.03,IBSERV_","_IBSERVDT_","_IBVEN_","_DFN_",",12,"I")
 .... Q:'IBDTPD  ; quit if the date paid is NULL/Empty
 .... S IBDOS=$$GET1^DIQ(162.02,IBSERVDT_","_IBVEN_","_DFN_",",.01,"I")
 .... S IBAUTH=$$GET1^DIQ(162.03,IBSERV_","_IBSERVDT_","_IBVEN_","_DFN_",",15.5,"I") ;   New location as per FB*3.5*154
 .... S IBTYP=$$GET1^DIQ(162.03,IBSERV_","_IBSERVDT_","_IBVEN_","_DFN_",",27,"I") I $G(IBTYP)["7078" S IBADMDT=$P($G(^FB7078(+IBTYP,0)),U,15) ; Find admission date
 .... S IBINV=$$GET1^DIQ(162.03,IBSERV_","_IBSERVDT_","_IBVEN_","_DFN_",",14,"I")
 .... Q:'IBINV  ;Quit if there is no Invoice for this record
 .... S IBCARETY=$$GET1^DIQ(162.03,IBSERV_","_IBSERVDT_","_IBVEN_","_DFN_",",23,"I")  ;Fee Program pointer to #161.8
 .... I "^2^3^6^7^"'[IBCARETY Q   ;Fee Program categories
 .... S IBPOV=$$GET1^DIQ(162.03,IBSERV_","_IBSERVDT_","_IBVEN_","_DFN_",",16,"I")
 .... Q:'IBPOV
 .... S IBCATC=$$CATC^FBPCR(DFN,IBDOS,IBPOV)  ;determine 3rd party copayment requirements
 .... S IBFBINS=$$INSURED^IBCNS1(DFN,IBDOS)  ; Check for active insurance as per date of service
 .... D ADMIT,CHKOTPT,FILE
 Q
 ;
ADMIT ;                check for inpatient 1st party bills
 Q:$G(IBADMDT)=""
 S IBBILL=0
 K ^TMP("IBRBF",$J)  ; kill of temp global before call
 D FPINPT^IBEFURF(DFN,IBADMDT)
 S IBBILL=$O(^TMP("IBRBF",$J,"FP",0))
 K ^TMP("IBRBF",$J)
 Q
 ;
 ;
FILE ;                 check payment against file #360
 ;  
 N FDA,IBEDIT,IBRECZ,IBOAUTH,IBOCLM,IBOBILL,IBFLAG
 S (IBOAUTH,IBEDIT,IBREC,IBFLAG,IENS,IBCLAIM)=0,IBBILL=$G(IBBILL)
 I $G(IBAUTH)="" S IBAUTH="0"
 ;                      check to see if the patient has that invoice, if so use that record
 I IBINV,$D(^IBFB(360,"F",DFN,IBINV)) S IBREC=$O(^IBFB(360,"F",DFN,IBINV,0))  ;Check patient and invoice xref for existing record
 ;
 ;                      check to see if there is a record existing with no Auth that we can link to properly
 I 'IBAUTH,$D(^IBFB(360,"C",DFN)) D
 . S IBRECZ=0  ;        set a temporary record number to check against former records by looping through "C" xref
 . F  S IBRECZ=$O(^IBFB(360,"C",DFN,IBRECZ)) Q:IBRECZ=""  D
 .. S IBOCLM=$P($G(^IBFB(360,IBRECZ,1)),U)  ;Claim IEN exists for this record
 .. S IBOBILL=$P($G(^IBFB(360,IBRECZ,1)),U,4)  ; Bill IEN exists for this record
 .. I IBOCLM!IBOBILL S IBREC=IBRECZ,IBRECZ="a" Q  ;Found a record to edit, set missing Auth to zero and quit
 .. Q
 ;
 I ('FRSTPRT&'IBFBINS)!('IBCATC&'IBFBINS) Q   ; Quit if no insurance and not Cat C or First party
 ;
 ;                      edit an existing record
 I IBREC D
 . K FDA
 . ; S IBCLAIM=+$$GET1^DIQ(360,IBREC_",",1.01,"I")
 . ; D STUB  ;check/create stub record in file #356
 . I $$GET1^DIQ(360,IBREC_",",1.03,"I")="" S FDA(360,IBREC_",",1.03)=$G(IBINV)  ;Invoice number
 . I $$GET1^DIQ(360,IBREC_",",.05,"I")="" S FDA(360,IBREC_",",.05)=IBDOS  ;Initial treatment date
 . I IBBILL,$$GET1^DIQ(360,IBREC_",",1.04,"I")="" S FDA(360,IBREC_",",1.04)=IBBILL ;1st Party Co-pay - Admission
 . ; I IBCLAIM,$$GET1^DIQ(360,IBREC_",",1.01,"I")'=IBCLAIM S FDA(360,IBREC_",",1.01)=IBCLAIM  ;Claim number
 . I $$GET1^DIQ(360,IBREC_",",2.03,"I")="" S FDA(360,IBREC_",",2.03)="FR"  ;Set facility revenue worklist queue
 . Q:'$D(FDA)
 . S IBFLAG=1  ; flag used for log file
 . D UPDATE^DIE("","FDA")
 . I 'IBCATC S IBBILL=$$GET1^DIQ(360,IBREC_",",1.04,"I") I IBBILL D SETOTPT
 .;
 ;
 ;                      if the patient or the Invoice isn't present add a new record
 I 'IBREC D
 . K FDA,IENROOT
 . S IBFLAG=1  ; flag used for log file
 . S IBIENS="+1,",IENS=$P(^IBFB(360,0),U,3)+1
 . S FDA(360,IBIENS,.01)=IENS,FDA(360,IBIENS,.02)=$G(DFN),FDA(360,IBIENS,.03)=$G(IBAUTH)
 . S FDA(360,IBIENS,1.03)=$G(IBINV),FDA(360,IBIENS,.05)=IBDOS  ;Invoice, Initial treatment date
 . I IBBILL S FDA(360,IBIENS,1.04)=IBBILL ;1st Party Co-pay - Admission
 . I OTPTBIL S FDA(360,IBIENS,1.04)=OTPTBIL ;1st Party Co-pay - outpt
 . S FDA(360,IBIENS,2.03)="FR"  ;Set facility revenue worklist queue
 . S (IENROOT,IENROOT(1))="" ;       adding new entry)
 . D UPDATE^DIE("","FDA","IENROOT")
 . I IENROOT(1)'="" S IBREC=IENROOT(1)
 . ; D STUB K FDA
 . ; S FDA(360,IBREC_",",1.01)=IBCLAIM
 . ; D UPDATE^DIE("","FDA")
 I IBREC,'FRSTPRT D
 . Q:$P($G(^IBFB(360,IBREC,3)),U,2)=3
 . K FDA
 . S IBFLAG=1  ; flag used for log file
 . S FDA(360,IBREC_",",3.02)=3
 . D UPDATE^DIE("","FDA")
 ; 
 I FRSTPRT D
 . Q:$P($G(^IBFB(360,IBREC,3)),U,2)=1
 . K FDA
 . S IENROOT="",IBFLAG=1  ; flag used for log file
 . S FDA(360,IBREC_",",3.02)=1
 . D UPDATE^DIE("","FDA","IENROOT")
 ;
 I IBBILL!(OTPTBIL) D  ;                 set pointer for Inpt or outpt 1st party copay
 . I IBBILL Q:$P(^IB(IBBILL,0),U,23)=IBREC  ;     exists and valid
 . I OTPTBIL Q:$P(^IB(OTPTBIL,0),U,23)=IBREC
 . K FDA
 . S IBFLAG=1  ; flag used for log file
 . ;S FDA(350,IBBILL_",",.23)=IBREC  ;    set Non-Va Care value to the pointer to file 360
 . D UPDATE^DIE("","FDA")
 ;
LOG ;                    set log (audit) file entries
 N FDA,IBEVENT,IBMOD,IBDUZ
 Q:'IBFLAG  ;No changes were made
 D NOW^%DTC S IBFBDT=%
 S IBMOD=0,IBDUZ=$G(DUZ) I $G(IBDUZ)="" S IBDUZ=".5"  ; Set user to postmaster (if ran via taskman)
 S FDA(360.04,"+1,"_IBREC_",",.01)=IBFBDT,FDA(360.04,"+1,"_IBREC_",",.03)=$G(IBDUZ)
 S IBMOD=0,IBLOG=$P($G(^IBFB(360,IBREC,4,0)),U,3)+1
 I IBLOG="" S IBMOD=1
 S IBEVENT=$S(IBMOD=0:"Auth log-FR queue",1:"Auth mod-FR queue"),FDA(360.04,"+1,"_IBREC_",",.02)=IBEVENT
 D UPDATE^DIE("","FDA")
 Q
 ;
STUB ;     look for third party claim pointer in file #356
 Q  ;REMOVE SUBROUTINE
 K IENROOT
 I IBCLAIM,$$GET1^DIQ(360,IBREC_",",1.03,"I")'=IBINV S IBCLAIM=0  ;1 invoice per claim
 I IBCLAIM,$D(^IBFB(360,"AD",IBCLAIM)),$O(^IBFB(360,"AD",IBCLAIM,0))'=IBREC S IBCLAIM=0  ;Claim already exists for another record
 I 'IBCLAIM!($$GET1^DIQ(356,IBCLAIM_",",.33,"I")="") D  Q   ;        invalid pointer to file #356 or it's not present (add if needed)
 . K FDC,ZIENS,ZIEN
 . I 'IBCLAIM S ZIENS="+1,",ZIEN=$P(^IBT(356,0),U,3)+1,IENROOT="" D
 .. S FDC(356,ZIENS,.01)=IBSITE_ZIEN,FDC(356,ZIENS,.02)=DFN  ;IEN and Patient
 .. S FDC(356,ZIENS,.06)=IBDOS,FDC(356,ZIENS,.2)=1  ;Date of service and Active
 . ;Edit an existing claim with no pointer
 . I IBCLAIM S ZIENS=IBCLAIM_","
 . S FDC(356,ZIENS,.33)=IBREC  ;Link back to file #360 (IB-FB INTERFACE TRACKING FILE)
 . I IBCARETY D
 .. I IBCARETY=2 S FDC(356,ZIENS,.18)=6 Q                ;Outpatient
 .. I IBCARETY=3 S FDC(356,ZIENS,.18)=8 Q                ;Pharmacy
 .. I IBCARETY=6!(IBCARETY=7) S FDC(356,ZIENS,.18)=7 Q   ;Inpatient
 . I IBCLAIM  D UPDATE^DIE("","FDC")  ;edit
 . I 'IBCLAIM D
 .. D UPDATE^DIE("","FDC","IENROOT")
 .. I IENROOT(1)'="" S IBCLAIM=IENROOT(1)  ;New
 Q
 ;
SETOTPT ;  Look for first party claim pointer in file #360 to an exist Bill IEN
 N FDA
 ;
 Q:'$D(^IB(IBBILL,0))  ;               invalid pointer to file #350 or it's not present
 ;Q:$P(^IB(IBBILL,0),U,23)=IBREC  ;     pointer is present and valid
 ;S FDA(350,IBBILL_",",.23)=IBREC  ;    set Non-Va Care value to the pointer to file 360
 D UPDATE^DIE("","FDA")
 Q
 ;
CHKOTPT ;                              check for Outpatient 1st party bills
 K ^TMP("IBRBF",$J)  ;                 kill of temp global before call
 S (FRSTPRT,OTPTBIL)=0
 D FPOPV^IBEFURF(DFN,IBDOS) Q:'$D(^TMP("IBRBF",$J))
 S OTPTBIL=$O(^TMP("IBRBF",$J,"FP",0)),FRSTPRT=1  ;set outpt 1st party copay IEN and first party flag
 K ^TMP("IBRBF",$J)
 ;
 ;END OF IBFBNP1
