IBCNERP8 ;DAOU/BHS - IBCNE eIV STATISTICAL REPORT COMPILE ;11-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,271,345,416,506,621,631,668,687,737**;21-MAR-94;Build 19
  ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; eIV - Insurance Verification Interface
 ;
 ;Input vars from IBCNERP7:
 ; IBCNERTN = "IBCNERP7"
 ; **IBCNESPC array ONLY passed by reference **
 ; IBCNESPC("BEGDTM") = Start Dt/Tm for rpt range
 ; IBCNESPC("ENDDTM") = End Dt/Tm for rpt range
 ; IBCNESPC("SECTS")  = 1 - All sections OR ',' sep'd list of 1 or more
 ;  of the following (not all)
 ;  2 - Outgoing data, inq trans stats
 ;  3 - Incoming data, resps rec'd stats
 ;  4 - Current status, pending resps, queued inqs, deferred inqs, payer
 ;      stats, ins buf stats
 ; IBCNESPC("MM") = "" - do not generate MailMan message OR MAILGROUP to
 ;  send report to Mail Group as defined in the IB site parameters
 ;Output vars:
 ; Based on IBCNESPC("SECTS") parameter the following scratch globals
 ; may be built
 ; 1 OR contains 2 --> 
 ; ^TMP($J,RTN,"OUT")=TotInq^InsBufExtSubtotal^PreRegExtSubtotal^...
 ;  NonVerifInsExtSubtotal^NoActInsExtSubtotal
 ; 1 OR contains 3 --> 
 ; ^TMP($J,RTN,"IN")=TotResp^InsBufExtSubtotal^PreRegExtSubtotal^...
 ;  NonVerifInsExtSubtotal^NoActInsExtSubtotal
 ; 1 OR contains 4 --> 
 ; ^TMP($J,RTN,"CUR")=TotPendingResponses^TotQueuedInquiries^...
 ;  TotDeferredInquiries(Hold)^TotInsCosw/oNationalID^...
 ;  ToteIVPyrsDisabldLocally^TotUserActReq^TotInsBufVerified^TotalManVerified...
 ;  TotaleIVVerified^TotInsBufUnverified^! InsBufSubtotal^...
 ;  ? InsBufSubtotal^- InsBufSubtotal^Other InsBufSubtotal^...
 ;  $ EscolatedBufSubtotal
 ; 1 OR contains 4 -->
 ; ^TMP($J,RTN,"PYR",APP,PAYER,IEN)="" (list of new payers)  ;IB*2.0*687
 ;
 ; Must call at EN
 ;
 ;  /ckb-IB*2*687  Added APP to incorporate IIU into this rpt; corrected
 ;           references from Nationally active & locally active to
 ;           Nationally and Locally enabled
 Q
 ;
EN(IBCNERTN,IBCNESPC) ; Entry pt
 ; Init vars
 N IBBDT,IBEDT,IBSCT,IBTOT,PIECES,VALUE,CT
 ;
 I '$D(ZTQUEUED),$G(IOST)["C-" W !!,"Compiling report data ..."
 ;
 S IBTOT=0
 ;
 ; Kill scratch global
 K ^TMP($J,IBCNERTN)
 ;
 ; Init looping vars
 S IBBDT=$G(IBCNESPC("BEGDTM")),IBEDT=$G(IBCNESPC("ENDDTM"))
 S IBSCT=$G(IBCNESPC("SECTS"))
 ;
 I IBSCT=1!$F(IBSCT,",2,") D OUT(IBCNERTN,IBBDT,IBEDT,.IBTOT)
 I $G(ZTSTOP) G EXIT
 I IBSCT=1!$F(IBSCT,",3,") D IN(IBCNERTN,IBBDT,IBEDT,.IBTOT)
 I $G(ZTSTOP) G EXIT
 I IBSCT=1!$F(IBSCT,",4,") D CUR(IBCNERTN,IBBDT,IBEDT,.IBTOT),PYR(IBCNERTN,IBBDT,IBEDT,.IBTOT)
 ;
EXIT ; EN Exit pt
 Q
 ;
