IBCBB12 ;ALB/DEM - PROCEDURE AND LINE LEVEL PROVIDER EDITS ;17-OCT-2010
 ;;2.0;INTEGRATED BILLING;**432**;21-MAR-94;Build 192
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
LNPROV(IBIFN) ; DEM;432 - Edits for line level providers.
 ;
 ; Input:
 ;       IBIFN - Claim number IEN.
 ;
 ; Output:
 ;       OK - '1' Edits
 ;            '0' No Edits.
 ;       *Note: OK returned if called as function.
 ;              Can be called as routine as well.
 ;       IBER - Edit error string. Only updated if errors.
 ;
 ; Patch 432 EDITS:
 ;
 ; (1) Not all procedures have a Line Level Rendering Provider,
 ;     and no Claim Level Rendering Provider.
 ;     Error Message in Billing for Prof Rendering.
 ;     *Note: Only applies to Rendering Provider Type.
 ;
 ; (2) All procedures have a Line Level Rendering Provider,
 ;     and a Claim Level Rendering Provider who is different
 ;     from any of the Line Level Rendering Providers.
 ;     Error in Billing.
 ;     *Note: Apply to all provider types (Rendering, Referring, Supervising, Attending, Operating, and Other Operating).
 ;
 N OK
 S OK=0  ; Initialize OK=0 for FALSE.
 Q:'$G(IBIFN) OK  ; Need claim number IEN to continue.
 N IBPRVFUN,IBCLPRV,IBLNPRV,PRVFUN
 S:'$G(IBFT) IBFT=$$FT^IBCEF(IBIFN)  ; Form Type for claim.
 Q:(IBFT'=2)&(IBFT'=3) OK  ; Must be CMS-1500 (2) or UB-04 (3) Form Type.
 S:IBFT=2 PRVFUN(2)="RENDERING,REFERRING,SUPERVISING"  ; Allowable line provider functions for CMS-1500.
 S:IBFT=3 PRVFUN(3)="RENDERING,REFERRING,OPERATING,OTHER OPERATING"  ; Allowable line provider functions for UB-04.
 F PRVFUN("CNT")=1:1:$L(PRVFUN(IBFT),",") S IBPRVFUN=$P(PRVFUN(IBFT),",",PRVFUN("CNT")) D
 . I IBFT=2,IBPRVFUN="RENDERING",'$$LNPRV2(IBPRVFUN),'$D(^DGCR(399,IBIFN,"PRV","C",IBPRVFUN))  D  Q  ; Edit Check (1).
 . . S OK=1  ; OK=1 indicates we have at least one error.
 . . S IBER=IBER_"IB333;"
 . . Q
 . ;
 . Q:'$$LNPRV2(IBPRVFUN,.IBLNPRV)  ; Quit if not all the procedures have a line level provider of the same provider type.
 . Q:'$D(^DGCR(399,IBIFN,"PRV","C",IBPRVFUN))  ; No claim level provider for this provider type.
 . ;
 . Q:'$$CLPRV2(IBPRVFUN,.IBCLPRV)  ; Must have provider for provider type IBPRVFUN to continue (Edit (2)).
 . ;
 . S IBCLPRV=0 F  S IBCLPRV=$O(IBCLPRV(IBPRVFUN,IBCLPRV)) Q:'IBCLPRV  D  ; Edit Check (2).
 . . Q:$D(IBLNPRV(IBPRVFUN,IBCLPRV))  ; Check against line provider array IBLNPRV.
 . . S OK=1
 . . S IBER=IBER_"IB334;"
 . . Q
 . Q
 ;
 Q OK
 ;
