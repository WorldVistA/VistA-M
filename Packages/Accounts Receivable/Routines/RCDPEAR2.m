RCDPEAR2 ;ALB/TMK/PJH - EFT Unmatched Aging Report - FILE 344.3 ;04-NOV-02
 ;;4.5;Accounts Receivable;**173,269,276,284,283**;Mar 20, 1995;Build 8
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
EN1 ; Entry from option - run on the fly
 N DIR,Y,%ZIS,ZTRTN,ZTSAVE,ZTDESC,POP,X,RCNP,RCJOB,RCJOB1
 N RCRANGE,RCDISPTY,RCSTART,ZTSTOP,RCEND,DIC,RCIND,RCNP1
 S RCIND=1
 S RCRANGE=$$DTRNG^RCDPEM4()
 I RCRANGE=0 G EN1Q
 I $P(RCRANGE,U,1) D
 . S RCSTART=$P(RCRANGE,U,2)-1
 . S RCEND=$P(RCRANGE,U,3)
 ;Get insurance company to be used as filter
 ; PRCA*4.5*284 - RCDPEM9 now return a stack in RCNP (Type of Response(1=Range,2=All,3=Specific)^From Range^Thru Range)
 S RCNP=$$GETPAY^RCDPEM9(344.31) I +RCNP=-1 G EN1Q
 ;Get display type
 S RCDISPTY=$$DISPTY^RCDPEM3() Q:RCDISPTY=-1
 I $D(DUOUT)!$D(DTOUT) G EN1Q
 I RCDISPTY D INFO^RCDPEM6
 S:$P($G(RCRANGE),U)>0 RCIND=RCIND+3
 S:$D(^TMP("RCSELPAY",$J))&(+RCNP=1) RCIND=RCIND+5
 S RCJOB=$J
 ; Ask device
 S %ZIS="QM" D ^%ZIS G:POP EN1Q
 I $D(IO("Q")) D  G EN1Q
 . S ZTRTN="RPTOUT^RCDPEAR2",ZTDESC="EFT AGING REPORT"
 . S ZTSAVE("*")=""
 . ; PRCA*4.5*284 - Because TMP global may be on another server, save off specific payers in local
 . I +RCNP=3 M RCNP1=^TMP("RCSELPAY",$J)
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Your task number "_ZTSK_" has been queued.",1:"Unable to queue this job.")
 . K ZTSK,IO("Q") D HOME^%ZIS
 U IO
 D RPTOUT
EN1Q Q
 ;
