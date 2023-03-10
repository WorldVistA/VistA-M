RCDPENR2 ;ALB/SAB - EPay National Reports - ERA/EFT Trending Report ; 7/1/19 2:02pm
 ;;4.5;Accounts Receivable;**304,321,326,349**;Mar 20, 1995;Build 44
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;Read ^DGCR(399) via Private IA 3820
 ;Read ^DG(40.8) via Controlled IA 417
 ;Read ^IBM(361.1) via Private IA 4051
 ;Use DIV^IBJDF2 via Private IA 3130
 ;Use DIVISION^VAUTOMA via Controlled IA 664
 ;
 Q
 ;
EFTERA()  ;  EFT/ERA TRENDING REPORT
 ;
 N DIRUT,DIROUT,DTOUT,DUOUT,X,Y,POP
 N RCBGDT,RCDATA,RCDATE,RCDISP,RCENDDT,RCPYRLST,RCSDT,RCEDT,RCRQDIV,RCRPT
 N RCCLM,RCDIV,RCEXCEL,RCEX,RCPAR,RCPAY,RCPAYR,RCTIN,RCTINR,RCTYPE,RCWHICH
 ;
 ; Alert software to display to screen
 S RCDISP=1
 ;
 ; Ask for Division
 S RCRQDIV=$$GETDIV^RCDPENR4(.RCDIV)
 Q:RCRQDIV=-1
 ;
 S RCAUTO=$$ASKAUTO^RCDPEU1() Q:RCAUTO=-1         ; PRCA*4.5*349 
 ;
 S RCTYPE=$$RTYPE^RCDPEU1() Q:RCTYPE=-1
 S RCWHICH=$$NMORTIN^RCDPEAPP() Q:RCWHICH=-1
 ;
 S RCPAR("SELC")=$$PAYRNG^RCDPEU1(0,1,RCWHICH)
 Q:RCPAR("SELC")=-1
 S RCPAY=RCPAR("SELC")
 ;
 I RCPAR("SELC")'="A" D  Q:XX=-1 
 . S RCPAR("TYPE")=RCTYPE
 . S RCPAR("SRCH")=$S(RCWHICH=2:"T",1:"N")
 . S RCPAR("FILE")=344.4
 . S RCPAR("DICA")="Select Insurance Company"_$S(RCWHICH=1:" NAME: ",1:" TIN: ")
 . S XX=$$SELPAY^RCDPEU1(.RCPAR)
 ;
 ; Ask the user for rate type
 S RCRATE=$$GETRATE()
 Q:RCRATE=-1
 ;
 ; PRCA*4.5*349 - Add Closed Claims filter
 S RCCLM=$$CLOSEDC^RCDPEU1()
 Q:RCCLM=-1
 ;
 ; Ask the user for report type, with a prompt for the main report.
 S RCRPT=$$GETRPT(1)
 Q:RCRPT=-1
 ;
 ; Retrieve start date
 S RCBGDT=$$GETSDATE()
 Q:RCBGDT=-1
 ;
 ; Retrieve end date.  Send user start date as the lower bound.
 S RCENDDT=$$GETEDATE(RCBGDT)
 Q:RCENDDT=-1
 ;
 ;If the user is running the main report, ask if they wish to export to Excel
 S RCEXCEL=0
 S:RCRPT="M" RCEXCEL=$$DISPTY^RCDPRU()
 D:RCEXCEL INFO^RCDPRU
 I 'RCEXCEL,(RCRPT="M") W !!,"This report requires 132 columns.",!!
 D AUTO(1,RCBGDT,RCENDDT,.RCPYRLST,RCRQDIV,RCRPT,RCEXCEL,RCRATE,.RCDIV,RCAUTO)
 Q
 ;
