IBCNERP0 ;DAOU/BHS - IBCNE eIV STATISTICAL REPORT (cont'd) ;11-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,271,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; eIV - Insurance Verification Interface
 ;
 ; PYR tag called by IBCNERP8
 ;
 ; Cannot be called from top of routine
 Q
 ;
PYR(RTN,BDT,EDT,TOT) ; Determine Incoming Data
 ; Input params: RTN-routine name for ^TMP($J), BDT-start dt/time,
 ;  EDT-end dt/time, **TOT-total records searched - used only for status
 ;  checks when the process is queued (passed by reference)
 ; Output vars: Set ^TMP($J,RTN,"PYR",PAYER NAME,IEN of file 365.12)=""
 N PIEN,PYR,CREATEDT,APPIEN,APPDATA
 ;S BDT=$P(BDT,"."),EDT=$P(EDT,".")
 S PIEN=0 F  S PIEN=$O(^IBE(365.12,PIEN)) Q:'PIEN  D
 . S TOT=TOT+1
 . S CREATEDT=$P($G(^IBE(365.12,PIEN,0)),U,4)
 . I CREATEDT=""!(CREATEDT<BDT)!(CREATEDT>EDT) Q
 . S PYR=$P($G(^IBE(365.12,PIEN,0)),U)
 . Q:PYR="~NO PAYER"       ; used internally only - not a real eIV payer
 . ;
 . ; Get Payer app multiple IEN
 . S APPIEN=$$PYRAPP^IBCNEUT5("IIV",PIEN)
 . ; Must have eIV application
 . I 'APPIEN Q
 . S APPDATA=$G(^IBE(365.12,PIEN,1,APPIEN,0))
 . ; Must be Nationally Active
 . I '$P(APPDATA,U,2) Q
 . ;
 . S ^TMP($J,RTN,"PYR",PYR,PIEN)=""
 Q
 ;
HEADER(HDRDATA,PGC,PXT,MAX,CRT,SITE,DTMRNG,MM) ; Print header info for each pg
 ; Init vars
 N CT,HDRCT,LIN,HDR
 ;
 ; Prompt to print next page for reports to the screen
 I CRT,PGC>0,'$D(ZTQUEUED) D  I PXT G HEADERX
 . I MAX<51 F LIN=1:1:(MAX-$Y) W !
 . S DIR(0)="E" D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT) S PXT=1 Q
 I $D(ZTQUEUED),$$S^%ZTLOAD() S ZTSTOP=1 G HEADERX
 ;
 ; Update page ct
 S PGC=PGC+1
 ;
 ; Update header based on MailMan message flag
 S HDRCT=0
 S HDRCT=HDRCT+1,HDRDATA(HDRCT)="eIV Statistical Report"_$$FO^IBCNEUT1($$FMTE^XLFDT($$NOW^XLFDT,1)_"  Page: "_PGC,56,"R")
 ;S HDRDATA(HDRCT)=$$FO^IBCNEUT1(SITE,(80-$L(SITE)\2)+$L(SITE),"R"),HDRCT=HDRCT+1
 S HDR="Report Timeframe:"
 S HDRCT=HDRCT+1,HDRDATA(HDRCT)=$$FO^IBCNEUT1(HDR,80-$L(HDR)\2+$L(HDR),"R")
 S HDRCT=HDRCT+1,HDRDATA(HDRCT)=$$FO^IBCNEUT1(DTMRNG,(80-$L(DTMRNG)\2)+$L(DTMRNG),"R")
 ;
 I MM S HDRCT=HDRCT+1,HDRDATA(HDRCT)=""
 ; Only write out Header for non-MailMan message output
 I MM="" W @IOF F CT=1:1:HDRCT W !,?1,HDRDATA(CT)
 ;
HEADERX ; HEADER exit pt
 Q
 ;
