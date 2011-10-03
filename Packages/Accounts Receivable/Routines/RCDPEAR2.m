RCDPEAR2 ;ALB/TMK - ELECTRONIC EFT AGING REPORT - FILE 344.3 ;04-NOV-02
 ;;4.5;Accounts Receivable;**173**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
EN1 ; Entry from option - run on the fly
 N RCDETAIL,RCMIN,DIR,X,Y,%ZIS,ZTRTN,ZTSAVE,ZTDESC,POP
 S DIR(0)="NA^0:1000",DIR("A")="Enter the minimum # of days elapsed before including on report (0-1000): " S:$P($G(^RC(342,1,7)),U,2) DIR("B")=$P(^(7),U,2)
 S DIR("?",1)="This is the # minimum # of days this EFT has been in an UNMATCHED status",DIR("?",2)="before being included on this report.  EFT's with a 0 dollar balance are",DIR("?")="always excluded from this report."
 W ! D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) G EN1Q
 S RCMIN=+Y
 S DIR(0)="SA^S:SUMMARY;D:DETAIL",DIR("A")="DO YOU WANT (S)UMMARY OR (D)ETAIL?: ",DIR("B")="SUMMARY" D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) G EN1Q
 S RCDETAIL=(Y="D")
 ; Ask device
 S %ZIS="QM" D ^%ZIS G:POP EN1Q
 I $D(IO("Q")) D  G EN1Q
 . S ZTRTN="RPTOUT^RCDPEAR2("_RCMIN_","_RCDETAIL_")",ZTDESC="AR - EDI LOCKBOX EFT AGING REPORT"
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Your task number "_ZTSK_" has been queued.",1:"Unable to queue this job.")
 . K ZTSK,IO("Q") D HOME^%ZIS
 U IO
 D RPTOUT(RCMIN,RCDETAIL)
EN1Q Q
 ;