AUTO(RCDISP,RCBGDT,RCENDDT,RCPYRLST,RCRQDIV,RCRPT,RCEXCEL,RCRATE,RCDIV,RCAUTO) ;
 ; Inputs: RCAUTO (Optional) - A - Auto-Post, N-Non-Auto-Post, B-Both (Defaults to B)
 ;         RCDISP - Display results to screen or archive file flag
 ;         RCBGDT - begin date of the report
 ;         RCENDDT - End date of the report
 ;         RCPYRLST - Payers to report on (All, range, or single payer)
 ;         RCRQDIV - Division to report on - (A)ll or a single division
 ;         RCRPT - (M)ain, (S)ummary or (G)rand Total Report
 ;         RCEXCEL - Flag to indicate output in "^" delimited format
 ;         RCRATE - Billing Rate Type flag
 ;         RCDIV - Divisions to report on.
 ;         RCPAY - Payers to report on (All, range, or single payer)
 ;         RCTYPE - Types of payers to include (M - Medical, P - Pharmacy, T - Tricare)
 ;         RCWHICH - select payers by name or TIN (1 - Name, 2 - TIN)
 ;
 ;Select output device
 W !
 I $G(RCAUTO)="" S RCAUTO="B"       ; PRCA*4.5*349
 I $G(RCCLM)="" S RCCLM="A"         ; PRCA*4.5*349
 I $G(RCPAY)="" S RCPAY="A"         ; PRCA*4.5*349
 I $G(RCTYPE)="" S RCTYPE="A"       ; PRCA*4.5*349
 I $G(RCWHICH)="" S RCWHICH=2       ; PRCA*4.5*349
 I RCDISP S %ZIS="QM" D ^%ZIS Q:POP
 ;Option to queue
 I 'RCDISP,$D(IO("Q")) D  Q
 .N ZTDESC,ZTQUEUED,ZTRTN,ZTSAVE,ZTSK
 .S ZTRTN="REPORT^RCDPENR2"
 .S ZTDESC="EFT/ERA Trending Report"
 .S ZTSAVE("RC*")=""
 .S ZTSAVE("^TMP(""RCDPEU1"",$J,")=""
 .D ^%ZTLOAD
 .I $D(ZTSK) W !!,"Task number "_ZTSK_" has been queued."
 .E  W !!,"Unable to queue this job."
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 ;Compile and Print Report
 D REPORT
 Q
 ;
REPORT   ; Trace the ERA file for the given date range
 ;
 N RCPYRS,RCINS,RCDATA,RCDTLDT,RCDTLIEN,RCIEN,RCEOB,RCBILLNO,RCBATCH,RCPHARM,RCPYALL,RCTINALL
 ;
 ;Note: RCPYALL an RCTINALL are used in tag HEADER to determine header output.
 ;
 ; Clear temp arrays
 K ^TMP("RCDPEADP",$J),^TMP("RCDPENR2",$J)
 ;
 ; Compile list of divisions
 D DIV^RCDPENR4(.RCDIV)
 ;
 ; Gather raw data
 ; PRCA*4.5*349 - Add Closed Claims filter
 D GETEFT^RCDPENR3(RCBGDT,RCENDDT,RCRATE,RCCLM)
 D GETERA^RCDPENR4(RCBGDT,RCENDDT,RCRATE,RCCLM)
 ;
 ;Check for data captures
 I '$D(^TMP("RCDPENR2",$J,"MAIN")) D  Q
 .  W !!,"There was no data available for the requested report.  Please try again."
 ;
 ;Generate the statistics if any data captured
 D COMPILE^RCDPENR3
 ;
 ; Print out the results
 D PRINT(RCRPT)
 ;
 ;Clean up temp array afterwards
 K ^TMP("RCDPENR2",$J)
 K ^TMP("RCDPEU1",$J)
 Q 
 ;
 ;Print the results.