LNPRV2(IBPRVFUN,IBLNPRV) ; Function - Edit Check (2) for line level provider.
 ; See Edit Check (2) at top of routine for details.
 ;
 ; Input:
 ;       IBPRVFUN - Provider Type (FUNCTION). Example: RENDERING.
 ;       IBLNPRV(Array) - Passed by reference. Intially undefined.
 ;
 ; Output:
 ;       OK - If Edit Check (2) line level provider condition has
 ;            been met, then OK will return '1' for TRUE, ELSE, '0'
 ;            for FALSE.
 ;            *See Edit Check (2) at top of routine for details.
 ;       IBLNPRV(Array) - If Edit Check (2) condition has been met,
 ;                        then IBLNPRV will contain the provider type,
 ;                        and provider variable pointer as array
 ;                        subscripts, and array element is SET to
 ;                        NULL. => IBLNPRV(IBPRVFUN,IBLNPROV)="".
 ;
 N OK,IBPROCP,IBLPIEN,IBLNPROV
 S IBPROCP=0 F  S IBPROCP=$O(^DGCR(399,IBIFN,"CP",IBPROCP)) Q:'IBPROCP  D  I $D(OK),'OK Q
 . Q:'($D(^DGCR(399,IBIFN,"CP",IBPROCP,0))#10)
 . I '$D(^DGCR(399,IBIFN,"CP",IBPROCP,"LNPRV","C",IBPRVFUN)) S OK=0 Q  ; No line provider function for this procedure.
 . S IBLPIEN=$O(^DGCR(399,IBIFN,"CP",IBPROCP,"LNPRV","C",IBPRVFUN,0))
 . I 'IBLPIEN S OK=0 Q  ; No line provider IEN for this line provider function.
 . I '($D(^DGCR(399,IBIFN,"CP",IBPROCP,"LNPRV",IBLPIEN,0))#10) S OK=0 Q  ; No zero node for line level provider.
 . S IBLNPROV=$P(^DGCR(399,IBIFN,"CP",IBPROCP,"LNPRV",IBLPIEN,0),"^",2)
 . I 'IBLNPROV S OK=0 Q  ; No line provider for this line provider function.
 . S IBLNPRV(IBPRVFUN,IBLNPROV)=""
 . Q
 ;
 Q:$D(OK) OK  ; OK will never equal '1' for TRUE at this point.
 I '$D(OK),'$D(IBLNPRV(IBPRVFUN)) S OK=0 Q OK  ; No line provider array for this line provider function.
 S OK=1  ; Edit Check (2) line provider condition has been met.
 Q OK
 ;
CLPRV2(IBPRVFUN,IBCLPRV) ; Function - Edit Check (2) for claim level provider.
 ; See Edit Check (2) at top of routine for details.
 ;
 ; Input:
 ;       IBPRVFUN - Provider Type (FUNCTION). Example: RENDERING.
 ;       IBCLPRV(Array) - Passed by reference. Intially undefined.
 ;
 ; Output:
 ;       OK - If Edit Check (2) claim level provider condition has
 ;            been met, then OK will return '1' for TRUE, ELSE, '0'
 ;            for FALSE.
 ;            *See Edit Check (2) at top of routine for details.
 ;       IBCLPRV(Array) - If Edit Check (2) condition has been met,
 ;                        then IBCLPRV will contain the provider type,
 ;                        and provider variable pointer as array
 ;                        subscripts, and array element is SET to
 ;                        NULL. => IBCLPRV(IBPRVFUN,IBCLPROV)="".
 ;
 N IBCLPIEN,IBCLPROV,OK
 S OK=0  ; Initialize OK=0 for FALSE.
 S IBCLPIEN=0 F  S IBCLPIEN=$O(^DGCR(399,IBIFN,"PRV","C",IBPRVFUN,IBCLPIEN)) Q:'IBCLPIEN  D  Q:OK
 . Q:'($D(^DGCR(399,IBIFN,"PRV",IBCLPIEN,0))#10)
 . S IBCLPROV=$P(^DGCR(399,IBIFN,"PRV",IBCLPIEN,0),"^",2)
 . Q:'IBCLPROV
 . S IBCLPRV(IBPRVFUN,IBCLPROV)=""  ; Set array for Edit Check (2) to compare claim level provider with line level provider.
 . S OK=1  ; At this point we have our claim level provider of provider type IBPRVFUN. Set OK=1 for TRUE.
 . Q
 ;
 Q:'OK OK
 S OK=1
 Q OK
 ;
