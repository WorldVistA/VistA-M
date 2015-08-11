RCDPEAR2 ;ALB/TMK/PJH - EFT Unmatched Aging Report - FILE 344.3 ;Nov 24, 2014@18:31:57
 ;;4.5;Accounts Receivable;**173,269,276,284,283,293,298**;Mar 20, 1995;Build 121
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
 ; PRCA*4.5*298 notes at bottom
EN1 ; option: EFT Unmatched Aging Report [RCDPE EFT AGING REPORT]
 N %ZIS,DIC,DIR,POP,RCDISPTY,RCDTRNG,RCEND,RCHDR,RCJOB,RCJOB1,RCLSTMGR,RCNP,RCPYRLST,RCPGNUM,RCSTART,X,Y
 ; RCDISPTY = display type
 ; RCEND = end date
 ; RCLSTMGR = list manager flag
 ; RCNP = payer info: "1^first payer^last payer" or "2^^" (for all)
 ; RCPYRLST - payer list for selected payers
 ; RCDTRNG= "1^start date^end date"
 ; RCSTART = start date
 ;
 S RCLSTMGR=""  ; initial value
 S RCDTRNG=$$DTRNG^RCDPEM4() G:'(RCDTRNG>0) EN1Q
 S RCSTART=$P(RCDTRNG,U,2)-1,RCEND=$P(RCDTRNG,U,3)
 ;Get insurance company to be used as filter
 ; PRCA*4.5*284 - RCNP (Type of Response(1=Range,2=All,3=Specific)^From name^To name)
 S RCNP=$$GETPAY^RCDPEM9(344.31) G:RCNP<0 EN1Q
 ;Get display type
 S RCDISPTY=$$DISPTY^RCDPEM3() G:RCDISPTY<0 EN1Q
 ; display device info about Excel format, set ListMan flag to prevent question
 I RCDISPTY S RCLSTMGR="^" D INFO^RCDPEM6
 I $D(DUOUT)!$D(DTOUT) G EN1Q
 S RCJOB=$J  ; needed in RPTOUT
 ;
 ; if not output to Excel ask for ListMan display, exit if timeout or '^' - PRCA*4.5*298
 I RCLSTMGR="" S RCLSTMGR=$$ASKLM^RCDPEARL I RCLSTMGR<0 G EN1Q
 ; display in ListMan format and exit on return
 I RCLSTMGR D  G EN1Q
 .S RCTMPND=$T(+0)_"^EFT UNMATCHED AGING"  K ^TMP($J,RCTMPND)  ; clean any residue
 .D RPTOUT
 .N H,L,HDR S L=0
 .S HDR("TITLE")=$$HDRNM
 .F H=1:1:7 I $D(RCHDR(H)) S L=H,HDR(H)=RCHDR(H)  ; take first 3 lines of report header
 .I $O(RCHDR(L)) D  ; any remaining header lines at top of report
 ..N N S N=0,H=L F  S H=$O(RCHDR(H)) Q:'H  S N=N+.001,^TMP($J,RCTMPND,N)=RCHDR(H)
 .D LMRPT^RCDPEARL(.HDR,$NA(^TMP($J,RCTMPND))) ; generate ListMan display
 ;
 S RCJOB=$J,RCTMPND=""
 ; Ask device
 S %ZIS="QM" D ^%ZIS G:POP EN1Q
 I $D(IO("Q")) D  G EN1Q
 .N ZTDESC,ZTRTN,ZTSAVE,ZTSTOP
 .S ZTRTN="RPTOUT^RCDPEAR2",ZTDESC="EFT AGING REPORT"
 .S ZTSAVE("RC*")="",ZTSAVE("VAUTD")=""
 .; PRCA*4.5*284 - Because TMP global may be on another server, save off specific payers in local
 .I +RCNP=3 M RCPYRLST=^TMP("RCSELPAY",$J)
 .D ^%ZTLOAD
 .W !!,$S($G(ZTSK):"Task number "_ZTSK_" has been queued.",1:"Unable to queue this task.")
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 U IO D RPTOUT
 ;
EN1Q ; exit and clean up
 I 'RCLSTMGR D ^%ZISC
 K ^TMP("RCSELPAY",$J),^TMP("RCPAYER",$J)
 Q
 ;
