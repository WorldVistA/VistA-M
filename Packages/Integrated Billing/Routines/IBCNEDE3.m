IBCNEDE3 ;AITC/CKB - eIV Appointment Extract ; 23-OCT-2023
 ;;2.0;INTEGRATED BILLING;**778,827**;21-MAR-94;Build 24
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;
 ; Reference to ^XLFDT  in ICR #10103
 ; Reference to ^XLFSTR  in ICR #10104
 ;
 ;IB*778/CKB - this routine is called by IBCNEDE2 which is used for the Appointment Extract
 ;
 Q  ; can't be called directly
 ;
STRIP(VALUE) ; check non-alpha numeric characters
 ;INPUT:
 ; VALUE  = the string/field to check
 ;
 ;RETURN:
 ; STRNG  = NO non-alpha numeric chars were found, STRNG equal VALUE
 ;        = if non-alpha numeric chars were found, STRNG will be returned without non-alpha numeric chars in VALUE
 ;
 ;  ASCII codes:  48-57: 0-9 / 65-90: A-Z / 97-122: a-z
 ;
 N IBI,IBY,LEN,STRNG,XX
 I $G(VALUE)="" S STRNG=VALUE G STRIPX
 S LEN=$L(VALUE)
 S (IBY,STRNG)=""
 F IBI=1:1:LEN S IBY=$E(VALUE,IBI) Q:IBY=""  D
 . ;Remove all non-alpha numeric characters
 . I ($A(IBY)<48) Q
 . I ($A(IBY)>57&($A(IBY)<65))!($A(IBY)>90&($A(IBY)<97))!($A(IBY)>122) Q
 . S STRNG=STRNG_IBY
STRIPX ; 
 Q STRNG
 ;
UPDSD(PIEN,AIEN,SVDT) ;Update service date based on Payers allowed date range -  Appointment Extract
 ;from UPDDTS^IBCNEDE6, except past service dates and freshness days are no longer updated
 ;Input:
 ;  PIEN - Payer IEN
 ;  AIEN - Payer App IEN 
 ;Output:
 ;  SVDT - passed by reference, updated service date
 ;
 N DATA,FDAYS
 ;
 I ($G(PIEN)="")!($G(AIEN)="") Q
 ;
 S FDAYS=0
 S DATA=$G(^IBE(365.12,PIEN,1,AIEN,0))
 ; Quit without changing if node is not defined
 I DATA="" Q
 ; FUTURE SERVICE DAYS 
 S FDAYS=$$GET1^DIQ(365.121,AIEN_","_PIEN_",",4.03)
 ; Process future service days if not edited and if not null
 I FDAYS'="" D
 . ; If zero and Service Date is greater than today, reset to TODAY
 . I FDAYS=0&(SVDT>DT) S SVDT=$$DT^XLFDT
 . ; If non-zero and Service Date is later than the allowed
 . ;  Payer Service Date range, reset the Service Date to latest
 . ;  allowable date for the Payer
 . I FDAYS,(SVDT>$$FMADD^XLFDT($$DT^XLFDT,FDAYS)) D
 .. S SVDT=$$FMADD^XLFDT($$DT^XLFDT,FDAYS)
 Q
 ;