OPPROVCK(IBIFN) ; DEM;432 - Other Operating Provider edit checks.
 ;
 ; Input:
 ;       IBIFN - Claim number IEN.
 ;
 ; Output:
 ;       OK - '1' Edits
 ;            '0' No Edits.
 ;       *Note: OK returned if called as function ($$).
 ;              Can be called as routine as well.
 ;
 ; Patch 432 line level Other Operating Provider Edit checks:
 ;
 ; (1) If claim level Other Operating Provider, then
 ;     (1.1) claim must have claim level Operating Provider.
 ;           OR
 ;     (1.2) every line must have Operating Provider.
 ;
 ;  If (1) Passes, then do edit check (2) below.
 ;
 ;  (2) If any claim line has Other Operating Provider, then
 ;      (2.1) must have Operating Provider on same claim line,
 ;            OR
 ;      (2.2) must have claim level Operating Provider.
 ;
 N OK
 S OK=0  ; Initialize OK=0 for FALSE.
 Q:'$G(IBIFN) OK  ; Need claim number IEN to continue.
 S:'$G(IBFT) IBFT=$$FT^IBCEF(IBIFN)  ; Form Type for claim.
 Q:(IBFT'=2)&(IBFT'=3) OK  ; Must be CMS-1500 (2) or UB-04 (3) Form Type.
 ;
 N IBPRVFUN,IBLNFLAG,IBLNPRV,CLOK,LNOK
 ;
 ; Note: Claim level provider - OTHER and OTHER OPERATING are the same.
 ; Check if condition (1) has been met.
 F IBPRVFUN="OTHER","OTHER OPERATING" S CLOK=$$CLOPPRV1(IBPRVFUN) Q:CLOK
 Q:'CLOK OK  ; No claim level OTHER OPERATING PROVIDER, then QUIT, no further checks.
 S OK=0  ; Initialize OK=0 for FALSE. 
 ; Condition (1) has been met, check condtion (1.1).
 S CLOK=0  ; Initialize CLOK=0 for FALSE.
 I $D(^DGCR(399,IBIFN,"PRV","C","OPERATING")) S IBPRVFUN="OPERATING",CLOK=$$CLOPPRV1(IBPRVFUN)  ; Check condition (1.1).
 ; If CLOK at this point, then skip condition check (1.2) and continue to condition (2).
 S LNOK=0  ; Initialize LNOK=0 for FALSE.
 I 'CLOK S IBPRVFUN="OPERATING",LNOK=$$LNOPPRV1(IBPRVFUN) I 'LNOK S OK=1 Q OK  ; Check condition (1.2). If 'LNOK, then we have an error and QUIT.
 ; If LNOK, then continue to condition check (2).
 S LNOK=0  ; Initialize LNOK=0 for FALSE.
 K IBLNPRV  ; KILL IBLNPRV array before call to $$LNOPPRV1(IBPRVFUN,1,.IBLNPRV).
 S IBPRVFUN="OTHER OPERATING",LNOK=$$LNOPPRV1(IBPRVFUN,1,.IBLNPRV)  ; Condition check (2) start.
 I '$D(IBLNPRV("PRVFUN")) S OK=0 Q OK  ; If no data in IBLNPRV("PRVFUN") array, then skip rest of checks, no error.
 ; If data in IBLNPRV("PRVFUN") array, then check condition (2.1).
 S IBPRVFUN="OPERATING",LNOK=$$LNOPPRV1(IBPRVFUN,1,.IBLNPRV)  ; Condition check (2.1) start.
 S LNOK=0  ; Initialize LNOK=0 for FALSE.
 D:$D(IBLNPRV("PRVFUN"))  ; If data in IBLNPRV("PRVFUN") array, then continue condition check (2.1).
 . N IBPROCP
 . S IBPROCP=0 F  S IBPROCP=$O(IBLNPRV("PROC",IBPROCP)) Q:'IBPROCP  D  Q:'LNOK
 . . I $D(IBLNPRV("PROC",IBPROCP,"OTHER OPERATING")),'$D(IBLNPRV("PROC",IBPROCP,"OPERATING")) S LNOK=0 Q
 . . S LNOK=1  ; At this point, we have at least one match. If there wasn't a match, then LNOK=0 and we would have QUIT.
 . . Q
 . Q
 I LNOK S OK=0 Q OK  ; Conditions (2) and (2.1) are met (no error). SET OK=0 and QUIT.
 ; If 'LNOK, then continue to condition check (2.2).
 S CLOK=0  ; Initialize CLOK=0 for FALSE.
 S IBPRVFUN="OPERATING",CLOK=$$CLOPPRV1(IBPRVFUN)  ; Condition check (2.2).
 I CLOK S OK=0 Q OK  ; Conditions (2) and (2.2) are met (no error). SET OK=0 and QUIT.
 ; At this point, we have an error. SET OK=1, and QUIT.
 S OK=1
 Q OK
 ;
