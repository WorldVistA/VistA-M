RCDPPLB ;ALB/TJB - ERA/PROVIDER LEVEL ADJUSTMENTS REPORT ;1/02/15 10:00am
 ;;4.5;Accounts Receivable;**303**;Mar 20, 1995;Build 84
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ; PRCA*4.5*303 - ERA/PROVIDER LEVEL ADJUSTMENTS REPORT 
 ;
 ; DESCRIPTION : The following generates a report to display ERA data with PLB
 ;     data details. The report is ad-hoc and allow the user to extract report
 ;     data, as well as view and manage refund requests for all PLB adjustment
 ;     codes (FB, WO, 72, IR, J1, L6, CS, WU, etc.):
 ;
EN ; Entry point for Report
 N DUOUT,DTOUT,DIR,DTOK,R,X,Y,Z,I,JJ,KK,DL,DX0,CD,CZ,EXLN,IX,RCDT1,RCDT2,RCDET,RCEXCEL,ZTRTN,ZTSK,ZTDESC,ZTSAVE,ZTSTOP,%ZIS,POP,ZPY,PY,PCT,ZPPY
 N RCJOB,RCCD,RCRD,RCNOW,RCODE,RCDET,RCLPAY,RCPAY,RCTIN,RCSORT,RCSTAT,RCTIN,RCTLIST,RCPG,RCHR,RCDISP,IDX,TY,FILE,IEN,ZN,RCQUIT,RCDONE,XCNT,DIVHDR,CRHDR,RCDONE
 S RCQUIT=0,RCODE="" ; Global variable to signal exit
 ;
 ; ICR 1077 - Get division/station
 D DIVISION^VAUTOMA
 I 'VAUTD&($D(VAUTD)'=11) G PLBQ
 S DIR("A")="(S)ummary or(D)etail Report format? ",DIR(0)="SA^S:Summary Information only;D:Detail and Totals"
 S DIR("B")="SUMMARY" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") G PLBQ
 S RCDET=(Y="D")
 ;
 ; Get PLB Codes for report
 D PLBC(.RCODE) G:$G(RCODE)']"" PLBQ
 ; Payer Names from 344.6
 S RCDONE=$$GETPAY^RCDPRU(.RCPAY) G:RCDONE=0 PLBQ
 S:$G(RCPAY("DATA"))'="" RCPAY=$G(RCPAY("DATA"))
 ;
 S RCDONE=$$GETTIN^RCDPRU(.RCTIN) G:RCDONE=0 PLBQ
 S:$G(RCTIN("DATA"))'="" RCTIN=$G(RCTIN("DATA"))
 ;
 S DIR("A")="Sort Report (C)odes or (P)ayer?: ",DIR(0)="SA^C:PLB Codes;P:Payer Name;CODES:PLB Codes"
 S DIR("B")="CODES" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") G PLBQ
 S RCSORT=$E(Y,1)
 ;
 S DIR("?")="Enter the Beginning date for the report"
 S DIR(0)="DAO^:"_DT_":APE",DIR("A")="Start Date: ",DIR("B")="T" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") G PLBQ
 S RCDT1=Y
 S DIR("?")="Enter the end date for the report"
 S DIR("B")="T"
 S DIR(0)="DAO^"_RCDT1_":"_DT_":APE",DIR("A")="End Date: " D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") G PLBQ
 S RCDT2=Y
 S DTOK=$$CHECKDT^RCDPRU(RCDT1,RCDT2,344.4)
 I 'DTOK W !!,"*** Note: Date Range "_$$DATE^RCDPRU(RCDT1)_" - "_$$DATE^RCDPRU(RCDT2)," ***",! W "*** No Records found ***",! D ASK^RCDPRU(.RCQUIT) G PLBQ
 ; Removed Excel per Susan on 03/24/2015 meeting
 ; Get input to export to excel.
 S RCEXCEL=""
 ;S RCEXCEL=$$DISPTY^RCDPRU()
 ;D:RCEXCEL INFO^RCDPRU
 ;
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . S ZTRTN="ENQ^RCDPARC",ZTDESC="AR - 835 Provider Adjustment & Payer Data Report",ZTSAVE("*")=""
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Your task number"_ZTSK_" has been queued.",1:"Unable to queue this job.")
 . K ZTSK,IO("Q") D HOME^%ZIS
 U IO
 ;