IN(RTN,BDT,EDT,TOT) ; Determine Incoming Data
 ; Input params: RTN-routine name for ^TMP($J), BDT-start dt/time,
 ;  EDT-end dt/time, **TOT-total records searched - used only for status
 ;  checks when the process is queued (passed by reference)
 ; Output vars: Set pcs of ^TMP($J,RTN,"IN") as follows:
 ;  1=total Resps rec'd for date/time range
 ;  2=Ins Buf extract subtotal
 ;  3=Pre-Reg extract subtotal
 ;  4=Non-ver extract subtotal
 ;  5=No Act Ins subtotal
 ;
 ; Init vars
 N IBDT,PYRIEN,PATIEN,IBPTR,IBTYP,RPTDATA,TRANSIEN
 ;
 ; Loop thru the eIV Resp File (#365) x-ref on Date/Time Resp Rec'd
 S IBDT=$O(^IBCN(365,"AD",BDT),-1)
 F  S IBDT=$O(^IBCN(365,"AD",IBDT)) Q:IBDT=""!(IBDT>EDT)  D  Q:$G(ZTSTOP)
 . S PYRIEN=0
 . F  S PYRIEN=$O(^IBCN(365,"AD",IBDT,PYRIEN)) Q:'PYRIEN  D  Q:$G(ZTSTOP)
 . . S PATIEN=0
 . . F  S PATIEN=$O(^IBCN(365,"AD",IBDT,PYRIEN,PATIEN)) Q:'PATIEN  D  Q:$G(ZTSTOP)
 . . . S IBPTR=0
 . . . F  S IBPTR=$O(^IBCN(365,"AD",IBDT,PYRIEN,PATIEN,IBPTR)) Q:'IBPTR  D  Q:$G(ZTSTOP)
 . . . . S TOT=TOT+1
 . . . . I $D(ZTQUEUED),TOT#100=0,$$S^%ZTLOAD() S ZTSTOP=1 Q
 . . . . ; Update total 
 . . . . S $P(RPTDATA,U,1)=$P($G(RPTDATA),U,1)+1
 . . . . ; Update extract type total
 . . . . ; Get the data for the report - build RPTDATA
 . . . . ;IB*2.0*631/TAZ
 . . . . ;S IBTYP=5,TRANSIEN=$P($G(^IBCN(365,IBPTR,0)),U,5)
 . . . . S TRANSIEN=$P($G(^IBCN(365,IBPTR,0)),U,5)
 . . . . ; IB*2.0*621
 . . . . S TQIEN=$P($G(^IBCN(365,IBPTR,0)),U,5)
 . . . . I TQIEN="" Q
 . . . . S IBTYP=$$GET1^DIQ(365.1,TQIEN_",",.1,"I")
 . . . . S IBQUERY=$$GET1^DIQ(365.1,TQIEN_",",.11,"I")
 . . . . S IBMBI=$$GET1^DIQ(365.1,TQIEN_",",.16,"I")
 . . . . I IBTYP'="" D
 . . . . . I IBTYP=3 Q
 . . . . . ;IB*2.0*631
 . . . . . I IBTYP=7 S $P(RPTDATA,U,6)=$P($G(RPTDATA),U,6)+1  Q  ; MBI Request``
 . . . . . I ("~1~5~6~"[("~"_IBTYP_"~")) S $P(RPTDATA,U,2)=$P($G(RPTDATA),U,2)+1 Q
 . . . . . I IBTYP=4 D  Q
 . . . . . . I IBQUERY="I" S $P(RPTDATA,U,4)=$P($G(RPTDATA),U,4)+1 ; EICD Queries
 . . . . . . I IBQUERY="V" S $P(RPTDATA,U,5)=$P($G(RPTDATA),U,5)+1 ; EICD Verification
 . . . . . S:IBTYP=2 $P(RPTDATA,U,3)=$P($G(RPTDATA),U,3)+1
 . . . . ; IB*2.0*621 - End IN Group
 ;
 I $G(ZTSTOP) G INX
 ;
 ; Save data to global
 S ^TMP($J,RTN,"IN")=$G(RPTDATA)
 ;
INX ; IN exit pt
 Q
 ;
OUT(RTN,BDT,EDT,TOT) ; Outgoing Data
 ;Input params:  RTN-routine name used as subscript in ^TMP($J),
 ; BDT-start date/time, EDT-end date/time, **TOT-total recs searched-used
 ; only for status checks when process is queued (passed by reference)
 ;Output vars: Set pcs of ^TMP($J,RTN,"OUT") as follows:
 ; 1=total Inqs transmitted for timeframe
 ; 2=Ins Buffer extract subtotal
 ; 3=Pre-Reg extract subtotal
 ; 4=Non-Ver extract subtotal
 ; 5=No Act Ins subtotal
 ; 6=MBI subtotal
 ;
 ; Init vars
 N IBDT,IBPTR,IBTYP,RPTDATA,TQIEN
 ;
 ; Loop thru the eIV Resp File (#365) by x-ref on Date/Time Resp Created
 ;  Only count responses for unique HL7 message IDs - filter out
 ;  unsolicited responses as they artificially inflate the Outgoing Count
 S IBDT=$O(^IBCN(365,"AE",BDT),-1)
 F  S IBDT=$O(^IBCN(365,"AE",IBDT)) Q:IBDT=""!(IBDT>EDT)  D  Q:$G(ZTSTOP)
 . S IBPTR=0
 . F  S IBPTR=$O(^IBCN(365,"AE",IBDT,IBPTR)) Q:'IBPTR  D  Q:$G(ZTSTOP)
 . . S TOT=TOT+1
 . . I $D(ZTQUEUED),TOT#100=0,$$S^%ZTLOAD() S ZTSTOP=1 Q
 . . ; Quit, if response was not O - original
 . . I $P($G(^IBCN(365,IBPTR,0)),U,10)'="O" Q
 . . ; Update total
 . . S $P(RPTDATA,U,1)=$P($G(RPTDATA),U,1)+1
 . . ; Update extract type total (1,2,3,4)
 . . S TQIEN=$P($G(^IBCN(365,IBPTR,0)),U,5)
 . . I TQIEN="" Q
 . . ; IB*2.0*621
 . . ;S IBTYP=$P($G(^IBCN(365.1,TQIEN,0)),U,10)
 . . S IBTYP=$$GET1^DIQ(365.1,TQIEN_",",.1,"I")
 . . S IBQUERY=$$GET1^DIQ(365.1,TQIEN_",",.11,"I")
 . . S IBMBI=$$GET1^DIQ(365.1,TQIEN_",",.16,"I")
 . . I IBTYP'="" D
 . . . I IBTYP=3 Q
 . . . ;I IBTYP=1 D  Q  ;IB*2.0*631/TAZ
 . . . I IBTYP=7 S $P(RPTDATA,U,6)=$P($G(RPTDATA),U,6)+1  Q  ; MBI Request``
 . . . I ("~1~5~6~"[("~"_IBTYP_"~")) S $P(RPTDATA,U,2)=$P($G(RPTDATA),U,2)+1 Q
 . . . I IBTYP=4 D  Q
 . . . . I IBQUERY="I" S $P(RPTDATA,U,4)=$P($G(RPTDATA),U,4)+1 ; EICD Queries
 . . . . I IBQUERY="V" S $P(RPTDATA,U,5)=$P($G(RPTDATA),U,5)+1 ; EICD Verification
 . . . S:IBTYP=2 $P(RPTDATA,U,3)=$P($G(RPTDATA),U,3)+1
 ;
 I $G(ZTSTOP) G OUTX
 ;
 ; Save data to global array
 S ^TMP($J,RTN,"OUT")=$G(RPTDATA)
 ;
OUTX ; OUT exit pt
 Q
 ;
CUR(RTN,BDT,EDT,TOT) ; Current Status - stats - timeframe independent
 ; Input params: RTN-routine name as subs in ^TMP($J), **TOT-total recs
 ;  searched - used only for status checks when the process is queued
 ;  passed by reference
 ; Output vars: Set pcs of ^TMP($J,RTN,"CUR") as follows:
 ;  1=total Pending Resps (Transmitted-2)
 ;  2=total Queued Inqs (Ready to Transmit-1/Retry-6)
 ;  3=total Deferred Inqs (Hold-4)
 ;  4=Ins Cos w/o National ID
 ;  5=Payers w/eIV locally enabled is NO  ;/vd-IB*2*687 - Reworded the description.
 ;   ; 6=total user action required (symbol'='*' or '#' or '!' or '?' or '-')
 ;  6=total user action required (symbol'='#' or '!' or '?' or '-') ;IB*737/DTG stop use of '*' verified
 ;  7=total Man. Ver'd Ins Buf entries (symbol='*') ;IB*737/DTG stop use of '*' verified
 ;  8=total eIV Processed Ver. (symbol='+')
 ;  9=total awaiting processing (symbol='?' or BLANK)
 ;  10=total Ins Buf entries w/symbol='#'
 ;  11=total Ins Buf entries w/symbol='!'
 ;  12=total Ins Buf entries w/symbol='?'
 ;  13=total Ins Buf entries w/symbol='-'
 ;  ;  14=total Ins Buffer entries w/symbol not in ('*','#','!','?','-')
 ;  14=total Ins Buffer entries w/symbol not in ('#','!','?','-') ;IB*737/DTG stop use of '*' verified
 ;  15=total Ins Buffer entries w/symbol='$'
 ;  16=total Ins Buffet entries w/symbol= % ; IB*2.0*621 - Added 16-21
 ;  17=total Insurance Buffer
 ;  18=Total Appointment 
 ;  19=total Ele Ins Cov Discovery (EICD)
 ;  20=total EICD Triggered Einsurance Verification
 ;  21=total MBI Inquiry
 ;  22=total IIU Payer 'Received IIU Data' set to NO ;IB*2.0*687
 ;
 ;  ^TMP($J,RTN,"CUR","FLAGS","NE",APP,Payer name,N) = nationally enabled flag timestamp ^ nationally enabled flag setting
 ;  ^TMP($J,RTN,"CUR","FLAGS","AU",APP,Payer name,N) = auto updated flag timestamp ^ auto update flag setting
 ;
 ;/ckb-IB*2.0*687 Added APP to incorporate IIU into this report;
 ;           added IIU Payer 'Received IIU Data' set to NO to the report; 
 ;           corrected references from Active (A) & Trusted (T) to
 ;           Nationally Enabled (NE) and Auto Update (AU)
 ;
 ; Init vars
 N RIEN,TQIEN,ICIEN,IBIEN,RPTDATA,IEN,IBSYMBOL,PIECE,IBSTS,APPIEN
 N PIEN,TMP,APPDATA,XDT,PDATA
 ;
 S RPTDATA=""
 ;
 ; Responses pending (Transmitted - 2)
 S RIEN=0
 F  S RIEN=$O(^IBCN(365,"AC",2,RIEN)) Q:'RIEN  D  Q:$G(ZTSTOP)
 .  S TOT=TOT+1
 .  I $D(ZTQUEUED),TOT#100=0,$$S^%ZTLOAD() S ZTSTOP=1 Q
 .  S $P(RPTDATA,U,1)=$P(RPTDATA,U,1)+1
 .  ; IB*2.0*621
 .  S TQIEN=$P($G(^IBCN(365,RIEN,0)),U,5)
 .  I TQIEN="" Q
 .  S IBTYP=$$GET1^DIQ(365.1,TQIEN_",",.1,"I")
 .  S IBQUERY=$$GET1^DIQ(365.1,TQIEN_",",.11,"I")
 .  S IBMBI=$$GET1^DIQ(365.1,TQIEN_",",.16,"I")
 .  I IBTYP'="" D
 . . I IBTYP=3 Q
 . . ;I IBTYP=1 D  Q ;IB*2.0*631
 . . I IBTYP=7 S $P(RPTDATA,U,21)=$P($G(RPTDATA),U,21)+1  Q  ; MBI Request``
 . . I ("~1~5~6~"[("~"_IBTYP_"~")) S $P(RPTDATA,U,17)=$P($G(RPTDATA),U,17)+1 Q
 .  S:IBTYP=2 $P(RPTDATA,U,18)=$P($G(RPTDATA),U,18)+1 ; Appointment
 .  I IBTYP=4 D  Q
 .  . I IBQUERY="I" S $P(RPTDATA,U,19)=$P($G(RPTDATA),U,19)+1 ; EICD Queries
 .  . I IBQUERY="V" S $P(RPTDATA,U,20)=$P($G(RPTDATA),U,20)+1 ; EICD Verification
 .  ; IB*2.0*621 - End IN Group
 ;
 I $G(ZTSTOP) G CURX
 ;
 ; Queued inquiries (Ready to Transmit - 1/Retry - 6) and 
 ; Deferred inquiries (Hold - 4)
 F IBSTS=1,6,4 D  Q:$G(ZTSTOP)
 . S TQIEN=0
 . F  S TQIEN=$O(^IBCN(365.1,"AC",IBSTS,TQIEN)) Q:'TQIEN  D  Q:$G(ZTSTOP)
 . .  S TOT=TOT+1
 . .  I $D(ZTQUEUED),TOT#100=0,$$S^%ZTLOAD() S ZTSTOP=1 QUIT
 . .  I IBSTS'=4 S $P(RPTDATA,U,2)=$P(RPTDATA,U,2)+1 Q
 . .  S $P(RPTDATA,U,3)=$P(RPTDATA,U,3)+1
 ;
 I $G(ZTSTOP) G CURX
 ;
 ; Payer stats
 ; Ins cos w/o National ID
 S ICIEN=0,$P(RPTDATA,U,4)=0
 F  S ICIEN=$O(^DIC(36,ICIEN)) Q:'ICIEN  D  Q:$G(ZTSTOP)
 .  S TOT=TOT+1
 .  I $D(ZTQUEUED),TOT#100=0,$$S^%ZTLOAD() S ZTSTOP=1 QUIT
 .  ; Exclude inactive
 .  S TMP=$$ACTIVE^IBCNEUT4(ICIEN) I 'TMP Q
 .  ; Exclude Medicaid, etc.
 .  I $$EXCLUDE^IBCNEUT4($P(TMP,U,2)) Q
 .  ; Does a NATIONAL ID exist?
 .  ; VA CBO defines 'No National ID' as lack of EDI IDs - fields (#36,3.02) & (#36,3.04) 3/4/14
 .  ; This is *NOT* a check for the 'VA NATIONAL ID' associated with the linked payer
 .  I ($$GET1^DIQ(36,ICIEN_",",3.02)="")&($$GET1^DIQ(36,ICIEN_",",3.04)="") S $P(RPTDATA,U,4)=$P(RPTDATA,U,4)+1 Q
 .  Q
 .  ; Determine assoc Payer
 .  ;S PIEN=$P($G(^DIC(36,ICIEN,3)),U,10)
 .  ; Missing payer link
 .  ;I 'PIEN S $P(RPTDATA,U,4)=$P(RPTDATA,U,4)+1 Q
 .  ; Does a VA NATIONAL ID exist?
 .  ;I $P($G(^IBE(365.12,PIEN,0)),U,2)'="" Q
 .  ;S $P(RPTDATA,U,4)=$P(RPTDATA,U,4)+1
 ;
 I $G(ZTSTOP) G CURX
 ;
 ; eIV Payers locally enabled is NO   ;/ckb-IB*2.0*687 - Reworded the comment
 S PIEN=0
 F  S PIEN=$O(^IBE(365.12,PIEN)) Q:'PIEN  D  Q:$G(ZTSTOP)
 .  S TOT=TOT+1
 .  I $D(ZTQUEUED),TOT#100=0,$$S^%ZTLOAD() S ZTSTOP=1 Q
 .  S PDATA=$G(^IBE(365.12,PIEN,0))
 .  ; Must have National ID
 .  I $P(PDATA,U,2)="" Q
 .  ; Get Payer app multiple IEN
 .  ;   /ckb-IB*2.0*687 - Replaced the following code.
 .  ;IB*668/TAZ - Changed Payer Application from IIV to EIV
 .  ;S APPIEN=$$PYRAPP^IBCNEUT5("EIV",PIEN)
 .  ; Must have eIV application
 .  ;I 'APPIEN Q
 .  ; Get Active/Trusted flag logs
 .  ;D GETFLAGS(PIEN,APPIEN,PDATA,BDT,EDT,.RPTDATA)
 .  ;
 .  ;S APPDATA=$G(^IBE(365.12,PIEN,1,APPIEN,0))
 .  ; Must be Nationally Active
 .  ;I '$P(APPDATA,U,2) Q
 .  ; Must not be Locally Active
 .  ;I $P(APPDATA,U,3) Q
 .  ;S $P(RPTDATA,U,5)=$P(RPTDATA,U,5)+1
 . ;
 . N IENEIV,IENIIU
 . K APPDATA
 . S IENEIV=$$PYRAPP^IBCNEUT5("EIV",PIEN)
 . S IENIIU=$$PYRAPP^IBCNEUT5("IIU",PIEN)
 . I 'IENEIV,'IENIIU Q  ; Payer doesn't have any applications.
 . ;'Receive IIU Data' field is set to NO (0), null values are also considered NO.
 . I IENIIU D
 . . ; Get the Nationally Enabled/Auto Update flag logs
 . . D GETFLAGS(PIEN,IENIIU,PDATA,BDT,EDT,"IIU",.RPTDATA)
 . . S APPDATA=$G(^IBE(365.12,PIEN,1,IENIIU,0))
 . . ; Must be Nationally Enabled
 . . I '$P(APPDATA,U,2) Q
 . . I $P($G(^IBE(365.12,PIEN,1,IENIIU,5)),U)'=1 S $P(RPTDATA,U,22)=$P(RPTDATA,U,22)+1
 . I IENEIV D
 . . ; Get the Nationally Enabled/Auto Update flag logs
 . . D GETFLAGS(PIEN,IENEIV,PDATA,BDT,EDT,"EIV",.RPTDATA)
 . . S APPDATA=$G(^IBE(365.12,PIEN,1,IENEIV,0))
 . . ; Must be Nationally Enabled
 . . I '$P(APPDATA,U,2) Q
 . . ; Must not be Locally Enabled
 . . I $P(APPDATA,U,3) Q
 . . S $P(RPTDATA,U,5)=$P(RPTDATA,U,5)+1
 ;/ckb-IB*2.0*687 End of new code
 ;
 I $G(ZTSTOP) G CURX
 ;
 ; Buffer stats
 ; Loop thru the Ins Buffer File (#355.33)
 S IBIEN=0,XDT=0
 F  S XDT=$O(^IBA(355.33,"AEST","E",XDT)) Q:XDT=""  D  Q:$G(ZTSTOP)
 . F  S IBIEN=$O(^IBA(355.33,"AEST","E",XDT,IBIEN)) Q:IBIEN=""  D  Q:$G(ZTSTOP)
 . . S TOT=TOT+1
 . . I $D(ZTQUEUED),TOT#100=0,$$S^%ZTLOAD() S ZTSTOP=1 Q
 . . S IBSYMBOL=$$SYMBOL^IBCNBLL(IBIEN)
 . . ; Determine piece to update based on symbol
 . . ;  ;('*') = Man. Verified,  ('#','!','-','?',blank/null) = eIV Processing
 . . ; ('#','!','-','?',blank/null) = eIV Processing  ;IB*737/DTG stop use of '*' verified
 . . ; ('+') = eIV Processed, ('$') = Escalated, Active policy
 . . ; IB*2.0*506/taz Node 15 added.
 . . ; IB*2.0*621/ Node 16 Added.
 . . ;S PIECE=$S(IBSYMBOL="*":7,IBSYMBOL="+":8,IBSYMBOL="#":10,IBSYMBOL="!":11,IBSYMBOL="-":13,IBSYMBOL="?":12,IBSYMBOL="$":15,IBSYMBOL="%":16,1:14)
 . . S PIECE=$S(IBSYMBOL="+":8,IBSYMBOL="#":10,IBSYMBOL="!":11,IBSYMBOL="-":13,IBSYMBOL="?":12,IBSYMBOL="$":15,IBSYMBOL="%":16,1:14)  ;IB*737/DTG stop use of '*' verified
 . . I PIECE=12!(PIECE=14) S $P(RPTDATA,U,9)=$P($G(RPTDATA),U,9)+1
 . . E  S $P(RPTDATA,U,6)=$P($G(RPTDATA),U,6)+1
 . . S $P(RPTDATA,U,PIECE)=$P($G(RPTDATA),U,PIECE)+1
 ;
 I $G(ZTSTOP) G CURX
CURM ;
 ; Save data to global
 M ^TMP($J,RTN,"CUR")=RPTDATA
 ;
CURX ; CUR exit point
 Q
 ;
 ;/ckb-IB*2.0*687 - GETFLAGS is rewritten to incorporate IIU and improve readability.
 ;   This function is only called by CUR^IBCNERP8; it is called by IBCNERPC but not used.
GETFLAGS(PIEN,APPIEN,PDATA,BDT,EDT,APP,RPTDATA) ;
 ; PIEN - Payer ien in file 365.12
 ; APPIEN - Application ien in subfile 365.121
 ; PDATA - 0 node of Payer file entry
 ; BDT - Start date/time
 ; EDT - End date/time
 ; APP - Payer Application EIV or IIU
 ; RPTDATA - output array, passed by reference
 ; 
 N FLAGS,IEN,PNAME,TYP,TM,VAL,Z
 S PNAME=$P(PDATA,U)
 I '$D(APP) S APP=0 ;to prevent error when called from IBCNERPC
 ; TYP=2 Nationally Enabled Log / TYP=3 Auto-Update Log
 F TYP=2,3 D
 . S TM=EDT,Z=0 F  S TM=$O(^IBE(365.12,PIEN,1,APPIEN,TYP,"B",TM),-1) Q:TM=""!($$FMDIFF^XLFDT(TM,BDT,2)'>0)  D
 . . S IEN=$O(^IBE(365.12,PIEN,1,APPIEN,TYP,"B",TM,""))
 . . S VAL=$$EXTERNAL^DILFD("365.121"_TYP,.02,,$P(^IBE(365.12,PIEN,1,APPIEN,TYP,IEN,0),U,2))
 . . S Z=Z+1
 . . S RPTDATA("FLAGS",APP,$S(TYP=2:"NE",1:"AU"),PNAME,Z)=$$FMTE^XLFDT(TM,"5ZS")_"^"_VAL
 . . Q
 Q
 ;
PYR(RTN,BDT,EDT,TOT) ; Determine Incoming Data
 ; Input params: RTN-routine name for ^TMP($J), BDT-start dt/time,
 ;  EDT-end dt/time, **TOT-total records searched - used only for status
 ;  checks when the process is queued (passed by reference)
 ; Output vars: Set ^TMP($J,RTN,"PYR",APP,PAYER NAME,IEN of file 365.12)=""  ;IB*2.0*687
 ;
 ;  /ckb-IB*2*687  Added APP to incorporate IIU into this report. Moved from IBCNERP0.
 ;IB*737/TAZ - Removed reference to Most Popular Payer and "~NO PAYER"
 ;
 ;N PIEN,PYR,CREATEDT,APPIEN,APPDATA
 N PIEN,PYR,CREATEDT,APP,APPIEN,APPDATA
 S PIEN=0 F  S PIEN=$O(^IBE(365.12,PIEN)) Q:'PIEN  D
 . S PYR=$P($G(^IBE(365.12,PIEN,0)),U)
 . S TOT=TOT+1
 . F APP="EIV","IIU" D
 . . S APPIEN=+$$PYRAPP^IBCNEUT5(APP,+PIEN)  ; Get the ien of the application
 . . I 'APPIEN Q  ; No application for this Payer.
 . . ; Get the Date/Time Created from the Application
 . . S CREATEDT=$P($G(^IBE(365.12,PIEN,1,APPIEN,0)),U,13)
 . . I CREATEDT=""!(CREATEDT<BDT)!(CREATEDT>EDT) Q
 . . ;
 . . ; Get Payer app multiple IEN
 . . ;IB*668/TAZ - Changed Payer Application from IIV to EIV
 . . ;S APPIEN=$$PYRAPP^IBCNEUT5("EIV",PIEN)
 . . ; Must have eIV application
 . . ;I 'APPIEN Q
 . . ;IB*687 -remove Nationally Active check
 . . ;S APPDATA=$G(^IBE(365.12,PIEN,1,APPIEN,0))
 . . ; Must be Nationally Active
 . . ;I '$P(APPDATA,U,2) Q
 . . ;
 . . S ^TMP($J,RTN,"PYR",APP,PYR,PIEN)=""
 . . Q
 Q