RPTOUT ; Entry point for queued job, nightly job
 ; RCTMPND = name of the subscript for ^TMP to use to return all lines
 ;         If undefined or null, output is printed
 ; Return global if RCTMPND not null: ^TMP($J,RCTMPND,line#)=line text
 N DIC,DUOUT,RC0,RC13,RC3443,RCCT,RCIEN,RCNT,RCOUT,RCPAY,RCSTOP,RCTOT,RCZ,X,Z,Z0
 S RCTMPND=$G(RCTMPND)
 S (RCCT,RCSTOP,RCNT,RCTOT)=0
 K ^TMP($J,"RCERA_AGED"),^TMP($J,"RCERA_ADJ")
 ; PRCA*4.5*284 - Queued job needs to reload payer selection list
 I $G(RCJOB)'="",RCJOB'=$J D
 .K ^TMP("RCSELPAY",$J)
 .D RLOAD^RCDPEAR1(344.31)
 .S RCJOB=$J
 ; build local payer array here
 S RCNP=+RCNP
 D SELPAY^RCDPEAR1(RCNP,RCJOB,.RCPAY)
 I RCTMPND'="" K ^TMP($J,RCTMPND)
 ; cross-ref on file #344.31 field #.08 - MATCH STATUS
 S RCIEN=0 F  S RCIEN=$O(^RCY(344.31,"AMATCH",0,RCIEN)) Q:'RCIEN  D   ;unmatched entries only
 .Q:$P($G(^RCY(344.31,RCIEN,3)),U)  ; EFT has been removed
 .Q:$P($G(^RCY(344.31,RCIEN,0)),U,7)=0  ; payment of zero
 .;
 .S RC13=$P($G(^RCY(344.31,RCIEN,0)),U,13)  ; date received
 .; Check for payer match
 .I '$$CHKPYR^RCDPEDAR(RCIEN,0,RCJOB) Q
 .; Check date range
 .Q:(RCSTART>RC13)!(RC13>RCEND)
 .; Passed all the filters - include on report
 .S ^TMP($J,"RCEFT_AGED",$$FMDIFF^XLFDT(RC13,DT),RCIEN)=0,RCNT=RCNT+1
 ;
 D:'RCLSTMGR HDRBLD  ; create header
 D:RCLSTMGR HDRLM  ; create Listman header
 ;
 I RCDISPTY D EXCEL Q
 ;
 ; Find total amount of EFTs
 S RCZ="" F  S RCZ=$O(^TMP($J,"RCEFT_AGED",RCZ)) Q:RCZ=""  S RCIEN=0 F  S RCIEN=$O(^TMP($J,"RCEFT_AGED",RCZ,RCIEN)) Q:'RCIEN  D  G:RCSTOP PRTQ
 .I $D(ZTQUEUED),$$S^%ZTLOAD S (RCSTOP,ZTSTOP)=1 K ZTREQ I +$G(RCPGNUM) W:RCTMPND="" !!,"***TASK STOPPED BY USER***" Q
 .S RC0=$G(^RCY(344.31,RCIEN,0)),RC3443=$G(^RCY(344.3,+RC0,0))
 .S RCTOT=RCTOT+$P(RC0,U,7)
 ;
 D:'RCLSTMGR HDRLST^RCDPEARL(.RCSTOP,.RCHDR)  ; initial report header
 ;
 S Z=$$SETSTR^VALM1("Totals:","",1,79)
 D SL^RCDPEARL(Z,.RCCT,RCTMPND)
 S Z=$$SETSTR^VALM1(" Number Aged Electronic EFT Messages Found: "_RCNT,"",1,79)
 D SL^RCDPEARL(Z,.RCCT,RCTMPND)
 S Z=$$SETSTR^VALM1(" Amount Aged Electronic EFT Messages Found: $"_$FN(+RCTOT,",",2),"",1,79)
 D SL^RCDPEARL(Z,.RCCT,RCTMPND)
 D SL^RCDPEARL($TR($J("",IOM)," ","="),.RCCT,RCTMPND)
 ;
 S RCZ="" F  S RCZ=$O(^TMP($J,"RCEFT_AGED",RCZ)) Q:RCZ=""  S RCIEN=0 F  S RCIEN=$O(^TMP($J,"RCEFT_AGED",RCZ,RCIEN)) Q:'RCIEN  D  G:RCSTOP PRTQ
 .I $D(ZTQUEUED),$$S^%ZTLOAD S (RCSTOP,ZTSTOP)=1 K ZTREQ I +$G(RCPGNUM) W:RCTMPND="" !!,"***TASK STOPPED BY USER***" Q
 .I RCPGNUM D SL^RCDPEARL(" ",.RCCT,.RCTMPND) ; On detail list, skip line
 .I 'RCLSTMGR,$Y>(IOSL-RCHDR(0)) D HDRLST^RCDPEARL(.RCSTOP,.RCHDR) Q:RCSTOP
 .S RC0=$G(^RCY(344.31,RCIEN,0)),RC3443=$G(^RCY(344.3,+RC0,0))
 .S RCTOT=RCTOT+$P(RC0,U,7)
 .S Z=$$SETSTR^VALM1($J(-RCZ,4),"",1,4)
 .S Z=$$SETSTR^VALM1("  "_$P(RC0,U,4),Z,5,75)
 .D SL^RCDPEARL(Z,.RCCT,RCTMPND)
 .N RCPAY S RCPAY=$P(RC0,U,2) S:RCPAY="" RCPAY="NO PAYER NAME RECEIVED" ; PRCA*4.5*298
 .S Z=$$SETSTR^VALM1(RCPAY_"/"_$P(RC0,U,3),"",11,69) ; PRCA*4.5*298
 .S Z=$$SETSTR^VALM1("  "_$$FMTE^XLFDT($P(RC0,U,12),2),Z,70,10)
 .D SL^RCDPEARL(Z,.RCCT,RCTMPND)
 .S Z=$$SETSTR^VALM1($J("",6)_$S($P(RC0,U,13):$$FMTE^XLFDT($P(RC0,U,13),2),1:""),"",1,17)
 .S Z=$$SETSTR^VALM1("  "_$J($P(RC0,U,7),15,2),Z,18,17)
 .; PRCA*4.5*283 - change length from 8 to 11 to allow for 9 digit DEP #'s
 .S Z=$$SETSTR^VALM1("  "_$P(RC3443,U,6),Z,35,11)
 .S Z=$$SETSTR^VALM1("  "_$S($P(RC3443,U,12):"",1:"NOT ")_"Posted to 8NZZ"_$S($P(RC3443,U,12):" "_$$FMTE^XLFDT($P(RC3443,U,11),2),1:""),Z,47,36)
 .D SL^RCDPEARL(Z,.RCCT,RCTMPND)
 .K RCOUT
 .D GETS^DIQ(344.31,RCIEN_",",2,"E","RCOUT")
 .Q:'$O(RCOUT(344.31,RCIEN_",",2,0))
 .D SL^RCDPEARL($J("",8)_"--EXCEPTION NOTES--",.RCCT,RCTMPND)
 .S Z=0 F  S Z=$O(RCOUT(344.31,RCIEN_",",2,Z)) Q:'Z  D  Q:RCSTOP
 ..I 'RCLSTMGR,$Y>(IOSL-RCHDR(0)) D HDRLST^RCDPEARL(.RCSTOP,.RCHDR) Q:RCSTOP
 ..D SL^RCDPEARL($J("",8)_" "_RCOUT(344.31,RCIEN_",",2,Z),.RCCT,RCTMPND)
 ;
 ;
 ; PRCA*4.5*298, put end-of-report into SL^RCDPEARL
 D SL^RCDPEARL(" ",.RCCT,RCTMPND)  ; skip a line
 D SL^RCDPEARL($$ENDORPRT^RCDPEARL,.RCCT,RCTMPND)
 ;
PRTQ ;
 ; PRCA*4.5*298, added ListMan check
 I '$D(ZTQUEUED),'RCLSTMGR,'RCSTOP D ASK^RCDPEARL(.RCSTOP)
 I $D(ZTQUEUED) S ZTREQ="@"
 I '$D(ZTQUEUED) D ^%ZISC
 K ^TMP($J,"RCEFT_AGED"),ZTQUEUED
 Q
 ;
 ; extrinsic variable, text for header PRCA*4.5*298
HDRNM() Q "EFT UNMATCHED AGING REPORT"
 ;
HDRBLD ; create the report header
 ; returns RCHDR, RCPGNUM, RCSTOP
 ;   RCHDR(0) = header text line count
 ;   RCHDR("XECUTE") = M code for page number
 ;   RCHDR("RUNDATE") = date/time report generated, external format
 ;   RCPGNUM - page counter
 ;   RCSTOP - flag to exit
 ;INPUT:
 ; RCDTRNG - date range filter value to be printed as part of the header
 ; RCPAY - Payer filter value(s)
 ; RCLSTMGR
 ;
 K RCHDR S RCHDR("RUNDATE")=$$NOW^RCDPEARL,RCPGNUM=0,RCSTOP=0
 ;
 I RCDISPTY D  Q  ; Excel format, xecute code is QUIT, null page number
 .S RCHDR(0)=1,RCHDR("XECUTE")="Q",RCPGNUM=""
 .S RCHDR(1)="Aged Days^Trace #^Deposit From/ID^File Date^Deposit Amount^Deposit #^Deposit Post Status^Deposit Date"
 ;
 N START,END,MSG,DATE,Y,DIV,HCNT
 S START=$$FMTE^XLFDT($P(RCDTRNG,U,2),2),END=$$FMTE^XLFDT($P(RCDTRNG,U,3),2)
 ;
 S Y=$$HDRNM,HCNT=1,RCHDR(HCNT)=$J("",80-$L(Y)\2)_Y  ; line 1 will be replaced by XECUTE code below
 S RCHDR("XECUTE")="N Y S RCPGNUM=RCPGNUM+1,Y=$$HDRNM^"_$T(+0)_"_$S(RCLSTMGR:"""",1:$J(""Page: ""_RCPGNUM,12)),RCHDR(1)=$J("" "",80-$L(Y)\2)_Y"
 S Y="RUN DATE: "_RCHDR("RUNDATE"),HCNT=HCNT+1,RCHDR(HCNT)=$J("",80-$L(Y)\2)_Y  ; line 1 will be replaced by XECUTE code below
 ;
 ; Payer(s)
 S Y="PAYERS: " D
 .I $D(RCPAY)=1 S Y=Y_RCPAY,HCNT=HCNT+1,RCHDR(HCNT)=$J("",80-$L(Y)\2)_Y Q
 .N S,X S S=0 F  S S=$O(RCPAY(S)) Q:'S  D
 ..S X=RCPAY(S)_$S($O(RCPAY(S)):", ",1:"")
 ..I $L(X)+$L(Y)>80 S HCNT=HCNT+1,RCHDR(HCNT)=Y,Y=$J(" ",8)
 ..S Y=Y_X
 .;
 .S:$TR(Y," ")]"" HCNT=HCNT+1,RCHDR(HCNT)=Y  ; any residual data
 S Y="DATE RANGE: "_$P($$FMTE^XLFDT(START,2),"@")_" - "_$P($$FMTE^XLFDT(END,2),"@")_" (DATE EFT FILED)"
 S Y=$J("",80-$L(Y)\2)_Y,HCNT=HCNT+1,RCHDR(HCNT)=Y
 ;
 S Y="AGED",HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y="DAYS  TRACE #",HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y="          DEPOSIT FROM/ID                                               DEP DATE",HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y="      FILE DATE     DEPOSIT AMOUNT  DEP #       DEPOSIT POST STATUS",HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y="",$P(Y,"=",81)="",HCNT=HCNT+1,RCHDR(HCNT)=Y  ; row of equal signs at bottom
 ;
 S RCHDR(0)=HCNT
 ;
 Q
 ;
HDRLM ; create the Listman header section
 ; returns RCHDR
 ;   RCHDR(0) = header text line count
 ;INPUT:
 ; RCDTRNG - date range filter value to be printed as part of the header
 ; RCPAY - Payer filter value(s)
 ;
 K RCHDR S RCPGNUM=0,RCSTOP=0
 ;
 N START,END,MSG,DATE,Y,DIV,HCNT
 S START=$$FMTE^XLFDT($P(RCDTRNG,U,2),2),END=$$FMTE^XLFDT($P(RCDTRNG,U,3),2)
 S Y="DATE RANGE: "_$P($$FMTE^XLFDT(START,2),"@")_" - "_$P($$FMTE^XLFDT(END,2),"@")_" (DATE EFT FILED)"
 S HCNT=1,RCHDR(HCNT)=Y
 ; Payer(s)
 S Y="PAYERS: " D
 .I $D(RCPAY)=1 S Y=Y_RCPAY,HCNT=HCNT+1,RCHDR(HCNT)=Y Q
 .N S,X S S=0 F  S S=$O(RCPAY(S)) Q:'S  D
 ..S X=RCPAY(S)_$S($O(RCPAY(S)):", ",1:"")
 ..I $L(X)+$L(Y)>80 S HCNT=HCNT+1,RCHDR(HCNT)=Y,Y=$J(" ",8)
 ..S Y=Y_X
 .;
 .S:$TR(Y," ")]"" HCNT=HCNT+1,RCHDR(HCNT)=Y  ; any residual data
 ;
 S HCNT=HCNT+1,RCHDR(HCNT)=""
 S Y="AGED",HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y="DAYS TRACE #",HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y="         DEPOSIT FROM/ID                                               DEP DATE",HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y="     FILE DATE     DEPOSIT AMOUNT  DEP #       DEPOSIT POST STATUS",HCNT=HCNT+1,RCHDR(HCNT)=Y
 ;
 S RCHDR(0)=HCNT
 ;
 Q
 ;
EXCEL ; Print report to screen, one record per line for export to MS Excel.
 W !!,"Aged Days^Trace #^Deposit From/ID^File Date^Deposit Amount^Deposit #^Deposit Post Status^Deposit Date"
 S RCZ="" F  S RCZ=$O(^TMP($J,"RCEFT_AGED",RCZ)) Q:RCZ=""  S RCIEN=0 F  S RCIEN=$O(^TMP($J,"RCEFT_AGED",RCZ,RCIEN)) Q:'RCIEN  D  G:RCSTOP PRTQ2
 .I $D(ZTQUEUED),$$S^%ZTLOAD S (RCSTOP,ZTSTOP)=1 K ZTREQ I +$G(RCPG) W:RCTMPND="" !!,"***TASK STOPPED BY USER***" Q
 .S RC0=$G(^RCY(344.31,RCIEN,0)),RC3443=$G(^RCY(344.3,+RC0,0))
 .N RCPAY S RCPAY=$P(RC0,U,2) S:RCPAY="" RCPAY="NO PAYER NAME RECEIVED" ; PRCA*4.5*298
 .S Z=$J(-RCZ,4)_"^"_$P(RC0,U,4)_"^"_RCPAY_"/"_$P(RC0,U,3)_"^"_$S($P(RC0,U,13):$$FMTE^XLFDT($P(RC0,U,13),2),1:"")_"^" ; PRCA*4.5*298
 .S Z=Z_$P(RC0,U,7)_"^"_$P(RC3443,U,6)_"^"_$S($P(RC3443,U,12):"",1:"NOT ")_"Posted to 8NZZ"_$S($P(RC3443,U,12):"^"_$$FMTE^XLFDT($P(RC0,U,12),2),1:"")
 .W !,Z
 W !!,"*** END OF REPORT ***",!
 ;
PRTQ2 ;
 I $D(ZTQUEUED) S ZTREQ="@"
 I '$D(ZTQUEUED) D ^%ZISC
 K ^TMP($J,"RCEFT_AGED"),^TMP("RCSELPAY",$J),^TMP("RCPAYER",$J),^TMP($J,"RCERA_ADJ")
 Q
 ;
 ;PRCA*4.5*298
 ; removed RCIND local variable
 ; changed RC00 to RC3443
 ; replaced SETLINE with SL^RCDPEARL
 ; added $$HDRNM
 ; added RCLSTMGR in checks for header
 ; changed upper case text to mixed case throughout
 ;
