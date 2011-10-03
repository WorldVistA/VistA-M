RCDPEWLC ;ALB/TMK - EEOB WORKLIST BATCH PROCESSING ;18-FEB-2004
 ;;4.5;Accounts Receivable;**208**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
SUMRPT(RCERA) ; Produce batch summary report from the ERA worklist for
 ; ERA worklist entry RCERA
 N POP,ZTDESC,ZTRTN,ZTQUEUED,%ZIS
 D FULL^VALM1
 I '$O(^RCY(344.49,RCERA,3,0)) D NOTSET Q
 ; Ask device
 S %ZIS="QM" D ^%ZIS G:POP SUMRPTQ
 I $D(IO("Q")) D  G SUMRPTQ
 . S ZTRTN="RPTOUT^RCDPEWLC("_RCERA_")",ZTDESC="AR - EDI LOCKBOX BATCH SUMMARY REPORT"
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Your task number "_ZTSK_" has been queued.",1:"Unable to queue this job.")
 . K ZTSK,IO("Q") D HOME^%ZIS
 U IO
 D RPTOUT(RCERA)
SUMRPTQ Q
 ;
RPTOUT(RCERA) ; Queued job entrypoint
 N RCPG,RCSTOP,RCT,RCHAS,Q,Z,Z0
 S (RCPG,RCSTOP,RCHAS)=0
 S Z=0 F  S Z=$O(^RCY(344.49,RCERA,3,Z)) Q:'Z!RCSTOP  S Z0=$G(^(Z,0)) D
 . I 'RCPG!(($Y+5)>IOSL) D HDR(.RCPG,RCERA,.RCSTOP)
 . Q:RCSTOP
 . S RCHAS=1,RCT=0
 . S Q=0 F  S Q=$O(^RCY(344.49,RCERA,1,"ABAT",+Z0,Q)) Q:'Q  S RCT=RCT+1
 . W !,$J(+Z0,7)_"  "_$E($P(Z0,U,2)_$J("",30),1,30)_"  "_$P("NO ^YES",U,$P(Z0,U,3)+1)_$J("",13)_$P($G(^VA(200,+$P(Z0,U,4),0)),U)
 . W !,$J("",9)_"# RECORDS: "_RCT_"  CRITERIA: "_$$EXTERNAL^DILFD(344.493,.06,"",$P(Z0,U,6))
 . I $P(Z0,U,6)<3 W " FROM: "_$P(Z0,U,7)_" TO: "_$P(Z0,U,8)
 . I $P(Z0,U,6)=3 W "  "_$P("PARTIAL^FULL^NO",U,+Z0)_" PAYMENT"
 . I $P(Z0,U,6)=4 W "  "_$P("CO-PAY^NO CO-PAY",U,+Z0)
 ;
 I 'RCHAS D:'RCPG HDR(.RCPG,RCERA,.RCSTOP) W !,"THERE ARE NO BATCHES DEFINED FOR THIS ERA"
 I '$D(ZTQUEUED),'RCSTOP,RCPG D ASK()
 I $D(ZTQUEUED) S ZTREQ="@"
 I '$D(ZTQUEUED) D ^%ZISC
 Q
 ;
NOTSET ;
 N DIR,X,Y
 S DIR(0)="EA",DIR("A",1)="THERE ARE NO BATCHES ASSIGNED TO THIS ERA",DIR("A")="PRESS RETURN TO CONTINUE " W ! D ^DIR K DIR
 S VALMBCK="R"
 Q
 ;
HDR(RCPG,RCSCR,RCSTOP) ;Print report hdr
 ; RCPG = last page #
 ; RCSCR = the entry # in file 344.49
 ; RCSTOP = returned as 1 if abort is detected
 N RCZ0
 I $D(ZTQUEUED),$$S^%ZTLOAD S (RCSTOP,ZTSTOP)=1 K ZTREQ W:+$G(RCPG) !,"***TASK STOPPED BY USER***" Q
 S RCZ0=$G(^RCY(344.4,RCSCR,0))
 I RCPG&($E(IOST,1,2)="C-") D ASK(.RCSTOP) Q:RCSTOP
 W !,@IOF,*13
 S RCPG=$G(RCPG)+1
 W !,"EDI LBOX WORKLIST - BATCH SUMMARY REPORT",?59,$$FMTE^XLFDT(DT,2),?70,"Page: ",RCPG,!
 W !,"ERA #: ",$E(RCSCR_$J("",29),1,29)_"  TRACE #: "_$P(RCZ0,U,2)
 W !,"PAYER: "_$E($P(RCZ0,U,6)_$J("",30),1,30)_"  ERA DT: "_$$FMTE^XLFDT($P(RCZ0,U,4),"2D")
 W !!,"BATCH #  NAME"_$J("",28)_"READY TO POST?  STATUS SET BY"
 W !,$TR($J("",IOM)," ","=")
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
