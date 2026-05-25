RCDPENR5 ;ALB/CNF - EPay National Reports - ERA/EFT Report Utilities ;12/14/15
 ;;4.5;Accounts Receivable;**446**;Mar 20, 1995;Build 15
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
GETRPT(RCMNFLG) ;
 ; PRCA*4.5*446 - Moved from RCDPENR2 for size
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
GRAND(RCPUZ) ; PRCA*4.5*446 - Moved from RCDPENR2 for size
 ;  Input    RCPUZ - P: Payment EEOBs, U: Unmatched EEOBs, Z: Zero Payment EEOBs, A: All       ;PRCA*4.5*446
 ;
 S:'$L($G(RCPUZ)) RCPUZ="A"
 I $G(RCEXCEL) Q 0
 ;
 N I,I1,I2,I3,J,RCDATA,RCEFT,RCERA,RCERAFLG,RCEFTTXT,RCERATXT,RCERATYP,RCSTRING,RCSTOP ; PRCA*4.5*349, PRCA*4.5*446 I1,I2,I3
 ;
 S RCSTOP=0
 ; Print the Grand Total Banner
 I $Y>(IOSL-7),RCDISP D ASK^RCDPEADP(.RCSTOP,0) Q:RCSTOP  D HEADER^RCDPENR2
 I RCSUMFLG'="G",RCDISP D
 . W !,"GRAND TOTALS ALL PAYERS",!!
 . W RCLINE,!
 ;
 ; PRCA*4.5*446, add I1,I2,I3
 S I1=1,I2=1,I3=5   ; default for RCPUZ="A", ALL
 I RCPUZ="U" S I1=4,I3=4        ;Unposted contains Zero Pay and Unmatched
 I RCPUZ="Z" S I1=5,I3=5        ;Unposted contains Zero Pay and Unmatched
 I RCPUZ="P" S I3=3             ;Don't include Unposted
 ;
 ; Print all EOB/Payment combinations
 F J="AUTOPOST","MANUAL","UNPOSTED","TOTAL" Q:RCSTOP  F I=I1:I2:I3 D  Q:RCSTOP  ; PRCA*4.5*349, PRCA*4.5*446 use I1,I2,I3
 . ;
 . ; PRCA*4.5*446 filter for RCPUZ
 . I (RCPUZ="U")!(RCPUZ="Z") I (J="AUTOPOST")!(J="MANUAL") Q
 . I (RCPUZ="U")!(RCPUZ="Z") I J="TOTAL" Q   ; For Unmatched and Zero Pay, there are not 2 categories to total together like Autopost+Manual
 . I RCPUZ="P" I J="UNPOSTED" Q
 . ;
 . I J="AUTOPOST",I>1 Q  ; Only EFT/ERA can be auto-posted - PRCA*4.5*349
 . I J="MANUAL",I>3 Q    ; Unmatched and Zero pay are Unposted
 . I J="UNPOSTED",I<4 Q  ; Unmatched and Zero pay are Unposted
 . I '("/Z/U/"[("/"_RCPUZ_"/")) I (RCAUTO="A"&(J="MANUAL"))!(RCAUTO="N"&(J="AUTOPOST"))!(RCAUTO'="B"&(J="TOTAL")) Q  ; PRCA*4.5*349, PRCA*4.5*446 check RCPUZ
 . I RCPUZ="P" I J="UNPOSTED" Q   ; PRCA*4.5*446, If user wants to see Posted, exclude Zero Pay and Unmatched (Unposted)
 . S RCDATA=$G(^TMP("RCDPENR2",$J,"GTOT",J,I)) ; PRCA*4.5*349
 . S RCERATYP=$S(I=1:"EFT/ERA",I=2:"PAPER CHECK/ERA",I=3:"EFT/PAPER EOB",I=4:"/UNMATCHED ERA",1:"/ZERO PAYMENTS")  ; PRCA*4.5*446
 . S RCERAFLG=0
 . S RCEFTTXT=$P(RCERATYP,"/")
 . S RCERATXT=$P(RCERATYP,"/",2)
 . S RCEFT=$S(RCEFTTXT="EFT":"AN EFT",RCEFTTXT="PAPER CHECK":"A PAPER CHECK",1:"")  ; PRCA*4.5*446
 . I '((I=4)!(I=5)) S RCSTRING=RCERATXT_" MATCHED TO "_RCEFT_" - "_J ; PRCA*4.5*349, PRCA*4.5**446 If not unmatched or zero pay
 . I ((I=4)!(I=5)) S RCSTRING=RCERATXT   ; PRCA*4.5**446 If not unmatched or zero pay
 . I (RCEFTTXT="EFT"),(RCERATXT["ERA") S RCERAFLG=1
 . I (I=4)!(I=5) S RCERAFLG=1   ; PRCA*4.5*446 If unmatched or zero pay, then set ERA flag
 . D PRINTGT(RCSTRING,RCDATA,RCDISP,RCERAFLG,RCEXCEL,RCPUZ)
 ;
 Q RCSTOP
 ;
 ;Print the Grand Total/Summary data, Moved from ^RCDPENR3 because of routine size PRCA*4.5*446
PRINTGT(RCTITLE,RCDATA,RCDISP,RCERAFLG,RCEXCEL,RCPUZ) ;PRCA*4.5*332 - added comments below, 20 August 2018
 ; Print the Grand Total/Summary data for the EFT/ERA Trending Report
 ; Input: RCTITLE - Name of the report
 ; RCDATA - Array of compiled data being processed. RCDATA("A") autoposted, RCDATA("M") manually posted
 ; RCDISP - 1 - Display to screen, 0 otherwise 
 ; RCERAFLG - 1 if we're in the ERA matched to an EFT section
 ; 0 otherwise
 ; RCEXCEL - 1 output to excel, 0 otherwise
 ; RCPUZ - P: Payment EEOBs, U: Unmatched EEOBs, Z: Zero Payment EEOBs, A: All       ;PRCA*4.5*446
 ; RCSTOP - Initialized to 0
 ; Output: RCSTOP - User stopped the display of the report
 ;
 ; Undeclared Parameter(s) - RCRPIEN,RCLINE,RCSTOP
 ; RCRPIEN - IEN of the archive file (344.91(
 ; RCLINE - String of '-' (separator line)
 ; RCSUMFLG - 'M' - Main Report
 ; 'G' - Grand totals
 ; 'S' - Summary
 ;
 ;PRCA*4.5*332 comments end 
 ;
 N RCCOUNT,RCBILL,RCPAID,RCPCT,RCBECT,RCBEDY,RCAVGBE,RCEECT,RCEEDY
 N RCEPCT,RCEPDY,RCAVGEP,RCBPCT,RCBPDY,RCAVGBP,RCBORDER,RCSCDATA
 N RCC,RCB,RCAVGEE,RCLTXT,RCNA,I,RCSTRDTA,RCSTRNG,RCDTXT
 ;
 I '$L($G(RCPUZ)) S RCPUZ="A"  ;PRCA*4.5*446
 S RCERAFLG=+$G(RCERAFLG),RCDISP=$G(RCDISP)
 I $Y>(IOSL-7),RCDISP D ASK^RCDPEADP(.RCSTOP,0) Q:RCSTOP  D HEADER^RCDPENR2
 ;
 ; Display report type being displayed
 D PRINTHDR^RCDPENR2(RCTITLE,79)    ; PRCA*4.5*446, 79 (line length)
 ;
 ; Extract data from string and build string for output
 S $P(RCSCDATA,U,1)=+$P(RCDATA,U)
 S RCBILL=+$P(RCDATA,U,2)
 S RCPAID=+$P(RCDATA,U,3)
 S $P(RCSCDATA,U,2)=RCBILL
 S $P(RCSCDATA,U,3)=RCPAID
 S $P(RCSCDATA,U,4)=$S(+RCBILL=0:0,1:RCPAID/RCBILL)*100  ; Convert to percent format
 S RCBECT=+$P(RCDATA,U,4)
 S RCBEDY=+$P(RCDATA,U,5)
 S $P(RCSCDATA,U,6)=$FN($S(+RCBECT=0:0,1:RCBEDY/RCBECT),"",0)
 S RCEECT=+$P(RCDATA,U,6)
 S RCEEDY=+$P(RCDATA,U,7)
 S $P(RCSCDATA,U,7)=$FN($S(+RCEECT=0:0,1:RCEEDY/RCEECT),"",0)
 S RCEPCT=+$P(RCDATA,U,8)
 S RCEPDY=+$P(RCDATA,U,9)
 S $P(RCSCDATA,U,8)=$FN($S(+RCEPCT=0:0,1:RCEPDY/RCEPCT),"",0)
 S RCBPCT=+$P(RCDATA,U,10)
 S RCBPDY=+$P(RCDATA,U,11)
 S $P(RCSCDATA,U,9)=$FN($S(+RCBPCT=0:0,1:RCBPDY/RCBPCT),"",0)
 S $P(RCSCDATA,U,11)=+$P(RCDATA,U,12)
 S $P(RCSCDATA,U,12)=+$P(RCDATA,U,13)
 S $P(RCSCDATA,U,14)=+$P(RCDATA,U,14)
 S $P(RCSCDATA,U,15)=+$P(RCDATA,U,15)
 S $P(RCSCDATA,U,16)=RCPAID-$P(RCDATA,U,15)
 ;
 ; PRCA*4.5*446 Correct data for Unmatched and Zero Payments
 S RCNA=0 I (RCTITLE["UNMATCHED")!(RCTITLE["ZERO") S RCNA=1 F I=7,8,9,14 S $P(RCSCDATA,U,I)="N/A"
 ;
 F I=1:1:16 D  Q:RCSTOP
 . ; PRC*4.5*332, added (RCSUMFLG'="G") below
 . I (RCSUMFLG'="G"),RCDISP,($Y>(IOSL-4)) D  Q:RCSTOP
 . .  D ASK^RCDPEADP(.RCSTOP,0)
 . .  Q:RCSTOP
 . .  D HEADER^RCDPENR2
 . ;if printing from monthly background job save in file and quit
 . ;Otherwise print to screen
 . S (RCLTXT,RCDTXT)=$P($T(GDTXT+I),";;",2)
 . I RCTITLE["PAPER" D
 . . I (I>5),(I<9) D      ; correct display for lines 6,7,8,16
 . . . I (I=6),RCTITLE["CHECK" Q     ;Dont change line 6 if Paper check section
 . . . S RCB="EFT",RCC="CHK"  ; Correct display for Paper check section
 . . . I RCTITLE["EOB" S RCB="ERA",RCC="EOB"   ;correct display for paper eob
 . . . S RCDTXT=$P(RCLTXT,RCB,1)_RCC_$P(RCLTXT,RCB,2)
 . I 'RCDISP!RCEXCEL D  Q
 . . S RCSTRDTA=$P(RCSCDATA,U,I)
 . . ;Format lines: lines 2&3 are amounts, 4 is a percentage, remainder are integers.
 . . S RCSTRNG=RCDTXT_"^"_$S(I=4:$J($P(RCSTRDTA,"."),2)_"%",1:RCSTRDTA)
 . . I 'RCDISP D SAVEDATA^RCDPENR1(RCSTRNG,RCRPIEN) Q
 . .;if printing in an EXCEL format, print "^" delimited and quit
 . . I RCEXCEL W RCSTRNG,! Q
 . ;Output to screen
 . ;currency format
 . I (I=2)!(I=3)!(I=15) W RCDTXT,?65,$J($P(RCSCDATA,U,I),13,2),! Q
 . ; For the line items that are percentages.  Not using $J formatting due to rounding errors.
 . I I=4 W RCDTXT,?65,$J($P($P(RCSCDATA,U,I),"."),12),"%",! Q
 . ;Otherwise print Number format
 . I (I=16) D  Q
 . . W:RCERAFLG RCDTXT,?65,$J($P(RCSCDATA,U,I),13,2),!
 . W RCDTXT,?65,$J($P(RCSCDATA,U,I),13),!
 I RCSTOP Q RCSTOP
 I RCDISP W RCLINE,! ;Otherwise print Number format
 I 'RCDISP D SAVEDATA^RCDPENR1(RCLINE,RCRPIEN)
 Q RCSTOP
 ;
GDTXT ; Moved from ^RCDPENR3 because of routine size PRCA*4.5*446
 ;;TOTAL NUMBER OF CLAIMS
 ;;TOTAL AMOUNT BILLED
 ;;TOTAL AMOUNT PAID
 ;;PERCENTAGE AMOUNT PAID: (%Total Paid/Billed)
 ;;
 ;;AVG #DAYS BETWEEN BILLED/ERA
 ;;AVG #DAYS BETWEEN ERA/EFT
 ;;AVG #DAYS BETWEEN ERA+EFT REC'D/PMT POSTED
 ;;AVG #DAYS BETWEEN BILLED/PMT POSTED
 ;;
 ;;TOTAL NUMBER OF ERAs
 ;;TOTAL NUMBER OF EEOBs
 ;;
 ;;TOTAL NUMBER OF EFTs
 ;;TOTAL AMOUNT COLLECTED
 ;;TOTAL DIFFERENCE BETWEEN ERAs (PAID) - EFTs (COLLECTED):
 Q
 ;
PRINTHDR(RCTITLE,RCLL,RCNOLINE) ;
 ; PRCA*4.5*446 - Moved from RCDPENR2 for size, add RCLL as parameter for line length, add RCNOLINE to suppress line
 ;
 ; Undeclared parameters
 ;   RCLINE - line of "-" for report formating
 ;   RCSUMFLG - Type of report (M=Main,S=Summary,G=Grand Total)
 ;   RCDISP - Is the report being email (0) or Printed (1)
 ;   RCRPIEN - IEN to store the report if emailing
 ;
 I '$L($G(RCNOLINE)) S RCNOLINE=0   ;PRCA*4.5*446
 I 'RCLL S RCLL=79   ;PRCA*4.5*446 If Line Length isn't set, make it 79
 I $G(RCEXCEL) Q 0
 N PAD,PAD1,PAD2,RCBORDER,RCSTOP,RCSTR,X   ;PRCA*4.5*446 Add PAD,PAD1,PAD2,X
 ;
 S RCBORDER="",$P(RCBORDER,"*",20)="",$P(PAD," ",132)="",RCSTOP=0   ;PRCA*4.5*446 PAD is a variable of spaces to pad title
 I $Y>(IOSL-7),RCDISP D
 . D ASK^RCDPEADP(.RCSTOP,0)
 . Q:RCSTOP
 . D HEADER^RCDPENR2
 I RCSTOP Q RCSTOP
 ;
 ; Display report type being displayed
 S X=$L(RCBORDER)+$L(RCTITLE)+$L(RCBORDER)
 S X=RCLL-X
 S PAD1=$E(PAD,1,(X/2\1)),PAD2=$E(PAD,1,(X/2+.5\1))  ;PRCA*4.5*446 Calculate # spaces for PAD1, PAD2 to center title
 I 'RCDISP D  Q
 . S RCSTR=RCBORDER_PAD1_RCTITLE_PAD2_RCBORDER  ;PRCA*4.5*446 Replace spaces with PAD1, PAD2 to center title
 . D SAVEDATA^RCDPENR1(RCSTR,RCRPIEN)
 . D SAVEDATA^RCDPENR1(RCLINE,RCRPIEN)
 I RCDISP D
 . W RCBORDER,PAD1,RCTITLE,PAD2,RCBORDER,!  ;PRCA*4.5*446 Replace spaces with PAD1, PAD2 to center title
 . W:'RCNOLINE RCLINE,!   ;PRCA*4.5*446
 ;
 Q RCSTOP
 ;
ASKSORT() ; EP from RCDPENR2 - added for PRCA*4.5*446
 ; Input: N/A
 ; Returns: -1 - User ^ or timed out
 ; P - Sort by Payer
 ; A - Sort by Amount of payment
 ;
 N DA,DIR,DTOUT,DUOUT,X,Y,DIRUT,DIROUT,RCTYPE,RETURN
 S RCTYPE=""
 S DIR("?",1)="Enter 'P' to sort by Payer"
 S DIR("?")=" 'A' to sort by Amount of payment"
 S DIR(0)="SA^P:PAYER;A:AMOUNT OF PAYMENT"
 S DIR("A")="SORT BY (P)AYER or (A)MOUNT OF PAYMENT: "
 S DIR("B")=$S($G(DEF)'="":DEF,1:"PAYER")
 D ^DIR
 K DIR
 I $D(DTOUT)!$D(DUOUT) Q -1
 Q:Y="" "P"
 S RETURN=$E(Y)
 Q RETURN
 ;
 ;Print the Detailed portion of the report, sort by amount
MAINAMT(RCPUZ,RCAUTO,RCEXCEL) ;
 ; ***** IMPORTANT ***** If this section needs to be modified, also check MAIN^RCDPENR2
 ; New subroutine for PRCA*4.5*446, copied from MAIN^RCDPENR2 and modified for sort by amount
 ;
 S:'$L($G(RCPUZ)) RCPUZ="A"  ; PRCA*4.5*446
 ;
 N I,RCERATYP,RCDATA,RCERATXT,RCSTRING,RCEFTTXT,RCEFT,RCERA,RCCLAIM,RCBILL
 N RCAMTBL,RCPAID,RCBILLDT,RCERADT,RCEFTDT,RCPOSTDT,RCTRACE,RCATPST,RCIDX,RCAMTPD
 N RCETRAN,RCERA,RCEOB,RCEFTNO,RCBEDY,RCEEDY,RCEPDY,RCBPDY,RCMETHOD,RCNOLINE,RCTOTDY,RCTMP,RCSTOP,RCIDX,RCSUB6
 ;
 S RCMETHOD="",RCSTOP=0
 S RCNOLINE=1
 F  S RCMETHOD=$O(^TMP("RCDPENR2",$J,"MAINAMT",RCMETHOD)) Q:RCMETHOD=""  D  Q:RCSTOP
 . I (RCAUTO="A"&(RCMETHOD="MANUAL"))!(RCAUTO="N"&(RCMETHOD="AUTOPOST")) Q  ; PRCA*4.5*349
 . I RCPUZ="U" I RCMETHOD'="UNPOSTED" Q
 . I RCPUZ="Z" I RCMETHOD'="UNPOSTED" Q
 . I RCPUZ="P" I RCMETHOD="UNPOSTED" Q
 . ;
 . S RCSTOP=$$PRINTHDR^RCDPENR5(RCMETHOD,131,RCNOLINE)  ;PRCA*4.5*446  131=line length, RCNOLINE
 . Q:RCSTOP
 . ;
 . I '$G(RCEXCEL),$O(^TMP("RCDPENR2",$J,"MAINAMT",RCMETHOD,""))="" D             ; PRCA*4.5*349
 . . W "No data captured for this section during the specified time period.",!   ; PRCA*4.5*349
 . ;
 . S RCAMTBL=""
 . F  S RCAMTBL=$O(^TMP("RCDPENR2",$J,"MAINAMT",RCMETHOD,RCAMTBL)) Q:RCAMTBL=""  D  Q:RCSTOP
 . . S RCSUB6=""
 . . F  S RCSUB6=$O(^TMP("RCDPENR2",$J,"MAINAMT",RCMETHOD,RCAMTBL,RCSUB6)) Q:RCSUB6=""  D  Q:RCSTOP
 . . . S RCDATA=^TMP("RCDPENR2",$J,"MAINAMT",RCMETHOD,RCAMTBL,RCSUB6)
 . . . S I=$P(RCDATA,U,19)
 . . . I RCPUZ="U" I I'=4 Q
 . . . I RCPUZ="Z" I I'=5 Q
 . . . I RCPUZ="P" I I>3 Q
 . . . I RCPUZ="P" I RCMETHOD="AUTOPOST" I I'=1 Q   ; Must be EFT/ERA(1) for autopost. Exclude Paper Check(2), Paper EOB(3)
 . . . ;If RCPUZ="A" for all and user selected AUTOPOST, exclude 2, 3 but keep 1, 4, 5. This case is handled inside next for loop.
 . . . ;
 . . . I RCMETHOD="MANUAL",I>3 Q    ; Unmatched and Zero pay are Unposted
 . . . I RCMETHOD="AUTOPOST",I>1 Q  ; Only EFT/ERA can be auto-posted - PRCA*4.5*349
 . . . I RCMETHOD="UNPOSTED",I<4 Q  ; Unmatched and Zero pay are Unposted
 . . . ;
 . . . I $Y>(IOSL-5) D ASK^RCDPEADP(.RCSTOP,0) Q:RCSTOP  D HEADER^RCDPENR2
 . . . ;Init display values for the days
 . . . S RCCLAIM=$P(RCDATA,U,20)
 . . . S (RCBEDY,RCEEDY,RCEPDY,RCBPDY)=""
 . . . S RCBILL=$$GET1^DIQ(399,+RCCLAIM_",",".01","E")
 . . . I $P(RCDATA,U,9),$P(RCDATA,U,8) S RCBEDY=$$FMTH^XLFDT($P(RCDATA,U,9),1)-$$FMTH^XLFDT($P(RCDATA,U,8),1)
 . . . I $P(RCDATA,U,10),$P(RCDATA,U,9) S RCEEDY=$$FMTH^XLFDT($P(RCDATA,U,10),1)-$$FMTH^XLFDT($P(RCDATA,U,9),1)
 . . . S RCIDX=$S($$FMTH^XLFDT($P(RCDATA,U,10),1)>$$FMTH^XLFDT($P(RCDATA,U,10),1):10,1:9)  ; Find the latest date between ERA and EFT
 . . . I $P(RCDATA,U,11),$P(RCDATA,U,RCIDX) S RCEPDY=$$FMTH^XLFDT($P(RCDATA,U,11),1)-$$FMTH^XLFDT($P(RCDATA,U,RCIDX),1)  ; Use latest date to determ days btw ERA/EFT and Posting
 . . . I $P(RCDATA,U,11),$P(RCDATA,U,8) S RCBPDY=$$FMTH^XLFDT($P(RCDATA,U,11),1)-$$FMTH^XLFDT($P(RCDATA,U,8),1)
 . . . I (I=4)!(I=5) S RCEPDY="N/A",RCBPDY="N/A" I I=4 S RCEEDY="N/A"  ;PRCA*4.5*446 some fields are N/A for Unmatched and Zero Pay
 . . . I RCEXCEL D
 . . . . S RCTMP=RCBILL_"^"_$$FMTE^XLFDT($P(RCDATA,U,5),2)_"^"_$P(RCDATA,U,6)_"^"_$P(RCDATA,U,7)_"^"_$$FMTE^XLFDT($P(RCDATA,U,8),2)
 . . . . S RCTMP=RCTMP_"^"_$$FMTE^XLFDT($P(RCDATA,U,9),2)_"^"_$$FMTE^XLFDT($P(RCDATA,U,10),2)_"^"_$$FMTE^XLFDT($P(RCDATA,U,11),2)_"^"_$P(RCDATA,U,12)_"^"_$P(RCDATA,U,13)
 . . . . S RCTMP=RCTMP_"^"_$P(RCDATA,U,14)_"^"_$P(RCDATA,U,2)_"^"_$P(RCDATA,U,15)_"^"_$P(RCDATA,U,3)_"^"
 . . . . S RCTMP=RCTMP_RCBEDY_"^"_RCEEDY_"^"_RCEPDY_"^"_RCBPDY
 . . . . I I=4 S $P(RCTMP,"^",8)="N/A" ;PRCA*4.5*446 posted date is N/A for Unmatched and Zero Pay
 . . . . W RCTMP,!
 . . . I 'RCEXCEL D
 . . . . W RCBILL,?21,$$FMTE^XLFDT($P(RCDATA,U,5),2),?30,$J($P(RCDATA,U,6),10,2),?41,$J($P(RCDATA,U,7),10,2),?52,$$FMTE^XLFDT($P(RCDATA,U,8),2)
 . . . . W ?61,$$FMTE^XLFDT($P(RCDATA,U,9),2),?75,$$FMTE^XLFDT($P(RCDATA,U,10),2),?89,$$FMTE^XLFDT($P(RCDATA,U,11),2),?98,$P(RCDATA,U,12),?109,$P(RCDATA,U,13),!
 . . . . W ?5,$P(RCDATA,U,14),?17,$P(RCDATA,U,2),?28,$J($P(RCDATA,U,15),6),?39,$P(RCDATA,U,3),?50,$J(RCBEDY,8)
 . . . . W ?67,$J(RCEEDY,8),?83,$J(RCEPDY,8),?106,$J(RCBPDY,8),!
 . . . . W ?10,$P(RCDATA,U,17),!
 . ;I '$G(RCEXCEL) W RCLINE,!  ; PRCA*4.5*466, Remove line of "-"
 ;
 I RCSTOP Q RCSTOP
 ; Section break - ask user if they wish to continue...
 ;
 Q RCSTOP
 ;
