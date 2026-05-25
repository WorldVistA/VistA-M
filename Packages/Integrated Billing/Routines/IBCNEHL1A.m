IBCNEHL1A ;AITC/DJW - HL7 Process Incoming RPI Messages (Cont.) ; 10-JAN-2025
 ;;2.0;INTEGRATED BILLING;**806**;21-MAR-94;Build 19
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q  ; No direct calls allowed
 ;
AUTOUPD(RIEN) ;
 ;DTG - Rewrote tag to split logic between Medicare policies and commercial policies
 ;
 ;Returns "1^file 2 ien^file 2.312 ien^2nd file 2.312 ien^Medicare flag^subscriber flag", if entry
 ; in file 365 is eligible for auto-update, returns 0 otherwise.
 ;
 ;Medicare flag: 1 for Medicare, 0 otherwise
 ;Subscriber flag: 1 if patient is the subscriber, 0 otherwise
 ;
 ;For non-Medicare response: 1st file 2.312 ien is set, 2nd file 2.312 ien is empty, pieces 5-7 are empty
 ;For Medicare response: 1st file 2.312 ien contains ien for Medicare Part A, 2nd file 2.312 ien contains ien for Medicare Part B,
 ;                       either one may be empty, but at least one of them is set if entry is eligible.
 ;
 ;RIEN - ien in file 365
 ;
 N APPIEN,GDATA,GIEN,GNAME,GNUM,GNUM1,GOK,IEN2,IEN312,IEN36,IDATA0,IDATA3,ISSUB,MWNRA,MWNRB,MWNRIEN,MWNRTYP
 N ONEPOL,PIEN,RDATA0,RDATA1,RES,TQIEN,IDATA7,RDATA13,RDATA14,ISBLUE
 N IBGETTQ,IBGETWE,IBGETSTC,IBGETDEF,IBGETNOK
 S RES=0
 I +$G(RIEN)'>0 Q RES          ;Invalid ien for file 365
 ; - if entry is missing from #200, file in buffer
 I '$$FIND1^DIC(200,,"M",IBEIVUSR) Q RES  ;use variable for name
 ;
 ; - Moved up the next 5 lines.
 S RDATA0=$G(^IBCN(365,RIEN,0)),RDATA1=$G(^IBCN(365,RIEN,1))
 ;
 ;Longer fields for GROUP NAME, GROUP NUMBER, NAME OF INSURED, & SUBSCRIBER ID
 S RDATA13=$G(^IBCN(365,RIEN,13)),RDATA14=$G(^IBCN(365,RIEN,14))
 S PIEN=$P(RDATA0,U,3)
 S ISBLUE=$$GET1^DIQ(365.12,PIEN_",",.09,"I")
 ;
 ; - Moved up the next 2 lines.
 S MWNRIEN=$P($G(^IBE(350.9,1,51)),U,25),MWNRTYP=0,(MWNRA,MWNRB)=""
 I PIEN=MWNRIEN S MWNRTYP=$$ISMCR^IBCNEHLU(RIEN)
 ;
 I +MWNRTYP D CHKMCR Q RES  ; call CHKMCR for Medicare policies
 ;
 ;Only auto-update 'active policy' responses
 I $G(IIVSTAT)'=1 Q RES
 ; Changed app to EIV from IIV
 I +PIEN>0 S APPIEN=$$PYRAPP^IBCNEUT5("EIV",PIEN)
 I +$G(APPIEN)'>0 Q RES  ;couldn't find eIV application entry
 ;
 ; Don't allow any entry with HMS SOI to auto-update
 ; Don't allow any entry with Contract Services SOI to auto-update
 I $P(RDATA0,U,5)'="" I "^HMS^CONTRACT SERVICES^"[("^"_$$GET1^DIQ(365.1,$P(RDATA0,U,5)_",","SOURCE OF INFORMATION","E")_"^") Q RES  ; HAN IB*621
 ;
 ; Start, allow auto update for some "Request Electronic Insurance Inquiry" requests
 ;
 ;Check dictionary 365.1 MANUAL REQUEST DATE/TIME Flag, Quit if Set.
 ;I $P(RDATA0,U,5)'="",$P($G(^IBCN(365.1,$P(RDATA0,U,5),3)),U,1)'="" Q RES
 ;
 ; get values
 S (IBGETTQ,IBGETDEF,IBGETWE,IBGETSTC)=""
 ; Get 365.1 transmission queue number
 S IBGETTQ=$$GET1^DIQ(365,RIEN_",",.05,"I") I IBGETTQ="" Q RES
 ; Get 365.1 which extract
 S IBGETNOK=0
 S IBGETWE=$$GET1^DIQ(365.1,IBGETTQ_",",.1,"I") I IBGETWE=5 D  I IBGETNOK Q RES
 . ; Get 350.9 default service type code
 . S IBGETDEF=$$GET1^DIQ(350.9,1_",",60.01,"I") I IBGETDEF="" S IBGETNOK=1 Q
 . ; Get 365 requested service type code
 . S IBGETSTC=$$GET1^DIQ(365,RIEN_",",.15,"I") I IBGETSTC'=IBGETDEF S IBGETNOK=1 Q
 ;
 ; End, allow auto update for some "Request Electronic Insurance Inquiry" requests
 ;
 ; Changed to new field location
 I '$$GET1^DIQ(365.121,APPIEN_","_PIEN_",",4.01,"I") Q RES  ; auto-update is OFF
 S IEN2=$P(RDATA0,U,2) I +IEN2'>0 Q RES  ; couldn't find patient
 S ONEPOL=$$ONEPOL^IBCNEHLU(PIEN,IEN2)
 ;try to find a matching pat. insurance
 ; - Modify next two lines to check for ISBLUE
 ; - Remove the check for ISBLUE and RES
 ;S IEN36="" F  S IEN36=$O(^DIC(36,"AC",PIEN,IEN36)) Q:IEN36=""  D  I 'ISBLUE&(RES>0) Q
 ;.S IEN312="" F  S IEN312=$O(^DPT(IEN2,.312,"B",IEN36,IEN312)) Q:IEN312=""  D  I ('ISBLUE)&(RES>0&('+MWNRTYP)) Q
 S IEN36="" F  S IEN36=$O(^DIC(36,"AC",PIEN,IEN36)) Q:IEN36=""  D
 .S IEN312="" F  S IEN312=$O(^DPT(IEN2,.312,"B",IEN36,IEN312)) Q:IEN312=""  D
 ..S IDATA0=$G(^DPT(IEN2,.312,IEN312,0)),IDATA3=$G(^DPT(IEN2,.312,IEN312,3))
 ..S IDATA7=$G(^DPT(IEN2,.312,IEN312,7))
 .. ; $$EXPIRED was moved from IBCNEDE2 to IBCNEHL1
 ..I $$EXPIRED^IBCNEHL1($P(IDATA0,U,4)) Q  ;Insurance policy has expired
 ..S ISSUB=$$PATISSUB^IBCNEHLU(IDATA0)
 ..;Patient is the subscriber
 ..I ISSUB,'$$CHK1^IBCNEHL3 Q
 ..;Patient is the dependent
 ..; Sub call needs to know this is not Medicare
 ..;I 'ISSUB,'$$CHK2^IBCNEHL3(MWNRTYP) Q
 ..I 'ISSUB,'$$CHK2^IBCNEHL3(0) Q
 ..;check group #
 ..S GNUM=$P(RDATA14,U,2),GIEN=+$P(IDATA0,U,18),GOK=1  ;IB*497 - group # needs to be retrieved from new field
 ..; Remove check for non Medicare group # ;I '+MWNRTYP D  Q:'GOK
 ..D  Q:'GOK  ;Group # doesn't match
 ...I 'ONEPOL D
 ... .I GIEN'>0 S GOK=0 Q
 ... .S GNUM1=$P($G(^IBA(355.3,GIEN,2)),U,2)   ;IB*497 (vd)
 ... .I GNUM=""!(GNUM1="")!(GNUM'=GNUM1) S GOK=0
 ...I ONEPOL D
 ... .I GNUM'="",GIEN'="" S GNUM1=$P($G(^IBA(355.3,GIEN,2)),U,2) I GNUM1'="",GNUM'=GNUM1 S GOK=0  ;IB*497 (vd)
 ..; Process Blues and non-MWNR
 .. D   ;Not Medicare
 ... S P3=$P(RES,U,3),P3=P3_$S($L(P3):"~",1:"")_IEN312
 ... S RES=1_U_IEN2_U_P3_U_U_0_U_ISSUB ;Process Blues and non-MWNR 
 Q RES
 ;
 ; -----------------------------------------------
CHKMCR ; Medicare checks to determine if we can auto-load new policy
 ;       or auto-update existing policy
 ;
 ;Changed app to EIV from IIV
 I +PIEN>0 S APPIEN=$$PYRAPP^IBCNEUT5("EIV",PIEN)
 I +$G(APPIEN)'>0 Q  ;couldn't find eIV application entry
 ;
 S LOAD=$$LOAD^IBCNEHL5A(RIEN) I LOAD Q  ; LOADING the Medicare policy if allowed
 ;
 ;
 ; Only continue if we didn't load the active policy to patient's record as a new policy
 ;
 ;Don't allow any entry with HMS SOI to auto-update
 ;Don't allow any entry with Contract Services SOI to auto-update
 I $P(RDATA0,U,5)'="" I "^HMS^CONTRACT SERVICES^"[("^"_$$GET1^DIQ(365.1,$P(RDATA0,U,5)_",","SOURCE OF INFORMATION","E")_"^") Q RES
 ;
 ; allow auto update for some "Request Electronic Insurance Inquiry" requests
 ;
 ; get values
 S (IBGETTQ,IBGETDEF,IBGETWE,IBGETSTC)=""
 ; Get 365.1 transmission queue number
 S IBGETTQ=$$GET1^DIQ(365,RIEN_",",.05,"I") I IBGETTQ="" Q
 ; Get 365.1 which extract
 S IBGETNOK=0
 S IBGETWE=$$GET1^DIQ(365.1,IBGETTQ_",",.1,"I") I IBGETWE=5 D  I IBGETNOK Q
 . ; Get 350.9 default service type code
 . S IBGETDEF=$$GET1^DIQ(350.9,1_",",60.01,"I") I IBGETDEF="" S IBGETNOK=1 Q
 . ; Get 365 requested service type code
 . S IBGETSTC=$$GET1^DIQ(365,RIEN_",",.15,"I") I IBGETSTC'=IBGETDEF S IBGETNOK=1 Q
 ;
 I '$$GET1^DIQ(365.121,APPIEN_","_PIEN_",",4.01,"I") Q  ; auto-update is OFF
 ;
 S IEN2=$P(RDATA0,U,2) I +IEN2'>0 Q  ; couldn't find patient
 ;
 ;try to find a matching pat. insurance
 S IEN36="" F  S IEN36=$O(^DIC(36,"AC",PIEN,IEN36)) Q:IEN36=""  D
 .S IEN312="" F  S IEN312=$O(^DPT(IEN2,.312,"B",IEN36,IEN312)) Q:IEN312=""  D
 ..S IDATA0=$G(^DPT(IEN2,.312,IEN312,0)),IDATA3=$G(^DPT(IEN2,.312,IEN312,3))
 ..S IDATA7=$G(^DPT(IEN2,.312,IEN312,7))
 ..I $$EXPIRED^IBCNEHL1($P(IDATA0,U,4)) Q       ;Insurance policy has expired
 ..S ISSUB=$$PATISSUB^IBCNEHLU(IDATA0)
 ..;Patient is the subscriber
 ..I ISSUB,'$$CHK1^IBCNEHL3 Q
 ..;Patient is the dependent
 ..I 'ISSUB,'$$CHK2^IBCNEHL3(MWNRTYP) Q
 ..;check group #
 ..S GNUM=$P(RDATA14,U,2),GIEN=+$P(IDATA0,U,18),GOK=1
 ..D  Q:'GOK  ;Group # doesn't match
 ...I GIEN'>0 S GOK=0 Q
 ...S GDATA=$G(^IBA(355.3,GIEN,0))
 ...I $P(GDATA,U,14)="A" D
 ....I $P(MWNRTYP,U,5)="MA"!($P(MWNRTYP,U,5)="B") S MWNRA=IEN312 Q
 ....S GOK=0
 ...I $P(GDATA,U,14)="B" D
 ... .I $P(MWNRTYP,U,5)="MB"!($P(MWNRTYP,U,5)="B") S MWNRB=IEN312 Q
 ... .S GOK=0
 ..S RES=1_U_IEN2_U_MWNRA_U_MWNRB_U_1_U_ISSUB Q   ;Process MWNR
 Q
 ;
