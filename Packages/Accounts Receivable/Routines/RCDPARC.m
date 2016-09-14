RCDPARC ;ALB/TJB - CARC REPORT ON PAYER OR CARC CODE ;9/15/14 3:00pm
 ;;4.5;Accounts Receivable;**303**;Mar 20, 1995;Build 84
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ; PRCA*4.5*303 - CARC and Payer report
 ; DESCRIPTION :
 ;   The following generates a report that displays selected or all
 ;   CARC Codes and Payers and totals the amounts for each CARC code.
 ;   several filters may be used to limit the CARC codes or Payer information
 ;   to be displayed:
EN ; Entry point for Report
 N DUOUT,DTOUT,DIR,X,Y,RCDT1,RCDT2,RCDET,ZTRTN,ZTSK,ZTDESC,ZTSAVE,ZTSTOP,%ZIS,POP,DTOK,DIVHDR,CRHDR
 N RCDIV,RCINC,VAUTD,RCRANGE,RCNP,RCJOB,RCNP1,RCPG,RCNOW,RCHR,RCODE,RCRARC,RCSTOP,EX
 S RCRARC=0,RCSTOP=0
 ; ICR 1077 - Get division/station
 D DIVISION^VAUTOMA
 I 'VAUTD&($D(VAUTD)'=11) G ARCQ
 ;
 S DIR("A")="(S)ummary or(D)etail Report format?: ",DIR(0)="SA^S:Summary Information only;D:Detail and Totals"
 S DIR("B")="SUMMARY" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") G ARCQ
 S RCDET=($E(Y,1)="D")
 ; Get CARC Codes for report
 D GCARC^RCDPCRR(.RCODE) G:RCSTOP ARCQ
 ;
 ;I RCDET D  G:$D(DTOUT)!$D(DUOUT)!(Y="") ARCQ ; See if User wants RARCs displayed on Detailed report 
 ;. S DIR(0)="YA",DIR("A")="Display available RARCs on Detailed Report? (Y/N): ",DIR("B")="No"
 ;. D ^DIR K DIR
 ;. I $D(DTOUT)!$D(DUOUT)!(Y="") Q 
 ;. S RCRARC=(Y=1)
 S RCRARC=0 ; Set RARCs not to display on report, but keep around just in case Susan changes her mind.
 ;
 ; Get Payer information
 S EX=$$GETPAY^RCDPRU(.RCPAY)
 G:EX=0 ARCQ
 ;
 ; Get Payer TIN information
 S EX=$$GETTIN^RCDPRU(.RCTIN)
 G:EX=0 ARCQ
 ;
 S DIR("A")="Sort Report by (C)ARC or (P)ayer?: ",DIR(0)="SA^P:Payer Name;CARC: CARC Codes;C:CARC Codes"
 S DIR("B")="CARC" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") G ARCQ
 S RCSORT=$E(Y,1)
 ;
 S DIR("?")="Enter the Beginning date for the report"
 S DIR(0)="DAO^:"_DT_":APE",DIR("A")="Start Date: ",DIR("B")="T" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") G ARCQ
 S RCDT1=Y
 S DIR("?")="Enter the end date for the report"
 S DIR("B")=$$DATE^RCDPRU($P($$NOW^XLFDT,"."),"2Z")
 S DIR(0)="DAO^"_RCDT1_":"_DT_":APE",DIR("A")="End Date: ",DIR("B")="T" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") G ARCQ
 S RCDT2=Y
 S DTOK=$$CHECKDT^RCDPRU(RCDT1,RCDT2,361.1)
 I 'DTOK W !!,"*** Note: Date Range "_$$DATE^RCDPRU(RCDT1)_" - "_$$DATE^RCDPRU(RCDT2)," ***",! W "*** No Records found ***",! D ASK^RCDPRU(.RCSTOP) G ARCQ
 ; Get input to export to excel. Removed per Susan (03/24/2015)
 S RCEXCEL=0
 ;S RCEXCEL=$$DISPTY^RCDPRU()
 ;D:RCEXCEL INFO^RCDPRU
 ;
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . S ZTRTN="ENQ^RCDPARC",ZTDESC="AR - 835 CARC & PAYER DATA REPORT",ZTSAVE("*")=""
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Your task number"_ZTSK_" has been queued.",1:"Unable to queue this job.")
 . K ZTSK,IO("Q") D HOME^%ZIS
 U IO
 ;
