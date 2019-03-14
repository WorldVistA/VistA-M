IBCNEDE6 ;DAOU/DAC - eIV DATA EXTRACTS ;15-OCT-2002
 ;;2.0;INTEGRATED BILLING;**184,271,345,416,497,506,621**;21-MAR-94;Build 14
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q    ; no direct calls allowed
 ;
 ; IB*2*416 removed the ability to perform Identification inquiries.
 ; However, this code is being left as is for future changes.
 ;
 ; IB*2*621 removed old code associated with a previous extract that 
 ; is now replaced with EICD extract logic
 ;
UPDDTS(PIEN,SVDT,FRDT) ;  Update service date and freshness date per payer
 ; date parameters FUTURE SERVICE DAYS (365.121,.14) and PAST SERVICE
 ; DAYS (365.121,.15)
 ; Output:
 ;  SVDT - passed by reference - updates service date
 ;  FRDT - passed by reference - updates freshness date - except for 
 ;         INAC where it is optional
 N FDAYS,PDAYS,DIFF,AIEN,DATA,OSVDT,EDTFLG
 ;
 ; Init vars - save original service date to calc diff
 S (FDAYS,PDAYS,EDTFLG)=0,OSVDT=SVDT
 ; Determine Payer App IEN
 S AIEN=$$PYRAPP^IBCNEUT5("IIV",PIEN)
 I AIEN="" Q  ; Quit without changing if app is not defined
 S DATA=$G(^IBE(365.12,PIEN,1,AIEN,0))
 I DATA="" Q  ; Quit without changing if node is not defined
 S FDAYS=$P(DATA,U,14),PDAYS=$P(DATA,U,15)
 ; Process past service days if not null
 I PDAYS'="" D
 . ; If zero and Service Date is less than today, reset to today
 . I PDAYS=0&(SVDT<DT) S SVDT=$$DT^XLFDT,EDTFLG=1
 . ; If non-zero and service date is earlier than the allowed
 . ;  payer service date range, reset service date to earliest allowed
 . ;  date for the payer
 . I PDAYS,(SVDT<$$FMADD^XLFDT($$DT^XLFDT,-PDAYS)) D
 . . S SVDT=$$FMADD^XLFDT($$DT^XLFDT,-PDAYS),EDTFLG=1
 ; Process future service days if not edited and if not null
 I EDTFLG=0,FDAYS'="" D
 . ; If zero and Service Date is greater than today, reset to today
 . I FDAYS=0&(SVDT>DT) S SVDT=$$DT^XLFDT,EDTFLG=1
 . ; If non-zero and service date is later than the allowed
 . ;  payer service date range, reset service date to latest allowed
 . ;  date for the payer
 . I FDAYS,(SVDT>$$FMADD^XLFDT($$DT^XLFDT,FDAYS)) D
 . . S SVDT=$$FMADD^XLFDT($$DT^XLFDT,FDAYS),EDTFLG=1
 ;
 ; Determine if difference exists
 I EDTFLG,$G(FRDT)'="" S FRDT=$$FMADD^XLFDT(FRDT,$$FMDIFF^XLFDT(SVDT,OSVDT))
 ;
 Q
 ;
TFL(DFN) ; Examines treating facility list,
 ; value returned is 1 if patient has visited at least one other site
 N IBC,IBZ,IBS
 D TFL^VAFCTFU1(.IBZ,DFN) Q:-$G(IBZ(1))=1 0
 S IBS=+$P($$SITE^VASITE,"^",3),(IBZ,IBC)=0
 ; Look for remote facilities of type VAMC:
 F  S IBZ=$O(IBZ(IBZ)) Q:IBZ<1  I +IBZ(IBZ)>0,+IBZ(IBZ)'=IBS,$P(IBZ(IBZ),U,5)="VAMC" S IBC=1 Q
 Q IBC
