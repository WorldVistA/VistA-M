IBOTRR ;ALB/ARH - ROI EXPIRING REPORT ; 08-JAN-2013
 ;;2.0;INTEGRATED BILLING;**458**;21-MAR-94;Build 4
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ;get parameters then run the report
 D HOME^%ZIS N DIR,DIRUT,DUOUT,X,Y,IBBDT,IBEDT,IBEXCEL
 W !!,"ROI Special Consent Report - Find ROIs about to expire",!
 ;
 D DATE^IBOUTL I IBBDT=""!(IBEDT="") Q
 ;
 W !!,"ROI's that expire between "_$$FMTE^XLFDT(IBBDT,2)_" and "_$$FMTE^XLFDT(IBEDT,2)_" will be included on the report.",!
 ;
 ; Determine whether to gather data for Excel report
 S DIR("?")="Enter Yes to capture the report on the screen for transfer to Excel."
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Do you want to capture report data for an Excel document" D ^DIR K DIR I $D(DIRUT) G EXIT
 S IBEXCEL=0 I Y=1 S IBEXCEL=1 W !,"Enter '0;80;999' at the 'DEVICE:' prompt.",!
 ;
DEV ;get the device
 S %ZIS="QM",%ZIS("A")="OUTPUT DEVICE: " D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN="RPT^IBOTRR",ZTSAVE("IB*")="",ZTDESC="IB ROI Expires" D ^%ZTLOAD K IO("Q") G EXIT
 U IO
 ;
RPT ;find, save, and print the data that satisfies the search parameters
 ;entry point for tasked jobs
 ;
 K ^TMP($J,"IBOTRR")
 ;
 D SORT,PRINT
 ;
EXIT ;clean up and quit
 K ^TMP($J,"IBOTRR") Q:$D(ZTQUEUED)
 D ^%ZISC
 Q
 ;
SORT ; sort report - get all ROIs that will expire in Patient and Effective Date order
 N DFN,IBRFN,IBR0,IBPAT,IBB,IBE K ^TMP($J,"IBOTRR")
 ;
 S DFN=0 F  S DFN=$O(^IBT(356.26,"C",DFN)) Q:'DFN  D
 .S IBRFN=0 F  S IBRFN=$O(^IBT(356.26,"C",DFN,IBRFN)) Q:'IBRFN  D
 .. S IBR0=$G(^IBT(356.26,IBRFN,0))
 .. S IBB=+$P(IBR0,U,4),IBE=+$P(IBR0,U,5),IBPAT=$P($G(^DPT(+$P(IBR0,U,2),0)),U,1)
 .. ;
 .. I IBE'<IBBDT,IBE'>IBEDT S ^TMP($J,"IBOTRR",IBPAT,$P(IBR0,U,4),IBRFN)=""
 ;
 Q
 ;
PRINT ;print the report from the temp sort file to the appropriate device
 N IBPGN,IBLN,IBQUIT,IBPAT,IBB,IBRFN,IBR0
 S IBPGN=0,IBQUIT=0 D HDR Q:IBQUIT
 ;
 S IBPAT="" F  S IBPAT=$O(^TMP($J,"IBOTRR",IBPAT)) Q:IBPAT=""  D  Q:IBQUIT
 . S IBB="" F  S IBB=$O(^TMP($J,"IBOTRR",IBPAT,IBB)) Q:IBB=""  D  Q:IBQUIT
 .. S IBRFN=0 F  S IBRFN=$O(^TMP($J,"IBOTRR",IBPAT,IBB,IBRFN)) Q:'IBRFN  D  Q:$$LNCHK(2)
 ... S IBR0=$G(^IBT(356.26,IBRFN,0))
 ... I +$G(IBEXCEL) W !,IBPAT,U,$$FMTE^XLFDT($P(IBR0,U,4)),U,$$FMTE^XLFDT($P(IBR0,U,5)) S IBLN=1 Q
 ... W !,IBPAT,?36,$$FMTE^XLFDT($P(IBR0,U,4)),?53,$$FMTE^XLFDT($P(IBR0,U,5)) S IBLN=IBLN+1
 ;
 I 'IBQUIT D PAUSE
 Q
LNCHK(LNS) ; check if new page is needed
 I 'IBQUIT,IBLN>(IOSL-LNS) D PAUSE I 'IBQUIT D HDR
 Q IBQUIT
 ;
HDR ;print the report header
 N IBNOW,IBI
 I +$G(IBEXCEL) W !,"Patient^Effective^Expires" S IBLN=1 Q
 ;
 S IBQUIT=$$STOP Q:IBQUIT  S IBPGN=IBPGN+1,IBLN=7
 S IBNOW=$$FMTE^XLFDT($$NOW^XLFDT,2),IBNOW=$P(IBNOW,"@",1)_"  "_$P($P(IBNOW,"@",2),":",1,2)
 I IBPGN>1!($E(IOST,1,2)["C-") W @IOF
 ;
 W !,"ROI Special Consent To Expire ",$$FMTE^XLFDT(IBBDT)," - ",$$FMTE^XLFDT(IBEDT),?(IOM-30),IBNOW,?(IOM-8),"PAGE ",IBPGN,!
 W !,"Patient",?36,"Effective",?53,"Expires",!
 S IBI="",$P(IBI,"-",IOM+1)="" W IBI
 Q
 ;
PAUSE ;pause at end of screen if beeing displayed on a terminal
 Q:$E(IOST,1,2)'["C-"  N DIR,DUOUT,DTOUT,DIRUT W !
 S DIR(0)="E" D ^DIR K DIR
 I $D(DUOUT)!($D(DIRUT)) S IBQUIT=1
 Q
 ;
STOP() ;determine if user has requested the queued report to stop
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ I +$G(IBPGN) W !,"***TASK STOPPED BY USER***"
 Q +$G(ZTSTOP)