ALL(DFN,VAR) ;Find all insurance data on a patient for the Appointment Extract
 ;Logic from ALL^IBCNS1
 ; Input:
 ;       DFN  = patient
 ;       VAR  = variable used to store output array
 ;
 ; Output:
 ;        var(0)   = number of entries insurance multiple
 ;        var(x,0) = ^DPT(DFN,.312,x,0)
 ;        var(x,1) = ^DPT(DFN,.312,x,1)
 ;        var(x,2) = ^DPT(DFN,.312,x,2)
 ;        var(x,3) = ^DPT(DFN,.312,x,3)
 ;        var(x,4) = ^DPT(DFN,.312,x,4)
 ;        var(x,5) = ^DPT(DFN,.312,x,5)
 ;        var(x,7) = ^DPT(DFN,.312,x,7)
 ;    var(x,355.3) = ^IBA(355.3,$p(var(x,0),"^",18),0)
 ;
 N ADT,IBSP,IBIENS,X
 S ADT=DT
 S X=0 F  S X=$O(^DPT(DFN,.312,X)) Q:'X  I $D(^(X,0)) D
 . I '$$CHK(^DPT(DFN,.312,X,0),DFN,X,ADT) Q
 . S @VAR@(0)=$G(@VAR@(0))+1
 . S @VAR@(X,0)=$$ZND^IBCNS1(DFN,X)
 . S @VAR@(X,1)=$G(^DPT(DFN,.312,X,1))
 . S @VAR@(X,2)=$G(^DPT(DFN,.312,X,2))
 . S @VAR@(X,3)=$G(^DPT(DFN,.312,X,3))
 . S @VAR@(X,4)=$G(^DPT(DFN,.312,X,4))
 . S @VAR@(X,5)=$G(^DPT(DFN,.312,X,5))
 . S @VAR@(X,7)=$G(^DPT(DFN,.312,X,7))
 . S IBIENS=+$P($G(^DPT(DFN,.312,X,0)),"^",18)
 . S @VAR@(X,355.3)=$G(^IBA(355.3,IBIENS,0))
 . S $P(@VAR@(X,355.3),U,3)=$$GET1^DIQ(355.3,IBIENS_",",2.01)
 . S $P(@VAR@(X,355.3),U,4)=$$GET1^DIQ(355.3,IBIENS_",",2.02)
INSCHKQ ;
 Q
 ;
