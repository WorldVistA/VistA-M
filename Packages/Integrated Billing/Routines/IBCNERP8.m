IBCNERP8 ;DAOU/BHS - IBCNE eIV STATISTICAL REPORT COMPILE ;11-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,271,345,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
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
 ;  ToteIVPyrsDisabldLocally^TotInsBufVerified^TotalManVerified...
 ;  TotaleIVVerified^TotInsBufUnverified^! InsBufSubtotal^...
 ;  ? InsBufSubtotal^- InsBufSubtotal^Other InsBufSubtotal
 ; 1 OR contains 4 -->
 ; ^TMP($J,RTN,"PYR",PAYER,IEN)=""  (list of new payers)
 ;
 ; Must call at EN
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
 I IBSCT=1!$F(IBSCT,",4,") D CUR(IBCNERTN,IBBDT,IBEDT,.IBTOT),PYR^IBCNERP0(IBCNERTN,IBBDT,IBEDT,.IBTOT)
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
 . . . . S IBTYP=5,TRANSIEN=$P($G(^IBCN(365,IBPTR,0)),U,5)
 . . . . I TRANSIEN'="" S IBTYP=$P($G(^IBCN(365.1,TRANSIEN,0)),U,10) I IBTYP'="" S:+IBTYP<4 $P(RPTDATA,U,IBTYP+1)=$P($G(RPTDATA),U,IBTYP+1)+1
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
 . . S IBTYP=$P($G(^IBCN(365.1,TQIEN,0)),U,10)
 . . I IBTYP'="" S:IBTYP<4 $P(RPTDATA,U,IBTYP+1)=$P($G(RPTDATA),U,IBTYP+1)+1
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
 ;  5=Payers w/eIV disabled locally
 ;  6=total user action required (symbol'='*' or '#' or '!' or '?' or '-')
 ;  7=total Man. Ver'd Ins Buf entries (symbol='*')
 ;  8=total eIV Processed Ver. (symbol='+')
 ;  9=total awaiting processing (symbol='?' or BLANK)
 ;  10=total Ins Buf entries w/symbol='#'
 ;  11=total Ins Buf entries w/symbol='!'
 ;  12=total Ins Buf entries w/symbol='?'
 ;  13=total Ins Buf entries w/symbol='-'
 ;  14=total Ins Buffer entries w/symbol not in ('*','#','!','?','-')
 ;  
 ;  ^TMP($J,RTN,"CUR","FLAGS","A",Payer name,N) = active flag timestamp ^ active flag setting
 ;  ^TMP($J,RTN,"CUR","FLAGS","T",Payer name,N) = trusted flag timestamp ^ trusted flag setting
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
 S ICIEN=0
 F  S ICIEN=$O(^DIC(36,ICIEN)) Q:'ICIEN  D  Q:$G(ZTSTOP)
 .  S TOT=TOT+1
 .  I $D(ZTQUEUED),TOT#100=0,$$S^%ZTLOAD() S ZTSTOP=1 QUIT
 .  ; Exclude inactive
 .  S TMP=$$ACTIVE^IBCNEUT4(ICIEN) I 'TMP Q
 .  ; Exclude Medicaid, etc.
 .  I $$EXCLUDE^IBCNEUT4($P(TMP,U,2)) Q
 .  ; Determine assoc Payer
 .  S PIEN=$P($G(^DIC(36,ICIEN,3)),U,10)
 .  ; Missing payer link
 .  I 'PIEN S $P(RPTDATA,U,4)=$P(RPTDATA,U,4)+1 Q
 .  ; Does a VA NATIONAL ID exist?
 .  I $P($G(^IBE(365.12,PIEN,0)),U,2)'="" Q
 .  S $P(RPTDATA,U,4)=$P(RPTDATA,U,4)+1
 ;
 I $G(ZTSTOP) G CURX
 ;
 ; eIV Payers disabled locally
 S PIEN=0
 F  S PIEN=$O(^IBE(365.12,PIEN)) Q:'PIEN  D  Q:$G(ZTSTOP)
 .  S TOT=TOT+1
 .  I $D(ZTQUEUED),TOT#100=0,$$S^%ZTLOAD() S ZTSTOP=1 Q
 .  S PDATA=$G(^IBE(365.12,PIEN,0))
 .  ; Must have National ID
 .  I $P(PDATA,U,2)="" Q
 .  ; Get Payer app multiple IEN
 .  S APPIEN=$$PYRAPP^IBCNEUT5("IIV",PIEN)
 .  ; Must have eIV application
 .  I 'APPIEN Q
 .  ; Get Active/Trusted flag logs
 .  D GETFLAGS(PIEN,APPIEN,PDATA,BDT,EDT,.RPTDATA)
 .  ;
 .  S APPDATA=$G(^IBE(365.12,PIEN,1,APPIEN,0))
 .  ; Must be Nationally Active
 .  I '$P(APPDATA,U,2) Q
 .  ; Must not be Locally Active
 .  I $P(APPDATA,U,3) Q
 .  S $P(RPTDATA,U,5)=$P(RPTDATA,U,5)+1
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
 . . ; ('*') = Man. Verified,  ('#','!','-','?',blank/null) = eIV Processing
 . . ; ('+') = eIV Processed
 . . S PIECE=$S(IBSYMBOL="*":7,IBSYMBOL="+":8,IBSYMBOL="#":10,IBSYMBOL="!":11,IBSYMBOL="-":13,IBSYMBOL="?":12,1:14)
 . . I PIECE=12!(PIECE=14) S $P(RPTDATA,U,9)=$P($G(RPTDATA),U,9)+1
 . . E  S $P(RPTDATA,U,6)=$P($G(RPTDATA),U,6)+1
 . . S $P(RPTDATA,U,PIECE)=$P($G(RPTDATA),U,PIECE)+1
 ;
 I $G(ZTSTOP) G CURX
 ;
 ; Save data to global
 M ^TMP($J,RTN,"CUR")=RPTDATA
 ;
CURX ; CUR exit point
 Q
 ;
GETFLAGS(PIEN,APPIEN,PDATA,BDT,EDT,RPTDATA) ; get Active/Trusted flag logs
 ; PIEN - Payer ien in file 365.12
 ; APPIEN - Application ien in subfile 365.121
 ; PDATA - 0 node of Payer file entry
 ; BDT - Start date/time
 ; EDT - End date/time
 ; RPTDATA - output array, passed by reference
 ; 
 N FLAGS,IEN,PNAME,TYP,TM,VAL,Z
 S PNAME=$P(PDATA,U)
 F TYP=2,3 S TM=EDT,Z=0 F  S TM=$O(^IBE(365.12,PIEN,1,APPIEN,TYP,"B",TM),-1) Q:TM=""!($$FMDIFF^XLFDT(TM,BDT,2)'>0)  D
 .S IEN=$O(^IBE(365.12,PIEN,1,APPIEN,TYP,"B",TM,""))
 .S VAL=$$EXTERNAL^DILFD("365.121"_TYP,.02,,$P(^IBE(365.12,PIEN,1,APPIEN,TYP,IEN,0),U,2))
 .S Z=Z+1,RPTDATA("FLAGS",$S(TYP=2:"A",1:"T"),PNAME,Z)=$$FMTE^XLFDT(TM,"5ZS")_"^"_VAL
 .Q
 Q