RPTOUT(RCMIN,RCDETAIL,RCPRT) ; Entrypoint for queued job, nightly job
 ; RCMIN = the minimum # of days before an entry is included on report
 ; RCDETAIL = 1 if detail is needed, otherwise only summary is reported
 ; RCPRT = name of the subscript for ^TMP to use to return all lines
 ;        (for bulletin).  If undefined or null, output is printed
 ; Return global if RCPRT not null: ^TMP($J,RCPRT,line#)=line text
 N RCCT,RCPG,RCSTOP,RCNT,RCTOT,RCOUT,RCEDT,RC0,RC1,RC13,RCZ,RCZ0,RC00,Z,Z0
 S RCPRT=$G(RCPRT)
 S (RCCT,RCSTOP,RCPG,RCNT,RCTOT)=0
 S RCEDT=$$FMADD^XLFDT(DT,-RCMIN)
 K ^TMP($J,"RCEFT_AGED")
 I RCPRT'="" K ^TMP($J,RCPRT)
 S RCZ0=0 F  S RCZ0=$O(^RCY(344.31,"AMATCH",0,RCZ0)) Q:'RCZ0  D
 . Q:$P($G(^RCY(344.31,RCZ0,0)),U,7)=0
 . S RC13=$P($G(^RCY(344.31,RCZ0,0)),U,13)
 . I RC13>RCEDT Q
 . ; Minimum days have elapsed - include on report
 . S ^TMP($J,"RCEFT_AGED",$$FMDIFF^XLFDT(RC13,DT),RCZ0)=0,RCNT=RCNT+1
 ;
 S RCZ="" F  S RCZ=$O(^TMP($J,"RCEFT_AGED",RCZ)) Q:RCZ=""  S RCZ0=0 F  S RCZ0=$O(^TMP($J,"RCEFT_AGED",RCZ,RCZ0)) Q:'RCZ0  D  G:RCSTOP PRTQ
 . I $D(ZTQUEUED),$$S^%ZTLOAD S (RCSTOP,ZTSTOP)=1 K ZTREQ I +$G(RCPG) W:RCPRT="" !!,"***TASK STOPPED BY USER***" Q
 . I RCDETAIL,RCPG D SETLINE(" ",.RCCT,.RCPRT) ; On detail list, skip line
 . I 'RCPG!(($Y+5)>IOSL) D HDR(.RCCT,.RCPG,RCMIN,.RCSTOP,RCPRT,RCDETAIL) Q:RCSTOP
 . S RC0=$G(^RCY(344.31,RCZ0,0)),RC00=$G(^RCY(344.3,+RC0,0))
 . S RCTOT=RCTOT+$P(RC0,U,7)
 . S Z=$$SETSTR^VALM1($J(-RCZ,4),"",1,4)
 . S Z=$$SETSTR^VALM1("  "_$P(RC0,U,4),Z,5,22)
 . S Z=$$SETSTR^VALM1("  "_$E($P(RC0,U,2),1,30)_"/"_$P(RC0,U,3),Z,27,43)
 . S Z=$$SETSTR^VALM1("  "_$$FMTE^XLFDT($P(RC0,U,12),2),Z,70,10)
 . D SETLINE(Z,.RCCT,RCPRT)
 . S Z=$$SETSTR^VALM1($J("",6)_$S($P(RC0,U,13):$$FMTE^XLFDT($P(RC0,U,13),2),1:""),"",1,17)
 . S Z=$$SETSTR^VALM1("  "_$J($P(RC0,U,7),15,2),Z,18,17)
 . S Z=$$SETSTR^VALM1("  "_$P(RC00,U,6),Z,35,8)
 . S Z=$$SETSTR^VALM1("  "_$S($P(RC00,U,12):"",1:"NOT ")_"POSTED TO 8NZZ"_$S($P(RC00,U,12):" ON "_$$FMTE^XLFDT($P(RC00,U,11),2),1:""),Z,44,36)
 . D SETLINE(Z,.RCCT,RCPRT)
 . ;
 . I RCDETAIL D  ; Detail wanted
 .. K RCOUT
 .. D GETS^DIQ(344.31,RCZ0_",",2,"E","RCOUT")
 .. Q:'$O(RCOUT(344.31,RCZ0_",",2,0))
 .. D SETLINE($J("",8)_"--EXCEPTION NOTES--",.RCCT,RCPRT)
 .. S Z=0 F  S Z=$O(RCOUT(344.31,RCZ0_",",2,Z)) Q:'Z  D  Q:RCSTOP
 ... I ($Y+5)>IOSL D HDR(.RCCT,.RCPG,RCMIN,.RCSTOP,RCPRT,RCDETAIL) Q:RCSTOP
 ... D SETLINE($J("",8)_" "_RCOUT(344.31,RCZ0_",",2,Z),.RCCT,RCPRT)
 ;
 F Z0=1:1:2 D SETLINE(" ",.RCCT,RCPRT)
 I ($Y+7)>IOSL!'RCPG D HDR(.RCCT,.RCPG,RCMIN,.RCSTOP,RCPRT,RCDETAIL)
 S Z=$$SETSTR^VALM1("TOTALS:","",1,79)
 D SETLINE(Z,.RCCT,RCPRT)
 S Z=$$SETSTR^VALM1(" NUMBER AGED ELECTRONIC EFT MESSAGES FOUND: "_RCNT,"",1,79)
 D SETLINE(Z,.RCCT,RCPRT)
 S Z=$$SETSTR^VALM1(" AMOUNT AGED ELECTRONIC EFT MESSAGES FOUND: "_$J(+RCTOT,0,2),"",1,79)
 D SETLINE(Z,.RCCT,RCPRT)
 ;
PRTQ I '$D(ZTQUEUED),'RCSTOP,RCPG,RCPRT="" D ASK()
 I $D(ZTQUEUED) S ZTREQ="@"
 I '$D(ZTQUEUED) D ^%ZISC
 K ^TMP($J,"RCEFT_AGED")
 Q
 ;
HDR(RCCT,RCPG,RCMIN,RCSTOP,RCPRT,RCDETAIL) ;Prints report heading
 ; Function returns RCPG = current page # and RCCT = running line count
 ;   and RCSTOP = 1 if user aborted print 
 ; Above parameters must be passed by reference
 ; RCMIN = the minimum # of days before an entry is included on report
 ; RCDETAIL = 1 if detail is needed, otherwise only summary is reported
 ; RCPRT = name of the subscript for ^TMP to use to return all lines
 ;        (for bulletin).  If undefined or null, output is printed
 N Z,Z0
 I RCPG!($E(IOST,1,2)="C-") D
 . I RCPG&($E(IOST,1,2)="C-")&(RCPRT="") D ASK(.RCSTOP) Q:RCSTOP
 . I RCPRT="" W @IOF,*13 Q  ; Write form feed for report
 . ; Add 2 blank lines for bulletin
 . F Z=1:1:2 D SETLINE(" ",.RCCT,RCPRT)
 Q:$G(RCSTOP)
 S RCPG=RCPG+1
 S Z0="EDI LOCKBOX EFT UNMATCHED AGING "_$S(RCDETAIL:"DETAIL",1:"SUMMARY")_" REPORT"
 S Z=$$SETSTR^VALM1($J("",80-$L(Z0)\2)_Z0,"",1,79)
 S Z=$$SETSTR^VALM1("Page: "_RCPG,Z,70,10)
 D SETLINE(Z,.RCCT,RCPRT)
 S Z0="MINIMUM DAYS NOT MATCHED FOR AGING: "_RCMIN,Z0=$J("",80-$L(Z0)\2)_Z0
 S Z=$$SETSTR^VALM1(Z0,"",1,79)
 D SETLINE(Z,.RCCT,RCPRT)
 S Z0="RUN DATE: "_$$FMTE^XLFDT(DT,2),Z0=$J("",80-$L(Z0)\2)_Z0
 S Z=$$SETSTR^VALM1(Z0,"",1,79)
 D SETLINE(Z,.RCCT,RCPRT)
 D SETLINE(" ",.RCCT,RCPRT)
 D SETLINE("AGED",.RCCT,RCPRT)
 S Z=$$SETSTR^VALM1("DAYS"_$J("",2)_"TRACE #"_$J("",15)_"DEPOSIT FROM/ID"_$J("",28)_"DEP DATE","",1,79)
 D SETLINE(Z,.RCCT,RCPRT)
 D SETLINE(" ",.RCCT,RCPRT)
 S Z=$$SETSTR^VALM1($J("",6)_"FILE DATE"_$J("",5)_"DEPOSIT AMOUNT"_$J("",2)_"DEP #  "_$J("",2)_"DEPOSIT POST STATUS",Z,1,79)
 D SETLINE(Z,.RCCT,RCPRT)
 D SETLINE($TR($J("",IOM-1)," ","="),.RCCT,RCPRT)
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