PRINT(RCSUMFLG) ;Print the results
 ;
 ; Temp Array format
 ;   ^TMP("RCDPENR1",$J,"TOT")=# Medical 835's ^ # Pharmacy 835's ^
 N RCSTOP,RCPAGE,RCLINE,RCRUNDT,RCRPIEN,RCSUBJ,RCXMZ,SECTION
 ;
 ;set separator print line.
 S RCLINE="",$P(RCLINE,"-",IOM)=""
 S SECTION=RCSUMFLG
 ;
 ; Init the stop flag, page count
 S RCSTOP=0,RCPAGE=0
 ;
 ; Set the Run date for the report
 S RCRUNDT=$$FMTE^XLFDT($$NOW^XLFDT,2)
 ;
 ; Open the device
 I RCDISP U IO
 ;
 I 'RCDISP D  Q:'RCRPIEN
 . S RCRPIEN=$$INITARCH^RCDPENR1("EFT/ERA TRENDING")
 ;
 ; Display Header
 D HEADER
 ;
 ; Display the Main Level report 
 I RCSUMFLG="M" D
 .  S RCSTOP=$$MAIN()
 Q:RCSTOP
 ;
 S SECTION="S"
 I +$G(RCEXCEL)=0,RCSUMFLG="M" D
 . D ASK^RCDPEADP(.RCSTOP,0)
 . Q:RCSTOP
 . D HEADER
 I RCSTOP Q
 ;
 ; Display the Payer/TIN summary information
 I RCSUMFLG="S" S RCSTOP=$$SUMMARY()
 Q:RCSTOP
 ;
 ; Display the grand total at the end
 S SECTION="G"
 S RCSTOP=$$GRAND()
 Q:RCSTOP
 ;
 ; If not displaying to screen, send
 I 'RCDISP D
 . S RCSUBJ="ERA/EFT TRENDING REPORT"
 . S RCXMZ=$$XM^RCDPENRU(RCRPIEN,RCBGDT,RCENDDT,RCSUBJ)
 ;
 ;Report finished
 I $Y>(IOSL-4),RCDISP D ASK^RCDPEADP(.RCSTOP,0) Q:RCSTOP  D HEADER
 I RCDISP,'$G(RCEXCEL) W !,$$ENDORPRT^RCDPEARL
 W !
 ;
 ;Close device
 I '$D(ZTQUEUED) D ^%ZISC
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
HEADER ;Print the results
 ;
 ; Undeclared Parameters - RCDISP and RCRPIEN
 ;
 N RCAUTOT,RCDIVTXT,RCPYRTXT,RCSTR,RCTYPTXT,RCCLMTXT
 ;
 S RCDIVTXT=$$DIVTXT^RCDPENR1()
 S RCPYRTXT=$S(RCPAY="S":"SELECTED",RCPAY="R":"RANGE",1:"ALL")_" "
 S RCPYRTXT=RCPYRTXT_$S(RCWHICH=2:"TINS",1:"PAYERS")
 S RCTYPTXT=$S('+$G(RCEXCEL):"MEDICAL/PHARMACY/TRICARE: ",1:"")
 S RCTYPTXT=RCTYPTXT_$S(RCTYPE="M":"MEDICAL",RCTYPE="P":"PHARMACY",RCTYPE="T":"TRICARE",1:"ALL")
 S RCAUTOT="MANUAL/AUTOPOST: "_$S(RCAUTO="N":"MANUAL",RCAUTO="A":"AUTOPOST",1:"BOTH")
 S RCCLMTXT="Claims: "_$S(RCCLM="C":"CLOSED",1:"ALL")              ; PRCA*4.5*349
 ;
 S RCPAGE=RCPAGE+1
 I '+RCDISP D  Q
 . S RCSTR="EFT/ERA TRENDING REPORT^PAGE "_$J(RCPAGE,5)
 . D SAVEDATA^RCDPENR1(RCSTR,RCRPIEN)
 . S RCSTR="^"_RCDIVTXT_"^"_RCPYRTXT_"^"_RCTYPTXT
 . D SAVEDATA^RCDPENR1(RCSTR,RCRPIEN)
 . S RCSTR="^"_"DATE RANGE: "_$$FMTE^XLFDT(RCBGDT,2)_" - "_$$FMTE^XLFDT(RCENDDT,2)_"^"_"RUN DATE: "_RCRUNDT
 . D SAVEDATA^RCDPENR1(RCSTR,RCRPIEN)
 . D SAVEDATA^RCDPENR1(RCLINE,RCRPIEN)
 W @IOF,"EFT/ERA TRENDING REPORT"
 I '$G(RCEXCEL) D  ;
 . W ?122,"PAGE ",$J(RCPAGE,5),!
 . W " "_$E(RCDIVTXT,1,23),?25,$E(RCPYRTXT,1,20),?46,$E(RCTYPTXT,1,35)
 . W ?80,RCAUTOT,?108,RCCLMTXT,!
 . W ?5,"DATE RANGE: ",$$FMTE^XLFDT(RCBGDT,2)," - ",$$FMTE^XLFDT(RCENDDT,2)
 . W ?51,"RUN DATE: ",RCRUNDT,!
 . W RCLINE,!
 I +$G(RCEXCEL) D
 . W "^PAGE ",$J(RCPAGE,5)
 . W "^",RCDIVTXT,"^",RCPYRTXT,"^",RCTYPTXT
 . W "^","DATE RANGE: ",$$FMTE^XLFDT(RCBGDT,2)," - ",$$FMTE^XLFDT(RCENDDT,2)
 . W "^","RUN DATE: ",RCRUNDT
 . W "^",RCAUTOT,"^",RCCLMTXT,!
 ;
 ; Re-display the column headers
 I '$G(RCEXCEL),(SECTION="M") D COLHEAD
 I $G(RCEXCEL),(RCPAGE=1) D COLHEAD
 Q
 ;
 ;Print the Detailed portion of the report
MAIN() ;
 ;
 N RCERATYP,RCDATA,RCERATXT,RCSTRING,RCEFTTXT,RCEFT,RCERA,RCINSTIN,RCCLAIM,RCBILL
 N RCAMTBL,RCPAID,RCBILLDT,RCERADT,RCEFTDT,RCPOSTDT,RCTRACE,RCATPST,RCIDX,RCAMTPD
 N RCETRAN,RCERA,RCEOB,RCEFTNO,RCBEDY,RCEEDY,RCEPDY,RCBPDY,RCMETHOD,RCTOTDY,RCTMP,RCSTOP,RCIDX
 ;
 ; Print ERA/EFT combinations for each Insurance Company/Tin combination
 S RCINSTIN="",RCSTOP=0
 F  S RCINSTIN=$O(^TMP("RCDPENR2",$J,"MAIN",RCINSTIN)) Q:RCINSTIN=""  D  Q:RCSTOP
 . S RCMETHOD=""
 . F  S RCMETHOD=$O(^TMP("RCDPENR2",$J,"MAIN",RCINSTIN,RCMETHOD)) Q:RCMETHOD=""  D  Q:RCSTOP
 . . I (RCAUTO="A"&(RCMETHOD="MANUAL"))!(RCAUTO="N"&(RCMETHOD="AUTOPOST")) Q  ; PRCA*4.5*349
 . . S RCSTOP=$$PRINTINS(RCINSTIN) ; PRCA*4.5*349 add "." to this and every subsequent line
 . . Q:RCSTOP
 . . F I=1:1:3 D  Q:RCSTOP
 . . . I RCMETHOD="AUTOPOST",I>1 Q  ; Only EFT/ERA can be auto-posted - PRCA*4.5*349
 . . . S RCERATYP=$S(I=1:"EFT/ERA",I=2:"PAPER CHECK/ERA",1:"EFT/PAPER EOB")
 . . . S RCEFTTXT=$P(RCERATYP,"/")
 . . . S RCERATXT=$P(RCERATYP,"/",2)
 . . . S RCEFT=$S(RCEFTTXT="EFT":"AN EFT",1:"A PAPER CHECK")
 . . . S RCSTRING=RCERATXT_" MATCHED TO "_RCEFT_" - "_RCMETHOD ; PRCA*4.5*349
 . . . S RCSTOP=$$PRINTHDR(RCSTRING)
 . . . Q:RCSTOP
 . . . I '$G(RCEXCEL),$O(^TMP("RCDPENR2",$J,"MAIN",RCINSTIN,RCMETHOD,I,""))="" D      ; PRCA*4.5*349
 . . . . W "No data captured for this section during the specified time period.",!   ; PRCA*4.5*349
 . . . S RCCLAIM=""
 . . . F  S RCCLAIM=$O(^TMP("RCDPENR2",$J,"MAIN",RCINSTIN,RCMETHOD,I,RCCLAIM)) Q:RCCLAIM=""  D  Q:RCSTOP
 . . . . I $Y>(IOSL-5) D ASK^RCDPEADP(.RCSTOP,0) Q:RCSTOP  D HEADER
 . . . . S RCDATA=$G(^TMP("RCDPENR2",$J,"MAIN",RCINSTIN,RCMETHOD,I,RCCLAIM))
 . . . . I RCDATA="" D  Q
 . . . . . W !,"No data captured for this section during the specified time period.",!
 . . . . ;
 . . . . ;Init display values for the days
 . . . . S (RCBEDY,RCEEDY,RCEPDY,RCBPDY)=""
 . . . . S RCBILL=$$GET1^DIQ(399,+RCCLAIM_",",".01","E")
 . . . . I $P(RCDATA,U,9),$P(RCDATA,U,8) S RCBEDY=$$FMTH^XLFDT($P(RCDATA,U,9),1)-$$FMTH^XLFDT($P(RCDATA,U,8),1)
 . . . . I $P(RCDATA,U,10),$P(RCDATA,U,9) S RCEEDY=$$FMTH^XLFDT($P(RCDATA,U,10),1)-$$FMTH^XLFDT($P(RCDATA,U,9),1)
 . . . . S RCIDX=$S($$FMTH^XLFDT($P(RCDATA,U,10),1)>$$FMTH^XLFDT($P(RCDATA,U,10),1):10,1:9)  ; Find the latest date between ERA and EFT
 . . . . I $P(RCDATA,U,11),$P(RCDATA,U,RCIDX) S RCEPDY=$$FMTH^XLFDT($P(RCDATA,U,11),1)-$$FMTH^XLFDT($P(RCDATA,U,RCIDX),1)  ; Use latest date to determ days btw ERA/EFT and Posting
 . . . . I $P(RCDATA,U,11),$P(RCDATA,U,8) S RCBPDY=$$FMTH^XLFDT($P(RCDATA,U,11),1)-$$FMTH^XLFDT($P(RCDATA,U,8),1)
 . . . . I RCEXCEL D
 . . . . .  S RCTMP=RCBILL_"^"_$$FMTE^XLFDT($P(RCDATA,U,5),2)_"^"_$P(RCDATA,U,6)_"^"_$P(RCDATA,U,7)_"^"_$$FMTE^XLFDT($P(RCDATA,U,8),2)
 . . . . . S RCTMP=RCTMP_"^"_$$FMTE^XLFDT($P(RCDATA,U,9),2)_"^"_$$FMTE^XLFDT($P(RCDATA,U,10),2)_"^"_$$FMTE^XLFDT($P(RCDATA,U,11),2)_"^"_$P(RCDATA,U,12)_"^"_$P(RCDATA,U,13)
 . . . . . S RCTMP=RCTMP_"^"_$P(RCDATA,U,14)_"^"_$P(RCDATA,U,2)_"^"_$P(RCDATA,U,15)_"^"_$P(RCDATA,U,3)_"^"
 . . . . . S RCTMP=RCTMP_RCBEDY_"^"_RCEEDY_"^"_RCEPDY_"^"_RCBPDY
 . . . . . W RCTMP,!
 . . . . I 'RCEXCEL D
 . . . . . W RCBILL,?21,$$FMTE^XLFDT($P(RCDATA,U,5),2),?30,$J($P(RCDATA,U,6),10,2),?41,$J($P(RCDATA,U,7),10,2),?52,$$FMTE^XLFDT($P(RCDATA,U,8),2)
 . . . . . W ?61,$$FMTE^XLFDT($P(RCDATA,U,9),2),?75,$$FMTE^XLFDT($P(RCDATA,U,10),2),?89,$$FMTE^XLFDT($P(RCDATA,U,11),2),?98,$P(RCDATA,U,12),?109,$P(RCDATA,U,13),!
 . . . . . W ?5,$P(RCDATA,U,14),?17,$P(RCDATA,U,2),?28,$J($P(RCDATA,U,15),6),?39,$P(RCDATA,U,3),?50,$J(RCBEDY,8)
 . . . . . W ?67,$J(RCEEDY,8),?83,$J(RCEPDY,8),?106,$J(RCBPDY,8),!
 . . . I '$G(RCEXCEL) W RCLINE,!
 ;
 I RCSTOP Q RCSTOP
 ; Section break - ask user if they wish to continue...
 ;
 Q RCSTOP
 ;
SUMMARY() ;Print the Payer Summary portion of the report
 ;
 I $G(RCEXCEL) Q 0
 N RCSTOP ; PRCA*4.5*349
 ;
 ; Print ERA/EFT combinations for each Insurance Company/Tin combination
 S RCINSTIN="",RCSTOP=0
 F  S RCINSTIN=$O(^TMP("RCDPENR2",$J,"PAYER",RCINSTIN)) Q:RCINSTIN=""  D  Q:RCSTOP
 . D PAYSUM^RCDPENR4(RCINSTIN)
 Q RCSTOP
 ;
 ;Total for all payers in report
GRAND() ;
 I $G(RCEXCEL) Q 0
 ;
 N I,J,RCDATA,RCEFT,RCERA,RCERAFLG,RCEFTTXT,RCERATXT,RCERATYP,RCSTRING,RCSTOP ; PRCA*4.5*349
 ;
 S RCSTOP=0
 ; Print the Grand Total Banner
 I $Y>(IOSL-7),RCDISP D ASK^RCDPEADP(.RCSTOP,0) Q:RCSTOP  D HEADER
 I RCSUMFLG'="G",RCDISP D
 . W !,"GRAND TOTALS ALL PAYERS",!!
 . W RCLINE,!
 ;
 ; Print all 3 EOB/Payment combinations
 F J="AUTOPOST","MANUAL","TOTAL" Q:RCSTOP  F I=1:1:3 D  Q:RCSTOP  ; PRCA*4.5*349
 . I J="AUTOPOST",I>1 Q  ; Only EFT/ERA can be auto-posted - PRCA*4.5*349
 . I (RCAUTO="A"&(J="MANUAL"))!(RCAUTO="N"&(J="AUTOPOST"))!(RCAUTO'="B"&(J="TOTAL")) Q  ; PRCA*4.5*349
 . S RCDATA=$G(^TMP("RCDPENR2",$J,"GTOT",J,I)) ; PRCA*4.5*349
 . S RCERATYP=$S(I=1:"EFT/ERA",I=2:"PAPER CHECK/ERA",1:"EFT/PAPER EOB")
 . S RCERAFLG=0
 . S RCEFTTXT=$P(RCERATYP,"/")
 . S RCERATXT=$P(RCERATYP,"/",2)
 . S RCEFT=$S(RCEFTTXT="EFT":"AN EFT",1:"A PAPER CHECK")
 . S RCSTRING=RCERATXT_" MATCHED TO "_RCEFT_" - "_J ; PRCA*4.5*349
 . I (RCEFTTXT="EFT"),(RCERATXT["ERA") S RCERAFLG=1
 . D PRINTGT^RCDPENR3(RCSTRING,RCDATA,RCDISP,RCERAFLG,RCEXCEL)
 ;
 Q RCSTOP
 ;
PRINTINS(RCINS) ; Print the insurance header line
 ; Input:   RCINS   - Payer Name/TIN to be displayed
 ;          RCLINE  - line of dashes used for separation
 ; Returns 1 - User quit out of report, 0 otherwise
 I $G(RCEXCEL) Q 0
 N RCSTOP,XX,YY,ZZ
 ;
 S RCSTOP=0
 I $Y>(IOSL-7) D
 . D ASK^RCDPEADP(.RCSTOP,0)
 . Q:RCSTOP
 . D HEADER
 I RCSTOP Q RCSTOP
 W "PAYER NAME/TIN",!
 W " ",$$PAYTIN^RCDPRU2(RCINS,78),!
 W RCLINE,!
 Q RCSTOP
 ;
 ;Print the Payment Method header lines
PRINTHDR(RCTITLE) ;
 ; Undeclared parameters
 ;   RCLINE - line of "-" for report formating
 ;   RCSUMFLG - Type of report (M=Main,S=Summary,G=Grand Total)
 ;   RCDISP - Is the report being email (0) or Printed (1)
 ;   RCRPIEN - IEN to store the report if emailing
 ;
 I $G(RCEXCEL) Q 0
 N RCBORDER,RCSTOP,RCSTR
 ;
 S RCBORDER="",$P(RCBORDER,"*",20)="",RCSTOP=0
 I $Y>(IOSL-7),RCDISP D
 . D ASK^RCDPEADP(.RCSTOP,0)
 . Q:RCSTOP
 . D HEADER
 I RCSTOP Q RCSTOP
 ;
 ; Display report type being displayed
 I 'RCDISP D  Q
 . S RCSTR=RCBORDER_"     "_RCTITLE_"     "_RCBORDER
 . D SAVEDATA^RCDPENR1(RCSTR,RCRPIEN)
 . D SAVEDATA^RCDPENR1(RCLINE,RCRPIEN)
 I RCDISP D
 . W RCBORDER,"     ",RCTITLE,"     ",RCBORDER,!
 . W RCLINE,!
 ;
 Q RCSTOP
 ;
GETDIV(RCDIV) ; Retrieve the Division
 ; PRCA*4.5*349 - Moved to RCDPENR4 for size
 Q $$GETDIV^RCDPENR4(.RCDIV)
 ;
 ;Retrieve the Report Type
GETRATE() ;
 ;
 ;RCMNFLG - Ask to print the Main report (Detailed) report.  0=No, 1=Yes
 N X,Y,DIC,DTOUT,DUOUT
 ;
 S DIC="^DGCR(399.3,",DIC(0)="AEQMN"
 S DIC("S")="I $P(^(0),U,7)=""i"""
 D ^DIC K DIC
 Q +Y
 ;
 ;Retrieve the Report Type
GETRPT(RCMNFLG) ;
 ;
 ;RCMNFLG - Ask to print the Main report (Detailed) report.  0=No, 1=Yes
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT
 ;
 ; Prompt with Main (EFT/ERA Trending report (from RCDPENR2))
 I $G(RCMNFLG) D
 . S DIR("A")="Print (M)AIN Report, (S)UMMARY by Payer or (G)RAND TOTALS ONLY: "
 . S DIR(0)="SA^M:MAIN;S:SUMMARY;G:GRAND TOTAL"
 ;
 ; Prompt w/o main (Volume Statistics report (from RCDPENR1))
 I '$G(RCMNFLG) D
 . S DIR("A")="(S)UMMARY by Payer or (G)RAND TOTALS ONLY: "
 . S DIR(0)="SA^S:SUMMARY;G:GRAND TOTAL"
 ;
 S DIR("?")="Select the type of report to Generate."
 S DIR("B")="G"
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="")  Q -1
 Q Y
 ;
 ;
GETSDATE()  ;
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT,RCTODAY
 ;
 ;Assume the start date is 45 days prior to the end date
 ;
 ;Get the start date.  
 S RCTODAY=$P($$NOW^XLFDT,".")
 S DIR("?")="ENTER THE EARLIEST DATE TO INCLUDE ON THE REPORT"
 S DIR(0)="DA^:"_RCTODAY_":APE",DIR("A")="Start with DATE: "
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") Q -1
 Q Y
 ;
 ; Retrieve the end date of the report from the user.
GETEDATE(RCBDATE)  ;
 ; RCBDATE - Begin date of the report.  Used as a lower bound
 ;
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT,RCTODAY
 ;
 ; Get the End date first.  Assume the end date is today.
 S RCTODAY=$P($$NOW^XLFDT,".")
 S DIR("?")="ENTER THE LATEST DATE TO INCLUDE ON THE REPORT"
 S DIR("B")=$$FMTE^XLFDT(RCTODAY,2)
 S DIR(0)="DAO^"_$G(RCBDATE)_":"_RCTODAY_":APE",DIR("A")="Go to DATE: " D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") Q -1
 Q Y
 ; 
GETARPYR(RCTIN,RCPAY) ; Retrieve the Payer IEN from the RCDPE AUTO-PAY EXCLUSION file (#344.6)
 ; Input: RCTIN - Payer ID
 ;        RCPAY - Payer Name (optional)
 ; Return: Payer IEN (#344.6)
 ;
 N RCIEN,QUIT,ZZ
 S RCPAY=$G(RCPAY)
 ;
 ; Send the IEN entry in the file if the Payer is in it.  Otherwise, send 0.
 S RCIEN=0
 ;
 ; PRCA*4.5*321 - Add optional payer name to search to narrow down payer
 I RCPAY'="" D  ;
 . S ZZ="",QUIT=0
 . F  S ZZ=$O(^RCY(344.6,"C",RCTIN_" ",ZZ)) Q:ZZ=""  D  I RCIEN Q  ;
 . . I $$GET1^DIQ(344.6,ZZ_",",.01,"E")=RCPAY S RCIEN=ZZ
 ;
 I 'RCIEN D  ;
 . S RCIEN=$O(^RCY(344.6,"C",RCTIN_" ",""))
 ;
 Q +RCIEN
 ;
 ; Determine if the payer in the ERA or EFT should be included in the report.
INSCHK(RCINS) ;
 ;
 ;Send yes if all payers are being reported on.
 Q:$D(^TMP("RCDPENR2",$J,"INS","A")) 1
 ;
 ; Send yes if Payer is in the list to report on
 Q:$D(^TMP("RCDPENR2",$J,"INS",RCINS)) 1
 ;
 ; Otherwise, send no
 Q 0
 ;
DIV(RCDIV) ; build the list of divisions to report on.
 ; PRCA*4.5*349 - Moved to RCDPENR4 for size
 D DIV^RCDPENR4(.RCDIV)
 Q
 ;Determine the text to display for the Payer TINs
TINTXT() ;
 ;
 N RCTIN,RCTXT,RCTNTXT
 ; 
 Q:$D(^TMP("RCDPEADP",$J,"TIN","A")) "ALL PAYER TINS"
 ;
 ;Build list of Payer Tins
 ;
 S RCTIN="",RCTXT=""
 F  S RCTIN=$O(^TMP("RCDPEADP",$J,"TIN",RCTIN)) Q:RCTIN=""  D
 . S RCTNTXT=$$GET1^DIQ(344.6,+RCTIN_",",".02","I")
 . S RCTXT=RCTXT_RCTNTXT_","
 ;
 ; Remove comma at the end. 
 S RCTXT=$E(RCTXT,1,$L(RCTXT)-1)
 ;
 ; Display the first 35 characters of the division text list,
 Q $E(RCTXT,1,35)
 ;
COLHEAD ;
 ;
 N RCTMP
 ;
 ;Display the column headers
 I RCEXCEL D
 . S RCTMP="CLAIM#^DOS^AMT BILLED^AMT PAID^BILLED^ERA/EOB REC'D^EFT/PMT REC'D^POSTED^TRACE #^AUTOPOST/MANUAL"
 . S RCTMP=RCTMP_"^ETRANS TYPE^ERA#^#EEOBS^EFT#^#DAYS:(BILL/ERA)^#DAYS:(ERA/EFT)^#DAYS:(ERA+EFT/POSTED)^"
 . S RCTMP=RCTMP_"TOTAL #DAYS(BILL/POSTED)"
 . W RCTMP,!
 I 'RCEXCEL D
 . W "CLAIM#",?21,"DOS",?30,"AMT BILLED",?41,"AMT PAID",?52,"BILLED",?61,"ERA/EOB REC'D",?75,"EFT/PMT REC'D",?89,"POSTED",?98,"TRACE #",?109,"AUTOPOST/MANUAL",!
 . W ?5,"ETRANS TYPE",?17,"ERA#",?28,"#EEOBS",?39,"EFT#",?50,"#DAYS:(BILL/ERA)",?67,"#DAYS:(ERA/EFT)",?83,"#DAYS:(ERA+EFT/POSTED)",?106,"TOTAL #DAYS(BILL/POSTED)",!
 . W RCLINE,!
 Q
 ;
 ;Entry point for reprinting the header.
REPRINT(RCIEN) ;
 ;
 N I,RCDATA,J,RCSTOP,PAGE
 ;
 ;
 S PAGE=1
 D RPTHDR(RCIEN,PAGE)
 ;
 S I=4,RCSTOP=0  ;loop through the main body
 F  S I=$O(^RCDM(344.91,RCIEN,1,I)) Q:'I  D  Q:RCSTOP
 .  S RCDATA=$G(^RCDM(344.91,RCIEN,1,I,0))
 .  ;
 .  I $Y>(IOSL-4) D  Q:RCSTOP
 .  . D ASK^RCDPEADP(.RCSTOP,0)
 .  . Q:RCSTOP
 .  . S PAGE=PAGE+1
 .  . D RPTHDR(RCIEN,PAGE)
 .  ; main body of report
 .  W $P(RCDATA,U)
 .  I RCDATA["^" W ?65,$P(RCDATA,U,2)
 .  W !      ;Add <CRLF>
 Q
 ;
RPTHDR(RCIEN,PAGE) ; Reprint the header
 ;
 N I,RCDATA
 ;
 W @IOF   ; Create new page
 ;
 F I=1:1:4 D
 . S RCDATA=$G(^RCDM(344.91,RCIEN,1,I,0))
 . ; header lines formatting
 . I I=1 W ?15,$P(RCDATA,U),?70,PAGE,! Q
 . I I=2 W ?5,$P(RCDATA,U,2),! Q
 . I I=3!(I=4) W ?5,$P(RCDATA,U,2),?45,$P(RCDATA,U,3),! Q
 Q