RPTOUT(RCPRT) ; Entrypoint for queued job, nightly job
 ; RCPRT = name of the subscript for ^TMP to use to return all lines
 ;        (for bulletin).  If undefined or null, output is printed
 ; Return global if RCPRT not null: ^TMP($J,RCPRT,line#)=line text
 N RCCT,RCPG,RCPGS,RCSTOP,RCNT,RCTOT,RCOUT,RC0,RC13,RCZ,RCZ0,RC00,Z,Z0,DIC,DUOUT,X,RCPAY,RCRUNDT
 S RCPRT=$G(RCPRT)
 S (RCCT,RCSTOP,RCPG,RCNT,RCTOT,RCPGS)=0,RCRUNDT=$$NOW^RCDPEM6
 S RCPGS=1
 K ^TMP($J,"RCERA_AGED"),^TMP($J,"RCERA_ADJ")
 ; PRCA*4.5*284 - Queued job needs to reload payer selection list
 I $G(RCJOB)'="",RCJOB'=$J D
 . K ^TMP("RCSELPAY",$J)
 . D RLOAD^RCDPEAR1(344.31)
 . S RCJOB=$J
 ; build local payer array here
 S RCNP=+RCNP
 D SELPAY^RCDPEAR1(RCNP,RCJOB,.RCPAY)
 I RCPRT'="" K ^TMP($J,RCPRT)
 S RCZ0=0 F  S RCZ0=$O(^RCY(344.31,"AMATCH",0,RCZ0)) Q:'RCZ0  D
 .Q:$P($G(^RCY(344.31,RCZ0,3)),U)
 .Q:$P($G(^RCY(344.31,RCZ0,0)),U,7)=0
 .S RC13=$P($G(^RCY(344.31,RCZ0,0)),U,13)  ;date received
 .; Check for payer match
 .I '$$CHKPYR^RCDPEDAR(RCZ0,0,RCJOB) Q
 .; Check date range
 .I $P(RCRANGE,U,1) Q:(RCSTART>RC13)!(RC13>RCEND)
 .; Passed all the filters - include on report
 .S ^TMP($J,"RCEFT_AGED",$$FMDIFF^XLFDT(RC13,DT),RCZ0)=0,RCNT=RCNT+1
 I RCDISPTY D HDR(.RCCT,.RCPG,.RCSTOP,RCPRT,RCRANGE,.RCPAY,RCRUNDT),EXCEL Q
 ;
 ; Find total amount of EFTs
 S RCZ="" F  S RCZ=$O(^TMP($J,"RCEFT_AGED",RCZ)) Q:RCZ=""  S RCZ0=0 F  S RCZ0=$O(^TMP($J,"RCEFT_AGED",RCZ,RCZ0)) Q:'RCZ0  D  G:RCSTOP PRTQ
 . I $D(ZTQUEUED),$$S^%ZTLOAD S (RCSTOP,ZTSTOP)=1 K ZTREQ I +$G(RCPG) W:RCPRT="" !!,"***TASK STOPPED BY USER***" Q
 . S RC0=$G(^RCY(344.31,RCZ0,0)),RC00=$G(^RCY(344.3,+RC0,0))
 . S RCTOT=RCTOT+$P(RC0,U,7)
 ;
 S RCZ="" F  S RCZ=$O(^TMP($J,"RCEFT_AGED",RCZ)) Q:RCZ=""  S RCZ0=0 F  S RCZ0=$O(^TMP($J,"RCEFT_AGED",RCZ,RCZ0)) Q:'RCZ0  D  G:RCSTOP PRTQ
 . I $D(ZTQUEUED),$$S^%ZTLOAD S (RCSTOP,ZTSTOP)=1 K ZTREQ I +$G(RCPG) W:RCPRT="" !!,"***TASK STOPPED BY USER***" Q
 . I RCPG D SETLINE(" ",.RCCT,.RCPRT) ; On detail list, skip line
 . I 'RCPG!(($Y+5)>IOSL) S RCPGS=RCPGS+1 D HDR(.RCCT,.RCPG,.RCSTOP,RCPRT,RCRANGE,.RCPAY,RCRUNDT) Q:RCSTOP
 . S RC0=$G(^RCY(344.31,RCZ0,0)),RC00=$G(^RCY(344.3,+RC0,0))
 . S RCTOT=RCTOT+$P(RC0,U,7)
 . S Z=$$SETSTR^VALM1($J(-RCZ,4),"",1,4)
 . S Z=$$SETSTR^VALM1("  "_$P(RC0,U,4),Z,5,75)
 . D SETLINE(Z,.RCCT,RCPRT)
 . S Z=$$SETSTR^VALM1($P(RC0,U,2)_"/"_$P(RC0,U,3),"",11,69)
 . S Z=$$SETSTR^VALM1("  "_$$FMTE^XLFDT($P(RC0,U,12),2),Z,70,10)
 . D SETLINE(Z,.RCCT,RCPRT)
 . S Z=$$SETSTR^VALM1($J("",6)_$S($P(RC0,U,13):$$FMTE^XLFDT($P(RC0,U,13),2),1:""),"",1,17)
 . S Z=$$SETSTR^VALM1("  "_$J($P(RC0,U,7),15,2),Z,18,17)
 . ; PRCA*4.5*283 - change length from 8 to 11 to allow for 9 digit
 . ; DEP #'s
 . S Z=$$SETSTR^VALM1("  "_$P(RC00,U,6),Z,35,11)
 . S Z=$$SETSTR^VALM1("  "_$S($P(RC00,U,12):"",1:"NOT ")_"POSTED TO 8NZZ"_$S($P(RC00,U,12):" ON "_$$FMTE^XLFDT($P(RC00,U,11),2),1:""),Z,47,36)
 . D SETLINE(Z,.RCCT,RCPRT)
 . ;
 . K RCOUT
 . D GETS^DIQ(344.31,RCZ0_",",2,"E","RCOUT")
 . Q:'$O(RCOUT(344.31,RCZ0_",",2,0))
 . D SETLINE($J("",8)_"--EXCEPTION NOTES--",.RCCT,RCPRT)
 . S Z=0 F  S Z=$O(RCOUT(344.31,RCZ0_",",2,Z)) Q:'Z  D  Q:RCSTOP
 .. I ($Y+5)>IOSL D HDR(.RCCT,.RCPG,.RCSTOP,RCPRT,RCRANGE,.RCPAY,RCRUNDT) Q:RCSTOP
 .. D SETLINE($J("",8)_" "_RCOUT(344.31,RCZ0_",",2,Z),.RCCT,RCPRT)
 ;
 F Z0=1:1:2 D SETLINE(" ",.RCCT,RCPRT)
 I ($Y+7)>IOSL!'RCPG D HDR(.RCCT,.RCPG,.RCSTOP,RCPRT,RCRANGE,.RCPAY,RCRUNDT)
 S Z=$$SETSTR^VALM1("TOTALS:","",1,79)
 ;
 W !,"*** END OF REPORT ***",!
PRTQ I '$D(ZTQUEUED),'RCSTOP,RCPG,RCPRT="" D ASK()
 I $D(ZTQUEUED) S ZTREQ="@"
 I '$D(ZTQUEUED) D ^%ZISC
 K ^TMP($J,"RCEFT_AGED"),ZTQUEUED
 Q
 ;
HDR(RCCT,RCPG,RCSTOP,RCPRT,RCRANGE,RCPAY,RCRUNDT) ;Prints report heading
 ; Function returns RCPG = current page # and RCCT = running line count
 ;   and RCSTOP = 1 if user aborted print 
 ; Above parameters must be passed by reference
 ; RCPRT = name of the subscript for ^TMP to use to return all lines
 ;        (for bulletin).  If undefined or null, output is printed
 ; RCRANGE - date range filter value to be printed as part of the header
 ; RCPAY (required/pass-by-ref) - Payer filter value(s)
 ;
 N CNT,END,START,Z,Z0
 I RCPG!($E(IOST,1,2)="C-") D
 . I RCPG&($E(IOST,1,2)="C-")&(RCPRT="") D ASK(.RCSTOP) Q:RCSTOP
 . I RCPRT="" W @IOF,*13 Q  ; Write form feed for report
 Q:$G(RCSTOP)
 S RCPG=RCPG+1
 S Z0="EFT UNMATCHED AGING REPORT"
 S Z=$$SETSTR^VALM1($J("",80-$L(Z0)\2)_Z0,"",1,79)
 S:'RCDISPTY Z=$$SETSTR^VALM1("Page: "_RCPG,Z,64,17)
 D SETLINE(Z,.RCCT,RCPRT)
 S Z0="RUN DATE: "_RCRUNDT,Z0=$J("",80-$L(Z0)\2)_Z0
 S Z=$$SETSTR^VALM1(Z0,"",1,79)
 D SETLINE(Z,.RCCT,RCPRT)
 ; Payer(s)
 S Z="PAYERS: "
 I $D(RCPAY)=1 S Z=Z_RCPAY
 I $D(RCPAY)=10 D
 . S CNT=0
 . F  S CNT=$O(RCPAY(CNT)) Q:'CNT  D
 .. I Z="PAYERS: " S Z=Z_RCPAY(CNT) Q
 .. S Z=Z_$S(Z]"":",",1:"")_RCPAY(CNT)
 .. I $L(Z)>60 D
 ... S Z=$J("",88-$L(Z)\2)_Z
 ... D SETLINE(Z,.RCCT,RCPRT)
 ... S Z=""
 I Z]"" D
 . S Z=$J("",88-$L(Z)\2)_Z
 . D SETLINE(Z,.RCCT,RCPRT)
 ; Date Range
 S END=$P(RCRANGE,U,3)
 S START=$P(RCRANGE,U,2)
 S Z="DATE RANGE: "_$P($$FMTE^XLFDT(START,2),"@")_" - "_$P($$FMTE^XLFDT(END,2),"@")_" (DATE EFT FILED)",Z=$J("",80-$L(Z)\2)_Z
 D SETLINE(Z,.RCCT,RCPRT)
 Q:RCDISPTY
 D SETLINE("AGED",.RCCT,RCPRT)
 S Z=$$SETSTR^VALM1("DAYS"_$J("",2)_"TRACE #","",1,79)
 D SETLINE(Z,.RCCT,RCPRT)
 S Z=$$SETSTR^VALM1($J("",10)_"DEPOSIT FROM/ID"_$J("",46)_"DEP DATE","",1,79)
 D SETLINE(Z,.RCCT,RCPRT)
 ; PRCA*4.5*283 - Add 3 more spaces between DEP # AND DEPOSIT POST 
 ; STATUS to allow for 9 digit DEP #'s
 S Z=$$SETSTR^VALM1($J("",6)_"FILE DATE"_$J("",5)_"DEPOSIT AMOUNT"_$J("",2)_"DEP #  "_$J("",5)_"DEPOSIT POST STATUS",Z,1,79)
 D SETLINE(Z,.RCCT,RCPRT)
 D SETLINE($TR($J("",IOM-1)," ","="),.RCCT,RCPRT)
 I RCPG=1 D
 . S Z=$$SETSTR^VALM1("TOTALS:","",1,79)
 . D SETLINE(Z,.RCCT,RCPRT)
 . S Z=$$SETSTR^VALM1(" NUMBER AGED ELECTRONIC EFT MESSAGES FOUND: "_RCNT,"",1,79)
 . D SETLINE(Z,.RCCT,RCPRT)
 . S Z=$$SETSTR^VALM1(" AMOUNT AGED ELECTRONIC EFT MESSAGES FOUND: $"_$FN(+RCTOT,",",2),"",1,79)
 . D SETLINE(Z,.RCCT,RCPRT)
 . D SETLINE($TR($J("",IOM-1)," ","="),.RCCT,RCPRT)
 Q
 ;