ENQ ; Queue point for report.
 S RCNOW=$$NOW^RCDPRU(),RCPG=0,$P(RCHR,"=",IOM)=""
 ;
 K ^TMP("RCDPARC_REPORT",$J)
 ; Collect the data and put it into the ^TMP global
 D GETDATA($G(RCODE("CARC")),.RCPAY,.RCTIN,$G(RCSORT),$G(RCRARC),RCDT1,RCDT2,$NA(^TMP("RCDPARC_REPORT",$J)),.VAUTD)
 ;
REPORT ; Print out the report
 ; Set up Division Header Text and CARC Header Text
 S:VAUTD=1 DIVHDR="ALL" D:VAUTD=0
 . N I S DIVHDR="",I="" F  S I=$O(VAUTD(I)) Q:I=""  S:DIVHDR'="" DIVHDR=DIVHDR_", "_VAUTD(I) S:DIVHDR="" DIVHDR=VAUTD(I)
 I RCODE("CARC")="ALL" S CRHDR="ALL"
 E  S CRHDR=RCODE("CARC")
 ; Trim information so it will fit on an 80 or IOM character line
 D:($L(DIVHDR)+$L(CRHDR))>(IOM-25)
 . N VAL,DH,CH,R1,R2 S DH=0,CH=0,R1=0,R2=0,VAL=(IOM-25)\2 ; get half of the screen length
 . S:$L(DIVHDR)>VAL DH=1 S:$L(CRHDR)>VAL CH=1 S:DH=0 R1=VAL-$L(DIVHDR) S:CH=0 R2=VAL-$L(CRHDR)
 . I $L(DIVHDR)>(VAL+R2) S DIVHDR=$E(DIVHDR,1,(VAL+R2))_"..."
 . I $L(CRHDR)>(VAL+R1) S CRHDR=$E(CRHDR,1,(VAL+R2))_"..."
 ;
 I 'RCEXCEL D
 . S RCPG=RCPG+1 W @IOF
 . D HDRP($$HDR(RCDET,RCRARC),1,"Page: "_RCPG_" ")
 . D HDRP("SORT BY: "_$S($E(RCSORT,1)="C":"CARC",1:"Payer")_"  RUN DATE: "_RCNOW,1)
 . D HDRP("DIVISIONS: "_DIVHDR_" CARCs: "_CRHDR,1)
 . D HDRP("835 PAYERS: "_$S($E(RCPAY)="A":"ALL",1:"Selected")_" 835 PAYER TINs: "_$S($E(RCTIN)="A":"ALL",1:"Selected"),1)
 . D HDRP("EOB PAID DATE RANGE: "_$$DATE^RCDPRU(RCDT1)_" - "_$$DATE^RCDPRU(RCDT2),1)
 . W !,RCHR,!
 E  D
 . ; Excel Report
 . W "CARC^PAYER^TIN^REP_DATE^AMOUNT",!
 ;
 D PRTREP($NA(^TMP("RCDPARC_REPORT",$J,"REPORT")),$NA(^TMP("RCDPARC_REPORT",$J,"~~SUM")),RCSORT,RCDET,$G(RCRARC),.RCSTOP) G:RCSTOP ARCQ
 D ASK^RCDPRU(.RCSTOP)
 ;
ARCQ ; Clean-up and quit
 K DHDR,RCEXCEL,RCLIST,RCLPAY,RCODE,RCPAY,RCSORT,RCRARC,RCTIN,RCTLIST
 ;K ^TMP("RCDPARC_REPORT",$J)
 Q
 ;
 ; DATA = the Report information; SUMM = Summary, Grand totals;
 ; SORT = What is the major sort order for DATA, CARC or Payer
