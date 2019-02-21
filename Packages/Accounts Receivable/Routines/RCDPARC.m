RCDPARC ;ALB/TJB - CARC REPORT ON PAYER OR CARC CODE ;9/15/14 3:00pm
 ;;4.5;Accounts Receivable;**303,321,326**;Mar 20, 1995;Build 26
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
 N RCDIV,RCINC,VAUTD,RCLAIM,RCRANGE,RCNP,RCJOB,RCNP1,RCPG,RCNOW,RCHR,RCODE,RCPAR,RCPAY,RCRARC,RCSTOP,RCWHICH,EX
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
 S RCRARC=0 ; Set RARCs not to display on report, but keep around just in case Susan changes her mind.
 ;
 S RCLAIM=$$RTYPE^RCDPEU1("A") G:RCLAIM=-1 ARCQ ; Payer Type
 ; Get Payer information
 S RCWHICH=$$NMORTIN^RCDPEAPP() G:RCWHICH=-1 ARCQ   ; Filter by Payer Name or TIN
 ;
 S RCPAR("SELC")=$$PAYRNG^RCDPEU1(1,1,RCWHICH)      ; PRCA*4.5*326 - Selected or Range of Payers
 G:RCPAR("SELC")=-1 ARCQ                            ; PRCA*4.5*326 '^' or timeout
 S RCPAY=RCPAR("SELC")
 ;
 I RCPAR("SELC")'="A" D  G:XX=-1 ARCQ               ; PRCA*4.5*326 - Since we don't want all payers 
 . S RCPAR("TYPE")=RCLAIM                           ;         prompt for payers we do want
 . S RCPAR("SRCH")=$S(RCWHICH=2:"T",1:"N")
 . S RCPAR("FILE")=344.4
 . S RCPAR("DICA")="Select Insurance Company"_$S(RCWHICH=1:" NAME: ",1:" TIN: ")
 . S XX=$$SELPAY^RCDPEU1(.RCPAR)
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
 . S RCSTOP=$$NEWPG(.RCPG,1,.RCSL,RCDET,$G(RCRARC)) ; PRCA*4.5*326 - use $$NEWPG for first header
 E  D
 . ; Excel Report
 . W "CARC^PAYER^TIN^REP_DATE^AMOUNT",!
 ;
 D PRTREP($NA(^TMP("RCDPARC_REPORT",$J,"REPORT")),$NA(^TMP("RCDPARC_REPORT",$J,"~~SUM")),RCSORT,RCDET,$G(RCRARC),.RCSTOP) G:RCSTOP ARCQ
 D ASK^RCDPRU(.RCSTOP)
 ;
ARCQ ; Clean-up and quit
 K DHDR,RCEXCEL,RCLIST,RCLPAY,RCODE,RCPAY,RCSORT,RCRARC,RCTIN,RCTLIST
 K ^TMP("RCDPEU1",$J) ; PRCA*4.5*326
 ;K ^TMP("RCDPARC_REPORT",$J)
 Q
 ;