SETLINE(Z,RCCT,RCPRT) ; Sets line into print global or writes line
 ; Z = txt to output
 ; RCCT = line counter
 ; RCPRT = flag if 1, indicates output to global, no writes 
 S RCCT=RCCT+1
 I RCPRT="" W !,Z Q
 S ^TMP($J,RCPRT,RCCT)=Z
 Q
 ;
ASK(RCSTOP) ; Ask to continue
 ; If passed by reference ,RCSTOP is returned as 1 if print is aborted
 I $E(IOST,1,2)'["C-" Q
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="E" W ! D ^DIR
 I ($D(DIRUT))!($D(DUOUT)) S RCSTOP=1 Q
 Q
 ;
EXCEL ; Print report to screen, one record per line for export to MS Excel.
 W !!,"Aged Days^Trace #^Deposit From/ID^File Date^Deposit Amount^Deposit #^Deposit Post Status^Deposit Date"
 S RCZ="" F  S RCZ=$O(^TMP($J,"RCEFT_AGED",RCZ)) Q:RCZ=""  S RCZ0=0 F  S RCZ0=$O(^TMP($J,"RCEFT_AGED",RCZ,RCZ0)) Q:'RCZ0  D  G:RCSTOP PRTQ2
 . I $D(ZTQUEUED),$$S^%ZTLOAD S (RCSTOP,ZTSTOP)=1 K ZTREQ I +$G(RCPG) W:RCPRT="" !!,"***TASK STOPPED BY USER***" Q
 . S RC0=$G(^RCY(344.31,RCZ0,0)),RC00=$G(^RCY(344.3,+RC0,0))
 . S Z=$J(-RCZ,4)_"^"_$P(RC0,U,4)_"^"_$P(RC0,U,2)_"/"_$P(RC0,U,3)_"^"_$S($P(RC0,U,13):$$FMTE^XLFDT($P(RC0,U,13),2),1:"")_"^"
 . S Z=Z_$P(RC0,U,7)_"^"_$P(RC00,U,6)_"^"_$S($P(RC00,U,12):"",1:"NOT ")_"POSTED TO 8NZZ"_$S($P(RC00,U,12):"^"_$$FMTE^XLFDT($P(RC0,U,12),2),1:"")
 . W !,Z
 W !!,"*** END OF REPORT ***",!
 ;
PRTQ2 ;
 I $D(ZTQUEUED) S ZTREQ="@"
 I '$D(ZTQUEUED) D ^%ZISC
 K ^TMP($J,"RCEFT_AGED"),^TMP("RCSELPAY",$J),^TMP("RCPAYER",$J),^TMP($J,"RCERA_ADJ")
 Q