PRTREP(DATA,SUMM,SORT,CD,RA,RCSTOP) ; Print report data out of the "REPORT" subarray
 N IX,IY,TIX,TIY,IEN,CL,LN,LN2,DLN,AMTA,AMTB,AMTP,TIN,DESC,DX0,DZ,PAY,CZ,PCT,X,DIWL,DIWR,RCSL
 S $P(LN,"-",80)="",$P(DLN,"=",80)="",$P(LN2,"-",78)="",LN2="  "_LN2,RCSL=8
 ; Do Grand totals - moved to top of report per Susan on 7/16/2015
 S DX0=$G(@SUMM@("CLAIMS")),PCT=0
 S:+$P(DX0,U,2)'=0 PCT=$J(($P(DX0,U,4)/$P(DX0,U,2))*100,3,0)
 S:+$P(DX0,U,2)=0 PCT="ERR"
 I RCSL>=(IOSL-4) S RCSTOP=$$NEWPG(.RCPG,1,.RCSL,CD,RA) Q:RCSTOP
 W !
 W "GRAND TOTAL ALL CARCS / ALL PAYERS ON REPORT",!
 W "   TOTAL #CLAIMS:  ",$J($P(DX0,U,1),6,0),"  ADJ: ",PCT,"% [TOT AMT ADJUSTED / TOT AMT BILLED]",!
 W "   AMT ADJUST: $",$J($P(DX0,U,4),11,2),"  AMT BILLED: $",$J($P(DX0,U,2),11,2),"  AMT PAID: $",$J($P(DX0,U,3),11,2),!
 W !,DLN,!! S RCSL=RCSL+5
 ;
 S IX="",IEN="",CL=0,AMTB=0,AMTP=0,DESC="Empty Description"
 F  S IX=$O(@DATA@(IX)) Q:IX=""!RCSTOP  S TIX=$G(@DATA@(IX)),IY="" D  Q:RCSTOP 
 . D:SORT="C"  Q:RCSTOP  ; CARC Sorted output IX => CARC; IY => Payer Name
 .. S DX0=$G(@DATA@(IX,"~~SUM")),CL=$P(DX0,U,1),AMTB=$P(DX0,U,2),AMTP=$P(DX0,U,3),AMTA=$P(DX0,U,4),DESC=$P(DX0,U,5),PCT=(AMTA/AMTB)*100
 .. W "CARC: ",$J(IX,4)," TOTAL #CLAIMS: ",$J(CL,5,0)," ADJ:",$J(PCT,3,0),"% [TOT AMT ADJUSTED / TOT AMT BILLED]",! S RCSL=RCSL+1
 .. I RCSL>=(IOSL-2) S RCSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:RCSTOP
 .. W "  AMT ADJUST: ",$J(AMTA,11,2),"  AMT BILLED: ",$J(AMTB,12,2),"  AMT PAID: ",$J(AMTP,12,2),! S RCSL=RCSL+1
 .. I RCSL>=(IOSL-2) S RCSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:RCSTOP
 .. S X="Desc: "_$E(DESC,1,73),DIWL=1,DIWR=80 K ^UTILITY($J,"W") D ^DIWP,^DIWW S RCSL=RCSL+1
 .. I RCSL>=(IOSL-2) S RCSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:RCSTOP
 .. W LN,! S RCSL=RCSL+1
 .. I RCSL>=(IOSL-2) S RCSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:RCSTOP
 .. S CZ=0,PAY="" F  S PAY=$O(@DATA@(IX,"~~SUM",PAY)) Q:PAY=""!RCSTOP  S CZ=CZ+1 D  Q:RCSTOP
 ... S DZ=@DATA@(IX,"~~SUM",PAY),PCT=$S((+$P(DZ,U,2)'=0):($P(DZ,U,4)/$P(DZ,U,2)*100),1:"ERROR")
 ... I CZ>1 W LN2,! S RCSL=RCSL+1
 ... I RCSL>=(IOSL-2) S RCSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:RCSTOP
 ... W "  PAYER NAME/TIN: ",PAY,! S RCSL=RCSL+1
 ... I RCSL>=(IOSL-2) S RCSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:RCSTOP
 ... W "  #CLAIMS: ",$J($P(DZ,U,1),4,0)," ADJ:",$J(PCT,3,0),"% [ADJ: ",$J($P(DZ,U,4),10,2),"/BILLED: ",$J($P(DZ,U,2),10,2),"] PAID: ",$J($P(DZ,U,3),10,2),! S RCSL=RCSL+1
 ... I RCSL>=(IOSL-2) S RCSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:RCSTOP
 ... D:RCDET DETAIL(DATA,IX,PAY,.RCSL,.RCSTOP) Q:RCSTOP  ; Data array, CARC, Payer/TIN
 ... I RCSL>=(IOSL-2) S RCSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:RCSTOP
 .. Q:RCSTOP  W LN,! S RCSL=RCSL+1 ; Removed "!," in front of "LN"
 .. I RCSL>=(IOSL-2) S RCSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:RCSTOP
 . Q:RCSTOP
 . D:SORT="P"  Q:RCSTOP  ; Payer Sorted output IX => Payer Name; IY => CARC
 .. W "PAYER NAME/TIN: ",IX,! S RCSL=RCSL+1
 .. S DX0=$G(@DATA@(IX,"~~SUM")),CL=$P(DX0,U,1),AMTB=$P(DX0,U,2),AMTP=$P(DX0,U,3),AMTA=$P(DX0,U,4),PCT=(AMTA/AMTB)*100
 .. W "#CLAIMS: ",$J(CL,4,0)," ADJ: ",$J(PCT,3,0),"% [ADJ:",$J(AMTA,10,2),"/BILLED:",$J(AMTB,11,2),"] PAID:",$J(AMTP,11,2),! S RCSL=RCSL+1
 .. W LN,!! S RCSL=RCSL+2
 .. S CZ=0,IY="" F  S IY=$O(@DATA@(IX,"~~SUM",IY)) Q:IY=""  S CZ=CZ+1 D  Q:RCSTOP
 ... S DZ=@DATA@(IX,"~~SUM",IY)
 ... I CZ>1 W LN2,! S RCSL=RCSL+1
 ... I RCSL>=(IOSL-2) S RCSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:RCSTOP
 ... S PCT=$S((+$P(DZ,U,2)'=0):($P(DZ,U,4)/$P(DZ,U,2)*100),1:"ERROR")
 ... W ?2,"CARC: ",$J(IY,4),?14,"#CLAIMS: ",$J($P(DZ,U,1),5,0),?30,"ADJ: ",$J(PCT,3,0),"% [AMT ADJUSTED / AMT BILLED]",! S RCSL=RCSL+1
 ... I RCSL>=(IOSL-2) S RCSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:RCSTOP
 ... W ?2,"AMT ADJUST: ",$J($P(DZ,U,4),11,2),?26,"  BILLED: ",$J($P(DZ,U,2),12,2),?56," PAID: ",$J($P(DZ,U,3),12,2),! S RCSL=RCSL+1
 ... I RCSL>=(IOSL-2) S RCSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:RCSTOP
 ... S X="Desc: "_$E($P(DZ,U,5),1,68),DIWL=3,DIWR=80 K ^UTILITY($J,"W") D ^DIWP,^DIWW S RCSL=RCSL+1
 ... I RCSL>=(IOSL-2) S RCSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:RCSTOP
 ... D:RCDET DETAIL(DATA,IX,IY,.RCSL,.RCSTOP) Q:RCSTOP  ; Data array, Payer/TIN, CARC
 ... I RCSL>=(IOSL-2) S RCSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:RCSTOP
 .. Q:RCSTOP  W LN,! S RCSL=RCSL+1 ; Removed "!," in front of LN
 .. I RCSL>=(IOSL-2) S RCSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:RCSTOP
 Q
 ;
DETAIL(DATA,L1,L2,RCSL,DSTOP) ; Print detail information for this entry
 N IEN,DOS,DX,DY,HDR,PCT,PAT,SSN
 S HDR=0
 S IEN="" F  S IEN=$O(@DATA@(L1,L2,IEN)) Q:IEN=""!DSTOP  S HDR=HDR+1 D  Q:DSTOP 
 . ; Print out Detail
 . D:HDR=1  Q:DSTOP
 .. W "  ------------------------------------------------------------------------------",! S RCSL=RCSL+1
 .. W "  CLAIM#    DOS    %ADJ  [AMT ADJ/AMT BILLED]  PAID   PATIENT NAME          SSN",! S RCSL=RCSL+1
 .. W "  ==============================================================================",! S RCSL=RCSL+1
 .. I RCSL>=(IOSL-2) S DSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:DSTOP
 . S DX=@DATA@(L1,L2,IEN,0),DY=@DATA@(L1,L2,IEN,1),DOS=$$DATE^RCDPRU($$GET1^DIQ(399,$P(DX,U,1)_",",.03,"I")),PCT=($P(DY,U,2)/$P(DX,U,6))*100
 . ;S $P(DX,U,6)=654321.99,$P(DX,U,7)=123456.99
 . S PAT=$$GET1^DIQ(2,$P(DX,U,3)_",",.01,"E"),SSN="("_$E($$GET1^DIQ(2,$P(DX,U,3)_",",.09,"E"),*-3,*)_")"
 . W ?2,$P(DX,U,2),?10,DOS,?19,$J(PCT,3,0),?24,$J($P(DY,U,2),9,2),?34,$J($P(DX,U,6),9,2),?44,$J($P(DX,U,7),9,2),?54,$E(PAT,1,19),?74,SSN,! S RCSL=RCSL+1
 . I RCSL>=(IOSL-2) S DSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:DSTOP
 . ;W "RCRARC = ",RCRARC,"   DY=",DY,!
 . ; Write out RARC if we have one
 . I RCRARC=1&($P(DY,U,5)'="") S X="RARC: "_$P(DY,U,5)_"  "_$P(DY,U,6),DIWL=5,DIWR=80 K ^UTILITY($J,"W") D ^DIWP,^DIWW S RCSL=RCSL+1
 . I RCSL>=(IOSL-2) S DSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:DSTOP
 W ! S RCSL=RCSL+1
 Q
HDR(CD,RA) ; Report header
 N ZZ S ZZ=$S($G(RA)=1:" & RARC",1:"")
 Q:CD "EDI LOCKBOX 835 CARC"_ZZ_" DATA REPORT - DETAIL FORMAT"
 Q "EDI LOCKBOX 835 CARC DATA REPORT - SUMMARY FORMAT"
 ;
HDRP(Z,X,Z1) ; Print Header (Z=String, X=1 (line feed) X=0 (no LF), Z1 (page number right justified)
 I $G(X)=1 W !
 W ?(IOM-$L(Z)\2),Z W:$G(Z1)]"" ?(IOM-$L(Z1)),Z1
 Q
NEWPG(RCPG,RCNEW,RCSL,CD,RA) ; Check for new page needed, output header
 ; RCPG = Page number passwd by referece
 ; RCNEW = 1 to force new page
 ; RCSL = page length passed by reference
 ; Function returns 1 if user chooses to stop output
 N ZSTOP S ZSTOP=0
 I RCNEW!'RCPG!(($Y+5)>IOSL) D
 . D:RCPG ASK^RCDPRU(.ZSTOP) Q:ZSTOP
 . S RCPG=RCPG+1 W @IOF
 . D HDRP($$HDR(CD,RA),1,"Page: "_RCPG)
 . D HDRP("SORT BY: "_$S($E(RCSORT,1)="C":"CARC",1:"Payer")_"  RUN DATE: "_RCNOW,1)
 . D HDRP("Divisions: "_DIVHDR_" CARCs: "_CRHDR,1)
 . D HDRP("835 PAYERS: "_$S($E(RCPAY)="A":"ALL",1:"Selected")_" 835 PAYER TINs: "_$S($E(RCTIN)="A":"ALL",1:"Selected"),1)
 . D HDRP("EOB PAID DATE RANGE: "_$$DATE^RCDPRU(RCDT1)_" - "_$$DATE^RCDPRU(RCDT2),1)
 . W !,RCHR,! S RCSL=7
 Q ZSTOP
 ; Select Range or list of CARC Codes
CARC ;
 N DIR,OKAY
 S DIR("A")="Enter a List or Range of CARC codes: ",DIR(0)="F^1:200"
 S DIR("?")="Codes can be entered as: 1,2,4:15,A1:B6"
 S DIR("?",1)="Please enter a list or range of CARC Codes, use a comma "
 S DIR("?",2)="and a colon ':' to delimit ranges of codes."
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S RCSTOP=1 Q
 S RCODE=X,OKAY=$$VAL^RCDPRU(345,.RCODE)
 I 'OKAY S DIR("A",1)="Invalid Range/List of CARC Codes, Please reenter.." G CARC
 K DIR("A",1) ; Clean up DIR
 Q RCODE
 ; Get data for report and apply filters if necessary
GETDATA(GCARC,GPAYER,GTIN,GSORT,GRARC,GSTART,GSTOP,GARRAY,GDIV) ;
 N SDT,IEN,CNT,ZX,RM,ZND,CARR,PNARR,PTARR,RCSET,GLINE,DZN,PTR,ZPAY,RCERR,RCDEN
 S SDT=$O(^IBM(361.1,"E",GSTART),-1)
 ; Set up the arrays for filtering on CARC, PAYER name and Payer TINs
 D RNG^RCDPRU("CARC",GCARC,.CARR),RNG^RCDPRU("PAYER",GPAYER("DATA"),.PNARR),RNG^RCDPRU("TIN",GTIN("DATA"),.PTARR)
 ;Get possible bills to work on from ^IBM(361.1,"E") index
 F  S SDT=$O(^IBM(361.1,"E",SDT)) Q:SDT=""!(SDT>GSTOP)  D
 . S IEN="" F  S IEN=$O(^IBM(361.1,"E",SDT,IEN)) Q:IEN=""  D
 .. S RM=$$GET1^DIQ(361.1,IEN_",",102,"I") Q:$G(RM)=1  ; Quit looking if this EOB is removed
 .. ; If not all divisions then check to see if this EOB should be included
 .. I GDIV=0 S RCDIV="",RCDEN=$$GET1^DIQ(361.1,IEN_",",.01,"I") S:RCDEN'="" RCDIV=$$GET1^DIQ(399,RCDEN_",",.22,"I") Q:RCDIV=""  Q:$G(GDIV(RCDIV))=""
 .. ; Get the data for this claim and 835 Payer
 .. S ZND=^IBM(361.1,IEN,0),PTR=$P(ZND,U,1),ZPAY=$$FIND1^DIC(344.6,"","M",$P(ZND,U,3),"","","RCERR"),ZPAY=$$GET1^DIQ(344.6,ZPAY_",",.01,"E")
 .. S RCSET=1
 .. ; Are there CARC codes for this record
 .. S:($G(^IBM(361.1,IEN,10,0))']"")&($G(^IBM(361.1,IEN,15,0))']"") RCSET=0
 .. ; Is the PAYER included in the list
 .. S:'$$CHECK("PAYER",ZPAY,.PNARR) RCSET=0
 .. ; Is the payer TIN included in the list
 .. S:'$$CHECK("TIN",$P(ZND,U,3)_" ",.PTARR) RCSET=0
 .. Q:RCSET=0  ; No need to check further get next IEN
 .. ; Pointer to the bill (^DGCR(399,))^KBill #^Patient pointer^Payer Pointer [^DIC(36)]^Payer ID/TIN^Total Charges^Paid Amount
 .. S DZN=$G(^DGCR(399,PTR,0))
 .. S:($G(^IBM(361.1,IEN,10,0))]"")!($G(^IBM(361.1,IEN,15,0))]"") @GARRAY@("BILLS",IEN,0)=PTR_U_$P(DZN,U,1)_U_$P(DZN,U,2)_U_$P(ZND,U,2)_U_$P(ZND,U,3)_U_$G(^DGCR(399,PTR,"U1"))_U_$P($G(^IBM(361.1,IEN,1)),U,1)
 .. S CNT=0
 .. ; Get Claim Level CARC Data
 .. D:$G(^IBM(361.1,IEN,10,0))]""
 ... ; Get CARC information, CARC is in 361.11
 ... N IX,RCGX S IX="" D GETS^DIQ(361.1,IEN_",","10*;","E","RCGX")
 ... ; CARC^AMOUNT^QUANTITY^DESCRIPTION
 ... S IX="" F  S IX=$O(RCGX("361.111",IX)) Q:IX=""  D
 .... ; Quit if this CARC is not in the list
 .... Q:'$$CHECK("CARC",RCGX("361.111",IX,.01,"E"),.CARR)
 .... S CNT=CNT+1
 .... S @GARRAY@("BILLS",IEN,"C",CNT)=RCGX("361.111",IX,.01,"E")_U_RCGX("361.111",IX,.02,"E")_U_RCGX("361.111",IX,.03,"E")_U_RCGX("361.111",IX,.04,"E")
 .. ; Get Line level CARC Data
 .. D:$G(^IBM(361.1,IEN,15,0))]""
 ... ; Get CARC and RARC information. CARC is in 361.11511 and RARC is in 361.1154
 ... N IX,RCGX S IX="" D GETS^DIQ(361.1,IEN_",","15*;","IE","RCGX")
 ... ; CARC^AMOUNT^QUANTITY^DESCRIPTION
 ... S IX="" F  S IX=$O(RCGX("361.11511",IX)) Q:IX=""  D
 .... ; Quit if this CARC is not on the list
 .... Q:'$$CHECK("CARC",RCGX("361.11511",IX,.01,"E"),.CARR)
 .... S CNT=CNT+1
 .... S @GARRAY@("BILLS",IEN,"C",CNT)=RCGX("361.11511",IX,.01,"E")_U_RCGX("361.11511",IX,.02,"E")_U_RCGX("361.11511",IX,.03,"E")_U_RCGX("361.11511",IX,.04,"E")
 ... ; RARC^DESCRIPTION
 ... S IX="" F ZX=1:1 S IX=$O(RCGX("361.1154",IX)) Q:IX=""  S @GARRAY@("BILLS",IEN,"R",ZX)=RCGX("361.1154",IX,.02,"E")_U_RCGX("361.1154",IX,.03,"E")
 ; Possible bills have been accumulated in "BILLS" sub-array, Apply filters and accumulate data in "REPORT" sub-array
 D SORT(GARRAY,GSORT)
 Q
 ;
