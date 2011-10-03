RCDPEAR1 ;ALB/TMK - ELECTRONIC ERA AGING REPORT - FILE 344.4 ;31-OCT-02
 ;;4.5;Accounts Receivable;**173**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
EN1 ; Entry from option - run on the fly
 N RCDETAIL,RCMIN,DIR,X,Y,%ZIS,ZTRTN,ZTSAVE,ZTDESC,POP
 S DIR(0)="NA^0:1000",DIR("A")="Enter the minimum # of days elapsed before including on report (0-1000): " S:$P($G(^RC(342,1,7)),U,3) DIR("B")=$P(^(7),U,3)
 W ! D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) G EN1Q
 S RCMIN=+Y
 S DIR(0)="SA^S:SUMMARY;D:DETAIL",DIR("A")="DO YOU WANT (S)UMMARY OR (D)ETAIL?: ",DIR("B")="SUMMARY" D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) G EN1Q
 S RCDETAIL=(Y="D")
 ; Ask device
 S %ZIS="QM" D ^%ZIS G:POP EN1Q
 I $D(IO("Q")) D  G EN1Q
 . S ZTRTN="RPTOUT^RCDPEAR1("_RCMIN_","_RCDETAIL_")",ZTDESC="AR - EDI LOCKBOX ERA AGING REPORT"
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
 N RCCT,RCPG,RCSTOP,RCNT,RCDATA,RCOUT,RCEDT,RC0,RC7,RCZ,RCZ0,RCZ1,RC00,RCTOT,Z,Z0
 S RCPRT=$G(RCPRT)
 S (RCCT,RCSTOP,RCPG,RCNT,RCTOT)=0
 S RCEDT=$$FMADD^XLFDT(DT,-RCMIN)
 K ^TMP($J,"RCERA_AGED"),^TMP($J,"RCERA_ADJ")
 I RCPRT'="" K ^TMP($J,RCPRT)
 S RCZ0=0 F  S RCZ0=$O(^RCY(344.4,"AMATCH",0,RCZ0)) Q:'RCZ0  D
 . S RC7=$P($G(^RCY(344.4,RCZ0,0)),U,7)\1
 . I RC7>RCEDT Q
 . ; Minimum days have elapsed - include on report
 . S ^TMP($J,"RCERA_AGED",$$FMDIFF^XLFDT(RC7,DT),RCZ0)=0,RCNT=RCNT+1
 S RCZ="" F  S RCZ=$O(^TMP($J,"RCERA_AGED",RCZ)) Q:RCZ=""  S RCZ0=0 F  S RCZ0=$O(^TMP($J,"RCERA_AGED",RCZ,RCZ0)) Q:'RCZ0  D  G:RCSTOP PRTQ
 . I $D(ZTQUEUED),$$S^%ZTLOAD S (RCSTOP,ZTSTOP)=1 K ZTREQ I +$G(RCPG) W:RCPRT="" !!,"***TASK STOPPED BY USER***" Q
 . I RCDETAIL,RCPG D SETLINE(" ",.RCCT,.RCPRT) ; On detail list, skip line
 . I 'RCPG!(($Y+5)>IOSL) D HDR(.RCCT,.RCPG,.RCSTOP,RCPRT,RCDETAIL,RCMIN) Q:RCSTOP
 . S RC0=$G(^RCY(344.4,RCZ0,0)),RCTOT=RCTOT+$P(RC0,U,5)
 . S Z=$$SETSTR^VALM1($J(-RCZ,4),"",1,4)
 . S Z=$$SETSTR^VALM1("  "_$P(RC0,U,2),Z,5,22)
 . S Z=$$SETSTR^VALM1("  "_$E($P(RC0,U,6),1,30)_"/"_$P(RC0,U,3),Z,27,43)
 . S Z=$$SETSTR^VALM1("  "_$$FMTE^XLFDT($P(RC0,U,4),2),Z,70,10)
 . D SETLINE(Z,.RCCT,RCPRT)
 . S Z=$$SETSTR^VALM1($J("",16)_$S($P(RC0,U,7):$$FMTE^XLFDT($P(RC0,U,7)\1,2),1:""),"",1,25)
 . S Z=$$SETSTR^VALM1("  "_$J($P(RC0,U,5),15,2),Z,26,17)
 . S Z=$$SETSTR^VALM1("  "_+$P(RC0,U,11),Z,43,11)
 . S Z=$$SETSTR^VALM1("  "_$P(RC0,U),Z_$S('$$HACERA^RCDPEU(RCZ0):"",1:" (HAC ERA)"),54,26)
 . D SETLINE(Z,.RCCT,RCPRT)
 . ;
 . I "23"[$$ADJ^RCDPEU(RCZ0) D SETLINE($J("",9)_"** CLAIM LEVEL ADJUSTMENTS EXIST FOR THIS ERA ***",.RCCT,RCPRT)
 . I $O(^RCY(344.4,RCZ0,2,0)) D  ; ERA level adjustments exist
 .. N Q
 .. D DISPADJ^RCDPESR8(RCZ0,"^TMP("_$J_",""RCERA_ADJ"")")
 .. I $O(^TMP($J,"RCERA_ADJ",0)) D SETLINE($J("",9)_"** GENERAL ADJUSTMENT DATA EXISTS FOR ERA **",.RCCT,RCPRT)
 .. S Q=0 F  S Q=$O(^TMP($J,"RCERA_ADJ",Q)) Q:'Q  D SETLINE($J("",9)_$G(^TMP($J,"RCERA_ADJ",Q)),.RCCT,RCPRT)
 . ;
 . I RCDETAIL D  ; Detail wanted
 .. S RCZ1=0 F  S RCZ1=$O(^RCY(344.4,RCZ0,1,RCZ1)) Q:'RCZ1  S RC00=$G(^(RCZ1,0)) D  Q:RCSTOP
 ... N D
 ... K RCDATA,RCOUT
 ... ;I $O(^RCY(344.4,RCZ0,1,RCZ1),-1) D SETLINE(" ",.RCCT,RCPRT)
 ... I ($Y+5)>IOSL D HDR(.RCCT,.RCPG,.RCSTOP,RCPRT,RCDETAIL,RCMIN) Q:RCSTOP
 ... S D=$J("",7)_" EEOB Seq #: "_$P(RC00,U)_$S($D(^RCY(344.4,RCZ0,1,"ATB",1,RCZ1)):" (REVERSAL)",1:"")_"  EEOB "
 ... S D=D_$S('$P(RC00,U,2):"not on file",1:"on file for "_$P($G(^DGCR(399,+$G(^IBM(361.1,+$P(RC00,U,2),0)),0)),U))_"  "_$J(+$P(RC00,U,3),"",2)
 ... D SETLINE(D,.RCCT,RCPRT)
 ... Q:$P(RC00,U,2)
 ... D DISP^RCDPESR0("^RCY(344.4,"_RCZ0_",1,"_RCZ1_",1)","RCDATA",1,"RCOUT",68,1)
 ... I '$O(RCOUT(0)) D SETLINE($J("",9)_" NO DETAIL FOUND",.RCCT,RCPRT) Q
 ... S Z=0 F  S Z=$O(RCOUT(Z)) Q:'Z  D  Q:RCSTOP
 .... I ($Y+5)>IOSL D HDR(.RCCT,.RCPG,.RCSTOP,RCPRT,RCDETAIL,RCMIN) Q:RCSTOP
 .... D SETLINE($J("",9)_"*"_RCOUT(Z),.RCCT,RCPRT)
 ;
 F Z0=1:1:2 D SETLINE(" ",.RCCT,RCPRT)
 I ($Y+7)>IOSL!'RCPG D HDR(.RCCT,.RCPG,.RCSTOP,RCPRT,RCDETAIL,RCMIN)
 S Z=$$SETSTR^VALM1("TOTALS:","",1,79)
 D SETLINE(Z,.RCCT,RCPRT)
 S Z=$$SETSTR^VALM1(" NUMBER AGED ELECTRONIC ERA MESSAGES FOUND: "_RCNT,"",1,79)
 D SETLINE(Z,.RCCT,RCPRT)
 S Z=$$SETSTR^VALM1(" AMOUNT AGED ELECTRONIC ERA MESSAGES FOUND: "_$J(RCTOT,0,2),"",1,79)
 D SETLINE(Z,.RCCT,RCPRT)
 ;
PRTQ I '$D(ZTQUEUED),'RCSTOP,RCPG,RCPRT="" D ASK()
 I $D(ZTQUEUED) S ZTREQ="@"
 I '$D(ZTQUEUED) D ^%ZISC
 K ^TMP($J,"RCERA_AGED")
 Q
 ;
HDR(RCCT,RCPG,RCSTOP,RCPRT,RCDETAIL,RCMIN) ;Prints report heading
 ; Function returns RCPG = current page # and RCCT = running line count
 ;   and RCSTOP = 1 if user aborted print 
 ; Parameters must be passed by reference
 ; RCDETAIL = 1 if detail is needed, otherwise only summary is reported
 ; RCPRT = name of the subscript for ^TMP to use to return all lines
 ;        (for bulletin).  If undefined or null, output is printed
 ; RCMIN = minimum # days being used to age
 N Z,Z0
 Q:$G(RCSTOP)
 I RCPG!($E(IOST,1,2)="C-") D  Q:$G(RCSTOP)
 . I RCPG&($E(IOST,1,2)="C-")&(RCPRT="") D ASK(.RCSTOP) Q:RCSTOP
 . I RCPRT="" W @IOF,*13 Q  ; Write form feed for report
 . ; Add 2 blank lines for bulletin
 . F Z=1:1:2 D SETLINE(" ",.RCCT,RCPRT)
 S RCPG=RCPG+1
 S Z0="EDI LOCKBOX ERA AGING "_$S(RCDETAIL:"DETAIL",1:"SUMMARY")_" REPORT"
 S Z=$$SETSTR^VALM1($J("",80-$L(Z0)\2)_Z0,"",1,79)
 S Z=$$SETSTR^VALM1("Page: "_RCPG,Z,70,10)
 D SETLINE(Z,.RCCT,RCPRT)
 S Z0="MINIMUM DAYS FOR AGING: "_RCMIN,Z0=$J("",80-$L(Z0)\2)_Z0
 S Z=$$SETSTR^VALM1(Z0,"",1,79)
 D SETLINE(Z,.RCCT,RCPRT)
 S Z0="RUN DATE: "_$$FMTE^XLFDT(DT,2),Z0=$J("",80-$L(Z0)\2)_Z0
 S Z=$$SETSTR^VALM1(Z0,"",1,79)
 D SETLINE(Z,.RCCT,RCPRT)
 D SETLINE(" ",.RCCT,RCPRT)
 D SETLINE("AGED",.RCCT,RCPRT)
 S Z=$$SETSTR^VALM1("DAYS"_$J("",2)_"TRACE #"_$J("",15)_"PAYMENT FROM/ID"_$J("",28)_"ERA DATE","",1,79)
 D SETLINE(Z,.RCCT,RCPRT)
 D SETLINE(" ",.RCCT,RCPRT)
 S Z=$$SETSTR^VALM1($J("",16)_"FILE DATE"_$J("",6)_"AMOUNT PAID"_$J("",2)_"EEOB CNT "_$J("",2)_"ERA #",Z,1,79)
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