ENQ ; Start here for queued report
 S RCNOW=$$NOW^RCDPRU(),RCPG=0,$P(RCHR,"=",IOM)=""
 ;
 K ^TMP("RCDPPLB_REPORT",$J)
 ; Collect the data and put it into the ^TMP global
 D GETDATA($G(RCODE),.RCPAY,.RCTIN,$G(RCSORT),RCDT1,RCDT2,$NA(^TMP("RCDPPLB_REPORT",$J)),.VAUTD)
 ;
REPORT ; Print out the report
 ; Set up Division Header Text and PLB Code Header Text
 S RCSL=0
 S:VAUTD=1 DIVHDR="ALL" D:VAUTD=0
 . N I S DIVHDR="",I="" F  S I=$O(VAUTD(I)) Q:I=""  S:DIVHDR'="" DIVHDR=DIVHDR_", "_VAUTD(I) S:DIVHDR="" DIVHDR=VAUTD(I)
 S CRHDR=RCODE
 ; Trim information so it will fit on an 80 or IOM character line
 D:($L(DIVHDR)+$L(CRHDR))>(IOM-25)
 . N VAL,DH,CH,R1,R2 S DH=0,CH=0,R1=0,R2=0,VAL=(IOM-25)\2 ; get half of the screen length
 . S:$L(DIVHDR)>VAL DH=1 S:$L(CRHDR)>VAL CH=1 S:DH=0 R1=VAL-$L(DIVHDR) S:CH=0 R2=VAL-$L(CRHDR)
 . I $L(DIVHDR)>(VAL+R2) S DIVHDR=$E(DIVHDR,1,(VAL+R2))_"..."
 . I $L(CRHDR)>(VAL+R1) S CRHDR=$E(CRHDR,1,(VAL+R2))_"..."
 ;
 I 'RCEXCEL D
 . S RCPG=RCPG+1 W @IOF
 . D HDRP($$HDR(RCDET),1,"Page: "_RCPG_" ")
 . D HDRP("SORT by "_$S($E(RCSORT,1)="C":"PLB CODES",1:"PAYER NAMES")_"  REPORT RUN DATE: "_RCNOW,1)
 . D HDRP("DIVISION: "_DIVHDR_" Codes: "_CRHDR,1)
 . D HDRP("835 PAYERS: "_$S(RCPAY="ALL":"ALL",1:"Selected")_" 835 PAYER TINs: "_$S($E(RCTIN)="A":"ALL",1:"Selected"),1)
 . D HDRP("EOB PAID DATE RANGE: "_$$DATE^RCDPRU(RCDT1)_" - "_$$DATE^RCDPRU(RCDT2),1)
 . W !,RCHR,!
 E  D
 . ; Excel Report
 . W "CODE^PAYER^TIN^REP_DATE^AMOUNT",!
 ;
 S $P(ZLN,"-",80)="",$P(ZDLN,"=",80)="",$P(ZLN2,"-",78)="",ZLN2="  "_ZLN2,RCSL=7
 ; Do Grand totals first - per Susan 7/16/2015
 S DX0=$G(^TMP("RCDPPLB_REPORT",$J,"TOTALS")),PCT=0
 S:+$P(DX0,U,5)'=0 PCT=$J(($P(DX0,U,1)/$P(DX0,U,5))*100,3,0)
 S:+$P(DX0,U,5)=0 PCT="ERR"
 I RCSL>=(IOSL-4) S RCQUIT=$$NEWPG(.RCPG,1,.RCSL,RCSORT) Q:RCQUIT
 W ! S RCSL=RCSL+1
 W "GRAND TOTALS FOR ALL PLB CODES & PAYERS ON REPORT",! S RCSL=RCSL+1
 W "   TOTAL #ERAs:  ",$J($P(DX0,U,3),6,0),"  ADJ: ",PCT,"% [TOT AMT ADJUSTED / TOT AMT BILLED]",! S RCSL=RCSL+1
 W "   AMT ADJUST: $",$J($P(DX0,U,1),11,2),"  AMT BILLED: $",$J($P(DX0,U,5),11,2),"  AMT PAID: $",$J($P(DX0,U,2),11,2),! S RCSL=RCSL+1
 W !,ZDLN,!! S RCSL=RCSL+1
 I RCSL>=(IOSL-2) S RCQUIT=$$NEWPG(.RCPG,0,.RCSL,RCSORT) G:RCQUIT PLBQ
 ;
 S ZZ="" F  S ZZ=$O(^TMP("RCDPPLB_REPORT",$J,"SUMMARY",ZZ)) Q:ZZ=""  S ZDAT=^TMP("RCDPPLB_REPORT",$J,"SUMMARY",ZZ) D  Q:RCQUIT
 . D:RCSORT="C"  Q:RCQUIT
 .. W "ADJ CODE: ",ZZ,"  # ERAs: ",$J($P(ZDAT,U,3),5),"  ADJ: ",$S(+$P(ZDAT,U,5)>0:$J((($P(ZDAT,U,1)/$P(ZDAT,U,5))*100),3,0),1:"ERR"),"% [TOT AMT ADJUSTED / TOT AMT BILLED]",! S RCSL=RCSL+1
 .. I RCSL>=(IOSL-2) S RCQUIT=$$NEWPG(.RCPG,0,.RCSL,RCSORT) Q:RCQUIT
 .. W "   AMT ADJUST: ",$J($P(ZDAT,U,1),8,2),"  AMT BILLED: ",$J($P(ZDAT,U,5),9,2),"  AMT PAID: ",$J($P(ZDAT,U,2),9,2),! S RCSL=RCSL+1
 .. I RCSL>=(IOSL-2) S RCQUIT=$$NEWPG(.RCPG,0,.RCSL,RCSORT) Q:RCQUIT
 .. W "ADJ CODE TEXT: ",$P(ZDAT,U,4),! S RCSL=RCSL+1
 .. I RCSL>=(IOSL-2) S RCQUIT=$$NEWPG(.RCPG,0,.RCSL,RCSORT) Q:RCQUIT
 .. W ZLN,! S RCSL=RCSL+1
 .. I RCSL>=(IOSL-2) S RCQUIT=$$NEWPG(.RCPG,0,.RCSL,RCSORT) Q:RCQUIT
 .. S PY="",CZ=0 F  S PY=$O(^TMP("RCDPPLB_REPORT",$J,"SUMMARY",ZZ,PY)) Q:PY=""  S ZPY=^TMP("RCDPPLB_REPORT",$J,"SUMMARY",ZZ,PY) D  Q:RCQUIT  S CZ=CZ+1
 ... S:+($P(ZPY,U,5))'=0 ZPPY=$J((($P(ZPY,U,1)/$P(ZPY,U,5))*100),3,0)
 ... S:+($P(ZPY,U,5))=0 ZPPY="ERR"
 ... I CZ>0 W ZLN2,! S RCSL=RCSL+1
 ... W "  PAYER NAME/TIN: ",PY,! S RCSL=RCSL+1
 ... I RCSL>=(IOSL-2) S RCQUIT=$$NEWPG(.RCPG,0,.RCSL,RCSORT) Q:RCQUIT
 ... W "  #ERAs: ",$J($P(ZPY,U,3),4),"  ADJ: ",ZPPY,"% [ADJ: ",$J($P(ZPY,U,1),8,2),"/ BILLED: ",$J($P(ZPY,U,5),9,2),"] PAID: ",$J($P(ZPY,U,2),9,2),! S RCSL=RCSL+1
 ... D:RCDET DETAIL(RCSORT,ZZ,PY,$NA(^TMP("RCDPPLB_REPORT",$J))) Q:RCQUIT
 .. W:'RCQUIT ZLN,! S RCSL=RCSL+1
 . D:RCSORT="P"  Q:RCQUIT
 .. W "PAYER NAME/TIN: ",ZZ,! S RCSL=RCSL+1
 .. I RCSL>=(IOSL-2) S RCQUIT=$$NEWPG(.RCPG,0,.RCSL,RCSORT) Q:RCQUIT
 .. W "# ERAs:",$J($P(ZDAT,U,3),5),"  ADJ: ",$S(+$P(ZDAT,U,5)>0:$J((($P(ZDAT,U,1)/$P(ZDAT,U,5))*100),3,0),1:"ERR"),"% [AMT ADJ:",$J($P(ZDAT,U,1),8,2),"/ BILLED:",$J($P(ZDAT,U,5),9,2),"] PAID:",$J($P(ZDAT,U,2),9,2),! S RCSL=RCSL+1
 .. I RCSL>=(IOSL-2) S RCQUIT=$$NEWPG(.RCPG,0,.RCSL,RCSORT) Q:RCQUIT
 .. W ZLN,! S RCSL=RCSL+1
 .. I RCSL>=(IOSL-2) S RCQUIT=$$NEWPG(.RCPG,0,.RCSL,RCSORT) Q:RCQUIT
 .. S PY="",CZ=0 F  S PY=$O(^TMP("RCDPPLB_REPORT",$J,"SUMMARY",ZZ,PY)) Q:PY=""  S ZPY=^TMP("RCDPPLB_REPORT",$J,"SUMMARY",ZZ,PY) D  Q:RCQUIT  S CZ=CZ+1
 ... S ZPPY=$S(+$P(ZPY,U,5)'=0:$J((($P(ZPY,U,1)/$P(ZPY,U,5))*100),3,0),1:"ERR")
 ... I CZ>0 W ZLN2,! S RCSL=RCSL+1
 ... W "  ADJ CODE: ",PY,"  ADJ CODE TXT: ",$P(ZPY,U,4),! S RCSL=RCSL+1
 ... I RCSL>=(IOSL-2) S RCQUIT=$$NEWPG(.RCPG,0,.RCSL,RCSORT) Q:RCQUIT
 ... W "  #ERAs: ",$J($P(ZPY,U,3),4),"  ADJ: ",ZPPY,"% [ADJ: ",$J($P(ZPY,U,1),8,2),"/ BILLED: ",$J($P(ZPY,U,5),9,2),"] PAID: ",$J($P(ZPY,U,2),9,2),! S RCSL=RCSL+1
 ... D:RCDET DETAIL(RCSORT,ZZ,PY,$NA(^TMP("RCDPPLB_REPORT",$J))) Q:RCQUIT
 .. I 'RCQUIT W ZLN,! S RCSL=RCSL+1
 D:'RCQUIT ASK^RCDPRU(.RCQUIT)
PLBQ ;
 K RCQUIT,VAUTD,ZDAT,ZLN,ZDLN,ZLN2
 K ^TMP("RCDPPLB_REPORT",$J)
 Q
 ;
 ; SORT = by CODES or Payer; CAT = CODE or Payer/TIN to lookup
 ; DET = Second subscipt either Payer/TIN if Sort="C" or PLB Code if Sort="P"; ZGBL = Global to use through indirection
DETAIL(SORT,CAT,DET,ZGBL) ; Detail Report
 N ZLN1,ZFS,ZZ,ZDET,ZDZN,ZPCT,ZADJ,ZBIL,ZPD S $P(ZLN1,"-",77)="-",ZLN1="  "_ZLN1
 S ZFS=$S(SORT="C":"ERA",1:"PAYR")
 W ZLN1,! S RCSL=RCSL+1
 I RCSL>=(IOSL-2) S RCQUIT=$$NEWPG(.RCPG,0,.RCSL,RCSORT) Q:RCQUIT
 W "  #ERA        DATE     %ADJ    ADJUST       BILLED       PAID      CHECK#",! S RCSL=RCSL+1
 I RCSL>=(IOSL-2) S RCQUIT=$$NEWPG(.RCPG,0,.RCSL,RCSORT) Q:RCQUIT
 W "     TRACE#",! S RCSL=RCSL+1
 I RCSL>=(IOSL-2) S RCQUIT=$$NEWPG(.RCPG,0,.RCSL,RCSORT) Q:RCQUIT
 ;W "       COMMENTS ",! S RCSL=RCSL+1
 W "     REFERENCE#",! S RCSL=RCSL+1
 I RCSL>=(IOSL-2) S RCQUIT=$$NEWPG(.RCPG,0,.RCSL,RCSORT) Q:RCQUIT
 S ZZ="" F  S ZZ=$O(@ZGBL@(ZFS,CAT,ZZ)) Q:ZZ=""  S ZDZN=@ZGBL@(ZFS,CAT,ZZ,0) D  Q:RCQUIT
 . S ZDET=$$GETDT(SORT,CAT,DET,ZDZN,ZGBL)
 . Q:ZDET'=DET  ; If this isn't the same then skip
 . S ZADJ=$$DAMT("A",$S(SORT="C":CAT,1:DET),$P(ZDZN,U,1),ZFS,ZGBL),ZBIL=$$DAMT("B",CAT,$P(ZDZN,U,1),ZFS,ZGBL),ZPD=$$DAMT("P",CAT,$P(ZDZN,U,1),ZFS,ZGBL)
 . S ZPCT=$S(ZBIL'=0:$J(((ZADJ/ZBIL)*100),3,0),1:"ERR")
 . W $J($P(ZDZN,U,1),9),?12,$$DATE^RCDPRU($P(ZDZN,U,4)),?23,$J(ZPCT,3,0),?29,$J(ZADJ,9,2),?42,$J(ZBIL,9,2),?54,$J(ZPD,9,2),?68,$P(ZDZN,U,13),! S RCSL=RCSL+1
 . I RCSL>=(IOSL-2) S RCQUIT=$$NEWPG(.RCPG,0,.RCSL,RCSORT) Q:RCQUIT
 . W ?9,$P(ZDZN,U,2),! S RCSL=RCSL+1 ; Trace
 . I RCSL>=(IOSL-2) S RCQUIT=$$NEWPG(.RCPG,0,.RCSL,RCSORT) Q:RCQUIT
 . W ?9,$$DTCM(CAT,$P(ZDZN,U,1),ZFS,ZGBL),! S RCSL=RCSL+1 ; Reference #
 Q:RCQUIT
 I RCSL>=(IOSL-2) S RCQUIT=$$NEWPG(.RCPG,0,.RCSL,RCSORT) Q:RCQUIT
 ;W ZLN1,! S RCSL=RCSL+1
 Q
 ;
GETDT(SORT,CAT,DT,ZND,ZGBL) ; Get detail information for this entry
 N MYDT,MM
 S MYDT=""
 I SORT="C" Q $P(ZND,U,6)_"/"_$P(ZND,U,3)
 ; Otherwise we have a payer sort and need to do more work
 S MM=0.11 F  S MM=$O(@ZGBL@("00_ERA",$P(ZND,U,1),MM)) Q:MM=""  I $P(@ZGBL@("00_ERA",$P(ZND,U,1),MM),U,1)=DT S MYDT=$P(@ZGBL@("00_ERA",$P(ZND,U,1),MM),U,1) Q
 Q MYDT
 ;
 ; Get the type of amount from the ^TMP global
DAMT(TYPE,FIRST,ZIEN,XFS,XGBL) ; Get amounts
 N ZAMT,XDN S ZAMT=0
 ; Adjustment amount
 I TYPE="A" D  Q ZAMT
 . S AA=0.1 F  S AA=$O(@XGBL@("00_ERA",ZIEN,AA)) Q:AA=""  D
 .. Q:$P(@XGBL@("00_ERA",ZIEN,AA),U,1)'=FIRST  ; Not the correct record
 .. ; Otherwise we have the right record get the adjustment amount
 .. S ZAMT=ZAMT+$P(@XGBL@("00_ERA",ZIEN,AA),U,2)
 ; Total billed on ERA
 I TYPE="B" Q @XGBL@("00_ERA",ZIEN,0.1)
 ; Paid Amount
 I TYPE="P" Q $P(@XGBL@("00_ERA",ZIEN,0),U,5)
 Q ZAMT
 ;
DTCM(FIRST,ZIEN,XFS,XGBL) ; Get comment or reference number
 N AA,XDN,ZCM
 S XDN=0,ZCM=""
 D
 . S AA=0.1 F  S AA=$O(@XGBL@("00_ERA",ZIEN,AA)) Q:AA=""!(XDN=1)  D
 .. Q:$P(@XGBL@("00_ERA",ZIEN,AA),U,1)'=FIRST  ; Not the correct record
 .. ; Otherwise we have the right record get the adjustment amount
 .. S ZCM=$P(@XGBL@("00_ERA",ZIEN,AA),U,3),XDN=1
 Q ZCM
 ;
HDR(CD) ; Report header
 Q:CD "EDI LOCKBOX 835 PROVIDER LEVEL ADJUSTMENT (PLB) REPORT - DETAIL"
 Q "EDI LOCKBOX 835 PROVIDER LEVEL ADJUSTMENT (PLB) REPORT - SUMMARY"
 ;
HDRP(Z,X,Z1) ; Print Header (Z=String, X=1 (line feed) X=0 (no LF), Z1 (page number right justified)
 N LGT S LGT=$L(Z)+$L($G(Z1))
 I $G(X)=1 W !
 W ?(IOM-LGT\2),Z W:$G(Z1)]"" ?(IOM-$L(Z1)),Z1
 Q
 ;
NEWPG(RCPG,RCNEW,RCSL,CD) ; Check for new page needed, output header
 ; RCPG = Page number passwd by referece
 ; RCNEW = 1 to force new page
 ; RCSL = page length passed by reference
 ; Function returns 1 if user chooses to stop output
 N ZSTOP S ZSTOP=0
 I RCNEW!'RCPG!(($Y+5)>IOSL) D
 . D:RCPG ASK^RCDPRU(.ZSTOP) Q:ZSTOP
 . S RCPG=RCPG+1 W @IOF
 . D HDRP($$HDR(RCDET),1,"Page: "_RCPG)
 . D HDRP("SORT by "_$S($E(CD,1)="C":"PLB CODES",1:"PAYER NAMES")_"  REPORT RUN DATE: "_RCNOW,1)
 . D HDRP("DIVISION: "_DIVHDR_" Codes: "_CRHDR,1)
 . D HDRP("835 PAYERS: "_$S(RCPAY="ALL":"ALL",1:"Selected")_" 835 PAYER TINs: "_$S(RCTIN="A":"ALL",1:"Selected"),1)
 . D HDRP("Date Range: "_$$DATE^RCDPRU(RCDT1)_" - "_$$DATE^RCDPRU(RCDT2),1)
 . W !,RCHR,! S RCSL=7
 Q ZSTOP
 ;
 ; Get data for report and apply filters if necessary
GETDATA(GPLB,GPAYER,GTIN,GSORT,GSTART,GSTOP,GARRAY,GDIV) ;
 N SDT,IEN,CD,CNT,IX,ZX,XY,RM,PARR,PNARR,PTARR,RCSET,GLINE,ZN,ZED,ZEN,ZPAY,ZTIN,ZDESC,ZZ,RCERR,RCGX,RCEB,EOBTOT,STA,STNUM,STNAM,ZLVL
 S SDT=$O(^RCY(344.4,"AC",GSTART),-1)
 S ZLVL=$S(GSORT="C":"ERA",1:"PAYR")
 ; Set up arrays for filtering on PLB, PAYER name and Payer TINs
 D RNG^RCDPRU("PLB",.GPLB,.PARR),RNG^RCDPRU("PAYER",GPAYER,.PARR),RNG^RCDPRU("TIN",GTIN,.PARR)
 ;Get possible ERAs to work on from ^RCY(344.4,"AC") index
 F  S SDT=$O(^RCY(344.4,"AC",SDT)) Q:SDT=""!(SDT>GSTOP)  D
 . S IEN="" F  S IEN=$O(^RCY(344.4,"AC",SDT,IEN)) Q:IEN=""  S ZN=^RCY(344.4,IEN,0) D
 .. I GDIV=0 D ERASTA^RCDPEM4(IEN,.STA,.STNUM,.STNAM) Q:'$D(GDIV(STA))  ; If not the right Division/station then get next ERA
 .. K RCGX D GETS^DIQ(344.4,IEN_",","2*;","E","RCGX") Q:$D(RCGX)=0  ; Quit if no PLBs on this ERA
 .. S ZTIN=$$GET1^DIQ(344.4,IEN_",",.03,"E"),ZPAY=$$GET1^DIQ(344.4,IEN_",",.06,"E")
 .. Q:'$$CHECK("TIN",ZTIN,.PARR)  Q:'$$CHECK("PAYER",ZPAY,.PARR)  ; Quit if not including this tin or payer
 .. ; Billed amount on the EOBs, Get EOB Details
 .. K RCEB D GETS^DIQ(344.4,IEN_",","1*;","I","RCEB")
 .. ; Walk EOB Details and get the total amount billed
 .. S EOBTOT=0
 .. I $D(RCEB)>9 S XY="" F  S XY=$O(RCEB(344.41,XY)) Q:XY=""  S EOBTOT=EOBTOT+$$GET1^DIQ(361.1,RCEB(344.41,XY,.02,"I")_",","2.04","E")
 .. ; Get list of PLB Codes for this ERA
 .. S IX="" K CD F ZZ=1:1 S IX=$O(RCGX(344.42,IX)) Q:IX=""  D
 ... I '$$CHECK("PLB",RCGX(344.42,IX,.02,"E"),.PARR) Q  ; If plb not included in report quit and go to the next entry 
 ... ; Get IEN for PLB Code, then get description for code from file 345.1
 ... S ZEN=$$FIND1^DIC(345.1,"","",RCGX(344.42,IX,.02,"E"),"B","","RCERR") S:$G(ZEN)]"" ZDESC=$$GET1^DIQ(345.1,ZEN_",",.05,"","RCERR")
 ... S:$G(ZDESC)="" ZDESC=$G(RCGX(344.42,IX,.04,"E")) ; If no description use the Description from FSC
 ... S:$G(ZDESC)="" ZDESC="Bad data recieved from FSC" ; Otherwise make one up.
 ... ; PLB Code ^ Adj. Amount ^ Reference / Comment ^ Code Description
 ... S CD(ZZ)=$S(RCGX(344.42,IX,.02,"E")'="":RCGX(344.42,IX,.02,"E"),1:"00")_U_RCGX(344.42,IX,.03,"E")_U_RCGX(344.42,IX,.01,"E")_U_ZDESC
 ... S @GARRAY@("00_ERA",IEN,ZZ)=CD(ZZ)
 ... ; Add items to report global sorted by Payer or PLB Code
 ... S @GARRAY@("00_ERA",IEN,0)=ZN,@GARRAY@("00_ERA",IEN,0.1)=EOBTOT
 ... ;D:GSORT="C" BYCODE^RCDPRU(ZN,.CD,IEN,GARRAY,EOBTOT) D:GSORT="P" BYPAYR^RCDPRU(ZN,.CD,IEN,GARRAY,EOBTOT)
 ... S ZED=$S(GSORT="C":$P(CD(ZZ),U,1),1:$P(ZN,U,6)_"/"_$P(ZN,U,3)),@GARRAY@(ZLVL,ZED,IEN,0)=ZN
 D SUMIT^RCDPRU(GARRAY,ZLVL,GSORT)
 Q
 ; Check to see if this ITEM is included for processing
CHECK(TYPE,ITEM,ARRAY) ;
 ; If all are included no need to check further
 I TYPE="TIN" S:$E(ITEM,$L(ITEM))'=" " ITEM=ITEM_" " ; Add space to TIN if needed.
 Q:$G(ARRAY(TYPE))="ALL" 1
 Q:$G(ARRAY(TYPE,ITEM))=1 1
 Q 0
 ;
PLBC(RET) ; Get PLB Codes to limit for report or all
 N PLLIST,PLCODE,DTOUT,DUOUT,FILE S FILE=345.1
 S DIR("A")="Select (C)ode, (R)ange of Codes or (A)ll ?: ",DIR(0)="SA^A:All Codes;C:Single Code;R:Range/List of Codes"
 S DIR("B")="ALL" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S RCQUIT=1 Q
 S PLLIST=Y
 I PLLIST="A" S RET="ALL" Q
 I PLLIST="C" D  Q
 .; if invalid code return here
C1 .;
 . S DIR("A")="Enter a Code: ",DIR(0)="FA^1:200"
 . S DIR("?")="Only a single codes can be entered as: WO"
 . S DIR("?",1)="Please enter one Code for the report."
 . S DIR("?",2)="The single validated code will be included in the report."
 . D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT)!(Y="") S RCQUIT=1 Q
 . S PLCODE=$$UP^RCDPRU(X),PLCODE=$TR(PLCODE," ","")
 . I (PLCODE[":"),(PLCODE["-"),(PLCODE[",") W !!,"PLB Code: "_PLCODE_" not found, Please try again...",! S X="",PLCODE="" G C1
 . I '$$VAL(FILE,.PLCODE) W !!,"PLB Code: "_PLCODE_" not found, Please try again...",! S X="",PLCODE="" G C1
 . S RET=PLCODE
 ;
 I PLLIST="R" D
 . ; if invalid range/list of codes return here
C2 . ;
 . S DIR("A")="Enter a List or Range of Codes",DIR(0)="F^1:200"
 . S DIR("?")="Codes can be entered as: WO,51,AH:CT"
 . S DIR("?",1)="Please enter a list or range of Codes, use a comma between elements"
 . S DIR("?",2)="and a colon ':' or '-' to delimit ranges of codes."
 . D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT)!(Y="") S RCQUIT=1 Q
 . S PLCODE=$$UP^RCDPRU(X) I '$$VAL(FILE,.PLCODE) W !!,"PLB Code: "_PLCODE_" not found, Please try again...",! S X="",PLCODE="" G C2
 . S RET=PLCODE
 Q
 ;
VAL(XF,CODE) ; Validate a range or list of PLB Codes
 ; If invalid code is found VAILD = 0 and CODE will contain the offending codes
 Q $$VAL^RCDPRU(XF,.CODE)
 ;