CLOPPRV1(IBPRVFUN) ; Claim level provider/provider function check.
 ;
 ; Check if there is a claim level provider with provider function IBPRVFUN.
 ;
 ; Input:
 ;       IBPRVFUN - PROVIDER FUNCTION.
 ;
 ; Output:
 ;       OK - '1' Claim level provider exist for provider function IBPRVFUN.
 ;            '0' No Claim level provider exist for provider function IBPRVFUN.
 ;
 N OK,IBCLPIEN,IBCLPROV
 S OK=0  ; Initialize OK=0 for FALSE.
 ;
 I $D(^DGCR(399,IBIFN,"PRV","C",IBPRVFUN)) D
 . S IBCLPIEN=0 F  S IBCLPIEN=$O(^DGCR(399,IBIFN,"PRV","C",IBPRVFUN,IBCLPIEN)) Q:'IBCLPIEN  D  Q:OK
 . . Q:'($D(^DGCR(399,IBIFN,"PRV",IBCLPIEN,0))#10)
 . . S IBCLPROV=$P(^DGCR(399,IBIFN,"PRV",IBCLPIEN,0),U,2)
 . . Q:'IBCLPROV
 . . S OK=1  ; At this point we have claim level provider with provider function IBPRVFUN and can QUIT function/subroutine.
 . . Q
 . Q
 ;
 Q OK
 ;
