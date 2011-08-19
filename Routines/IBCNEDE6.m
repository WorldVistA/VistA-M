IBCNEDE6 ;DAOU/DAC - eIV DATA EXTRACTS ;15-OCT-2002
 ;;2.0;INTEGRATED BILLING;**184,271,345,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q    ; no direct calls allowed
 ;
 ; IB*2*416 removed the ability to perform Identification inquiries.
 ; However, this code is being left as is for future changes.
 ;
INAC(IBCNCNT,MAXNUM,IBDDI,SRVICEDT,FDAYS,APPTFLG) ;Get Inactive Insurances
 ; DAOU/BHS - 10/15/2002 - Replaced VRFDT w/ FDAYS (fresh days value)
 ; APPTFLG - Appt extract flag ONLY set from IBCNEDE2 - optional 0/1
 ;
 ; IB patch 416 discontinued the practice of using eIV for fishing for insurance
 ; using the "No Insurance" extract or by doing Identification inquiries.
 Q 0
 ;
 NEW IDATA,INCP,IEN,TQIEN,INS,INACT,DATA1,DATA2,FRESHDT
 NEW PAYER,PAYERID,RESULT,FOUND,SIDARRAY,SIDACT,SIDCNT,SID,INREC
 ;
 ; Need FOUND to avoid the creation of a no payer inquiry the day after
 ; the original inquiry for pre-reg (appt) extract and no insurance
 ; extract was created.
 S FOUND=0 ; set flag to 1 if potential inquiry was found
 ;
 S APPTFLG=$G(APPTFLG)
 S IDATA=$G(^IBE(350.9,1,51))
 S INACT=$P(IDATA,U,8)
 S FRESHDT=$$FMADD^XLFDT(SRVICEDT,-FDAYS)
 ;
 ;  If the search for inactive insurances is 'No', quit
 I 'INACT G INACX
 ;
 S INCP="" F  S INCP=$O(IBDDI(INCP)) Q:INCP=""  D  Q:IBCNCNT'<MAXNUM
 . S IEN="" F  S IEN=$O(^DPT(DFN,.312,"B",INCP,IEN)) Q:IEN=""  D
 .. S INS=$P(^DPT(DFN,.312,IEN,0),U)
 .. ;
 .. ;Check for Medicaid
 .. I $$EXCLUDE^IBCNEUT4($P($G(^DIC(36,INS,0)),U)) Q
 .. ;
 .. ;  Check for insurance company payer, etc.
 .. S RESULT=$$INSERROR^IBCNEUT3("I",INS)
 .. I $P(RESULT,U)'="" Q
 .. ;
 .. S PAYER=$P(RESULT,U,2),PAYERID=$P(RESULT,U,3)
 .. I ('PAYER)!(PAYERID="") Q
 .. ;
 .. S FOUND=1  ; potential inquiry
 .. ;
 .. ; Update service date based on payer's allowed range
 .. D UPDDTS(PAYER,.SRVICEDT,.FRESHDT)
 .. ;  update service dates for inquiries to be transmitted
 .. D TQUPDSV^IBCNEUT5(DFN,PAYER,SRVICEDT)
 .. ;  check for outstanding/current entries in File 356.1
 .. I '$$ADDTQ^IBCNEUT5(DFN,PAYER,SRVICEDT,FDAYS) Q
 .. ;
 .. ; Call function to set IIV TRANSMISSION QUEUE file #365.1
 .. ;
 .. K SIDARRAY
 .. S SIDACT=$$SIDCHK2^IBCNEDE5(DFN,PAYER,.SIDARRAY,FRESHDT)
 .. S SIDCNT=$P(SIDACT,U,2),SIDACT=$P(SIDACT,U)
 .. ;  Add to SIDCNT to compensate for a TQ entry w/ blank Sub ID
 .. I SIDACT=5!(SIDACT=6)!(SIDACT=7)!(SIDACT=8) S SIDCNT=SIDCNT+1
 .. I IBCNCNT+SIDCNT>MAXNUM S IBCNCNT=MAXNUM Q  ; see if TQ entries will exceed MAXNUM
 .. S SID="" F  S SID=$O(SIDARRAY(SID)) Q:SID=""  D
 ... S INREC=$P(SID,"_",2)   ; which patient ins rec ID is from
 ... D INACSET($P(SID,"_"),INREC)
 ... ; 
 .. ;  Create TQ entry w/ blank Sub ID
 .. I (SIDACT=5)!(SIDACT=6)!(SIDACT=7)!(SIDACT=8) S SID="" D INACSET("","")
 K SIDARRAY
INACX ;
 Q FOUND
 ;
INACSET(SID,INREC) ; INAC. SET
 ; The hard coded '1' in the 3rd piece of DATA1 sets the Transmission
 ; status of file 365.1 to "Ready to Transmit"
 ;
 ; IB*2*416 removed the ability to perform identification inquiries
 Q
 ;
 N FRESH
 S FRESH=$$FMADD^XLFDT(SRVICEDT,-FDAYS)
 S DATA1=DFN_U_PAYER_U_1_U_""_U_SID_U_FRESH
 ;
 ; The hardcoded 1st piece of DATA2 tells file 365.1 which extract
 ; it is.
 I APPTFLG S DATA2=2    ; appt extract IBCNEDE2
 I 'APPTFLG S DATA2=4   ; no ins extract IBCNEDE4
 S DATA2=DATA2_U_"I"_U_SRVICEDT_U_$G(INREC)
 ;
 S TQIEN=$$SETTQ^IBCNEDE7(DATA1,DATA2)
 I TQIEN'="" S IBCNCNT=IBCNCNT+1
 ;
 Q
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
 ; DAOU/WCW - Overriding this to allow service date of only today
 ;            for the time being - setting params to 0
 S FDAYS=0,PDAYS=0
 ; Process past service days if not null
 I PDAYS'="" D
 . ; If zero, reset to today
 . I PDAYS=0 S SVDT=$$DT^XLFDT,EDTFLG=1
 . ; If non-zero and service date is earlier than the allowed
 . ;  payer service date range, reset service date to earliest allowed
 . ;  date for the payer
 . I PDAYS,SVDT<$$FMADD^XLFDT($$DT^XLFDT,-PDAYS+1) D
 . . S SVDT=$$FMADD^XLFDT($$DT^XLFDT,-PDAYS+1),EDTFLG=1
 ; Process future service days if not edited and if not null
 I EDTFLG=0,FDAYS'="" D
 . ; If zero, reset to today
 . I FDAYS=0 S SVDT=$$DT^XLFDT,EDTFLG=1
 . ; If non-zero and service date is later than the allowed
 . ;  payer service date range, reset service date to latest allowed
 . ;  date for the payer
 . I FDAYS,SVDT>$$FMADD^XLFDT($$DT^XLFDT,FDAYS-1) D
 . . S SVDT=$$FMADD^XLFDT($$DT^XLFDT,FDAYS-1),EDTFLG=1
 ;
 ; Determine if difference exists
 I EDTFLG,$G(FRDT)'="" S FRDT=$$FMADD^XLFDT(FRDT,$$FMDIFF^XLFDT(SVDT,OSVDT))
 ;
 Q
 ;
BLANKTQ(SRVICEDT,FRESHDT,YDAYS,IBCNCNT) ; 
 ; This tag is only called from PROCESS^IBCNEDE4 
 ; No new records were created in file 365.1 for this DFN.
 ; Need to check if an inquiry for any payer exists for this DFN within
 ; the freshness period.  If it doesn't exist create a new blank inquiry
 ;
 ; Input
 ;    SRVICEDT - Service Date
 ;    FRESHDT - Freshness Date
 ;    YDAYS - 
 ;    IBCNCNT - updated - Counter for the extract
 ;
 ; IB*2*416 removed the ability to perform identification inquiries
 ;          - blank or otherwise
 Q
 ;
 I $$TFL^IBCNEDE6(DFN)=0 Q
 ;
 N PAYER,DATA1,DATA2,TQIEN
 ;
 S PAYER=$$FIND1^DIC(365.12,,"X","~NO PAYER")
 ;
 ; Update service date and freshness date based on payer allowed
 ;  date range
 D UPDDTS^IBCNEDE6(PAYER,.SRVICEDT,.FRESHDT)
 ;
 ; Update service dates for inquiries to be transmitted
 D TQUPDSV^IBCNEUT5(DFN,PAYER,SRVICEDT)
 ;
 ; Are we allowed to add it to the TQ file
 I '$$ADDTQ^IBCNEUT5(DFN,PAYER,SRVICEDT,YDAYS,1) G BLANKXT
 ;
 ; The hard coded '1' in the 3rd piece of DATA1 sets the Transmission
 ; status of file 365.1 to "Ready to Transmit"
 S DATA1=DFN_U_PAYER_U_1_U_""_U_""_U_FRESHDT
 ;
 ; The hardcoded '4' in the 1st piece of DATA2 is the value to tell
 ; the file 365.1 that it is the no active insurance extract.
 S DATA2=4_U_"I"_U_SRVICEDT
 ;
 S TQIEN=$$SETTQ^IBCNEDE7(DATA1,DATA2),PAYER=""
 I TQIEN'="" S IBCNCNT=IBCNCNT+1
 ;
BLANKXT ;
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
