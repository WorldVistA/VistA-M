RCDPEMAR ;ALB/CNF - MANUAL AUDIT REPORT ;12/31/24
 ;;4.5;Accounts Receivable;**446**;Mar 20, 1995;Build 15
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
 ; DESCRIPTION: The following generates a report that displays manually audited electronic bills
 ;
EN ; Main entry point for this report
 ; Ask Summary or Detail output
 ;
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,RCDT1,RCDT2,RCEXCEL,RCEXSTOP,RCLSTMGR,RCREP,RCTMPND,X,Y
 ;
 S:$G(U)="" U="^"
 ;
 ; Summary or Detail
 W !
 S DIR(0)="SOA^S:Summary Information Only;D:Detail Report"
 S DIR("A")="(S)ummary or (D)etail Report format? "
 S DIR("B")="SUMMARY"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") Q
 S RCREP=Y
 ;
 ; Start Date
 W !
 K DIR
 S DIR(0)="DAO^:"_DT_":APE",DIR("A")="Start Date: ",DIR("B")="T"
 S DIR("?")="ENTER THE EARLIEST DATE OF A MANUAL AUDIT TO INCLUDE ON THE REPORT"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") Q
 S RCDT1=Y
 ;
 ; End Date
 W !
 K DIR
 S DIR(0)="DAO^"_RCDT1_":"_DT_":APE",DIR("A")="End Date: ",DIR("B")="T"
 S DIR("?")="ENTER THE LATEST DATE OF A MANUAL AUDIT TO INCLUDE ON THE REPORT"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") Q
 S RCDT2=Y
 ;
 ; If user selected detail report (RCREP=D), offer option of Excel format
 S RCEXCEL=0,RCEXSTOP=0 I RCREP="D" D  Q:RCEXSTOP
 . W !
 . S RCEXCEL=$$DISPTY^RCDPEM3() I RCEXCEL<0 S RCEXSTOP=1 Q
 . ; display device info about Excel format, set ListMan flag to prevent question
 . I RCEXCEL S RCLSTMGR="^" D INFO^RCDPEM6
 . I $D(DUOUT)!$D(DTOUT) S RCEXSTOP=1 Q
 ;
 ; If not output to Excel, ask for ListMan display if user selected detail report (RCREP=D), quit if timeout or "^"
 S RCLSTMGR=0 I 'RCEXCEL I RCREP="D" W ! S RCLSTMGR=$$ASKLM^RCDPEARL Q:RCLSTMGR<0
 ;
 S RCTMPND="RCDPE_MAR" K ^TMP($J,RCTMPND)
 ;
 ; ListManager Display
 I RCLSTMGR=1 D  Q
 . N RCHDR,RCSTOP
 . D COMPILE(RCDT1,RCDT2,RCREP)
 . D REPDET(RCDT1,RCDT2)                    ; Put formatted lines in TMP array
 . D LMHDR(.RCSTOP,RCDT1,RCDT2,.RCHDR)      ; Create lines for header
 . D LMRPT(.RCHDR,$NA(^TMP($J,RCTMPND)),"") ; Generate ListMan display
 . K ^TMP($J,RCTMPND)
 ;
 ; Ask device
 S %ZIS="QM"
 D ^%ZIS
 Q:POP
 ;
 I $D(IO("Q")) D  Q                         ; Queued Report
 . N ZTDESC,ZTRTN,ZTSAVE,ZTSK
 . S ZTRTN="BK^RCDPMAR"
 . S ZTDESC="AR - EDI LOCKBOX MANUAL AUDIT REPORT"
 . S ZTSAVE("RC*")=""
 . ;
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Task number "_ZTSK_" was queued.",1:"Unable to queue this task.")
 . K ZTSK,IO("Q")
 . D HOME^%ZIS
 ;
 U IO
 ;
 ; Compile Data
 D COMPILE(RCDT1,RCDT2,RCREP)
 ;
 I RCREP="S" D REPSUM(RCDT1,RCDT2)
 I RCREP="D" D
 . I RCEXCEL D REPEXC Q
 . D REPDET(RCDT1,RCDT2)
 . N QUIT S QUIT=0 D PRINTDET(.QUIT)
 . I '$D(IO("Q")) I 'QUIT D
 . . S XX=""
 . . D ASK^RCDPEARL(.XX)
 ;
 K ^TMP("RCDPMAR",$J)
 K ^TMP($J,RCTMPND)
 ;
 Q
 ;