LNOPPRV1(IBPRVFUN,IBLNFLAG,IBLNPRV,IBPROCHK) ; Check every claim line for provider function IBPRVFUN.
 ;
 ;
 ; Input:
 ;       IBPRVFUN - PROVIDER FUNCTION.
 ;       IBLNFLAG(Optional) = 1 or 0. 1 indicates return IBLNPRV array passed by reference, otherwise '0' for NO.
 ;       IBLNPRV(Optional) - Array passed by reference => IF SET OK=1, then
 ;                           I $G(IBLNFLAG) S IBLNPRV("PROC",IBPROCP,IBPRVFUN)="",IBLNPRV("PRVFUN",IBPRVFUN,IBPROCP)=""
 ;       IBPROCHK - Condition on PROCEDURE (ICD, CPT, or HCFA procedure codes).
 ;
 ; Output:
 ;       OK - '1' Every line level provider exist for provider function IBPRVFUN.
 ;            '0' Not every line level provider exist for provider function IBPRVFUN.
 ;
 N OK
 S OK=0  ; Initialize OK=0 for FALSE.
 ;
 N IBLPIEN,IBLNPROV,IBPROCP
 S IBPROCP=0 F  S IBPROCP=$O(^DGCR(399,IBIFN,"CP",IBPROCP)) Q:'IBPROCP  D  Q:($D(^DGCR(399,IBIFN,"CP",IBPROCP,0))#10)&('OK)
 . Q:'($D(^DGCR(399,IBIFN,"CP",IBPROCP,0))#10)  ; No procedure '0' node.
 . I $G(IBPROCHK)'="" Q:$P(^DGCR(399,IBIFN,"CP",IBPROCP,0),U,1)'[IBPROCHK
 . I '$D(^DGCR(399,IBIFN,"CP",IBPROCP,"LNPRV","C",IBPRVFUN)) S OK=0 Q  ; No line provider function IBPRVFUN for this procedure.
 . S IBLPIEN=$O(^DGCR(399,IBIFN,"CP",IBPROCP,"LNPRV","C",IBPRVFUN,0))
 . I 'IBLPIEN S OK=0 Q  ; No line provider IEN for this line provider function.
 . I '($D(^DGCR(399,IBIFN,"CP",IBPROCP,"LNPRV",IBLPIEN,0))#10) S OK=0 Q  ; No '0' node for line level provider.
 . S IBLNPROV=$P(^DGCR(399,IBIFN,"CP",IBPROCP,"LNPRV",IBLPIEN,0),U,2)
 . I 'IBLNPROV S OK=0 Q  ; No line provider for this line provider function.
 . ; At this point we have line level provider of type IBPRVFUN.
 . ; S OK=1 for this claim line. OK can be changed back to '0', for FALSE, if claim line fails condition.
 . ; We would not get to this point if any line level provider with provider function IBPRVFUN didn't exist.
 . S OK=1
 . I $G(IBLNFLAG) S IBLNPRV("PROC",IBPROCP,IBPRVFUN)="",IBLNPRV("PRVFUN",IBPRVFUN,IBPROCP)=""
 . Q
 ;
 Q OK
 ;
UBPRVCK(IBIFN) ; DEM;432 - Check if claim requires operating provider.
 ;
 ; Description: This function checks if claim requires an operating provider.
 ;
 ;              Checks:
 ;
 ;              (1) If claim has a claim level operating provider,
 ;                  then no further checks (OK=1=TRUE).
 ;              (2) If claim doesn't have a claim level operating provider,
 ;                  then check:
 ;                  (2.1) Is this a UB-04 claim? NO = QUIT (OK=1), YES = Continue to next check.
 ;                  (2.2) Check every claim line that includes HCPCS procs - operating provider.
 ;                        If every claim line that includes HCPCS procs has an operating provider,
 ;                        then we are OK and QUIT (OK=1).
 ;                        If any claim line that includes HCPCS procs doesn't have an operating
 ;                        provider, then we have an ERROR (OK=0). 
 ;
 ; Input:
 ;       IBIFN = Claim number IEN.
 ;
 ; Output:
 ;        OK = 0 = claim doesn't have an operating provider
 ;                 when operating provider or rendering provider required.
 ;        OK = 1 = claim has an operating provider, or,
 ;                 claim doesn't require operating provider.
 ;
 N OK
 ; If claim doesn't have any procedure codes, then no checks required.
 I '$O(^DGCR(399,IBIFN,"CP",0)) S OK=1 Q OK
 ;
 S OK=$$CLOPPRV1("OPERATING")  ; Do we have a claim level OPERATING PROVIDER (OK=1=TRUE)?
 Q:OK OK  ; QUIT, we have a claim level OPERATING PROVIDER (OK=1=TRUE).
 ;
 N IBFT
 S IBFT=($$FT^IBCEF(IBIFN)=3)  ; UB-04 claim (1 = TRUE, 0 = FALSE)?
 S OK=1  ; Initialize OK=1.
 Q:'IBFT OK  ; QUIT OK=1, not a UB-04 claim.
 ;
 ; Claim level check did not pass, check claim lines.
 ; No claim level OPERATING PROVIDER, so check every PROCEDURE for OPERATING PROVIDER.
 S OK=$$UBPRVCK1("") ; Does every procedure have an OPERATING PROVIDER(1=TRUE,0=FALSE)?
 ;
 Q OK
 ;
UBPRVCK1(IBPROCHK,IBONE) ; DEM;432 - Continuation of UBPRVCK function.
 ;
 ; Input:
 ;       IBPROCHK(Optional) - Optional condition on PROCEDURE CODE (ICD, CPT, or HCFA procedure codes).
 ;       IBONE(Optional) - Quit if at least one line has an OPERATING
 ;
 ; Output:
 ;       OK - '1' Every procedure code that contains IBPROCHK (optional check) has an OPERATING PROVIDER.
 ;            or if IBONE, then at least one procedure code that contains IBPROCHK (optional check) has an OPERATING PROVIDER.
 ;            '0' Not every procedure code that contains IBPROCHK (optional check) has an OPERATING PROVIDER.
 ;            or if IBONE, then NO procedure codes that contain IBPROCHK (optional check) has an OPERATING PROVIDER.
 ;
 N OK
 S OK=0  ; Initialize OK=0 for FALSE.
 ;
 N IBLPIEN,IBLNPROV,IBPROCP
 S IBPROCP=0 F  S IBPROCP=$O(^DGCR(399,IBIFN,"CP",IBPROCP)) Q:'IBPROCP  D  Q:($D(^DGCR(399,IBIFN,"CP",IBPROCP,0))#10)&('OK)&('$G(IBONE))  I $G(IBONE),$G(OK) Q
 . Q:'($D(^DGCR(399,IBIFN,"CP",IBPROCP,0))#10)  ; No procedure '0' node.
 . I $G(IBPROCHK)'="" Q:$P(^DGCR(399,IBIFN,"CP",IBPROCP,0),U,1)'[IBPROCHK
 . I '$D(^DGCR(399,IBIFN,"CP",IBPROCP,"LNPRV","C","OPERATING")) S OK=0 Q  ; No line OPERATING PROVIDER for this procedure.
 . S IBLPIEN=$O(^DGCR(399,IBIFN,"CP",IBPROCP,"LNPRV","C","OPERATING",0))
 . I 'IBLPIEN S OK=0 Q  ; No line provider IEN for this line provider function.
 . I '($D(^DGCR(399,IBIFN,"CP",IBPROCP,"LNPRV",IBLPIEN,0))#10) S OK=0 Q  ; No '0' node for line level provider.
 . S IBLNPROV=$P(^DGCR(399,IBIFN,"CP",IBPROCP,"LNPRV",IBLPIEN,0),U,2)
 . I 'IBLNPROV S OK=0 Q  ; No line provider for this line provider function.
 . ; At this point we have line level provider of type OPERATING.
 . ; S OK=1 for this claim line. OK can be changed back to '0', for FALSE, if claim line fails condition.
 . ; We would not get to this point if any line level provider with provider function OPERATING didn't exist.
 . S OK=1
 . Q
 ;
 Q OK