CHK(X,PIEN,PINS,Z) ; Check patient policy - logic from CHK^IBCNS1
 ;Evaluate for inclusion in the Appointment Extract
 ;
 ; -- Input:
 ;      X = Zero node of entry in insurance multiple (#2.312)
 ;   PIEN = patient internal entry (#2)
 ;   PINS = insurance multiple internal entry (#2.312)
 ;      Z = Date to check
 ; -- Output:
 ; EVAL 1 = Evaluation for inclusion
 ;      0 = DO NOT Evaluate
 ;
 N GRP,EFFDT,EVAL,EXPDT,INSIEN
 ;Initialize variables
 S EVAL=0
 S EFFDT=$$GET1^DIQ(2.312,PINS_","_PIEN_",",8,"I")
 S EXPDT=$$GET1^DIQ(2.312,PINS_","_PIEN_",",3,"I")
 S GRP=$$GET1^DIQ(2.312,PINS_","_PIEN_",",.18,"I")
 ;
 ;Insurance Company entry doesn't exist
 S INSIEN=+X ;insurance company internal entry (#36)
 I $G(^DIC(36,INSIEN,0))="" G CHKQ
 ;Insurance Company Inactive
 I $$GET1^DIQ(36,INSIEN_",",.05,"I") G CHKQ
 ;Group Plan is Inactive
 I $$GET1^DIQ(355.3,GRP_",",.11,"I") G CHKQ
 ;
 ; - DO NOT Evaluate for inclusion
 ;Effective Date is in the future
 I EFFDT>Z S EVAL=0
 ;Expiration Date prior to today 
 I EXPDT<Z S EVAL=0
 ;Effective Date is in the future ;Expiration Date is in the future
 I EFFDT>Z I EXPDT>Z S EVAL=0
 ;
 ; - Evaluate for inclusion
 ;Effective Date is today or past ;Expiration Date is today or null or future 
 I EFFDT=Z!(EFFDT<Z) I ((EXPDT=Z)!(EXPDT>Z)!(EXPDT="")) S EVAL=1
 ;BAD Effective Date     ;BLANK Expiration Date
 I $$VALIDDT^IBCNINSU(EFFDT)<0 I EXPDT="" S EVAL=1
 ;BLANK Effective Date   ;BLANK Expiration Date
 I EFFDT="" I EXPDT="" S EVAL=1
 ;BLANK Effective Date   ;Expiration Date in the future
 I EFFDT="" I EXPDT>Z S EVAL=1
 ;BAD Effective Date     ;BAD Expiration Date
 I $$VALIDDT^IBCNINSU(EFFDT)<0 I $$VALIDDT^IBCNINSU(EXPDT)<0 S EVAL=1
 ;Effective Date is today or past ;BAD Expiration Date
 I EFFDT=Z!(EFFDT>Z) I $$VALIDDT^IBCNINSU(EXPDT)<0 S EVAL=1
CHKQ ;
 Q EVAL
 ;
TQUPDSV(DFN,PAYER,SRVDT,SUBID,GRPNUM) ; Update TQ service date for entries to be transmitted
 ; used by the Appointment Extract - logic from TQUPDSV^IBCNEUT5
 ;
 N CSPAN,CSRVDT,DA,SPAN,STS,SVDT,TQSUBID
 ;
 I ($G(DFN)="")!($G(PAYER)="")!($G(SRVDT)="") G TQUPDSVX
 ;
 ; Loop thru all entries in the TQ file (DO NOT CHANGE to DT-1 as SVDT)
 S SVDT=""
 F  S SVDT=$O(^IBCN(365.1,"AD",DFN,PAYER,SVDT)) Q:'SVDT  D
 . S DA=0
 . F  S DA=$O(^IBCN(365.1,"AD",DFN,PAYER,SVDT,DA)) Q:'DA!($G(TQFOUND))  D
 .. ;Find entries for the same patient/payer/subscriber ID/group number combo
 .. ; Compare SUBID against the HL7 SUBSCRIBER ID FIELD stored in the TQ file
 .. ;Strip/remove any non-alph char's from the Subscriber ID in the TQ file
 .. S TQSUBID=$$STRIP^IBCNEDE3($$GET1^DIQ(365.1,DA_",",.16))
 .. I SUBID'=TQSUBID Q
 .. ; Compare GRPNUM against the GROUP NUMBER stored in the TQ file
 .. I GRPNUM'=$$GET1^DIQ(365.1,DA_",",1.03) Q
 .. ;
 .. S STS=$P($G(^IBCN(365.1,DA,0)),U,4)  ; Get TQ Status
 .. ; If record is (1)Ready to Transmit or (6)Retry - update service date
 .. I (STS=1)!(STS=6) D  Q
 ... ; Initialize variables
 ... I STS=1 S FSCSEND=1   ; (1)Ready to Transmit, send to FSC now
 ... I STS=6 S FSCSEND=0   ; (6)Retry, DO NOT send to FSC now
 ... S TQFOUND=1           ; valid entry found in the TQ file
 ... S TQENT=DA            ; existing IEN in the TQ (need to send to FSC)
 ... ;    SRVDT - new service date (from the appointment)
 ... ;   CSRVDT - current service date for the existing TQ entry
 ... ;       DT - today
 ... S CSRVDT=$P($G(^IBCN(365.1,DA,0)),U,12)
 ... ; If current service date is TODAY, do not update
 ... I CSRVDT=DT Q
 ... ; If the new service date is TODAY, update the current service date (date in TQ entry) to TODAY
 ... I SRVDT=DT S CSRVDT=DT D SAVETQ^IBCNEUT2(DA,CSRVDT) Q
 ... ; If the current service day is in the past, update it to the new service date
 ... I CSRVDT<DT S CSRVDT=SRVDT D SAVETQ^IBCNEUT2(DA,CSRVDT) Q
 ... ; If both the current and new service dates are in the future, update the current
 ... ; service date to whichever date is closest to TODAY
 ... I (CSRVDT>DT)&(SRVDT>DT) D  Q
 .... S CSPAN=$$FMDIFF^XLFDT(CSRVDT,DT,1),SPAN=$$FMDIFF^XLFDT(SRVDT,DT,1)
 .... I CSPAN<SPAN D SAVETQ^IBCNEUT2(DA,CSRVDT) Q
 .... I SPAN<CSPAN D SAVETQ^IBCNEUT2(DA,SRVDT) Q
TQUPDSVX ;TQUPDSV exit
 Q
 ;
TQCHKS(DFN,PAYER,SRVDT,SUBID,GRPNUM,FRESHNESS) ; Looks at the TQ file for an existing entry
 ; checks to see if a new entry can be added to the TQ - used by the Appointment Extract
 ;
 N DA,STS,SVDT,TQSUBID
 ;
 I ($G(DFN)="")!($G(PAYER)="")!($G(SRVDT)="") G TQCHKSX
 ;
 ; Loop thru ALL entries in the TQ file
 S SVDT=""
 F  S SVDT=$O(^IBCN(365.1,"AD",DFN,PAYER,SVDT)) Q:'SVDT  D
 . S DA=0
 . F  S DA=$O(^IBCN(365.1,"AD",DFN,PAYER,SVDT,DA)) Q:'DA  D
 .. ;Find entries for the same patient/payer/subscriber ID/group number combo
 .. ; Compare SUBID against the HL7 SUBSCRIBER ID FIELD stored in the TQ file
 .. ;Strip/remove any non-alph char's from the Subscriber ID in the TQ file
 .. S TQSUBID=$$STRIP^IBCNEDE3($$GET1^DIQ(365.1,DA_",",.16))
 .. I SUBID'=TQSUBID Q
 .. ; Compare GRPNUM against the GROUP NUMBER stored in the TQ file
 .. I GRPNUM'=$$GET1^DIQ(365.1,DA_",",1.03) Q
 .. S STS=$P($G(^IBCN(365.1,DA,0)),U,4)  ; Get TQ Status
 .. ; If entry is (2)Transmitted or (3)Response Received - check freshness days
 .. I (STS=2)!(STS=3) D
 ... ;    ADDTQ = 0-do not add to TQ / 1-add to TQ file
 ... S ADDTQ=$$ADDTQ(DFN,PAYER,SUBID,GRPNUM,SRVICEDT,FRESHNESS) ; within freshness days
 ... Q
 ;
TQCHKSX ;TQCHKS exit
 Q
 ;
ADDTQ(DFN,PAYER,SUBID,GRPNUM,SRVDT,FDAYS) ; Function  - Returns flag (0/1)
 ; used by the Appointment Extract - logic from ADDTQ^IBCNEUT5
 ;   1 - TQ File entry can be added as the service date for the patient 
 ;       and payer >= MAX TQ service date + Freshness Days
 ;   0 - otherwise
 ;
 ; Input:
 ;  DFN    - Patient DFN (File #2)
 ;  PAYER  - Payer IEN (File #365.12)
 ;  SUBID  - Subscriber ID
 ;  GRPNUM - Group Number
 ;  SRVDT  - Service Date for potential TQ entry
 ;  FDAYS  - Freshness Days param (by extract type)
 ;
 N MAXDT
 S ADDTQ=1
 ;
 I ($G(DFN)="")!($G(SRVDT)="")!($G(FDAYS)="")!($G(PAYER)="") S ADDTQ=0 G ADDTQX
 ;
 ; MAX TQ Service Date
 S MAXDT=$$TQMAXSV(DFN,PAYER,SUBID,GRPNUM)
 I MAXDT="" G ADDTQX
 ; If Service Date < Max Service Date + Freshness Days, do not add
 I SRVDT'>$$FMADD^XLFDT(MAXDT,FDAYS) S ADDTQ=0
 ;
ADDTQX ; ADDTQ exit pt
 Q ADDTQ
 ;
TQMAXSV(DFN,PAYER,SUBID,GRPNUM) ; Returns MAX(TQ Service Date) for Patient & Payer
 ;used by the Appointment Extract - logic from TQMAXSV^IBCNEUT5
 ; Input: 
 ;  DFN     - Patient DFN (#2)
 ;  PAYER   - Payer IEN (#365.12)
 ;  SUBID   - Subscriber ID
 ;  GRPNUM  - Group Number
 ;
 ; Output:
 ;  TQMAXSV - MAX (most recent) service date from TQ entry for Patient & Payer
 ;
 N TQMAXSV
 S TQMAXSV=""
 I ($G(DFN)="")!'$G(PAYER) G TQMAXSVX
 ;
 N IBTQS,IENS,LASTBYP,STATLIST,TQIEN,TQSUBID
 ; This is the list of transmission statuses that are to be ignored:
 ;  4=Hold (IB*506 removed this status from occurring) / 5=Communication Failure / 7=Cancelled
 S STATLIST=",4,5,7,"
 ;
 S LASTBYP=""
 F  S LASTBYP=$O(^IBCN(365.1,"AD",DFN,PAYER,LASTBYP)) Q:LASTBYP=""  D
 . S TQIEN=""
 . F  S TQIEN=$O(^IBCN(365.1,"AD",DFN,PAYER,LASTBYP,TQIEN)) Q:TQIEN=""  D
 .. ;Find entries for the same patient/payer/subscriber ID/group number combo
 .. ; Compare SUBID against the HL7 SUBSCRIBER ID FIELD stored in the TQ file
 .. ;Strip/remove any non-alph char's from the Subscriber ID in the TQ file
 .. S TQSUBID=$$STRIP^IBCNEDE3($$GET1^DIQ(365.1,TQIEN_",",.16))
 .. I SUBID'=TQSUBID Q
 .. ; Compare GRPNUM against the GROUP NUMBER stored in the TQ file
 .. I GRPNUM'=$$GET1^DIQ(365.1,TQIEN_",",1.03) Q
 .. S IBTQS=+$$GET1^DIQ(365.1,TQIEN_",",.04,"I")    ; TQ STATUS
 .. I IBTQS,($F(STATLIST,","_IBTQS_",")) Q          ; If TQ STATUS is contained in STATLIST, quit
 .. I LASTBYP>TQMAXSV S TQMAXSV=LASTBYP
 ;
TQMAXSVX ;TQMAXSV exit
 Q TQMAXSV
 ;
TQEXIST(DFN,PIEN,SUBID,GRPNUM,FRESHNESS) ;IB*827/CKB - Looks at the TQ file for an existing entry
 ; This tag is being used by the eIV Appointment Extract
 ;
 ;INPUT:
 ; DFN - Patient DFN
 ; PIEN - Payer IEN
 ; SUBID - Subscriber ID
 ; GRPNUM - Group Number
 ; FRESHNESS - number of Freshness days (ie. 180 or 360 for Medicare)
 ;
 ;OUTPUT:
 ; 1 - if an entry exists in the TQ with the same DFN/PIEN/SUBID/GRPNUM within Freshness days
 ; 0 - if not found in the TQ
 ;
 N DA,EXIST,SVDT
 S EXIST=0
 ;
 I ($G(DFN)="")!($G(PIEN)="")!($G(FRESHNESS)="") G TQEXIT
 ;
 ; Loop thru ALL entries in the TQ file
 S SVDT=DT-FRESHNESS
 F  S SVDT=$O(^IBCN(365.1,"AD",DFN,PIEN,SVDT)) Q:'SVDT!(EXIST=1)  D
 . S DA=0 F  S DA=$O(^IBCN(365.1,"AD",DFN,PIEN,SVDT,DA)) Q:'DA!(EXIST=1)  D
 .. N STS,TQNAME,TQSUBID
 .. ; Strip/remove any non-alph char's from the Subscriber ID in the TQ file
 .. S TQSUBID=$$STRIP^IBCNEDE3($$GET1^DIQ(365.1,DA_",",.16))  ;HL7 SUBSCRIBER ID FIELD
 .. I SUBID'="",TQSUBID'=SUBID Q
 .. ; Compare GRPNUM against the GROUP NUMBER stored in the TQ file
 .. I GRPNUM'="",$$GET1^DIQ(365.1,DA_",",1.03)'=GRPNUM Q
 .. ; Get TQ Status - ignore if 7=Cancelled / 5=Communication Failure
 .. S STS=$$GET1^DIQ(365.1,DA_",",.04,"I") I (STS=7)!(STS=5) Q
 .. ; If Match is found, set EXIST=1
 .. S EXIST=1
 .. Q
 ;
TQEXIT ;TQEXIST exit
 Q EXIST
 ;
BFEXIST(DFN,INSNAME,SUBID,GRPNUM) ;Checks for the existence in the Buffer
 ;used by the Appointment Extract - logic from BFEXIST^IBCNEUT5
 ;INPUT:
 ;     DFN - Patient DFN
 ; INSNAME - Insurance Company Name File 36 - Field .01
 ;   SUBID - Subscriber ID
 ;  GRPNUM - Group Number
 ;
 ;OUTPUT:
 ; 1 - if an entry exists in the Buffer with the same DFN/INSNAME/SUBID/GRPNUM
 ; 0 - if not found in the Buffer
 ;
 ; This tag is being used by the Appointment Extract
 ;
 N BSUBID,BUFFNAME,EXIST,IEN
 S EXIST=0
 S INSNAME=$$UP^XLFSTR(INSNAME),INSNAME=$$TRIM^XLFSTR(INSNAME)
 I ('DFN)!(INSNAME="") G BFEXIT
 ;
 S IEN=0
 F  S IEN=$O(^IBA(355.33,"C",DFN,IEN)) Q:'IEN!EXIST  D
 .  ; Quit if status is NOT 'Entered'
 .  I $P($G(^IBA(355.33,IEN,0)),U,4)'="E" Q
 .  ; Quit if Ins Buffer Ins Co Name (trimmed) is NOT EQUAL to 
 .  ;  the Ins Co Name parameter (trimmed)
 .  S BUFFNAME=$$TRIM^XLFSTR($P($G(^IBA(355.33,IEN,20)),U))
 .  I $$UP^XLFSTR(BUFFNAME)'=INSNAME Q
 .  ; Does the SUBID and GRPNUM match what's stored in the Buffer
 .  ;Strip/remove any non-alph char's from the Subscriber ID in the Buffer
 .  S BSUBID=$$STRIP^IBCNEDE3($P($G(^IBA(355.33,IEN,90)),U,3))
 .  I SUBID'="",BSUBID'=SUBID Q
 .  I GRPNUM'="",($P($G(^IBA(355.33,IEN,90)),U,2))'=GRPNUM Q
 .  ; Match found
 .  S EXIST=1
 .  Q
BFEXIT ;BFEXIST exit
 Q EXIST
 ;
BFCHECK(DFN,INSNAME,SUBID,GRPNUM) ;IB*827/CKB - Checks for the existence in the Buffer
 ; if there is a Buffer entry perform additional checks
 ;INPUT:
 ;     DFN - Patient DFN
 ; INSNAME - Insurance Company Name File 36 - Field .01
 ;   SUBID - Subscriber ID
 ;  GRPNUM - Group Number
 ;
 ;OUTPUT:
 ; 1 - Save to the TQ
 ; 0 - do NOT save to the TQ
 ;
 N BSUBID,BUFFNAME,IEN,SAVE
 S SAVE=1
 S INSNAME=$$UP^XLFSTR(INSNAME),INSNAME=$$TRIM^XLFSTR(INSNAME)
 I ('DFN)!(INSNAME="") S SAVE=0 G BFCHECKX
 ; if pt is NOT in the buffer, SAVE to the TQ
 I '$D(^IBA(355.33,"C",DFN)) S SAVE=1 G BFCHECKX
 ;
 S IEN=0 F  S IEN=$O(^IBA(355.33,"C",DFN,IEN)) Q:'IEN!(SAVE=0)  D
 . N BSUBID,BUFFNAME,SYMBOL
 . ;If status is NOT 'Entered', Quit - SAVE to the TQ
 . I $P($G(^IBA(355.33,IEN,0)),U,4)'="E" S SAVE=1 Q
 . ;
 . ;Look for a matching Buffer entry (patient/insurance/subscriber id/group number)
 . ;  If Ins Buffer Ins Co Name (trimmed) is NOT EQUAL to the
 . ;   Ins Co Name passed in (trimmed), Quit - SAVE to the TQ
 . S BUFFNAME=$$TRIM^XLFSTR($P($G(^IBA(355.33,IEN,20)),U))
 . I $$UP^XLFSTR(BUFFNAME)'=INSNAME S SAVE=1 Q
 . ;  Compare the SUBID and GRPNUM match against the Subscriber ID (strip/
 . ;   remove any non-alph char's) and Group Number stored in the Buffer
 . ;   if the Buffer SUBID and GRPNUM are NOT EQUAL, Quit - SAVE to the TQ
 . S BSUBID=$$STRIP^IBCNEDE3($P($G(^IBA(355.33,IEN,90)),U,3))
 . I SUBID'="",BSUBID'=SUBID S SAVE=1 Q
 . I GRPNUM'="",($P($G(^IBA(355.33,IEN,90)),U,2))'=GRPNUM S SAVE=1 Q
 . ;
 . ;Matching Buffer entry found - Get and evaluate the Buffer Symbol
 . ;  Get the Buffer Symbol (355.33,.12 IIV STATUS - pointer to IIV SYMBOL file #365.15) 
 . S SYMBOL=$$SYMBOL^IBCNBLL(IEN)
 . ; If Buffer Symbol is NULL OR "!", do NOT save to the TQ, Quit 
 . I (SYMBOL=" ")!(SYMBOL="!") S SAVE=0 Q
 . ; If the Buffer Symbol if "a" OR "r" (E1 transactions), SAVE to the TQ
 . I (SYMBOL="a")!(SYMBOL="r") S SAVE=1 Q
 . ;Safety value to avoid a duplicate entry ie, for symbol +,-, etc (should not hit this)
 . S SAVE=0
 . Q
BFCHECKX ;BFCHECK Exit
 Q SAVE