PRTREP(DATA,SUMM,SORT,CD,RA,RCSTOP) ; Print report data out of the "REPORT" subarray
 ; Input:   DATA        - Compiled report data in ^TMP("RCDPARC_REPORT",$J)
 ;          SUM         - Compiled grand totals in ^TMP("RCDPARC_REPORT",$J,"~~SUM")
 ;          SORT        - Selected Sort Option
 ;          CD          - 'D' - Detail report, 'S' - Summary report
 ;          RA          - Always 0 for now to not display CARCS on report
 ; Output:  RCSTOP      - 1 if user quit out of the display, 0 otherwise
 N AMTA,AMTB,AMTP,CL,CZ,DESC,DIWL,DIWR,DLN,DX0,DZ,IX,IY,LN,LN2,PAY,PCT,PYRTINS,PYZ,RCSL
 N TIN,TIX,TIY,X,XX,YY,ZZ
 S $P(LN,"-",80)="",$P(DLN,"=",80)="",$P(LN2,"-",78)="",LN2="  "_LN2,RCSL=8
 ; Do Grand totals - moved to top of report per Susan on 7/16/2015
 S DX0=$G(@SUMM@("CLAIMS")),PCT=0
 S:+$P(DX0,U,2)'=0 PCT=$J(($P(DX0,U,4)/$P(DX0,U,2))*100,3,0)
 S:+$P(DX0,U,2)=0 PCT="ERR"
 I RCSL'<(IOSL-4) S RCSTOP=$$NEWPG(.RCPG,1,.RCSL,CD,RA) Q:RCSTOP
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
 .. I RCSL'<(IOSL-2) S RCSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:RCSTOP
 .. W "  AMT ADJUST: ",$J(AMTA,11,2),"  AMT BILLED: ",$J(AMTB,12,2),"  AMT PAID: ",$J(AMTP,12,2),! S RCSL=RCSL+1
 .. I RCSL'<(IOSL-2) S RCSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:RCSTOP
 .. S X="Desc: "_$E(DESC,1,73),DIWL=1,DIWR=80 K ^UTILITY($J,"W") D ^DIWP,^DIWW S RCSL=RCSL+1
 .. I RCSL'<(IOSL-2) S RCSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:RCSTOP
 .. W LN,! S RCSL=RCSL+1
 .. I RCSL'<(IOSL-2) S RCSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:RCSTOP
 .. S CZ=0,PAY="" F  S PAY=$O(@DATA@(IX,"~~SUM",PAY)) Q:PAY=""!RCSTOP  S CZ=CZ+1 D  Q:RCSTOP
 ... S DZ=@DATA@(IX,"~~SUM",PAY),PCT=$S((+$P(DZ,U,2)'=0):($P(DZ,U,4)/$P(DZ,U,2)*100),1:"ERROR")
 ... I CZ>1 W LN2,! S RCSL=RCSL+1
 ... I RCSL'<(IOSL-2) S RCSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:RCSTOP
 ... ; PRCA*4.5*321 Start modified code block
 ... D PAYTINS^RCDPRU2(PAY,.PYRTINS)
 ... W " PAYER NAME/TIN",!
 ... S RCSL=RCSL+1
 ... S PYZ="" F  S PYZ=$O(PYRTINS(PYZ)) Q:PYZ=""  D  Q:RCSTOP
 .... W " ",$$PAYTIN^RCDPRU2(PYRTINS(PYZ),76),!
 .... S RCSL=RCSL+1
 .... I RCSL'<(IOSL-2) S RCSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA)
 ... ; PRCA*4.5*321 End modified code block
 ... I RCSL'<(IOSL-2) S RCSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:RCSTOP
 ... W "  #CLAIMS: ",$J($P(DZ,U,1),4,0)," ADJ:",$J(PCT,3,0),"% [ADJ: ",$J($P(DZ,U,4),10,2),"/BILLED: ",$J($P(DZ,U,2),10,2),"] PAID: ",$J($P(DZ,U,3),10,2),! S RCSL=RCSL+1
 ... I RCSL'<(IOSL-2) S RCSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:RCSTOP
 ... D:RCDET DETAIL(DATA,IX,PAY,.RCSL,.RCSTOP) Q:RCSTOP  ; Data array, CARC, Payer/TIN
 ... I RCSL'<(IOSL-2) S RCSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:RCSTOP
 .. Q:RCSTOP  W LN,! S RCSL=RCSL+1 ; Removed "!," in front of "LN"
 .. I RCSL'<(IOSL-2) S RCSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:RCSTOP
 . Q:RCSTOP
 . D:SORT="P"  Q:RCSTOP  ; Payer Sorted output IX => Payer Name; IY => CARC
 .. ; PRCA*4.5*321 Start modified code block
 .. D PAYTINS^RCDPRU2(IX,.PYRTINS)
 .. W " PAYER NAME/TIN",!
 .. S RCSL=RCSL+1
 .. S PYZ="" F  S PYZ=$O(PYRTINS(PYZ)) Q:PYZ=""  D  Q:RCSTOP
 ... W " ",$$PAYTIN^RCDPRU2(PYRTINS(PYZ),76),!
 ... S RCSL=RCSL+1
 ... I RCSL'<(IOSL-2) S RCSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA)
 .. ; PRCA*4.5*321 End modified code block
 .. S DX0=$G(@DATA@(IX,"~~SUM")),CL=$P(DX0,U,1),AMTB=$P(DX0,U,2),AMTP=$P(DX0,U,3),AMTA=$P(DX0,U,4),PCT=(AMTA/AMTB)*100
 .. W "#CLAIMS: ",$J(CL,4,0)," ADJ: ",$J(PCT,3,0),"% [ADJ:",$J(AMTA,10,2),"/BILLED:",$J(AMTB,11,2),"] PAID:",$J(AMTP,11,2),! S RCSL=RCSL+1
 .. W LN,!! S RCSL=RCSL+2
 .. S CZ=0,IY="" F  S IY=$O(@DATA@(IX,"~~SUM",IY)) Q:IY=""  S CZ=CZ+1 D  Q:RCSTOP
 ... S DZ=@DATA@(IX,"~~SUM",IY)
 ... I CZ>1 W LN2,! S RCSL=RCSL+1
 ... I RCSL'<(IOSL-2) S RCSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:RCSTOP
 ... S PCT=$S((+$P(DZ,U,2)'=0):($P(DZ,U,4)/$P(DZ,U,2)*100),1:"ERROR")
 ... W ?2,"CARC: ",$J(IY,4),?14,"#CLAIMS: ",$J($P(DZ,U,1),5,0),?30,"ADJ: ",$J(PCT,3,0),"% [AMT ADJUSTED / AMT BILLED]",! S RCSL=RCSL+1
 ... I RCSL'<(IOSL-2) S RCSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:RCSTOP
 ... W ?2,"AMT ADJUST: ",$J($P(DZ,U,4),11,2),?26,"  BILLED: ",$J($P(DZ,U,2),12,2),?56," PAID: ",$J($P(DZ,U,3),12,2),! S RCSL=RCSL+1
 ... I RCSL'<(IOSL-2) S RCSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:RCSTOP
 ... S X="Desc: "_$E($P(DZ,U,5),1,68),DIWL=3,DIWR=80 K ^UTILITY($J,"W") D ^DIWP,^DIWW S RCSL=RCSL+1
 ... I RCSL'<(IOSL-2) S RCSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:RCSTOP
 ... D:RCDET DETAIL(DATA,IX,IY,.RCSL,.RCSTOP) Q:RCSTOP  ; Data array, Payer/TIN, CARC
 ... I RCSL'<(IOSL-2) S RCSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:RCSTOP
 .. Q:RCSTOP  W LN,! S RCSL=RCSL+1 ; Removed "!," in front of LN
 .. I RCSL'<(IOSL-2) S RCSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:RCSTOP
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
 .. I RCSL'<(IOSL-2) S DSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:DSTOP
 . S DX=@DATA@(L1,L2,IEN,0),DY=@DATA@(L1,L2,IEN,1),DOS=$$DATE^RCDPRU($$GET1^DIQ(399,$P(DX,U,1)_",",.03,"I")),PCT=($P(DY,U,2)/$P(DX,U,6))*100
 . ;S $P(DX,U,6)=654321.99,$P(DX,U,7)=123456.99
 . S PAT=$$GET1^DIQ(2,$P(DX,U,3)_",",.01,"E"),SSN="("_$E($$GET1^DIQ(2,$P(DX,U,3)_",",.09,"E"),*-3,*)_")"
 . W ?2,$P(DX,U,2),?10,DOS,?19,$J(PCT,3,0),?24,$J($P(DY,U,2),9,2),?34,$J($P(DX,U,6),9,2),?44,$J($P(DX,U,7),9,2),?54,$E(PAT,1,19),?74,SSN,! S RCSL=RCSL+1
 . I RCSL'<(IOSL-2) S DSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:DSTOP
 . ;W "RCRARC = ",RCRARC,"   DY=",DY,!
 . ; Write out RARC if we have one
 . I RCRARC=1&($P(DY,U,5)'="") S X="RARC: "_$P(DY,U,5)_"  "_$P(DY,U,6),DIWL=5,DIWR=80 K ^UTILITY($J,"W") D ^DIWP,^DIWW S RCSL=RCSL+1
 . I RCSL'<(IOSL-2) S DSTOP=$$NEWPG(.RCPG,0,.RCSL,CD,RA) Q:DSTOP
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
 N ZSTOP,XX ; PRCA*4.5*326
 S ZSTOP=0
 I RCNEW!'RCPG!(($Y+5)>IOSL) D
 . D:RCPG ASK^RCDPRU(.ZSTOP) Q:ZSTOP
 . S RCPG=RCPG+1 W @IOF
 . D HDRP($$HDR(CD,RA),1,"Page: "_RCPG)
 . D HDRP("SORT BY: "_$S($E(RCSORT,1)="C":"CARC",1:"Payer")_"  RUN DATE: "_RCNOW,1)
 . D HDRP("Divisions: "_DIVHDR_" CARCs: "_CRHDR,1)
 . ; PRCA*4.5*326 - Include M/P/T filter in header
 . S XX=$S(RCWHICH=2:"PAYER TINS",1:"835 PAYERS")_": "_$S(RCPAY="R":"Range",RCPAY="S":"Selected",1:"All")
 . S XX=XX_$J("",44-$L(XX))_"MEDICAL/PHARMACY/TRICARE: "
 . S XX=XX_$S(RCLAIM="M":"MEDICAL",RCLAIM="P":"PHARMACY",RCLAIM="T":"TRICARE",1:"ALL")
 . D HDRP(XX,1)
 . D HDRP("EOB PAID DATE RANGE: "_$$DATE^RCDPRU(RCDT1)_" - "_$$DATE^RCDPRU(RCDT2),1)
 . W !,RCHR,! S RCSL=7
 Q ZSTOP
 ;
 ;
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
 ; Input: GCCARC - Range of CARC codes to include
 ;        GPAYER - Range of payers to include 
 ;        GTIN   - Range of TINs to include
 ;        GSORT  - Sort order 
 ;        GRARC  - Flag to display RARC codes on the report (0 = No)
 ;        GSTART - Start date
 ;        GSTOP  - End date
 ;        GARRAY - Root of the array in which to store the output data
 ;        GDIV   - Range of Divisions to include
 ; Output: @GARRAY("BILLS",IEN,0)=A1^A2^A3^A4^A5^A6^A7
 ;           A1=Pointer to BILL/CLAIM file (#399)
 ;           A2=Bill Number
 ;           A3=Pointer to patient file (#2)
 ;           A4=Payer Name from EOB, pointer to Insurance file (#36)
 ;           A5=TIN from EOB
 ;           A6=Total Charges
 ;           A7=Paid amount
 ;
 N SDT,IEN,CNT,ZX,RM,ZND,CARR,PNARR,PTARR,RCSET,GLINE,DZN,PTR,ZPAY,RCERR,RCDEN
 S SDT=$O(^IBM(361.1,"E",GSTART),-1)
 ; Set up the arrays for filtering on CARC, PAYER name and Payer TINs
 D RNG^RCDPRU("CARC",GCARC,.CARR)
 ;Get possible bills to work on from ^IBM(361.1,"E") index
 F  S SDT=$O(^IBM(361.1,"E",SDT)) Q:SDT=""!(SDT>GSTOP)  D
 . S IEN="" F  S IEN=$O(^IBM(361.1,"E",SDT,IEN)) Q:IEN=""  D
 .. S RM=$$GET1^DIQ(361.1,IEN_",",102,"I") Q:$G(RM)=1  ; Quit looking if this EOB is removed
 .. ; If not all divisions then check to see if this EOB should be included
 .. I GDIV=0 S RCDIV="",RCDEN=$$GET1^DIQ(361.1,IEN_",",.01,"I") S:RCDEN'="" RCDIV=$$GET1^DIQ(399,RCDEN_",",.22,"I") Q:RCDIV=""  Q:$G(GDIV(RCDIV))=""
 .. ; Get the data for this claim and 835 Payer
 .. S ZND=^IBM(361.1,IEN,0),PTR=$P(ZND,U,1),ZPAY=$$GPAYR^RCDPRU2($P(ZND,U,3))
 .. S RCSET=1
 .. ; Are there CARC codes for this record
 .. S:($G(^IBM(361.1,IEN,10,0))']"")&($G(^IBM(361.1,IEN,15,0))']"") RCSET=0
 .. ;
 .. I RCPAY="A",RCLAIM'="A" D  Q:'RCSET  ; If both not specified check for inclusion
 ... S RCSET=$$ISTYPE^RCDPEU1(361.1,IEN,RCLAIM) ; PRCA*4.5*326 filter by Tricare etc.
 .. ;
 .. ; Check Payer Name
 .. I RCPAY'="A" D
 ... S RCSET=$$ISSEL^RCDPEU1(361.1,IEN) ; PRCA*4.5*326 this this a selected payer.
 .. ;
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
 .... Q:'$$CHK^RCDPRU2("CARC",RCGX("361.111",IX,.01,"E"),.CARR)
 .... S CNT=CNT+1
 .... S @GARRAY@("BILLS",IEN,"C",CNT)=RCGX("361.111",IX,.01,"E")_U_RCGX("361.111",IX,.02,"E")_U_RCGX("361.111",IX,.03,"E")_U_RCGX("361.111",IX,.04,"E")
 .. ; Get Line level CARC Data
 .. D:$G(^IBM(361.1,IEN,15,0))]""
 ... ; Get CARC and RARC information. CARC is in 361.11511 and RARC is in 361.1154
 ... N IX,RCGX S IX="" D GETS^DIQ(361.1,IEN_",","15*;","IE","RCGX")
 ... ; CARC^AMOUNT^QUANTITY^DESCRIPTION
 ... S IX="" F  S IX=$O(RCGX("361.11511",IX)) Q:IX=""  D
 .... ; Quit if this CARC is not on the list
 .... Q:'$$CHK^RCDPRU2("CARC",RCGX("361.11511",IX,.01,"E"),.CARR)
 .... S CNT=CNT+1
 .... S @GARRAY@("BILLS",IEN,"C",CNT)=RCGX("361.11511",IX,.01,"E")_U_RCGX("361.11511",IX,.02,"E")_U_RCGX("361.11511",IX,.03,"E")_U_RCGX("361.11511",IX,.04,"E")
 ... ; RARC^DESCRIPTION
 ... S IX="" F ZX=1:1 S IX=$O(RCGX("361.1154",IX)) Q:IX=""  S @GARRAY@("BILLS",IEN,"R",ZX)=RCGX("361.1154",IX,.02,"E")_U_RCGX("361.1154",IX,.03,"E")
 ; Possible bills have been accumulated in "BILLS" sub-array, Apply filters and accumulate data in "REPORT" sub-array
 D SORT^RCDPARC1(GARRAY,GSORT)
 Q
