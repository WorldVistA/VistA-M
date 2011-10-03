IBCNEDE4 ;DAOU/ALA - NO INSURANCE DATA EXTRACT ;24-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,271,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; ***** Note *****
 ; IB*2*416 removed the ability to perform Identification inquiries.
 ; However, this code is being left as is for future changes.
 ; But this routine is no longer called from IBCNEDE.
 ;
 ;**Program Description**
 ;  This program finds veterans who have been seen within a
 ;  specified date range but who have no active or no
 ;  insurance records
 ;  Periodically check for stop request for background task
 ;
 Q   ;can't call directly
 ;
EN ;
 NEW TMPCNT,IEN,TQIEN,DATA1,DATA2,EACTIVE,XDAYS,YDAYS,MAXCNT,IBBDT,IBEDT
 NEW IBD,IBPM,IBPMD,IBQUERY,IBCNCNT,SRVICEDT,IBINS,IBDD,IBDDI,DFN
 NEW IBOUTP,PTN,PAYER,FOUND1,FOUND2,DFN,DISYS,TDT,IBCNETOT,FRESH,FRESHDT
 NEW DGPMDT,AUPNDT
 ;
 S IBCNCNT=0
 ; Initialize count for periodic TaskMan check
 S IBCNETOT=0
 ;
 ;  Get Extract parameters
 S EACTIVE=$$SETTINGS^IBCNEDE7(4)
 I 'EACTIVE Q                   ; quit if not active
 S XDAYS=$P(EACTIVE,U,2)
 S YDAYS=$P(EACTIVE,U,3)
 S MAXCNT=$P(EACTIVE,U,4)
 S:MAXCNT="" MAXCNT=9999999999
 ;
 ;  Check for Date Last Treated and get DFN's
 S IBBDT=$$FMADD^XLFDT(DT,-XDAYS),IBEDT=DT
 ;
 ; * Main Control
 ;
 S IBD=IBBDT-.0001
 K ^TMP("IBCNEDE4",$J,"PTS")
 F II=1:1 D  Q:(IBD="")!(IBD\1>IBEDT)!(IBCNCNT'<MAXCNT)!($G(ZTSTOP))
 . S DGPMDT=$O(^DGPM("ATT3",IBD)),AUPNDT=$O(^AUPNVSIT("B",IBD))
 . I (AUPNDT="")!((DGPMDT\1)<(AUPNDT\1)) S IBD=DGPMDT
 . I (DGPMDT="")!((DGPMDT\1)>(AUPNDT\1)) S IBD=AUPNDT
 . I (IBD\1>IBEDT)!(IBD="") Q
 . ;
 . K ^TMP("IBJDI51",$J)
 . D INP(IBD)    ; sets up ^TMP("IBJDI51",$J)
 . I $G(ZTSTOP) Q
 . D OUTP(IBD)
 . I $G(ZTSTOP) Q
 . D REST(IBBDT-.0001,IBEDT)
 . D PROCESS
 . I $G(ZTSTOP) Q
 . S IBD=($$FMADD^XLFDT(IBD,+1))-.0001
 ;
EXIT ;
 K VINS,^TMP("IBJDI51",$J),^TMP("IBCNEDE4",$J,"PTS")   ; clean up
 ;
 Q
 ; * end of routine processing
 ;============================
 ;
INP(DATE) ;  Find inpatients for that date (we want most recent encounter)
 NEW IBD,IBPM,IBPMD,DFN
 S IBD=DATE-.0001
 F  S IBD=$O(^DGPM("ATT3",IBD)) Q:(IBD="")!(IBD\1>DATE)  D  Q:$G(ZTSTOP)
 . S IBPM=0 F  S IBPM=$O(^DGPM("ATT3",IBD,IBPM)) Q:IBPM=""  D  Q:$G(ZTSTOP)
 .. ; Update count for periodic check
 .. S IBCNETOT=IBCNETOT+1
 .. ; Check for request to stop background job, periodically
 .. I $D(ZTQUEUED),IBCNETOT#100=0,$$S^%ZTLOAD() S ZTSTOP=1 Q
 .. ;
 .. S IBPMD=$G(^DGPM(IBPM,0)) Q:'IBPMD
 .. S DFN=+$P(IBPMD,U,3) Q:'DFN
 .. I $P($G(^DPT(DFN,0)),U,21) Q         ; Exclude if test patient
 .. Q:$D(^TMP("IBCNEDE4",$J,"PTS",DFN,"INP"))      ; already processed
 .. S ^TMP("IBCNEDE4",$J,"PTS",DFN,"INP",IBD)=""
 .. D PROC^IBJDI5(DFN,"*",IBD)
 Q
 ;
OUTP(DATE) ; Find outpatients treated for this date (most recent encounter)
 NEW IBD,IEN,DFN
 S IBD=DATE-.000001
 F  S IBD=$O(^AUPNVSIT("B",IBD)) Q:(IBD="")!(IBD\1>DATE)  D  Q:$G(ZTSTOP)
 . S IEN=""
 . F  S IEN=$O(^AUPNVSIT("B",IBD,IEN)) Q:IEN=""  D  Q:$G(ZTSTOP)
 .. ; Update count for periodic check
 .. S IBCNETOT=IBCNETOT+1
 .. ; Check for request to stop background job, periodically
 .. I $D(ZTQUEUED),IBCNETOT#100=0,$$S^%ZTLOAD() S ZTSTOP=1 Q
 .. ;
 .. S DFN=$P($G(^AUPNVSIT(IEN,0)),U,5)
 .. Q:DFN=""
 .. I $P($G(^DPT(DFN,0)),U,21) Q         ; Exclude if test patient
 .. Q:$D(^TMP("IBCNEDE4",$J,"PTS",DFN,"OUTP"))    ; already processed
 .. S ^TMP("IBCNEDE4",$J,"PTS",DFN,"OUTP",IBD)=""
 .. ; Capture the most recent (last) encounter date
 .. I $G(^TMP("IBJDI51",$J,DFN))<(IBD\1) D PROC^IBJDI5(DFN,"",IBD)
 Q
 ;
REST(STARTDT,ENDDT) ; Check for a more recent encounter (inpat. or outpat.)
 ;
 NEW IBPM,IBPMD,IBD,DFN
 S DFN=0
 F  S DFN=$O(^TMP("IBJDI51",$J,DFN)) Q:DFN=""  D
 . ;
 . ; inpatients
 . S IBPM=0 F  S IBPM=$O(^DGPM("C",DFN,IBPM)) Q:IBPM=""  D
 .. S IBPMD=$G(^DGPM(IBPM,0)) Q:'IBPMD
 .. S IBD=$P(IBPMD,U,1) I ((IBD\1)<STARTDT)!((IBD\1)>ENDDT) Q
 .. Q:$D(^TMP("IBJDI51",$J,"PTS",DFN,"INP",IBD))  ;already checked
 .. S ^TMP("IBJDI51",$J,"PTS",DFN,"INP",IBD)=""
 .. ; Capture the most recent (last) encounter date
 .. I $G(^TMP("IBJDI51",$J,DFN))<(IBD\1) D PROC^IBJDI5(DFN,"*",IBD)
 . ;
 . ; outpatients
 . S IBD="" F  S IBD=$O(^AUPNVSIT("AA",DFN,IBD)) Q:IBD=""  D
 .. I ((IBD\1)<STARTDT)!((IBD\1)>ENDDT) Q
 .. Q:$D(^TMP("IBJDI51",$J,"PTS",DFN,"OUTP",IBD))  ;already checked
 .. S ^TMP("IBJDI51",$J,"PTS",DFN,"OUTP",IBD)=""
 .. ; Capture the most recent (last) encounter date
 .. I $G(^TMP("IBJDI51",$J,DFN))<(IBD\1) D PROC^IBJDI5(DFN,"",IBD)
 ;
 Q
 ;
PROCESS ;  Check selection criteria for each person with
 ;  a visit in the last defined time frame (e.g. 6 months)
 N SVIBDDI
 S DFN=0 F  S DFN=$O(^TMP("IBJDI51",$J,DFN)) Q:'DFN  D  Q:IBCNCNT'<MAXCNT!$G(ZTSTOP)
 . ;
 . ; Update count for periodic check
 . S IBCNETOT=IBCNETOT+1
 . ; Check for request to stop background job, periodically
 . I $D(ZTQUEUED),IBCNETOT#100=0,$$S^%ZTLOAD() S ZTSTOP=1 Q
 . ;
 . S SRVICEDT=$P(^TMP("IBJDI51",$J,DFN),U)
 . S FRESHDT=$$FMADD^XLFDT(SRVICEDT,YDAYS)
 . ;
 . ; Call IB utility to search for patient's inactive insurance
 . ; IBCNS passes back IBINS = 1 if active insurance was found
 . ; IBCNS sets the array IBDD to the patient's valid insurance
 . ; IBCNS sets the array IBDDI to the patient's invalid insurance
 . ;
 . K IBINS,IBDD,IBDDI,SVIBDDI
 . S IBOUTP=2
 . D ^IBCNS
 . K IBDD           ; don't need this array
 . I $G(IBINS)=1 Q  ; if active insurance was found quit
 . M SVIBDDI=IBDDI
 . ;
 . S (FOUND1,FOUND2)=0
 . ;
 . ; Returned all inactive insurances in IBDDI array
 . I $D(IBDDI)>0,(IBCNCNT<MAXCNT) S FOUND2=$$INAC^IBCNEDE6(.IBCNCNT,MAXCNT,.IBDDI,SRVICEDT,YDAYS)
 . M IBDDI=SVIBDDI
 . ;
 . ;  If no inactive insurances, work the popular insurances
 . I IBCNCNT<MAXCNT S FOUND1=$$POP(.IBCNCNT,MAXCNT,SRVICEDT,YDAYS,,.IBDDI)
 . ;
 . I 'FOUND1,'FOUND2,(IBCNCNT<MAXCNT) D BLANKTQ^IBCNEDE6(SRVICEDT,FRESHDT,YDAYS,.IBCNCNT)
 K ^TMP("IBJDI51",$J),IBDD,IBDDI,IBINS
 Q
 ;
POP(IBCNCNT,MAXCNT,SRVICEDT,FDAYS,APPTFLG,IBDDI) ; Get Popular Insurances
 ; FDAYS (Fresh Days value)
 ; APPTFLG - Appt extract flag ONLY set from IBCNEDE2 - optional 0/1
 ;
 NEW PDATA,POPFL,PNUM,PCNT,II,RESULT,PAYER,PAYERID
 NEW DATA1,DATA2,TQIEN,FOUND,SIDARRAY,SID,SIDACT,SIDCNT
 NEW FRESHDT,INACT,SKIPPAY
 ;
 ; Need FOUND to avoid the creation of a no payer inquiry the day after
 ; the original inquiry for pre-reg (appt) extract and no insurance
 ; extract was created.
 S FOUND=0 ; set flag to 1 if potential inquiry was found
 ;
 S APPTFLG=$G(APPTFLG)
 S PDATA=$G(^IBE(350.9,1,51))
 S POPFL=$P(PDATA,U,9),PNUM=$P(PDATA,U,10)
 S INACT=$P(PDATA,U,8)   ; get inactive flag from site parameters
 ;
 ;  If the search for popular insurances is 'No', quit
 I 'POPFL G POPX
 ;
 ; If the site does not check inactive insurances and the patient
 ; has inactive insurances, set up the array of payers to skip.
 ; This will be used to screen the patient's inactive payers from being
 ; included with the most popular payers. 
 I 'INACT,$D(IBDDI) D
 . N INCP,INSPAYID
 . S INCP="" F  S INCP=$O(IBDDI(INCP)) Q:'INCP  D
 .. S RESULT=$$INSERROR^IBCNEUT3("I",INCP)
 .. Q:$P(RESULT,U)'=""
 .. S INSPAYID=$P(RESULT,U,3)
 .. I INSPAYID="" Q
 .. S SKIPPAY(INSPAYID)=""
 ;
 S FRESHDT=$$FMADD^XLFDT(SRVICEDT,-FDAYS)
 ;
 ;  If no list of popular insurances, quit
 I $O(^IBE(350.9,1,51.18,0))="" G POPX
 S II=0 F PCNT=1:1:PNUM S II=$O(^IBE(350.9,1,51.18,II)) Q:'II  D  Q:IBCNCNT'<MAXCNT
 . S PAYER=$P(^IBE(350.9,1,51.18,II,0),U,1)
 . ;
 . S RESULT=$$PAYER^IBCNEUT4(PAYER)
 . I $P(RESULT,U)'="" Q   ; quit if error, don't record in ins. buffer
 . ; PAYERID = National ID
 . S PAYERID=$P(RESULT,U,2)
 . I PAYERID="" Q
 . ;
 . I $D(SKIPPAY(PAYERID)) Q  ; quit if it was determined that this payer be skipped
 . ;
 . S FOUND=1  ; potential inquiry
 . ;
 . ; Update service date and freshness date based on payer allowed
 . ;  date range
 . D UPDDTS^IBCNEDE6(PAYER,.SRVICEDT,.FRESHDT)
 . ;
 . ; DAOU/BHS - Update service dates for inquiries to be transmitted
 . D TQUPDSV^IBCNEUT5(DFN,PAYER,SRVICEDT)
 . ;
 . ;check for outstanding/current entries in File 356.1
 . ; Freshness check - are we allowed to add this entry to the TQ file
 . I '$$ADDTQ^IBCNEUT5(DFN,PAYER,SRVICEDT,FDAYS) Q
 . ;
 . ; Call function to set IIV TRANSMISSION QUEUE file #365.1
 . ;
 . K SIDARRAY
 . S SIDACT=$$SIDCHK2^IBCNEDE5(DFN,PAYER,.SIDARRAY,FRESHDT)
 . S SIDCNT=$P(SIDACT,U,2),SIDACT=$P(SIDACT,U)
 . ;  Add to TQ to compensate for TQ w/ blank Sub ID
 . I SIDACT'<5,(SIDACT'>8) S SIDCNT=SIDCNT+1
 . I IBCNCNT+SIDCNT>MAXCNT S IBCNCNT=MAXCNT Q     ; see if TQ entries will exceed MAXCNT
 . S SID=""
 . F  S SID=$O(SIDARRAY(SID)) Q:SID=""  D POPSET($P(SID,"_"),$P(SID,"_",2))
 . ;
 . ; Create TQ entry w/ blank Sub ID
 . I SIDACT=5!(SIDACT=6)!(SIDACT=7)!(SIDACT=8) S SID="" D POPSET("","") ;D POPSET()
POPX ; POP exit point
 Q FOUND
 ;
POPSET(SID,INREC) ;
 N FRESH
 ; The hard coded '1' in the 3rd piece of DATA1 sets the Transmission
 ; status of file 365.1 to "Ready to Transmit"
 S FRESH=$$FMADD^XLFDT(SRVICEDT,-FDAYS)
 S DATA1=DFN_U_PAYER_U_1_U_""_U_SID_U_FRESH
 ;
 ; The hardcoded 1st piece of DATA2 tells file 365.1 which extract
 ; it is.
 I APPTFLG S DATA2=2  ; appt extract IBCNEDE2
 I 'APPTFLG S DATA2=4 ; no ins extract IBCNEDE4
 S DATA2=DATA2_U_"I"_U_SRVICEDT_U_$G(INREC)
 ;
 S TQIEN=$$SETTQ^IBCNEDE7(DATA1,DATA2)
 I TQIEN'="" S IBCNCNT=IBCNCNT+1
 ;
 Q
 ;