SORT(ARRAY,SORT) ; Sort and summarize data based on SORT variable
 N CARC,IEN,D1,D2,PIEN,PAYER,Z,TIN,DESC,R1,BILL S IEN=""
 ; IEN= IEN from file 361.1; PIEN= 835 Payer IEN from file 344.6
 F  S IEN=$O(@ARRAY@("BILLS",IEN)) Q:IEN=""  D
 . S D1=@ARRAY@("BILLS",IEN,0),TIN=$P(D1,U,5),BILL=$P(D1,U,2)
 . S PAYER=$$GPAYR(TIN,IEN,$P(D1,U,1),BILL) Q:$G(PAYER)=""  ; couldn't find a payer to match TIN, quit
 . S CARC="",Z="",R1=""
 . F  S Z=$O(@ARRAY@("BILLS",IEN,"C",Z)) Q:Z=""  S D2=@ARRAY@("BILLS",IEN,"C",Z),CARC=$P(D2,U,1),DESC=$P(D2,U,4) D
 .. ; If RARC exists append to CARC Information
 .. S:$G(@ARRAY@("BILLS",IEN,"R",Z))'="" R1=@ARRAY@("BILLS",IEN,"R",Z)
 .. ;W "RARC: |",$G(@ARRAY@("BILLS",IEN,"R",Z)),"|",!
 .. D:SORT="C"  ; Sort by CARC, group by Payer
 ... S @ARRAY@("REPORT",CARC,PAYER_"/"_TIN,IEN,0)=D1
 ... ; First time through set the "BILLS" D2 into report, otherwise add adjustment amt to the existing for this CARC
 ... I $G(@ARRAY@("REPORT",CARC,PAYER_"/"_TIN,IEN,1))="" S @ARRAY@("REPORT",CARC,PAYER_"/"_TIN,IEN,1)=D2_U_R1
 ... E  S $P(@ARRAY@("REPORT",CARC,PAYER_"/"_TIN,IEN,1),U,2)=$P(@ARRAY@("REPORT",CARC,PAYER_"/"_TIN,IEN,1),U,2)+$P(D2,U,2) ;W "CARC: ",CARC," Bill: ",BILL," D2: ",D2,!
 .. D:SORT="P"  ; Sort by Payer, group by CARC
 ... S @ARRAY@("REPORT",PAYER_"/"_TIN,CARC,IEN,0)=D1
 ... ; First time through set the "BILLS" D2 into report, otherwise add adjustment amt to the existing for this CARC
 ... I $G(@ARRAY@("REPORT",PAYER_"/"_TIN,CARC,IEN,1))="" S @ARRAY@("REPORT",PAYER_"/"_TIN,CARC,IEN,1)=D2_U_R1
 ... E  S $P(@ARRAY@("REPORT",PAYER_"/"_TIN,CARC,IEN,1),U,2)=$P(@ARRAY@("REPORT",PAYER_"/"_TIN,CARC,IEN,1),U,2)+$P(D2,U,2)
 .. ;I CARC=1 W ARRAY," BILL:",BILL," CARC:",CARC,"  ",PAYER_"/"_TIN,"  ",$P(D1,U,6),"  ",$P(D1,U,7),"  ",DESC,"  ",$P(D2,U,2),"  ",SORT,!
 .. D SUM^RCDPRU(ARRAY,IEN,BILL,CARC,PAYER_"/"_TIN,$P(D1,U,6),$P(D1,U,7),DESC,$P(D2,U,2),SORT)
 Q
 ;
 ; Check to see if this ITEM is included for processing
CHECK(TYPE,ITEM,ARRAY) ;
 ; If all are included no need to check further
 Q:$G(ARRAY(TYPE))="ALL" 1
 Q:$G(ITEM)="" 0
 Q:$G(ARRAY(TYPE,ITEM))=1 1
 Q 0
 ;
 ; Get 835 Payer for this entry
GPAYR(GTIN,GIEN,GXIEN,KBILL) ;
 N RCX,RCERR
 S PIEN=$$FIND1^DIC(344.6,,"M",TIN,,,"RCERR")
 ; If we have PIEN, then exact match return the payer name
 Q:PIEN]"" $$GET1^DIQ(344.6,PIEN_",",.01,"E")
 ; Otherwise we need to look further for the Payer Name
 D FIND^DIC(344.6,,,"CM",TIN,,"C",,,"RCX","RCERR")
 ; Grab first entry
 Q:$G(RCX("DILIST",1,1))]"" $G(RCX("DILIST",1,1))
 Q ""