DISPLAY(ROW,EFTIEN,TRANS) ; Display EFT detail during user selection process  ; PRCA*4.5*439 Modified display
 ; Input: ROW    - Current row number
 ;        EFTIEN - IEN for EFT (#344.31)
 ;        TRANS  - EFT transaction number e.g. 999.1
 ;
 ; Output is written to the screen
 N PAYER,SUFX,TRANS
 S TRANS=$$GET1^DIQ(344.31,EFTIEN_",",.01,"I")
 S SUFX=$$GET1^DIQ(344.31,EFTIEN_",",.14)
 S:SUFX SUFX="."_SUFX
 S PAYER=$$GET1^DIQ(344.31,EFTIEN_",",.02)
 ;
 W !,$E(ROW_".     ",1,5)                            ; Row Number
 W $J(TRANS_SUFX,9)                                  ; EFT number with suffix
 W " "_$E(PAYER,1,45)_$E($J("",45),1,45-$L(PAYER))   ; Payer Name
 W " "_$J($$GET1^DIQ(344.31,EFTIEN_",",.07),19)      ; Amount
 W !,$J(" ",15)_$$GET1^DIQ(344.31,EFTIEN_",",.04)    ; Trace number
 Q
 ;
COMPILE(RCDT1,RCDT2,RCREP) ; Compile data for display
 ; Input: RCDT1 - Beginning date
 ;        RCDT2 - Ending date
 ;        RCREP - D if Detail format, S if Summary format
 ; Output: ^TMP("RCDPMAR",$J)
 ;
 N AUTODUZ,DATA,IEN399,RCDT,RCDATE,RCDUZ,RCIEN,X,Y
 K ^TMP("RCDPMAR",$J)
 ;
 ; Get DUZ for auto-audit
 S AUTODUZ=+$O(^VA(200,"B","PRCA,AUTOAUDIT",0))
 ;
 ; Loop through entries by date and approver
 K TOTALS
 S RCDT=RCDT1_".0000001",RCDT=$O(^PRCA(430,"AUDF",RCDT),-1)
 F  S RCDT=$O(^PRCA(430,"AUDF",RCDT)) Q:(RCDT\1)>RCDT2  Q:RCDT=""  S RCDUZ="" D
 . F  S RCDUZ=$O(^PRCA(430,"AUDF",RCDT,RCDUZ)) Q:'RCDUZ  D
 . . ;
 . . S RCDATE=RCDT\1
 . . ; Accumulate totals by date, sorted between auto-audits and manual audits
 . . S Y=$G(TOTALS("TOTAL",RCDATE)) S:'$L($P(Y,U,1)) $P(Y,U,1)=0 S:'$L($P(Y,U,2)) $P(Y,U,2)=0
 . . I RCDUZ=AUTODUZ S $P(Y,U,1)=$P(Y,U,1)+1,TOTALS("TOTAL",RCDATE)=Y
 . . E  S $P(Y,U,2)=$P(Y,U,2)+1,TOTALS("TOTAL",RCDATE)=Y
 . . ;
 . . ; Stop if user selected summary format
 . . I RCREP="S" Q
 . . ;
 . . ; Stop if entry is not a manual audit
 . . I RCDUZ=AUTODUZ Q
 . . ;
 . . ; Get internal number
 . . S RCIEN="",RCIEN=$O(^PRCA(430,"AUDF",RCDT,RCDUZ,RCIEN))
 . . ;
 . . ; Quit if internal number is invalid
 . . Q:'RCIEN  ; Quit if internal number is invalid
 . . S X=$G(^PRCA(430,RCIEN,0)) Q:'$L(X)  ; Quit if internal number is invalid
 . . ;
 . . ; Get data to print
 . . S DATA=""
 . . S $P(DATA,U,1)=RCDT                             ; AR DATE SIGNED, #92
 . . S $P(DATA,U,2)=$$GET1^DIQ(430,RCIEN,.01)        ; BILL
 . . S X=$P(DATA,U,2) S:X["-" X=$P(X,"-",2)          ; Remove Station Code
 . . ;
 . . S IEN399="",IEN399=$O(^DGCR(399,"B",X,""))      ; Get IEN for Bill in #399
 . . Q:'IEN399  Q:'$D(^DGCR(399,IEN399))             ; Quit if record doesn't exist IN Bill file
 . . ;
 . . S $P(DATA,U,3)=$$GET1^DIQ(399,IEN399,.07,"I")   ; RATE TYPE CODE (IEN), pointer to #399.3
 . . S $P(DATA,U,4)=$$GET1^DIQ(399,IEN399,.07,"E")   ; RATE TYPE DESCRIPTION
 . . S $P(DATA,U,5)=RCDUZ                            ; APPROVED BY (FISCAL), #90 (DUZ, IEN to #200)
 . . S $P(DATA,U,6)=$$GET1^DIQ(430,RCIEN,90,"E")     ; APPROVED BY (FISCAL), Name
 . . ;
 . . S X=$$PAYER(IEN399)                             ; Get Payer Information
 . . S $P(DATA,U,7)=$P(X,U,1)                        ; PAYER (IEN), pointer to #36
 . . S $P(DATA,U,8)=$P(X,U,2)                        ; PAYER Name
 . . S $P(DATA,U,9)=$P(X,U,3)                        ; PAYER Tin
 . . ;
 . . S ^TMP("RCDPMAR",$J,"DATA",RCDT,RCIEN)=DATA
 . . ;
 . . ; Store up to 4 comment lines
 . . I '$D(^PRCA(430,RCIEN,10)) Q   ; Quit if there aren't any comments
 . . F X=1:1:4 S ^TMP("RCDPMAR",$J,"DATA",RCDT,RCIEN,X)=$G(^PRCA(430,RCIEN,10,X,0))
 ;
 ; Merge totals into TMP global, format for array: TOTALS("TOTAL",date)=total count for auto-audit ^ total count for manual audit
 M ^TMP("RCDPMAR",$J,"TOTAL")=TOTALS("TOTAL")
 ;
 Q
 ;
REPSUM(RCDT1,RCDT2) ; Print Summary report
 ; Input: RCDT1 - Start Date
 ;        RCDT2 - End Date
 ; Output: Written to device
 ;
 N CNT,DATE,DATA,GTOT,J,LINES,RCHR,RCNOW,RCPG,RCSCR,STOP
 ;
 ; Initialize Report Date, Page Number and String of underscores
 S RCSCR=$S($E($G(IOST),1,2)="C-":1,1:0)
 S RCNOW=$$UP^XLFSTR($$NOW^RCDPRU()),RCPG=0,RCHR="",$P(RCHR,"-",IOM+1)=""
 ;
 U IO
 D HEADER("S",RCNOW,.RCPG,RCHR,RCDT1,RCDT2)
 I '$D(^TMP("RCDPMAR",$J,"TOTAL")) W !,"No data found"
 ;
 I $D(^TMP("RCDPMAR",$J,"TOTAL")) D
 . S GTOT="0^0"   ; Initialize grand total
 . ; Display body of the report
 . S DATE="" F  S DATE=$O(^TMP("RCDPMAR",$J,"TOTAL",DATE)) Q:'DATE  D  I RCPG=0 Q
 .. S DATA=^TMP("RCDPMAR",$J,"TOTAL",DATE)
 .. S LINES=1
 .. I RCSCR S LINES=LINES+1
 .. D CHKP("S",RCNOW,.RCPG,RCHR,RCDT1,RCDT2,RCSCR,.LINES) I RCPG=0 Q
 .. W !,$$FMTE^XLFDT(DATE\1,"2Z"),?13,$J($P(DATA,U,2),6),?23,$J($P(DATA,U,1),6)
 .. F J=1:1:2 S $P(GTOT,U,J)=$P(GTOT,U,J)+$P(DATA,U,J)   ;Accumulate grand total
 .;
 .W !,"  Total:",?12,$J($P(GTOT,U,2),7),?22,$J($P(GTOT,U,1),7)
 .W !!,"Percentage of Manually Audited Bills: "
 .I $P(GTOT,U,2) S J=($P(GTOT,U,2)/($P(GTOT,U,2)+$P(GTOT,U,1))),J=J*100,J=J+.5,J=J\1 W J
 .W:'$P(GTOT,U,2) "0"
 .W "%"
 ;
 I 'RCSCR W !,@IOF
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 ;
 W !,$$ENDORPRT^RCDPEARL()
 I RCPG,RCSCR S STOP=$S('$$PAUSE():1,1:0)
 ;
 Q
 ;
REPDET(RCDT1,RCDT2) ; Build Detailed report in TMP
 ; Input: RCDT1 - Start Date
 ;        RCDT2 - End Date
 ; Output: Saved to ^TMP in generic RCDP ListMan report format
 ;
 N CNT,DATE,DATA,J,K,LINES,PCS,RCHR,RCNOW,RCPG,RCSCR,X,X1,X2
 ;
 S LINES=1
 I '$D(^TMP("RCDPMAR",$J,"DATA")) S X="No data found" D SAVE(X,.LINES)
 ; Display the detail
 S DATE="" F  S DATE=$O(^TMP("RCDPMAR",$J,"DATA",DATE)) Q:'DATE  D
 . S CNT=0 F  S CNT=$O(^TMP("RCDPMAR",$J,"DATA",DATE,CNT)) Q:'CNT  D
 . . S DATA=^TMP("RCDPMAR",$J,"DATA",DATE,CNT)
 . . S X=$$FMTE^XLFDT(DATE\1,"2Z"),X=X_$$SPACES(X,11)              ; Date
 . . S X1=$P(DATA,U,2) S:$L(X1)>11 X1=$E(X1,1,11)                  ; Bill, Max of 11 characters
 . . S X=X_X1 S X=X_$$SPACES(X,24)
 . . S X1=$P(DATA,U,3)_" "_$P(DATA,U,4) S:$L(X1)>23 X1=$E(X1,1,23) ; Rate Type Code and Name, Max of 23 characters
 . . S X=X_X1 S X=X_$$SPACES(X,49)
 . . S X1=$P(DATA,U,6) S:$L(X1)>32 X1=$E(X1,1,32)                  ; User, Max of 32 characters
 . . S X=X_X1 S X=X_$$SPACES(X,52)
 . . D SAVE(X,.LINES)
 . . S X="  "_$P(DATA,U,8)_" / "_$P(DATA,U,9)                      ; Payer/Tin
 . . S:$L(X)>78 X=$E(X,1,78)                                       ; Max of 76 characters + 2 spaces
 . . D SAVE(X,.LINES)
 . . F J=1:1:4 S X=$G(^TMP("RCDPMAR",$J,"DATA",DATE,CNT,J)) I $L(X) S X="   "_X D
 . . . I $L(X)<81 D SAVE(X,.LINES) Q    ; Max length of 77 + 3 spaces
 . . . ; If line is longer than 80 characters, wrap the line. Break at a space, not in the middle of a word.
 . . . S X1=X,X2="",PCS=$L(X," ") F K=1:1:PCS Q:$L(X1)<81  S X1=$P(X," ",1,(PCS-K)),X2=$P(X," ",(PCS-K+1),PCS)
 . . . S X2="   "_X2
 . . . D SAVE(X1,.LINES),SAVE(X2,.LINES) ; Long line becomes 2 lines
 . . S X="" D SAVE(X,.LINES)
 S X=$$ENDORPRT^RCDPEARL()
 D SAVE(X,.LINES)      ; End of report
 ;
 Q
 ;
SPACES(DATA,COL) ; Return spaces for padding output
 ;  INPUT  DATA: String of data
 ;          COL: Column to begin for next data piece
 ;
 ;  OUTPUT Spaces to pad data string
 ;
 N LEN,NUM,SPACE,SPACES
 S $P(SPACE," ",80)=""                    ; string of 80 spaces
 S LEN=$L(DATA)                           ; length of existing data string
 S NUM=COL-LEN I NUM<0 S SPACES="" Q ""   ; NUM is the number of spaces needed to pad to the column number (COL)
 Q $E(SPACE,2,NUM)                        ; return spaces
 ;
REPEXC ; Print Excel report
 N CNT,DATA,DATE,X
 ;
 ; Header
 W !,"DATE^BILL^RATE TYPE CODE^RATE TYPE NAME^USER^PAYER NAME^PAYER TIN^COMMENT 1^COMMENT 2^COMMENT 3^COMMENT 4"
 ;
 ; Data
 I '$D(^TMP("RCDPMAR",$J,"DATA")) W !,"No data found" D  Q
 . N STOP S STOP=""
 . D ASK^RCDPEARL(.STOP)
 ;
 ; Display the detail
 S DATE="" F  S DATE=$O(^TMP("RCDPMAR",$J,"DATA",DATE)) Q:'DATE  D
 . S CNT=0 F  S CNT=$O(^TMP("RCDPMAR",$J,"DATA",DATE,CNT)) Q:'CNT  D
 . . S DATA=^TMP("RCDPMAR",$J,"DATA",DATE,CNT)
 . . W !,$$FMTE^XLFDT(DATE\1,"2Z"),"^",$P(DATA,U,2),"^",$P(DATA,U,3),"^",$P(DATA,U,4),"^",$P(DATA,U,6),"^",$P(DATA,U,8),"^",$P(DATA,U,9)
 . . F J=1:1:4 S X=$G(^TMP("RCDPMAR",$J,"DATA",DATE,CNT,J)) I $L(X) W "^",X
 W !,"*** END OF REPORT ***",!
 N STOP S STOP=""
 D ASK^RCDPEARL(.STOP)
 Q
 ;
SAVE(X,LINES) ; Save a line of the report to the ^TMP global
 S ^TMP($J,RCTMPND,LINES)=X
 S LINES=LINES+1
 Q
 ;
BK ; Run report in background through task manager
 D COMPILE
 D REPDET(RCDT1,RCDT2)
 N QUIT S QUIT=0 D PRINTDET(.QUIT)
 Q
 ;
PRINTDET(QUIT) ; Print line in ^TMP global to output the detail report to screen or printer
 ;INPUT - QUIT - User exits out of report
 ;
 ; Initialize Report Date, Page Number and String of underscores
 I $G(QUIT)="" S QUIT=0  ; Make sure quit is initialized
 ;
 N RCSCR,RCNOW,RCPG,RCHR
 S RCSCR=$S($E($G(IOST),1,2)="C-":1,1:0)
 S RCNOW=$$UP^XLFSTR($$NOW^RCDPRU()),RCPG=0,RCHR="",$P(RCHR,"-",IOM+1)=""
 ;
 N COUNT,LINE
 D HEADER("D",RCNOW,.RCPG,RCHR,RCDT1,RCDT2)
 S (COUNT,LINE,QUIT)=0
 F  S LINE=$O(^TMP($J,RCTMPND,LINE)) Q:'LINE  D  I QUIT S RCPG=0 Q
 . S COUNT=COUNT+1
 . I (COUNT+8)>IOSL D  I QUIT Q
 . . I $D(RCSCR) D  I QUIT Q
 . . . S QUIT='$$PAUSE()
 . . D HEADER("D",RCNOW,.RCPG,RCHR,RCDT1,RCDT2)
 . . S COUNT=1
 . W !,^TMP($J,RCTMPND,LINE)
 Q
 ;
PAUSE() ; Pause at end of each page for user input
 ; Input: None
 ; Output: User response
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="E"
 D ^DIR
 Q Y
 ;
CHKP(RCREP,RCNOW,RCPG,RCHR,RCDT1,RCDT2,RCSCR,LINES) ; Check if we need to do a page break
 ; Input: RCREP - D for Detail format, S for Summary format
 ;        RCNOW - DATE/TIME in external format
 ;        RCPG  - Current page number
 ;        RCHR  - Line of "-" to margin width
 ;        RCDT1 - Start date
 ;        RCDT2 - End date
 ;        RCSCR - 1 - Output is going to the users screen, 0 - to printer
 ;        LINES - Current line count
 ;
 I $Y'>(IOSL-LINES) Q
 I RCSCR,'$$PAUSE S RCPG=0 Q
 D HEADER(RCREP,RCNOW,.RCPG,RCHR,RCDT1,RCDT2)
 S LINES=1
 Q
 ;
HEADER(RCREP,RCNOW,RCPG,RCHR,RCDT1,RCDT2) ; Print Header Section
 ; Input: RCREP - D for Detail format, S for Summary format
 ;        RCNOW - DATE/TIME in external format
 ;        RCPG  - Current page number
 ;        RCHR  - Line of "-" to margin width
 ;        RCDT1 - Start date
 ;        RCDT2 - End date
 ; Output: Write statements
 ;
 N LINE
 ;
 W @IOF
 S RCPG=RCPG+1
 W "MANUAL AUDIT REPORT - ",$S(RCREP="D":"DETAIL",1:"SUMMARY")
 S LINE=RCNOW_"   PAGE: "_RCPG_" "
 W ?(IOM-$L(LINE)),LINE
 W !,"MANUAL AUDIT DATE RANGE: ",$$FMTE^XLFDT(RCDT1\1,"2Z")," - ",$$FMTE^XLFDT(RCDT2,"2Z"),!
 ;
 ; Write column headings for Detail report format
 I RCREP="D" D
 . W !,"DATE",?10,"BILL",?23,"RATE TYPE",?48,"USER",!,?2,"PAYER/TIN",!,?3,"COMMENTS"
 ;
 ; Write column headings for Summary report format
 I RCREP="S" D
 . W !,?14,"MANUAL",?24,"AUTO",!,"DATE",?13,"# BILLS",?22,"# BILLS"
 ;
 ; Write line of dashes, to margin width
 W !,RCHR
 Q
 ;
LMHDR(RCSTOP,RCDT1,RCDT2,RCHDR) ;   
 ; ListMan report heading
 ; Input:   RCDT1       - Internal Start Date of date range
 ;          RCDT2       - Internal End Date of date range
 ; Output:  RCHDR       - Array of listman header lines
 ;          RCSTOP      - 1 if user stopped 
 ;
 N RCCT,X,XX,Y,Z,Z0,Z1
 S RCCT=0
 S RCHDR("TITLE")="MANUAL AUDIT REPORT"
 S Z1=""
 ;
 S XX="MANUAL AUDIT DATE RANGE: "_$$FMTE^XLFDT(RCDT1\1,"2Z")_" - "
 S XX=XX_$$FMTE^XLFDT(RCDT2\1,"2Z")
 S RCCT=RCCT+1,RCHDR(RCCT)=XX
 S RCCT=RCCT+1,RCHDR(RCCT)="" ; blank line
 S XX="DATE      BILL         RATE TYPE               USER"
 S RCCT=RCCT+1,RCHDR(RCCT)=XX
 S XX="  PAYER/TIN"
 S RCCT=RCCT+1,RCHDR(RCCT)=XX
 S XX="   COMMENTS"
 S RCCT=RCCT+1,RCHDR(RCCT)=XX
 Q
 ;
LMRPT(RCLMHDR,RCLMND,LMTMP)  ; ListMan display
 ; Input:   RCLMHDR     - Header text, passed by ref. (required)
 ;          RCLMND      - Storage node for ListMan data (required)
 ;          LMTMP       - Name of a listman template to use
 ;                        Optional, defaults to ""
 Q:'$D(RCLMHDR)  Q:($G(RCLMND)="")          ; both required
 S LMTMP="RCDPE MISC REPORTS TM8"           ; top margin is 8 lines
 ;
 N XX
 S XX=$S($G(LMTMP)'="":LMTMP,1:"RCDPE MISC REPORTS")
 D EN^VALM(XX)
 Q
 ;
PAYER(IEN399) ; Get Payer Name and TIN
 ; Input:   IEN399     - IEN to #399
 ; Output:  Payer IEN ^ Payer Name ^ Payer TIN
 ;
 N IEN3611,STOP,X,Y,Z
 ;
 S IEN3611="",STOP=0,X="",Y="",Z=""
 F  S IEN3611=$O(^IBM(361.1,"B",IEN399,IEN3611)) Q:'IEN3611  Q:STOP  D
 . S X=$$GET1^DIQ(361.1,IEN3611,.02,"I")   ; Payer IEN
 . S Y=$$GET1^DIQ(361.1,IEN3611,.02,"E")   ; Payer Name
 . S Z=$$GET1^DIQ(361.1,IEN3611,.03)       ; Payer TIN
 . I X S STOP=1                            ; If we found a payer, stop searching
 ;
 I 'X D 
 . S X=$$GET1^DIQ(399,IEN399,101,"I")      ; PAYER IEN
 . S Y=$$GET1^DIQ(399,IEN399,101,"E")      ; PAYER Name
 . S Z=""
 ;
 Q X_"^"_Y_"^"_Z
