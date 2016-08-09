RCDPENR2 ;ALB/SAB - EPay National Reports - ERA/EFT Trending Report ;12/10/14
 ;;4.5;Accounts Receivable;**304**;Mar 20, 1995;Build 104
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
 ;
EFTERA()  ;  EFT/ERA TRENDING REPORT
 ;
 N DIRUT,DIROUT,DTOUT,DUOUT,X,Y,POP
 N RCBGDT,RCDATA,RCDATE,RCDISP,RCENDDT,RCPYRLST,RCSDT,RCEDT,RCRQDIV,RCRPT
 N RCTIN,RCDIV,RCEXCEL,RCEX,RCPAYR,RCTINR
 ;
 ; Alert software to display to screen
 S RCDISP=1
 ;
 ; Ask for Division
 S RCRQDIV=$$GETDIV(.RCDIV)
 Q:RCRQDIV=-1
 ;
 ; Ask the user for all payers or range of payers
 S RCEX=$$GETPAY^RCDPRU(.RCPAYR) Q:'RCEX
 Q:'RCEX
 S RCPYRLST("START")=$P($G(RCPAYR("START")),U,4),RCPYRLST("END")=$P($G(RCPAYR("END")),U,4)
 ;
 ; Ask the user for all payers or range of payers by Tin
 S RCEX=$$GETTIN^RCDPRU(.RCTINR)   ;Get the list of payers using their TIN's
 Q:'RCEX
 S RCPYRLST("TIN","START")=$P($G(RCTINR("START")),U,2),RCPYRLST("TIN","END")=$P($G(RCTINR("END")),U,2)
 Q:$D(RCPYRLST("QUIT"))
 ;
 ; Ask the user for rate type
 S RCRATE=$$GETRATE()
 Q:RCRATE=-1
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
 D AUTO(1,RCBGDT,RCENDDT,.RCPYRLST,RCRQDIV,RCRPT,RCEXCEL,RCRATE,.RCDIV)
 Q
 ;
AUTO(RCDISP,RCBGDT,RCENDDT,RCPYRLST,RCRQDIV,RCRPT,RCEXCEL,RCRATE,RCDIV) ;
 ; RCDISP - Display results to screen or archive file flag
 ; RCBGDT - begin date of the report
 ; RCENDDT - End date of the report
 ; RCPYRLST - Payers to report on (All, range, or single payer)
 ; RCRQDIV - Division to report on - (A)ll or a single division
 ; RCRPT - (M)ain, (S)ummary or (G)rand Total Report
 ; RCEXCEL - Flag to indicate output in "^" delimited format
 ; RCRATE - Billing Rate Type flag
 ; RCDIV - Divisions to report on.
 ;
 ;Select output device
 W !
 I RCDISP S %ZIS="QM" D ^%ZIS Q:POP
 ;Option to queue
 I 'RCDISP,$D(IO("Q")) D  Q
 .N ZTDESC,ZTQUEUED,ZTRTN,ZTSAVE,ZTSK
 .S ZTRTN="REPORT^RCDPENR2"
 .S ZTDESC="EFT/ERA Trending Report"
 .S ZTSAVE("RC*")=""
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
 N RCPYRS,RCINS,RCDATA,RCDTLDT,RCDTLIEN,RCIEN,RCEOB,RCBILLNO,RCBATCH,RCTYPE,RCPHARM,RCPYRFLG,RCPYALL,RCTINALL
 ;
 ;Note: RCPYALL an RCTINALL are used in tag HEADER to determine header output.
 ;
 ; Clear temp arrays
 K ^TMP("RCDPEADP",$J),^TMP("RCDPENR2",$J)
 ;
 ; Compile list of divisions
 D DIV(.RCDIV)
 ;
 ; Compile the list of payers
 ; by name
 D PYRARY^RCDPENRU(RCPYRLST("START"),RCPYRLST("END"),1)  ; use insurance file payer list
 ;
 ; and by TIN
 D TINARY^RCDPENR4(RCPYRLST("TIN","START"),RCPYRLST("TIN","END"))  ; use insurance file payer list
 ;
 ; Set printout parameters
 I $D(^TMP("RCDPEADP",$J,"INS","A")) S RCPYALL=1
 I $D(^TMP("RCDPEADP",$J,"TIN","A")) S RCTINALL=1
 ;
 ; Now find only those payers in both lists
 S RCPYRFLG=$$INTRSCT^RCDPENR4()
 ;
 ; If no payers, quit.
 Q:'RCPYRFLG 
 ;
 ; Gather raw data
 D GETEFT^RCDPENR3(RCBGDT,RCENDDT,RCRATE)
 D GETERA^RCDPENR4(RCBGDT,RCENDDT,RCRATE)
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
 Q 
 ;
 ;Print the results.
