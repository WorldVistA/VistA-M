IBCNEDE3 ;DAOU/DJW - NONVERINS DATA EXTRACT ;18-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,271,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This program finds veterans who have been seen within a
 ;  specified date range that have active insurance records which has
 ;  not been verified recently.
 ;  Periodically check for stop request for background task
 ;
 Q   ; program can not be called directly
 ;
EN ; Loop through designated cross-references for updates 
 ; (Non verified insurance)
 ;
 ; Initialize 
 NEW DIC,DA,X,Y,DLAYGO,DINUM,DTOUT,DFN,FRESHDT,IBD,IBPM,IBPMD
 NEW IEN,MAXCNT,IBCNECNT,EACTIVE,XDAYS,YDAYS,TDT,VI,IBBDT,IBEDT
 NEW VINCON,VNOK,SRVICEDT,RESULT,PAYER,PAYERID,ARRAY,ERROR,SUPPBUFF
 NEW TRANSNO,IBQUERY,PTN,INSNAME,IBCNETOT,SID,SIDACT,SIDDATA
 NEW SIDARRAY,SIDCNT,DISYS,DGPMDT,AUPNDT,II,PATID
 ;
 S IEN="",IBCNECNT=0
 ; Initialize count for periodic TaskMan check
 S IBCNETOT=0
 ;
 ; Get site parameter settings for non-verified ins. extract
 S EACTIVE=$$SETTINGS^IBCNEDE7(3)
 I 'EACTIVE G EXIT                   ; Quit if extract not active
 S XDAYS=$P(EACTIVE,U,2)
 S YDAYS=$P(EACTIVE,U,3)
 S MAXCNT=$P(EACTIVE,U,4)
 S:MAXCNT="" MAXCNT=9999999999
 S SUPPBUFF=$P(EACTIVE,U,5)
 ;
 ;  Check for Date Last Treated and get DFN's
 S IBBDT=$$FMADD^XLFDT(DT,-XDAYS),IBEDT=DT
 ;
 ;  * main control
 ;
 S IBD=IBBDT-.0001
 K ^TMP("IBCNEDE3",$J,"PTS")
 F II=1:1 D  Q:(IBD="")!(IBD\1>IBEDT)!(IBCNECNT'<MAXCNT)!($G(ZTSTOP))
 . S DGPMDT=$O(^DGPM("ATT3",IBD)),AUPNDT=$O(^AUPNVSIT("B",IBD))
 . I (AUPNDT="")!((DGPMDT\1)<(AUPNDT\1)) S IBD=DGPMDT
 . I (DGPMDT="")!((DGPMDT\1)>(AUPNDT\1)) S IBD=AUPNDT
 . I (IBD\1>IBEDT)!(IBD="") Q
 . ;
 . K ^TMP("IBJDI51",$J)
 . D INP(IBD)    ; sets up ^TMP("IBJDI51",$J)
 . I $G(ZTSTOP) Q
 . D OUTP(IBD)    ; sets up ^TMP("IBJDI51",$J)
 . I $G(ZTSTOP) Q
 . ;D REST(IBBDT-.0001,IBEDT)    ; sets up ^TMP("IBJDI51",$J)
 . D PROCESS
 . I $G(ZTSTOP) Q
 . S IBD=($$FMADD^XLFDT(IBD,+1))-.0001
 ;
EXIT ;
 K VINS,^TMP("IBJDI51",$J),^TMP("IBCNEDE3",$J,"PTS")   ; clean up
 ;
 Q
 ; * end of routine processing
 ;===========================================
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
 .. Q:$D(^TMP("IBCNEDE3",$J,"PTS",DFN,"INP"))      ; already processed 
 .. S ^TMP("IBCNEDE3",$J,"PTS",DFN,"INP",IBD)=""
 .. D PROC^IBJDI5(DFN,"*",IBD)
 Q
 ;
OUTP(DATE) ; Find outpatients treated for this date (most recent encounter)
 NEW IBD,IEN,DFN
 S IBD=DATE-.0001
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
 .. Q:$D(^TMP("IBCNEDE3",$J,"PTS",DFN,"OUTP"))    ; already processed
 .. S ^TMP("IBCNEDE3",$J,"PTS",DFN,"OUTP",IBD)=""
 .. ; Capture the most recent (last) encounter date
 .. I $G(^TMP("IBJDI51",$J,DFN))<(IBD\1) D PROC^IBJDI5(DFN,"",IBD)
 Q
 ;
REST(STARTDT,ENDDT) ; Check to see if there was a more recent inpatient
 ; or outpatient encounter for this patient.
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
 K ^TMP("IBCNEDE3",$J,"PTS")  ; clean up - no longer needed
 Q
 ;
PROCESS ;  Get insurance for each patient
 N MCAREFLG
 S DFN=0 F  S DFN=$O(^TMP("IBJDI51",$J,DFN)) Q:'DFN  D  Q:IBCNECNT'<MAXCNT!$G(ZTSTOP)
 . S MCAREFLG=0
 . ; Update count for periodic check
 . S IBCNETOT=IBCNETOT+1
 . ; Check for request to stop background job, periodically
 . I $D(ZTQUEUED),IBCNETOT#100=0,$$S^%ZTLOAD() S ZTSTOP=1 Q
 . ;
 . S SRVICEDT=$P(^TMP("IBJDI51",$J,DFN),U)
 . S FRESHDT=$$FMADD^XLFDT(SRVICEDT,-YDAYS)
 . K VINS
 . D ALL^IBCNS1(DFN,"VINS",3)
 . ;
 . I $G(VINS(0))="" Q  ; no active insurance
 . ;
 . S VI=0 F  S VI=$O(VINS(VI)) Q:VI=""!(IBCNECNT'<MAXCNT)  D
 .. S VINCON=$P(VINS(VI,0),U)
 .. ;
 .. S INSNAME=$P($G(^DIC(36,VINCON,0)),U)
 .. ; allow only one MEDICARE transmission per patient
 .. I INSNAME["MEDICARE",MCAREFLG Q
 .. ;Check for ins. companies to exclude (i.e. Medicaid)
 .. I $$EXCLUDE^IBCNEUT4(INSNAME) Q
 .. ;
 .. ;Check for Ins. Company/Payer problems
 .. S RESULT=$$INSERROR^IBCNEUT3("I",VINCON)
 .. ;
 .. I $P(RESULT,U)'="" D BUFF Q    ; error encountered
 .. ;
 .. S PAYER=$P(RESULT,U,2),PAYERID=$P(RESULT,U,3) ; Payer IEN & Payer ID
 .. I 'PAYER!(PAYERID="") Q
 .. I '$$PYRACTV^IBCNEDE7(PAYER) Q        ; Payer is not nationally active
 .. ;
 .. ; set patient id field   IB*2*416
 .. S PATID=$P($G(VINS(VI,5)),U,1)    ; 5.01 field in pt. ins.
 .. ;
 .. ; Update service date and freshness date based on payer allowed
 .. ;  date range
 .. D UPDDTS^IBCNEDE6(PAYER,.SRVICEDT,.FRESHDT)
 .. ;
 .. ; Update service dates for inquiries to be transmitted
 .. D TQUPDSV^IBCNEUT5(DFN,PAYER,SRVICEDT)
 .. ;
 .. ; Check for outstanding/current entries in File 365.1
 .. I '$$ADDTQ^IBCNEUT5(DFN,PAYER,SRVICEDT,YDAYS) Q
 .. K SIDARRAY
 .. S SIDDATA=$$SIDCHK^IBCNEDE5(PAYER,DFN,,.SIDARRAY,FRESHDT)
 .. S SIDACT=$P(SIDDATA,U),SIDCNT=$P(SIDDATA,U,2)
 .. ;
 .. I SIDACT=3 D  Q
 ... I 'SUPPBUFF,'$$BFEXIST^IBCNEUT5(DFN,INSNAME) D PT^IBCNEBF(DFN,VI,18,"",1)
 .. ;
 .. I IBCNECNT+SIDCNT>MAXCNT S IBCNECNT=MAXCNT Q  ;quit if TQ entries>MAXCNT
 .. S SID=""
 .. F  S SID=$O(SIDARRAY(SID)) Q:SID=""  D:$P(SID,"_")'="" SET($P(SID,"_"),$P(SID,"_",2),PATID) S:INSNAME["MEDICARE" MCAREFLG=1
 .. I SIDACT=4 D SET("","",PATID) S:INSNAME["MEDICARE" MCAREFLG=1
 Q
 ;
SET(SID,INR,PATID) ; Call function to set IIV TRANSMISSION QUEUE file #365.1
 NEW DATA1,DATA2,TQIEN
 ;
 ; The hard coded '1' in the 3rd piece of DATA1 sets the Transmission
 ; status of file 365.1 to "Ready to Transmit"
 S DATA1=DFN_U_PAYER_U_1_U_""_U_SID_U_FRESHDT
 S $P(DATA1,U,8)=PATID     ; IB*2*416
 ;
 ; The hardcoded '3' in the 1st piece of DATA2 is the value to tell
 ; the file 365.1 that it is the non-verified extract.
 S DATA2=3_U_"V"_U_SRVICEDT_U_INR
 ;
 S TQIEN=$$SETTQ^IBCNEDE7(DATA1,DATA2)
 I TQIEN'="" S IBCNECNT=IBCNECNT+1
 ;
 Q
BUFF ; Create new buffer entry, if one doesn't already exist, with a 
 ; bang symbol
 I SUPPBUFF Q   ; determine if we suppress buffer entries
 I '$$BFEXIST^IBCNEUT5(DFN,INSNAME) D PT^IBCNEBF(DFN,VI,$P(RESULT,U),"",1)
 Q
 ;
