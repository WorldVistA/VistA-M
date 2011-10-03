IBAGMR ;WOIFO/AAT-GMT SINGLE PATIENT REPORT;11-JUL-02
 ;;2.0;INTEGRATED BILLING;**183**;21-MAR-94
 ;; Per VHA Directive 10-93-142, this routine should not be modified
 ;
 N IBQUIT
 F  S IBQUIT=0 D  Q:IBQUIT
 . N IBDFN,IBBDT,IBEDT,%DT,X,Y,DIC
 . W !
 . S IBDFN=$$ASKPAT() I IBDFN=-1 S IBQUIT=1 Q
 . D DATE I IBBDT<0 Q  ;S IBQUIT=1 Q  ;Enter date range (defaults are begin/end of the clock)
 . D ASKDEV ;Choose device and run/schedule printing
 Q
 ;
ASKDEV ; Ask about output device and print the report (or run task)
 N %ZIS,POP
 S %ZIS="QM"
 W ! D ^%ZIS Q:POP  ; Quit and ask for patient again. Otherwise Set IBSTOP=1
 ; If it was queued
 I $D(IO("Q")) D RUNTASK Q
 U IO D REPORT^IBAGMR1 ; Generate report directly
 D ^%ZISC ; Close the device
 Q
 ;
 ;
RUNTASK ; Start Taskman job
 N ZTRTN,ZTSK,IBVAR,ZTSAVE,ZTDESC
 S ZTRTN="REPORT^IBAGMR1",ZTDESC="IB GMT SINGLE PATIENT REPORT"
 F IBVAR="IBDFN","IBBDT","IBEDT" S ZTSAVE(IBVAR)=""
 D ^%ZTLOAD
 I $G(ZTSK) W !!,"This request has been queued.  The task number is "_ZTSK_"."
 E  W !!,"Unable to queue this job."
 K IO("Q")
 D HOME^%ZIS W !
 Q
 ;
 ;
 ; Ask begin/end dates, with default values
 ; Input:  none
 ; Output: IBBDT,IBEDT - begin/end dates
DATE N %DT,Y,IBNOW,IBGMTEFD
 S IBNOW=$$NOW(),IBGMTEFD=$$GMTEFD^IBAGMT
DATAGN ;Loop entry point
 S (IBBDT,IBEDT)=-1
 ; Get beginning date
 S IBBDT=$$ASKDT("Start with DATE: ",$S(IBNOW<IBGMTEFD:IBNOW,1:IBGMTEFD))
 I IBBDT<1 Q
 ; Get ending date
 S IBEDT=$$ASKDT("Go to DATE: ",IBNOW)
 I IBEDT<1 S IBBDT=-1 Q  ;User cancelled
 I IBEDT<IBBDT W !,"Ending date must follow start date!",! G DATAGN
 Q
 ;
 ;Returns today's date in FM format
NOW() N %,%H,%I,X
 D NOW^%DTC
 Q X
 ;
 ; Input: prompt, default value (FM format)
 ; Output: date (FM) or -1, if cancelled
ASKDT(IBPRMT,IBDFLT) ;Date input
 N DIR,Y,Y0,X,DIROUT,DIRUT
 I $G(IBPRMT)'="" S DIR("A")=IBPRMT
 I $G(IBDFLT)'="" S DIR("B")=$$FMTE^XLFDT(IBDFLT,"1D")
 S DIR(0)="DA"
 D ^DIR I $D(DIRUT) Q -1
 W " (",$$FMTE^XLFDT(Y),")"
 Q Y
 ;
ASKPAT() N Y,DIC,IBGMTST
 S DIC="^DPT(",DIC(0)="AEQMN" D ^DIC
 I Y>0 S IBGMTST=$$ISGMTPT^IBAGMT(Y,DT)
 I Y>0,IBGMTST=-1 W !!,"*** WARNING! GMT Copayment Status is unknown for the patient!",!
 I Y>0,IBGMTST=0 W !!,"*** WARNING! The patient does not have GMT Copayment Status!",!
 Q +$G(Y,-1)