PRINT(RCSUMFLG) ;Print the results
 ;
 ; Temp Array format
 ;   ^TMP("RCDPENR1",$J,"TOT")=# Medical 835's ^ # Pharmacy 835's ^
 N RCSTOP,RCPAGE,RCLINE,RCRUNDT,RCRPIEN,RCSUBJ,RCXMZ
 ;
 ;set separator print line.
 S RCLINE="",$P(RCLINE,"-",IOM)=""
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
 S:RCSUMFLG="M" RCSUMFLG="S"   ; Reset summary flag to prevent Main Column headers from appearing.
 ;
 ; Display the Payer/TIN summary information
 I RCSUMFLG'="G" S RCSTOP=$$SUMMARY()
 Q:RCSTOP
 ;
 ; Display the grand total at the end
 S RCSTOP=$$GRAND()
 Q:RCSTOP
 ;
 ; If not displaying to screen, send
 I 'RCDISP D
 . S RCSUBJ="ERA/EFT TRENDING REPORT"
 . S RCXMZ=$$XM^RCDPENRU(RCRPIEN,RCBGDT,RCENDDT,RCSUBJ)
 ;
 ;Report finished
 I $Y>(IOSL-7),RCDISP D ASK^RCDPEADP(.RCSTOP,0) Q:RCSTOP  D HEADER
 I RCDISP W !,$$ENDORPRT^RCDPEARL
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
 N RCDIVTXT,RCPYRTXT,RCTINTXT,RCSTR
 ;
 S RCDIVTXT=$$DIVTXT^RCDPENR1()
 S RCPYRTXT="ALL PAYERS" S:$G(RCPYALL)'=1 RCPYRTXT=$$PAYERTXT^RCDPENR1(344.6)
 S RCTINTXT="ALL TINS" S:$G(RCTINALL)'=1 RCTINTXT=$$TINTXT()
 ;
 S RCPAGE=RCPAGE+1
 I '+RCDISP D  Q
 . S RCSTR="EFT/ERA TRENDING REPORT^PAGE "_$J(RCPAGE,5)
 . D SAVEDATA^RCDPENR1(RCSTR,RCRPIEN)
 . S RCSTR="^"_RCDIVTXT_"^"_RCPYRTXT_"^"_RCTINTXT
 . D SAVEDATA^RCDPENR1(RCSTR,RCRPIEN)
 . S RCSTR="^"_"DATE RANGE: "_$$FMTE^XLFDT(RCBGDT,2)_" - "_$$FMTE^XLFDT(RCENDDT,2)_"^"_"RUN DATE: "_RCRUNDT
 . D SAVEDATA^RCDPENR1(RCSTR,RCRPIEN)
 . D SAVEDATA^RCDPENR1(RCLINE,RCRPIEN)
 W @IOF,"EFT/ERA TRENDING REPORT"
 I '+$G(RCEXCEL) D  Q
 . W ?70,"PAGE ",$J(RCPAGE,5),!
 . W ?5,$E(RCDIVTXT,1,23),?30,$E(RCPYRTXT,1,28),?60,$E(RCTINTXT,1,20),!
 . W ?5,"DATE RANGE: ",$$FMTE^XLFDT(RCBGDT,2)," - ",$$FMTE^XLFDT(RCENDDT,2)
 . W ?51,"RUN DATE: ",RCRUNDT,!
 . W RCLINE,!
 I +$G(RCEXCEL) D
 . W "^PAGE ",$J(RCPAGE,5),!
 . W "^",RCDIVTXT,"^",RCPYRTXT,"^",RCTINTXT,!
 . W "^","DATE RANGE: ",$$FMTE^XLFDT(RCBGDT,2)," - ",$$FMTE^XLFDT(RCENDDT,2)
 . W "^","RUN DATE: ",RCRUNDT,!
 . W RCLINE,!
 ;
 ;Re-display the column headers
 I (RCSUMFLG="M"),(RCPAGE'=1) D COLHEAD
 Q
 ;
 ;Print the Detailed portion of the report
MAIN() ;
 ;
 N RCERATYP,RCDATA,RCERATXT,RCSTRING,RCEFTTXT,RCEFT,RCERA,RCINSTIN,RCCLAIM,RCBILL
 N RCAMTBL,RCPAID,RCBILLDT,RCERADT,RCEFTDT,RCPOSTDT,RCTRACE,RCATPST,RCIDX,RCAMTPD
 N RCETRAN,RCERA,RCEOB,RCEFTNO,RCBEDY,RCEEDY,RCEPDY,RCBPDY,RCTOTDY,RCTMP,RCSTOP,RCIDX
 ;
 ; Print ERA/EFT combinations for each Insurance Company/Tin combination
 S RCINSTIN="",RCSTOP=0
 F  S RCINSTIN=$O(^TMP("RCDPENR2",$J,"MAIN",RCINSTIN)) Q:RCINSTIN=""  D  Q:RCSTOP
 . S RCSTOP=$$PRINTINS(RCINSTIN)
 . Q:RCSTOP
 . F I=1:1:3 D  Q:RCSTOP
 . . S RCERATYP=$S(I=1:"EFT/ERA",I=2:"PAPER CHECK/ERA",1:"EFT/PAPER EOB")
 . . S RCEFTTXT=$P(RCERATYP,"/")
 . . S RCERATXT=$P(RCERATYP,"/",2)
 . . S RCEFT=$S(RCEFTTXT="EFT":"AN EFT",1:"A PAPER CHECK")
 . . S RCSTRING=RCERATXT_" MATCHED TO "_RCEFT
 . . S RCSTOP=$$PRINTHDR(RCSTRING)
 . . Q:RCSTOP
 . . S RCCLAIM=""
 . . F  S RCCLAIM=$O(^TMP("RCDPENR2",$J,"MAIN",RCINSTIN,I,RCCLAIM)) Q:RCCLAIM=""  D  Q:RCSTOP
 . . . I $Y>(IOSL-7) D ASK^RCDPEADP(.RCSTOP,0) Q:RCSTOP  D HEADER
 . . . S RCDATA=$G(^TMP("RCDPENR2",$J,"MAIN",RCINSTIN,I,RCCLAIM))
 . . . I RCDATA="" D  Q
 . . . . W !,"No data captured for this section during the specified time period.",!
 . . . ;
 . . . ;Init display values for the days
 . . . S (RCBEDY,RCEEDY,RCEPDY,RCBPDY)=""
 . . . S RCBILL=$$GET1^DIQ(399,+RCCLAIM_",",".01","E")
 . . . I $P(RCDATA,U,9),$P(RCDATA,U,8) S RCBEDY=$$FMTH^XLFDT($P(RCDATA,U,9),1)-$$FMTH^XLFDT($P(RCDATA,U,8),1)
 . . . I $P(RCDATA,U,10),$P(RCDATA,U,9) S RCEEDY=$$FMTH^XLFDT($P(RCDATA,U,10),1)-$$FMTH^XLFDT($P(RCDATA,U,9),1)
 . . . S RCIDX=$S($$FMTH^XLFDT($P(RCDATA,U,10),1)>$$FMTH^XLFDT($P(RCDATA,U,10),1):10,1:9)  ; Find the latest date between ERA and EFT
 . . . I $P(RCDATA,U,11),$P(RCDATA,U,RCIDX) S RCEPDY=$$FMTH^XLFDT($P(RCDATA,U,11),1)-$$FMTH^XLFDT($P(RCDATA,U,RCIDX),1)  ; Use latest date to determ days btw ERA/EFT and Posting
 . . . I $P(RCDATA,U,11),$P(RCDATA,U,8) S RCBPDY=$$FMTH^XLFDT($P(RCDATA,U,11),1)-$$FMTH^XLFDT($P(RCDATA,U,8),1)
 . . . I RCEXCEL D
 . . . . S RCTMP=RCBILL_"^"_$$FMTE^XLFDT($P(RCDATA,U,5),2)_"^"_$P(RCDATA,U,6)_"^"_$P(RCDATA,U,7)_"^"_$$FMTE^XLFDT($P(RCDATA,U,8),2)
 . . . . S RCTMP=RCTMP_"^"_$$FMTE^XLFDT($P(RCDATA,U,9),2)_"^"_$$FMTE^XLFDT($P(RCDATA,U,10),2)_"^"_$$FMTE^XLFDT($P(RCDATA,U,11),2)_"^"_$P(RCDATA,U,12)_"^"_$P(RCDATA,U,13)
 . . . . S RCTMP=RCTMP_"^"_$P(RCDATA,U,14)_"^"_$P(RCDATA,U,2)_"^"_$P(RCDATA,U,15)_"^"_$P(RCDATA,U,3)_"^"
 . . . . S RCTMP=RCTMP_RCBEDY_"^"_RCEEDY_"^"_RCEPDY_"^"_RCBPDY
 . . . . W RCTMP,!
 . . . I 'RCEXCEL D
 . . . . W RCBILL,?21,$$FMTE^XLFDT($P(RCDATA,U,5),2),?30,$J($P(RCDATA,U,6),10,2),?41,$J($P(RCDATA,U,7),10,2),?52,$$FMTE^XLFDT($P(RCDATA,U,8),2)
 . . . . W ?61,$$FMTE^XLFDT($P(RCDATA,U,9),2),?75,$$FMTE^XLFDT($P(RCDATA,U,10),2),?89,$$FMTE^XLFDT($P(RCDATA,U,11),2),?98,$P(RCDATA,U,12),?109,$P(RCDATA,U,13),!
 . . . . W ?5,$P(RCDATA,U,14),?17,$P(RCDATA,U,2),?28,$J($P(RCDATA,U,15),6),?39,$P(RCDATA,U,3),?50,$J(RCBEDY,8)
 . . . . W ?67,$J(RCEEDY,8),?83,$J(RCEPDY,8),?106,$J(RCBPDY,8),!
 . . W RCLINE,!
 I RCSTOP Q RCSTOP
 ; Section break - ask user if they wish to continue...
 I +$G(RCEXCEL)=0 D
 . D ASK^RCDPEADP(.RCSTOP,0)
 . Q:RCSTOP
 . D HEADER
 ;
 Q RCSTOP
 ;
SUMMARY() ;Print the Payer Summary portion of the report
 ;
 N RCERATYP,RCDATA,RCERATXT,RCSTRING,RCEFTTXT,RCEFT,RCERA,RCSTOP,RCERAFLG,I
 ;
 ; Print ERA/EFT combinations for each Insurance Company/Tin combination
 S RCINSTIN="",RCSTOP=0
 F  S RCINSTIN=$O(^TMP("RCDPENR2",$J,"PAYER",RCINSTIN)) Q:RCINSTIN=""  D  Q:RCSTOP
 . I $Y>(IOSL-7) D ASK^RCDPEADP(.RCSTOP,0) Q:RCSTOP  D HEADER
 . D PRINTINS(RCINSTIN)
 . ; Print all 3 combinations
 . F I=1:1:3 D  Q:RCSTOP
 . . S RCDATA=$G(^TMP("RCDPENR2",$J,"PAYER",RCINSTIN,I))
 . . S RCERATYP=$S(I=1:"EFT/ERA",I=2:"PAPER CHECK/ERA",1:"EFT/PAPER EOB")
 . . S RCERAFLG=0
 . . S RCEFTTXT=$P(RCERATYP,"/")
 . . S RCERATXT=$P(RCERATYP,"/",2)
 . . S RCEFT=$S(RCEFTTXT="EFT":"AN EFT",1:"A PAPER CHECK")
 . . S RCSTRING=RCERATXT_" MATCHED TO "_RCEFT
 . . I (RCEFTTXT="EFT"),(RCERATXT["ERA") S RCERAFLG=1
 . . D PRINTGT^RCDPENR3(RCSTRING,RCDATA,RCDISP,RCERAFLG,RCEXCEL)
 ;
 Q RCSTOP
 ;
 ;Total for all payers in report
GRAND() ;
 ;
 N RCERATYP,RCDATA,RCERATXT,RCSTRING,RCEFTTXT,RCEFT,RCERA,RCSTOP,RCERAFLG,I
 ;
 S RCSTOP=0
 ; Print the Grand Total Banner
 I $Y>(IOSL-7),RCDISP D ASK^RCDPEADP(.RCSTOP,0) Q:RCSTOP  D HEADER
 I RCSUMFLG'="G",RCDISP D
 . W !,"GRAND TOTALS ALL PAYERS",!!
 . W RCLINE,!
 ;
 ; Print all 3 EOB/Payment combinations
 F I=1:1:3 D  Q:RCSTOP
 . S RCDATA=$G(^TMP("RCDPENR2",$J,"GTOT",I))
 . S RCERATYP=$S(I=1:"EFT/ERA",I=2:"PAPER CHECK/ERA",1:"EFT/PAPER EOB")
 . S RCERAFLG=0
 . S RCEFTTXT=$P(RCERATYP,"/")
 . S RCERATXT=$P(RCERATYP,"/",2)
 . S RCEFT=$S(RCEFTTXT="EFT":"AN EFT",1:"A PAPER CHECK")
 . S RCSTRING=RCERATXT_" MATCHED TO "_RCEFT
 . I (RCEFTTXT="EFT"),(RCERATXT["ERA") S RCERAFLG=1
 . D PRINTGT^RCDPENR3(RCSTRING,RCDATA,RCDISP,RCERAFLG,RCEXCEL)
 ;
 Q RCSTOP
 ;
 ;Print the insurance header line
PRINTINS(RCINS) ;
 N RCSTOP
 ; undeclared parameter
 ;   RCLINE - line of "-" for report formating
 ;
 S RCSTOP=0
 I $Y>(IOSL-7) D
 . D ASK^RCDPEADP(.RCSTOP,0)
 . Q:RCSTOP
 . D HEADER
 I RCSTOP Q RCSTOP
 W "PAYER NAME/TIN: ",RCINS,!
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
 D:RCSUMFLG="M" COLHEAD    ;display column headers
 ;
 Q RCSTOP
 ;
 ; Retrieve the Division
GETDIV(RCDIV) ;
 ;
 ; The use of DIVISION^VAUTOMA Supported by IA 1077
 ;
 N VAUTD
 D DIVISION^VAUTOMA
 I VAUTD=1 S RCDIV("A")="" Q 1
 I 'VAUTD&($D(VAUTD)'=11) Q -1
 M RCDIV=VAUTD
 Q 1
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
 ; Retrieve the Payer IEN from the RCDPE AUTO-PAY EXCLUSION file (#344.6)
GETARPYR(RCTIN) ;
 ;
 N RCIEN
 ;
 ; Send the IEN entry in the file if the Payer is in it.  Otherwise, send 0.
 S RCIEN=0
 ;
 ;append a space character to the tin to perform the correct search.
 S RCIEN=$O(^RCY(344.6,"C",RCTIN_" ",""))
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
 ; build the list of divisions to report on.
DIV(RCDIV) ;
 ;
 N RCI
 ;
 ; If all divisions selected, set the all division flag
 I $D(RCDIV("A")) S ^TMP("RCDPENR2",$J,"DIVALL")="" Q
 ;
 ; Loop through division list and build temp array for it.
 S RCI=0
 F  S RCI=$O(RCDIV(RCI)) Q:'RCI  S ^TMP("RCDPENR2",$J,"DIV",RCDIV(RCI))=""
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
 . S RCTMP="CLAIM#^DOS^AMT BILLED^AMT PAID^BILLED^ERA/EOB REC'D^EFT/PMT REC'D^POSTED^TRACE #"
 . S RCTMP=RCTMP_"^ETRANS TYPE^ERA#^#EEOBS^EFT#^#DAYS:(BILL/ERA)^#DAYS:(ERA/EFT)^#DAYS:(ERA+EFT/POSTED)^TOTAL #DAYS(BILL/POSTED)"
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
